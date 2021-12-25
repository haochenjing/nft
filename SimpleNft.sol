//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract nft{
    string private _name;
    string private _symbol;

    bool private _addable;
    bool private _transferable;
    bool private _burnable;

    address private admin;
    uint private countOfSupply;
    uint private maxSupply;
    mapping(uint256 => address) owners;
    mapping(address => uint256) balances;

    modifier onlyAdmin(){
        require( msg.sender == admin, "you are not admin");
        _;
    }

    constructor(string memory name , string memory symbol , bool addable, bool transferable, bool burnable){
        _name = name;
        _symbol = symbol;
        _addable = addable;
        _transferable = transferable;
        _burnable = burnable;
        admin = msg.sender;
        countOfSupply = 0;
        maxSupply = 100000;
    }



    function name() public view returns(string memory){
        return _name;
    }

    function symbol() public view returns(string memory){
        return _symbol;
    }

    function ownerOf(uint256 tokenId) public view returns(address){
        address owner = owners[tokenId];
        require(owner != address(0),"noexist token");
        return owner;
    }


    function addSupply(uint256 num) public onlyAdmin{
        require(_addable == true , "can not add supply");
        maxSupply = maxSupply + num;
    }

    function mint() public {
        countOfSupply ++;
        require(countOfSupply <= maxSupply , "all nfts have been minted");
        balances[msg.sender] ++;
        owners[countOfSupply] = msg.sender;
    }

    function burn(uint tokenId) public  {
        require(_burnable == true ,"can not burn");
        address owner = owners[tokenId];
        balances[owner] --;
        delete owners[tokenId];

    }

    function transfer(uint256 tokenId, address to) public {
        require(_transferable == true , "can not transfer");
        require(to != address(0),"can not transfer to zero address");
        balances[msg.sender] --;
        owners[tokenId] = to;
    }


}
