#!/usr/bin/perl

#set module
use DBI;

$mysql_n="root";
$mysql_p="1";
$mysql_d="cmpp_server";

#connect mysql
my $in=DBI->connect("DBI:mysql:database=$mysql_d;host=192.168.5.82","$mysql_n","$mysql_p",{'RaiseError'=>1});
#select databases;
for(my $num=18210000000;$num<18210010000;$num++)
{
my $select=$in->prepare("insert into receive_deliver (sp_number,mobile,msg_content,status,msg_format,insert_time) values ('106551901','$num','$num',0,8,'2014-05-26 10:13:00');");
$select->execute() or die($select->error);
}

#print the list
#while(my $list=$select->fetchrow_hashref()){
#  print "$list->{'file_sn'}\t";
#  print "$list->{'file_name'}\t";
#  print "$list->{'mobile_count'}\t";

#}
print "\n";
#close mysql
$in->disconnect();
