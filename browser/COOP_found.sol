pragma solidity >=0.4.22 <0.6.0;

contract coop_find {
    
    struct Mission {
        uint coins;
        address payable host;
        uint description; /// bitmap of mission catagory
        bool status;
        address payable [] queue;
        uint queue_last;
        uint queue_next;
    }
    
    function dequeue(uint mission_num) public returns (address payable data) {
        
        require(mission[mission_num].queue_last > mission[mission_num].queue_next, "queue empty"); 
        // non-empty queue

        data = mission[mission_num].queue[mission[mission_num].queue_next];
        delete mission[mission_num].queue[mission[mission_num].queue_next];
        
        mission[mission_num].queue_next += 1;
    }
    
    struct Account{
        uint has_issue;
        uint in_task;
        uint finished_issue;
        uint finished_task;
    }
    
    address chairperson;
    mapping(uint => Mission) mission;
    mapping(address => Account) account;
    
    uint num_of_missions;
    uint max_of_missions;
    uint max_of_issues;
    uint max_of_tasks;
    
    /// initiation, set a limited list of missions
    constructor(uint _max_of_missions, uint _max_of_issues, uint _max_of_tasks) public {
        chairperson = msg.sender;
        num_of_missions = 0;
        max_of_missions = _max_of_missions;
        max_of_issues = _max_of_issues;
        max_of_tasks = _max_of_tasks;
    }
    
    /// give an issue, find coops
    function Issue(uint descript, uint coins) public payable returns(uint){
        require(num_of_missions < max_of_missions, "not enough queue space");
        require(account[msg.sender].has_issue < max_of_issues, "too many issues");
        require(msg.value == 2*coins);
        
        uint mission_num = descript % max_of_missions;
        
        while(mission[mission_num].status == true){
            mission_num = (mission_num) % max_of_missions;
        }
        address payable [] memory new_queue;
        Mission memory new_mission = Mission(
            coins, msg.sender, descript, true, new_queue, 0, 0);
        mission[mission_num] = new_mission;
        num_of_missions ++;
        account[msg.sender].has_issue++;

        num_of_missions++;
        return(mission_num);
    }
    
    event coop_found(uint _mission_num, address _who);
    
    /// find a mission, become a coop
    function Assign(uint mission_num) public{
        require(mission[mission_num].status == true, "mission DNE");
        require(account[msg.sender].in_task < max_of_tasks, "has too much missions");
        
        account[msg.sender].in_task ++;
        mission[mission_num].queue.push(msg.sender);
        mission[mission_num].queue_last++;
        emit coop_found(mission_num, msg.sender);
    }
   
    function Getinfo(uint mission_num)public view returns(
        uint coin, bool stat, uint descript, address whose, uint queue_length){
        require(mission[mission_num].status == true, "mission DNE");
           
        stat = mission[mission_num].status;
        descript = mission[mission_num].description;
        whose = mission[mission_num].host;
        queue_length = mission[mission_num].queue_last - mission[mission_num].queue_next;
        coin = mission[mission_num].coins;

    }

    event coop_paid(address _coop, bool _accept_or_not);
    
    function pay_coop(uint mission_num, bool accept_or_not)public payable{
        require(mission[mission_num].host == msg.sender);
        
        address payable towho = dequeue(mission_num);
        if(accept_or_not){
            msg.value == mission[mission_num].coins;
        }
        towho.transfer(msg.value);
        account[towho].in_task--;
        if(accept_or_not) {
            account[towho].finished_task++;
        }
        emit coop_paid(towho, accept_or_not);
    }
    
    function mission_abort(uint mission_num)public{
        require(mission[mission_num].status == true, "mission DNE");
        require(mission[mission_num].host == msg.sender, "account does not possess the mission");
        require(mission[mission_num].queue_next == mission[mission_num].queue_last,
            "queue not cleared");
        msg.sender.transfer(mission[mission_num].coins *2);
        mission[mission_num].status = false;
        /// delete mission[mission_num];
        account[msg.sender].has_issue--;
        account[msg.sender].finished_issue++;
        num_of_missions --;
    }
}

