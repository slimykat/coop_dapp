pragma solidity >=0.4.22 <0.6.0;

contract coop_found {

    struct Mission {
        uint coins;
        address payable host;
        address payable coop;
        uint description; /// bitmap of mission catagory
        bool status;
    }
    struct Account{
        uint has_issue;
        uint in_mission;
        bool exist;
    }
    
    address chairperson;
    mapping(uint => Mission) mission;
    mapping(address => Account) account;
    
    uint num_of_missions;
    uint max_of_missions;
    /// initiation, set a limited list of missions
    constructor() public {
        chairperson = msg.sender;
        num_of_missions = 0;
        max_of_missions = 0;
    }

    function set_queue(uint _max_of_missions)public{
        require(msg.sender == chairperson, "not enough authority");
        max_of_missions = _max_of_missions;
    }

    function build_account() public{
        require(account[msg.sender].exist == false, "account already exist");
        account[msg.sender].has_issue = 0;
        account[msg.sender].in_mission = 0;
        account[msg.sender].exist = true;
    }

    /// give an issue, find coops
    function Issue(uint descript, uint coins) public returns(uint){
        require(num_of_missions < max_of_missions, "not enough queue space");
        require(account[msg.sender].has_issue < 10, "too many issues");
        
        uint mission_num = descript % max_of_missions;
        
        while(mission[mission_num].status == true){
            mission_num = (mission_num + 1) % max_of_missions;
        }
        
        Mission memory new_mission = Mission(coins, msg.sender, msg.sender, descript, true);
        mission[mission_num] = new_mission;
        num_of_missions ++;
        account[msg.sender].has_issue++;

        num_of_missions++;
        return(mission_num);
    }
    
    /// find a mission, become a coop
    function Assign(uint mission_num)public{
        require(mission[mission_num].status == true, "mission DNE");
        require(mission[mission_num].coop == mission[mission_num].host, "already taken");
        require(account[msg.sender].in_mission < 10, "has too much missions");
        
        mission[mission_num].coop = msg.sender;
        account[msg.sender].in_mission ++;
    }
    
    function Getinfo(uint mission_num)public view returns(uint coin, bool status, uint descript, address whose, address towho){
        if(mission_num > num_of_missions){
            status = false;
            descript = 0;
        }
        else{
            status = mission_status[mission_num];
            descript = mission[mission_num].description;
            whose = mission[mission_num].host;
            towho = mission[mission_num].coop;
            coin = mission[mission_num].coins;
        }
    }

    function Search(uint nodes, address towho, uint filter_number)public returns(uint num){
        ///algorithm**
        /// break keywords into nodes and store in bitmap
        /// calculate dist for each possible missions
        /// return the missions that is under the filter_number
    }
    
    function coop_found(uint mission_num, address )public payable{
        require(mission[mission_num].host == msg.sender);
        require(mission[mission_num].coins <= msg.value);
        
        
        /*
        Mission memory mission = stores[missionOwner[_missionId]][_missionId];
        mission.solver = applicantById[_applicantId].addr;
        stores[missionOwner[_missionId]][_missionId] = mission;
        Escrow escrow = (new Escrow).value(msg.value)(_missionId, msg.sender, mission.solver, arbiter);
        missionEscrow[_missionId] = address(escrow);
        */
        
    }
    function coop_deny(uint mission_num)public{
        ///not sure if needed
        ///require(mission_num[mission_num].host == msg.sender);
        ///mission[mission_num].coop = null;
    }
}