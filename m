From: G L <glafranceweb@yahoo.com>
Subject: Problem with suspend to ram (s3)
Date: Fri, 25 Jan 2008 21:41:06 -0800 (PST)
Message-ID: <107307.22958.qm@web55201.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web55201.mail.re4.yahoo.com ([206.190.58.165]:35977 "HELO
	web55201.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752947AbYAZFrt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Jan 2008 00:47:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,


I 
originally 
posted 
about 
my 
problem 
on 
the 
Ubuntu 
forums 
( http://ubuntuforums.org/showthread.php?t=673729 
). 
Having 
received not 
a 
single 
reply, 
I 
decided 
to 
give 
it 
a 
shot 
here.  
Also, 
I've 
been 
googling 
for a few 
evenings 
now 
and 
I 
cannot 
find 
any 
clear 
solution 
to 
this. :(


First, 
here's 
what 
I'm 
using:

Mythbuntu 
7.10 
Gutsy 
Biostar 
TF7050-M2 
motherboard 
(with 
latest 
BIOS) 
AMD 
Athlon 
64 
X2 
4400+ 
Brisbane 
Seagate 
Barracuda 
500GB 
SATA2
2 
GB 
RAM 

When 
I 
suspend 
(S3), 
it 
seems 
to 
work 
okay. 
Computer 
goes 
to 
sleep 
and I 
don't 
hear 
any 
fans 
or 
the 
hard 
drive, 
and 
the 
screen 
goes 
blank.

When 
I 
resume, 
it 
*seems* 
wake 
up 
okay, 
until, 
I 
think, 
it 
tries 
to wake 
up 
the 
hard 
drive. 
Then 
all 
I 
get 
on 
the 
screen 
are 
errors 
like these:


ata1 
soft 
reset 
failed
ata1 
COMRESET 
failed
device 
sda5 
XFS 
metadata 
write 
error 
block 
<bunch 
of 
numbers>
Buffer 
I/O 
error 
on 
device 
sda1, 
logical 
block 
<some 
number>
Remounting 
filesystem 
read-only


All 
I 
see 
are 
error 
messages 
like 
above scrolling... 
it 
doesn't 
seem 
to 
stop 
until 
I 
poweroff 
the 
computer, wait 
a 
few 
seconds, 
then 
poweron 
and 
it 
boots 
normally.

Seems 
to 
me 
that 
the 
computer 
is 
unable 
to 
wake 
up 
the 
hard 
drive 
from its 
beauty 
sleep. 
:-/

I 
enabled/uncommented 
the 
following 
two 
lines 
in "/etc/default/acpi-support":

DISABLE_DMA=true
RESET_DRIVE=true

...but 
the 
problem 
persists. 

Do 
I 
need 
to 
modify 
something 
else 
in 
the 
acpi-support 
file?

Then 
I 
tried 
to 
follow 
the 
instructions 
on 
this 
page 
( http://zechs.dyndns.org/wordpress/?p=234 
) 
to 
get 
s2both 
and 
s2disk 
to work.

When 
I 
tried 
Suspend, 
nothing 
seemed 
to 
happen 
at 
first. 
I 
was 
still seeing 
the 
desktop 
environment 
on 
the 
screen, 
the 
mouse 
cursor 
was 
still moving. 
I 
could 
still 
click 
on 
buttons 
and 
icons, 
however 
it 
would 
have no 
effect. 
No 
program 
would 
start.

So 
I 
rebooted.

What 
followed 
is 
one 
of 
the 
worst 
hard 
drive 
problem 
I've 
ever 
saw!  
It said 
that 
/dev/sda1 
has 
way 
too 
many 
errors 
and 
that 
it'll 
only 
mount read-only 
so 
that 
I 
can 
run 
fsck 
manually. 
Then 
it 
gave 
me 
a 
root 
shell prompt.

I 
ran 
fsck, 
there 
were 
many 
many 
inode 
and 
block 
errors 
about 
this 
and that. 
I 
was 
feeling 
pretty 
bummed 
out 
so 
I 
just 
answer 
'y' 
when 
it would 
ask 
me 
if 
I 
wanted 
to 
fix 
the 
problem.

The 
computer 
then 
rebooted 
again, 
and 
everything 
seemed 
to 
run normally. 
I 
tried 
all 
different 
programs 
and 
things 
(to 
see 
if 
any 
important files 
had 
been 
damaged), 
but 
everything 
looks 
okay. 
(Phew?)

I 
still 
can't 
seem 
to 
get 
suspend 
to 
work 
though... 
which 
is 
a 
pain 
because 
I 
want 
to 
make 
the 
computer 
suspend 
to 
ram 
when 
I 
press 
the 
power 
button 
of 
my 
remote. 
:-|


Guillaume



