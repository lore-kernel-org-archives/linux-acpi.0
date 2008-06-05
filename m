From: Michael Born <michael.born@stud.uni-hannover.de>
Subject: requested info
Date: Thu, 5 Jun 2008 17:43:28 +0200
Message-ID: <200806051743.28470.michael.born@stud.uni-hannover.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.stud.uni-hannover.de ([130.75.176.3]:37190 "EHLO
	studserv.stud.uni-hannover.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753038AbYFEQ6S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jun 2008 12:58:18 -0400
Received: from femtolab04.iqo.uni-hannover.de ([130.75.103.154])
	by studserv.stud.uni-hannover.de (8.13.8/8.13.8) with ESMTP id m55FhSIs006816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 5 Jun 2008 17:43:28 +0200 (MEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hello kernel hacker,

In my "dmesg" was written I should contact you and provide some information.
"ACPI Exception (thermal-0459): AE_ERROR, ACPI thermal trip point state 
changed Please send acpidump to linux-acpi@vger.kernel.org [20070126]"
What might be the result of such error message?
I'm asking because the computer in question has a problem with opensuse 11.0 
beta3/rc1 and folding@home. After some time the 4 threads of the f@h client 
dissappear from "top" but are still shown in "ps x" (see below).
Also strange was the "top" output of the cpu2 load - 0% used and 0%idle - so 
my cpu2 is on holiday :-)

thorsam@M2A-VM-9600BE:~> top
top - 10:36:09 up 13:33,  1 user,  load average: 3.98, 3.96, 4.22
Tasks: 105 total,   1 running, 104 sleeping,   0 stopped,   0 zombie
Cpu0  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu2  :  0.0%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu3  :  0.3%us,  0.0%sy,  0.0%ni, 98.7%id,  1.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   1928972k total,   465064k used,  1463908k free,    55580k buffers
Swap:   514072k total,        0k used,   514072k free,   124264k cached

http://www.stud.uni-hannover.de/user/75182/acpidump.txt
http://www.stud.uni-hannover.de/user/75182/boot.msg
http://www.stud.uni-hannover.de/user/75182/cpuinfo.txt

system:
Phenom 9600BE
ASUS M2A-VM-HDMI (latest BIOS 1801, the ACPI message also appeared with BIOS 
1603)
2x1GB ADATA PC2-800
old 6GB IDE HDD
opensuse 11.0 beta3 and RC1 tested
thorsam@M2A-VM-9600BE:~> uname -a
Linux M2A-VM-9600BE 2.6.25.4-8-default #1 SMP 2008-05-26 15:23:05 +0200 x86_64 
x86_64 x86_64 GNU/Linux

Please email me directly If you need more info as I don't read the mailing 
list.

Best regards
Michael




The system with two f@h-smp clients (8 worker threads) doing nothing???

thorsam@M2A-VM-9600BE:~> top
top - 10:19:57 up 13:17, 1 user, load average: 5.09, 4.93, 4.76
Tasks: 109 total, 2 running, 107 sleeping, 0 stopped, 0 zombie
Cpu(s): 0.0%us, 0.0%sy, 0.0%ni, 98.6%id, 1.4%wa, 0.0%hi, 0.0%si, 0.0%st
Mem: 1928972k total, 465440k used, 1463532k free, 55132k buffers
Swap: 514072k total, 0k used, 514072k free, 124148k cached

PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
1 root 20 0 860 328 272 S 0 0.0 0:00.66 init
2 root 15 -5 0 0 0 S 0 0.0 0:00.00 kthreadd
3 root RT -5 0 0 0 S 0 0.0 0:00.00 migration/0
4 root 15 -5 0 0 0 S 0 0.0 0:00.00 ksoftirqd/0
5 root RT -5 0 0 0 S 0 0.0 0:00.00 migration/1
6 root 15 -5 0 0 0 S 0 0.0 0:00.00 ksoftirqd/1
7 root RT -5 0 0 0 S 0 0.0 0:00.00 migration/2
8 root 15 -5 0 0 0 S 0 0.0 0:00.00 ksoftirqd/2
9 root RT -5 0 0 0 S 0 0.0 0:00.00 migration/3
10 root 15 -5 0 0 0 S 0 0.0 0:00.00 ksoftirqd/3
11 root 15 -5 0 0 0 S 0 0.0 0:00.38 events/0
12 root 15 -5 0 0 0 S 0 0.0 0:00.40 events/1
13 root 15 -5 0 0 0 S 0 0.0 0:00.06 events/2
14 root 15 -5 0 0 0 S 0 0.0 0:00.28 events/3
15 root 15 -5 0 0 0 S 0 0.0 0:00.00 khelper
16 root 15 -5 0 0 0 S 0 0.0 0:00.00 kblockd/0
thorsam@M2A-VM-9600BE:~> ps x
PID TTY STAT TIME COMMAND
3951 ? Sl 0:00 ./fah6 -smp
3956 ? S 0:00 ./mpiexec -np 4 -host 127.0.0.1 ./FahCore_a1.exe -dir 
work/ -suffix 01 -checkpoint 15 -lifeline
3957 ? SNl 181:09 ./FahCore_a1.exe -dir work/ -suffix 01 -checkpoint 
15 -lifeline 3951 -version 602
3958 ? SNl 118:19 ./FahCore_a1.exe -dir work/ -suffix 01 -checkpoint 
15 -lifeline 3951 -version 602
3959 ? SNl 106:08 ./FahCore_a1.exe -dir work/ -suffix 01 -checkpoint 
15 -lifeline 3951 -version 602
3960 ? SNl 104:32 ./FahCore_a1.exe -dir work/ -suffix 01 -checkpoint 
15 -lifeline 3951 -version 602
4011 ? Sl 0:00 ./fah6 -smp
4016 ? S 0:00 ./mpiexec -np 4 -host 127.0.0.1 ./FahCore_a1.exe -dir 
work/ -suffix 01 -priority 96 -checkpoint
4017 ? SNl 20:00 ./FahCore_a1.exe -dir work/ -suffix 01 -priority 
96 -checkpoint 15 -lifeline 4011 -version 602
4018 ? SNl 17:30 ./FahCore_a1.exe -dir work/ -suffix 01 -priority 
96 -checkpoint 15 -lifeline 4011 -version 602
4019 ? SNl 16:08 ./FahCore_a1.exe -dir work/ -suffix 01 -priority 
96 -checkpoint 15 -lifeline 4011 -version 602
4020 ? SNl 16:02 ./FahCore_a1.exe -dir work/ -suffix 01 -priority 
96 -checkpoint 15 -lifeline 4011 -version 602
5279 ? S 0:00 sshd: thorsam@pts/0
5280 pts/0 Ss 0:00 -bash
5305 pts/0 R+ 0:00 ps x
