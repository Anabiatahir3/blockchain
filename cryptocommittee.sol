pragma solidity ^0.5.1;


contract cryptocommittee{
    address payable owner;
    mapping (address => uint) public balances;
    
    struct Token {
        address payable owner;
        uint amount;
        bool sold;
    }
    
    Token[5] public Committee;
    
    
     event TokenOwnerChanged(
        uint index
    );
    
    event TokenBoughtfromCommittee(
        uint index,
        uint amount,
        bool sold
    );
    
    event CommitteeAwarded(
        uint index,
        uint amount,
        address winner
    );
    
    constructor() public {
        owner = msg.sender;
        
        
        Committee[0].amount = 400;
        Committee[0].sold = false;
        Committee[0].owner = msg.sender;
        
        Committee[1].amount = 400;
        Committee[1].sold = false;
        Committee[1].owner = msg.sender;
        
        Committee[2].amount = 400;
        Committee[2].sold = false;
        Committee[2].owner = msg.sender;
        
        Committee[3].amount = 400;
        Committee[3].sold = false;
        Committee[3].owner = msg.sender;
        
        Committee[4].amount = 400;
        Committee[4].sold = false;
        Committee[4].owner = msg.sender;
        
    }
    
function BuyToken(uint index, uint price) public {
        Token storage token = Committee[index];
        
        require(msg.sender != owner);
        // the owner of contract can not buy tokens
        
        if(price == token.amount && token.sold != true)
        {
            Committee[index].sold = true;
            Committee[index].amount = 0;
            balances[msg.sender]=price;
            
            // the balance of each is equal to the price for which they bought tokens
            
            emit TokenBoughtfromCommittee(index,price,true);
        }
        
    }
    
function CommitteeGiventoOne(uint index) public payable {
        
        address winner = Committee[index].owner;
        bool checker = false;
        for(int i=0;i<5;i++)
        {
            if(Committee[index].sold==true)
            {
                checker=true;
                continue;
                
            }
            else
            {
                checker=false;
                break;
            }
        }
        
        if (checker==false)
        {
            return;
            // if all the Committee tokens have not been sold then the money can not be awarded to anyone
        }
        
        else
        {
        
        require(msg.sender == owner);
        // committe winner only assigned by the main contract starter 

        balances[winner] = balances[msg.sender] * 5;

        // all committee money assigned to the winner
        
        for(int i=0;i<5;i++){
        
        Committee[index].amount = 400;
        Committee[index].sold = false;
        Committee[index].owner = msg.sender;
        }
        
    // the committee tokens are refreshed and are up for sale
    
        emit CommitteeAwarded(index,balances[winner],winner);
        }
    }
        
       
}