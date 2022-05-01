//SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.5.0 <0.9.0;
// ----------------------------------------------------------------------------
// EIP-20: ERC-20 Token Standard
// https://eips.ethereum.org/EIPS/eip-20
// -----------------------------------------
 
interface ERC20Interface {
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function transfer(address to, uint tokens) external returns (bool success);
    
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);
    
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
 
 contract SageToken is ERC20Interface{
     string public name = "Sagetoken";
     string public symbol = "SAGE";
     uint public decimal = 10;
     uint public override totalSupply;

     address public founder;
     mapping(address => uint) balances;

     mapping(address => mapping(address => uint)) allowances;

     constructor (){
            totalSupply = 1000000;
            founder = msg.sender;
            balances[founder] = totalSupply;
     }
     function balanceOf(address tokenOwner) public override view returns (uint balance){
         return balances[tokenOwner];
     }

         function transfer(address to, uint tokens) public override returns (bool success){
             require(balances[msg.sender] >= tokens);
             balances[to] += tokens;
             balances[msg.sender] -= tokens;
            emit Transfer(msg.sender, to, tokens);
            return success;
         }

    function allowance(address tokenOwner, address spender) public override view returns (uint remaining){
        return allowances[tokenOwner][spender];
    }
        function approve(address spender, uint tokens) public override returns (bool success){
            balances[msg.sender] -= tokens;
            allowances[msg.sender][spender] += tokens;
            return success;
        }

    function transferFrom(address from, address to, uint tokens) public override returns (bool success){
        require(allowances[msg.sender][from] >= tokens);
        require(balances[msg.sender] >= tokens);

        balances[msg.sender] -= tokens;
        allowances[msg.sender][from] -= tokens;
        balances[to] += tokens;
        return success;

    }



 }