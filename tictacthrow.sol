pragma solidity 0.4.18;

contract TicTacThrow {
    event NewGame(uint gameId, address player1, address player2);

    struct Game {
        address player1;
        address player2;
        address[3][3] board;
        address winner;
        bool hasWon;
        address turn;
    }
    
    Game[] public games;
    
    function getBoard (uint id) public view returns (uint[3][3]) {
        
        uint[3][3] memory retBoard; 
        address[3][3] memory board = games[id].board;
        
        for (uint i = 0; i < board.length; i++) {
            for (uint j = 0; j < board.length; j++) {
                if (board[i][j] == 0) {
                    retBoard[i][j] = 0;
                }
                if (board[i][j] == games[id].player1) {
                    retBoard[i][j] = 1;
                }
                if (board[i][j] == games[id].player2) {
                    retBoard[i][j] = 2;
                }
            }
        }
        return retBoard;
    }
    
    function createGame(address _player1, address _player2) public returns (uint) {
        address[3][3] memory board;
        uint id = games.push(Game(_player1, _player2, board, 0, false, _player1));
        NewGame(id, _player1, _player2);
        return id - 1;
    }
    function setWinner(Game _game, address _winner) private pure returns (bool) {
        _game.winner = _winner;
        _game.hasWon = true;
        return true;
    }

    function checkWin(Game _game) private pure returns (bool) {
        address[3][3] memory board = _game.board;
        for (uint i = 0; i < board.length; i++) {
            address firstVal = board[i][0]; 
            //  check horizontal;
            for (uint j = 0; j < board.length; j++) {
                if (firstVal != board[i][j]) {
                    break;
                }
                if (j == 2) {
                    return setWinner(_game, firstVal);
                }
            }
            // check vertical
            for (uint k = 0; k < board.length; k++) {
                if (firstVal != board[k][i]) {
                    break;
                }
                if (k == 2) {
                    return setWinner(_game, firstVal);
                }
            }
        }
        // check diagonals;
        if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
            return setWinner(_game, board[0][0]);
        }
        if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
            return setWinner(_game, board[2][0]);
        }
        return false;
    }
    
    function makeMove(uint _game, address _player, uint8 _x, uint8 _y) public returns (address) {
        Game memory g = games[_game];
        require(g.turn == _player);
        require(g.board[_x][_y] == 0);
        require(g.hasWon != true);
        games[_game].board[_x][_y] = _player;
        games[_game].turn = _player == g.player1 ? g.player2 : g.player1;
        checkWin(g);
        if (g.hasWon == false) {
            return 0;
        }
        return _player;
    }    

}
