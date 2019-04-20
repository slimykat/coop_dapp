pragma solidity >=0.4.22 <0.6.0;

contract Ballot {

    struct Mission {
        uint coins;
        /// bool pendding;
        address payable host;
        address payable coop;
        uint description; ///bitmap of mission catagory
    }
    
    struct Account{
        address payable addr;
        uint has_issue;
        uint in_mission;
    }
    
    address chairperson;
    Mission[] mission;
    bool[] mission_status;  /// f: waiting t: processing
    
    
    mapping(address => Account) account;
    uint public num_of_missions;
    
    /// initiation, set a limited list of missions
    constructor(uint8 _numMissions) public {
        require(_numMissions > 1);
        chairperson = msg.sender;
        mission.length = _numMissions;
        mission_status.length = _numMissions;
    }

    function build_account(address payable from) public{
        require(msg.sender == chairperson);
        account[from].has_issue = 0;
        account[from].in_mission = 0;
        account[from].addr = from;
    }

    /// assign a mission
    function Issue(uint sets, uint coins) public returns(uint){
        require(num_of_missions < mission.length, "not enough queue space");
        require(account[msg.sender].has_issue < 10, "too many issues");
        
        uint mission_num = 0;
        for (uint i = 0; i < mission.length; i++){
            if(mission_status[i] == false){
                mission_status[i] = true;
                mission_num = i;
                
                Mission memory new_mission = Mission(coins, msg.sender, msg.sender, sets);
                mission[i] = new_mission;
                num_of_missions ++;
                account[msg.sender].has_issue++;
            }
        }
        return(mission_num);
    }

   /// event();
    
    function Assign(uint mission_num)public{
        require(mission_status[mission_num] == true);
        require(mission[mission_num].coop != mission[mission_num].host);
        require(account[msg.sender].in_mission < 10);
        
        mission[mission_num].coop = msg.sender;
      ///  emit
    }
    function Getinfo(uint mission_num)public view returns(uint coin, bool status, uint descript, address whose, address towho){
        if(mission_num < num_of_missions){
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
