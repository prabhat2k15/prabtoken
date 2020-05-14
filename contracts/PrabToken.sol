pragma solidity ^0.5.0;

import "./SafeMath.sol";
import "./ERC20Interface.sol";

contract PrabToken is ERC20Interface, SafeMath {
    string public name;
    
    string public symbol;
    
    uint8 public decimals;
    
    uint256 public _totalSupply;
    
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    
    constructor() public {
        name = "PrabToken";
        
        symbol = "PRT";
        
        decimals = 8;
        
        _totalSupply = 100000000000000000000000000;
        
        balances[msg.sender] = _totalSupply;
        
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
    
    function totalSupply() public view returns (uint) {
        return _totalSupply - balances[address(0)];
    }
    
    function balanceOf(address tokenOwner) public view returns (uint balance){
        return balances[tokenOwner];
    }
    
    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }
    
    function approve(address spender, uint tokens) public returns (bool success){
        allowed[msg.sender][spender] =  tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    
    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens );
        balances[to] = safeAdd(balances[to], tokens);
        
        emit Transfer(msg.sender, to, tokens);
        return true;
    }
   
   function transferFrom(address from, address to, uint tokens) public returns (bool success) {
       balances[from] = safeSub(balances[from], tokens);
       allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
       balances[to] =  safeAdd(balances[to], tokens);
       
       emit Transfer(from, to, tokens);
       return true;
   } 
    
    
}


