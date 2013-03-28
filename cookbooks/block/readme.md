# Block

A custom chef recipe that allows you to block IP addresses from accessing your servers, via iptables.

## Usage

Add the IPs that you wish to block to the `recipes/default.rb` file, using the following syntax:

```ruby
block do
  ip "111.111.111.111"
  ip "222.222.222.222", :ports => [22, 80, 443]
  ip "222.0.0.0/8"
end
```

This will block the IP address `111.111.111.111` from accessing any port on the instance. It then blocks `222.222.222.222` on ports `22`, `80` and `443`. Finally, it will block any IP address on the `222.0.0.0/8` subnet.