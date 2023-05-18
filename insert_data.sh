#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games RESTART IDENTITY")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

# Insert 
  if [[ $YEAR != "year" ]]
    then
#      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
#      if [[ -z $WINNER_ID ]]
#        then
          echo "$($PSQL "INSERT INTO teams(name) VALUES('$WINNER'), ('$OPPONENT') ON CONFLICT (name) DO NOTHING")"
#            if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
#              then
#                echo Inserted into team name: $WINNER
#            fi
#          WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
#      fi

#      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
#      if [[ -z $OPPONENT_ID ]]
#        then
#          INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT (name) DO NOTHING")
#            if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
#              then
#                echo Inserted into team name: $OPPONENT
#            fi
#          OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")  
#      fi

      echo "$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', (SELECT team_id FROM teams WHERE name = '$WINNER'), (SELECT team_id FROM teams WHERE name = '$OPPONENT'), $WINNER_GOALS, $OPPONENT_GOALS)")"
#      if [[ $INSERT_RESULT == "INSERT 0 1" ]]
#      then
#        echo Inserted into games: $YEAR, $ROUND, $WINNER_GOALS, $OPPONENT_GOALS, $WINNER, $OPPONENT
#      fi
  fi
done
