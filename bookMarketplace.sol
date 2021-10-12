pragma solidity ^0.5.1;

contract Bookcontract {
    address payable owner;
    mapping (address => uint) public balances;
    
    struct Book {
        address payable owner;
        bool forSale;
        uint price;
        string name;
    }
    
    Book[5] public book_market;
    
    
     event BookOwnerChanged(
        uint index
    );
    
    event BookremovedfromMarket(
        uint index,
        uint price,
        bool forSale
    );
    
    event BookAddedtoMarket(
        uint index,
        uint price,
        bool forSale,
        string name
    );
    
    constructor() public {
        owner = msg.sender;
        
        
        book_market[0].price = 4000;
        book_market[0].forSale = false;
        book_market[0].name="Pride and prejudice";
        book_market[0].owner = msg.sender;
        
        book_market[1].price = 500;
        book_market[1].forSale = false;
        book_market[1].name="The good doctor of Warsaw";
        book_market[1].owner = msg.sender;
        
        book_market[2].price = 320;
        book_market[2].forSale = false;
        book_market[2].name="The Great Gatsby";
        book_market[2].owner = msg.sender;
        
        book_market[3].price = 670;
        book_market[3].forSale = false;
        book_market[3].name="A man called Ove";
        book_market[3].owner = msg.sender;
        
        book_market[4].price = 600;
        book_market[4].forSale = false;
        book_market[4].name="The Vanishing half";
        book_market[4].owner = msg.sender;
    }
function putBookForSale(uint index, uint price) public {
        Book storage book = book_market[index];
        
        require(msg.sender == book_market[index].owner);
        
        book_market[index].forSale = true;
        book_market[index].price = price;
        
        emit BookAddedtoMarket(index,price,true,book.name);
    }
function buyBook(uint index,uint bid) public payable {
        Book storage book = book_market[index];
        
        require(msg.sender != book_market[index].owner && book.forSale && bid >= book.price);
        
        if (book.owner ==address(0)) {
            balances[owner] += msg.value;
        }
        else
        {
            balances[book.owner] += msg.value;
        }
        
        book.owner = msg.sender;
        book.forSale = false;
        
        emit BookOwnerChanged(index);
    }
        
       
}