// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Kingsride {
    
    struct Ride {
        string driverName;
        string driverPhoneNumber;
        string passengerName;
        string passengerPhoneNumber;
        uint256 fareAmount;
        // Add additional fields for geographical maps integration if needed
    }

    mapping(uint256 => Ride) public rides;
    uint256 public rideCount;

    // Events to emit ride events
    event RideBooked(uint256 rideId, string driverName, string passengerName, uint256 fareAmount);
    event RideCompleted(uint256 rideId, string driverName, string passengerName, uint256 fareAmount);

    // Function to book a ride
    function bookRide(
        string memory _driverName,
        string memory _driverPhoneNumber,
        string memory _passengerName,
        string memory _passengerPhoneNumber,
        uint256 _fareAmount
    ) external {
        rideCount++;
        rides[rideCount] = Ride(
            _driverName,
            _driverPhoneNumber,
            _passengerName,
            _passengerPhoneNumber,
            _fareAmount
        );
        emit RideBooked(rideCount, _driverName, _passengerName, _fareAmount);
    }

    // Function to complete a ride
    function completeRide(uint256 _rideId) external {
        require(_rideId <= rideCount, "Invalid ride ID");
        Ride storage ride = rides[_rideId];
        emit RideCompleted(_rideId, ride.driverName, ride.passengerName, ride.fareAmount);
        delete rides[_rideId];
    }
}
