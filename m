From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Tue, 1 Oct 2002 06:50:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210010650.37137.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <200209260406.48808.earny@net4u.de> <20020930020016.A90@toy.ucw.cz>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020930020016.A90-muQmgwBScQHrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Montag, 30. September 2002 04:00, Pavel Machek wrote:
> Hi!
> Can you ksymoops it?

OkOk ;-) Same procedure: I recompiled the kernel to have a clean System.m=
ap,
installed my 'cooling preventer', and started burnP6. If the temp reaches=
=20
about 75 =B0C, i type 'reboot'.

(I have also checked for a longer time, that the laptop is running at thi=
s=20
temp without any problems. If  i let the laptop cooling down, he will=20
boot up without any problems.)

The results differs at each reboot, so i append 3 different oops'es.
The first 2 ones are during a normal boot, the second seems more often th=
an=20
the first one. Then i tried to boot into single user. In this case it is =
not easy to=20
see the first oops on the screen: If i try to enter the root passwort, i =
get=20
immediatly a bunch of oops'es, unable to read the first one. The third oo=
ps
is done in single user mode, not typing in the password and wait. The oop=
s('es)=20
appears after a couple of seconds.

Enjoy ;-)

(i was not able to use a serial console, i typed careful all oops'es from=
 the=20
display. Don't blame me, if you find a typo :-)

#########################################################################=
#

Gericom M6-T 1200MHz=20

earny@lidl:~> uname -a
Linux lidl 2.4.20-pre7 #6 Tue Oct 1 00:55:43 CEST 2002 i686 unknown
earny@lidl:~> cat /proc/acpi/info
version:                 20020918
states:                  S0 S1 S4 S5
earny@lidl:~> ksymoops -v /usr/src/linux/vmlinux < oops1
ksymoops 2.4.6 on i686 2.4.20-pre7.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre7/ (default)
     -m /boot/System.map (default)

Oops: 0002
CPU: 0
EIP:  0010:[<c011fe45>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c159cea8 ebx: 00000006 ecx: 00000000 edx: 00000000
esi: c1593478 edi: c01c11e8 ebp: 00000000 esp: dea5dd44
ds: 0018 es: 0018 ss: 0018
Process ldconfig (pid: 689, stackpage=3Ddea5d000)
Stack: c1593460 00000246 c01bb1a1 c1593478 00001000 c031fd84 c031fd40 c01=
c1b64
       c031fd84 c01c11e8 000007d0 00000000 000001f6 c15c9c00 c031fd84 c03=
1fd84
       00000000 ddf82140 00000001 00000008 0031fd84 c01c3803 00000000 c03=
1fd84
Call Trace:    [<c01bb1a1>] [<c01c1b64>] [<c01c11e8>] [<c01c3803>] [<c01c=
6e75>]
  [<c01bc497>] [<c01bc4f7>] [<c01bc857>] [<c01bc8db>] [<c01ae6e4>] [<c011=
d2ec>]
  [<c01382c2>] [<c01288f5>] [<c0128934>] [<c0129a8e>] [<c01265f2>] [<c012=
676e>]
  [<c0115d04>] [<c0115ba4>] [<c010d5ee>] [<c010d616>] [<c010874c>]
Code: 89 72 04 89 16 89 46 04 89 30 53 9d eb 14 53 9d 8b 44 24 08


>>EIP; c011fe45 <add_timer+b5/dc>   <=3D=3D=3D=3D=3D

>>eax; c159cea8 <_end+126fa88/224ecbe0>
>>esi; c1593478 <_end+1266058/224ecbe0>
>>edi; c01c11e8 <ide_dma_intr+0/ac>
>>esp; dea5dd44 <_end+1e730924/224ecbe0>

Trace; c01bb1a1 <ide_set_handler+59/64>
Trace; c01c1b64 <ide_dmaproc+188/36c>
Trace; c01c11e8 <ide_dma_intr+0/ac>
Trace; c01c3803 <via82cxxx_dmaproc+cf/dc>
Trace; c01c6e75 <do_rw_disk+2bd/528>
Trace; c01bc497 <start_request+147/220>
Trace; c01bc4f7 <start_request+1a7/220>
Trace; c01bc857 <ide_do_request+287/2d4>
Trace; c01bc8db <do_ide_request+f/14>
Trace; c01ae6e4 <generic_unplug_device+20/28>
Trace; c011d2ec <__run_task_queue+50/5c>
Trace; c01382c2 <block_sync_page+16/1c>
Trace; c01288f5 <__lock_page+8d/b8>
Trace; c0128934 <lock_page+14/18>
Trace; c0129a8e <filemap_nopage+136/1f8>
Trace; c01265f2 <do_no_page+52/17c>
Trace; c012676e <handle_mm_fault+52/b0>
Trace; c0115d04 <do_page_fault+160/480>
Trace; c0115ba4 <do_page_fault+0/480>
Trace; c010d5ee <old_mmap+ea/120>
Trace; c010d616 <old_mmap+112/120>
Trace; c010874c <error_code+34/3c>

Code;  c011fe45 <add_timer+b5/dc>
00000000 <_EIP>:
Code;  c011fe45 <add_timer+b5/dc>   <=3D=3D=3D=3D=3D
   0:   89 72 04                  mov    %esi,0x4(%edx)   <=3D=3D=3D=3D=3D
Code;  c011fe48 <add_timer+b8/dc>
   3:   89 16                     mov    %edx,(%esi)
Code;  c011fe4a <add_timer+ba/dc>
   5:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c011fe4d <add_timer+bd/dc>
   8:   89 30                     mov    %esi,(%eax)
Code;  c011fe4f <add_timer+bf/dc>
   a:   53                        push   %ebx
Code;  c011fe50 <add_timer+c0/dc>
   b:   9d                        popf
Code;  c011fe51 <add_timer+c1/dc>
   c:   eb 14                     jmp    22 <_EIP+0x22> c011fe67 <add_tim=
er+d7/dc>
Code;  c011fe53 <add_timer+c3/dc>
   e:   53                        push   %ebx
Code;  c011fe54 <add_timer+c4/dc>
   f:   9d                        popf
Code;  c011fe55 <add_timer+c5/dc>
  10:   8b 44 24 08               mov    0x8(%esp,1),%eax

earny@lidl:~>############################################################=
###
earny@lidl:~> ksymoops -v /usr/src/linux/vmlinux < oops2
ksymoops 2.4.6 on i686 2.4.20-pre7.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre7/ (default)
     -m /boot/System.map (default)

Oops: 0002
CPU: 0
EIP:  0010:[<c011ff45>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c159cea8 ebx: dea56574 ecx: 00000000 edx: 00000000
esi: 00000206 edi: 00000000 ebp: dea56520 esp: deb2bd14
ds: 0018 es: 0018 ss: 0018
Process mount (pid: 667, stackpage=3Ddeb2b000)
Stack: dea56520 00000000 00000000 c0239ca9 dea56574 0000175c c029c000 deb=
2bd78
       df3e3ebc c0239cd0 c029c000 dea56520 00000000 00000000 deb2bd78 c01=
640cd
       c029c000 dea56520 00000000 00000000 dea56574 fffffff5 deadbb9c dea=
56520
Call Trace:    [<c0239ca9>] [<c0239cd0>] [<c01640cd>] [<c023a177>] [<c023=
a613>]
  [<c023a3cc>] [<c0163eef>] [<c0163fae>] [<c0164b49>] [<c01391b7>] [<c013=
92f8>]
  [<c0148e79>] [<c0149132>] [<c0148f94>] [<c01494b4>] [<c010865b>]
Code: 89 5a 04 89 13 89 43 04 89 18 56 9d 89 f8 5b 5e 5f c3 90 53


>>EIP; c011ff45 <mod_timer+d9/ec>   <=3D=3D=3D=3D=3D

>>eax; c159cea8 <_end+126fa88/224ecbe0>
>>ebx; dea56574 <_end+1e729154/224ecbe0>
>>ebp; dea56520 <_end+1e729100/224ecbe0>
>>esp; deb2bd14 <_end+1e7fe8f4/224ecbe0>

Trace; c0239ca9 <__rpc_sleep_on+19d/1a4>
Trace; c0239cd0 <rpc_sleep_on+20/44>
Trace; c01640cd <nfs_flushd+f1/fc>
Trace; c023a177 <__rpc_execute+9f/2a4>
Trace; c023a613 <rpc_new_task+17/15c>
Trace; c023a3cc <rpc_execute+50/64>
Trace; c0163eef <nfs_reqlist_init+6f/88>
Trace; c0163fae <nfs_reqlist_alloc+4a/58>
Trace; c0164b49 <nfs_read_super+825/908>
Trace; c01391b7 <get_sb_nodev+37/6c>
Trace; c01392f8 <do_kern_mount+80/104>
Trace; c0148e79 <do_add_mount+65/130>
Trace; c0149132 <do_mount+14e/168>
Trace; c0148f94 <copy_mount_options+50/a0>
Trace; c01494b4 <sys_mount+84/c4>
Trace; c010865b <system_call+33/38>

Code;  c011ff45 <mod_timer+d9/ec>
00000000 <_EIP>:
Code;  c011ff45 <mod_timer+d9/ec>   <=3D=3D=3D=3D=3D
   0:   89 5a 04                  mov    %ebx,0x4(%edx)   <=3D=3D=3D=3D=3D
Code;  c011ff48 <mod_timer+dc/ec>
   3:   89 13                     mov    %edx,(%ebx)
Code;  c011ff4a <mod_timer+de/ec>
   5:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c011ff4d <mod_timer+e1/ec>
   8:   89 18                     mov    %ebx,(%eax)
Code;  c011ff4f <mod_timer+e3/ec>
   a:   56                        push   %esi
Code;  c011ff50 <mod_timer+e4/ec>
   b:   9d                        popf
Code;  c011ff51 <mod_timer+e5/ec>
   c:   89 f8                     mov    %edi,%eax
Code;  c011ff53 <mod_timer+e7/ec>
   e:   5b                        pop    %ebx
Code;  c011ff54 <mod_timer+e8/ec>
   f:   5e                        pop    %esi
Code;  c011ff55 <mod_timer+e9/ec>
  10:   5f                        pop    %edi
Code;  c011ff56 <mod_timer+ea/ec>
  11:   c3                        ret
Code;  c011ff57 <mod_timer+eb/ec>
  12:   90                        nop
Code;  c011ff58 <del_timer+0/44>
  13:   53                        push   %ebx

 <0>Kernel panic: Aiee, killing interrupt handler!
earny@lidl:~>############################################################=
###
earny@lidl:~> ksymoops -v /usr/src/linux/vmlinux < oops3
ksymoops 2.4.6 on i686 2.4.20-pre7.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre7/ (default)
     -m /boot/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000=
004
c011fe45
*pde =3D 00000000
Oops: 0002
CPU: 0
EIP:  0010:[<c011fe45>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c159cea8 ebx: 00000206 ecx: 00000000 edx: 00000000
esi: c159bf2c edi: 00000000 ebp: c159bf40 esp: c159bf14
ds: 0018 es: 0018 ss: 0018
Process init (pid: 1, stackpage=3Dc159b000)
Stack: c159bf2c 000017eb c0116886 c159bf2c 00000000 dff652a0 00000000 000=
00000
       000017eb c159a000 c01167d0 c159bf74 c01417b1 00000004 00000001 c15=
c1b38
       00000104 00000400 c159a000 000001f4 0000000b 00000000 00000000 df9=
95000
Call Trace:    [<c0116886>] [<c01167d0>] [<c01417b1>] [<c0141b50>] [<c010=
865b>]
Code: 89 72 04 89 16 89 46 04 89 30 53 9d eb 14 53 9d 8b 44 24 08


>>EIP; c011fe45 <add_timer+b5/dc>   <=3D=3D=3D=3D=3D

>>eax; c159cea8 <_end+126fa88/224ecbe0>
>>esi; c159bf2c <_end+126eb0c/224ecbe0>
>>ebp; c159bf40 <_end+126eb20/224ecbe0>
>>esp; c159bf14 <_end+126eaf4/224ecbe0>

Trace; c0116886 <schedule_timeout+6e/94>
Trace; c01167d0 <process_timeout+0/48>
Trace; c01417b1 <do_select+19d/1dc>
Trace; c0141b50 <sys_select+338/474>
Trace; c010865b <system_call+33/38>

Code;  c011fe45 <add_timer+b5/dc>
00000000 <_EIP>:
Code;  c011fe45 <add_timer+b5/dc>   <=3D=3D=3D=3D=3D
   0:   89 72 04                  mov    %esi,0x4(%edx)   <=3D=3D=3D=3D=3D
Code;  c011fe48 <add_timer+b8/dc>
   3:   89 16                     mov    %edx,(%esi)
Code;  c011fe4a <add_timer+ba/dc>
   5:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c011fe4d <add_timer+bd/dc>
   8:   89 30                     mov    %esi,(%eax)
Code;  c011fe4f <add_timer+bf/dc>
   a:   53                        push   %ebx
Code;  c011fe50 <add_timer+c0/dc>
   b:   9d                        popf
Code;  c011fe51 <add_timer+c1/dc>
   c:   eb 14                     jmp    22 <_EIP+0x22> c011fe67 <add_tim=
er+d7/dc>
Code;  c011fe53 <add_timer+c3/dc>
   e:   53                        push   %ebx
Code;  c011fe54 <add_timer+c4/dc>
   f:   9d                        popf
Code;  c011fe55 <add_timer+c5/dc>
  10:   8b 44 24 08               mov    0x8(%esp,1),%eax

 <0>Kernel panic: Attempted to kill init!
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000004
c012056b
*pde =3D 00000000
Oops: 0002
CPU: 0
EIP:  0010:[<c012056b>]  Not tainted
EFLAGS: 00010012
eax: 00000000 ebx: c0302a1c ecx: c159cea8 edx: 00000004
esi: 00000000 edi: c0302960 ebp: 00000000 esp: c159bd48
ds: 0018 es: 0018 ss: 0018
Process init (pid: 1, stackpage=3Dc159b000)
Stack: 00000000 c02f7540 00000000 c02f7560 00001700 00000000 00001700 000=
00004
       00000001 c159bd6c c159bd6c c011d232 c011d176 00000000 00000001 c02=
f7560
       fffffffe c011cf9a c02f7560 00000000 c02f5900 00000000 c159bdbc 000=
00046
Call Trace:    [<c011d232>] [<c011d176>] [<c011cf9a>] [<c0109b22>] [<c010=
bcf8>]
  [<c0240018>] [<c01aca51>] [<c0118eb5>] [<c011bbf0>] [<c0108c16>] [<c011=
5ef7>]
  [<c0115ba4>] [<e2821f41>] [<c012f3ff>] [<c010874c>] [<c011fe45>] [<c011=
6886>]
  [<c01167d0>] [<c01417b1>] [<c0141b50>] [<c010865b>]
Code: 89 46 04 89 30 8b 41 08 c7 01 00 00 00 00 c7 41 04 00 00 00


>>EIP; c012056b <timer_bh+10b/368>   <=3D=3D=3D=3D=3D

>>ebx; c0302a1c <tv2+bc/220>
>>ecx; c159cea8 <_end+126fa88/224ecbe0>
>>edi; c0302960 <tv2+0/220>
>>esp; c159bd48 <_end+126e928/224ecbe0>

Trace; c011d232 <bh_action+1a/40>
Trace; c011d176 <tasklet_hi_action+4a/70>
Trace; c011cf9a <do_softirq+5a/a4>
Trace; c0109b22 <do_IRQ+96/a8>
Trace; c010bcf8 <call_do_IRQ+5/d>
Trace; c0240018 <modify_qos+b4/d4>
Trace; c01aca51 <panic_blink+15/84>
Trace; c0118eb5 <panic+d5/e8>
Trace; c011bbf0 <do_exit+48/240>
Trace; c0108c16 <die+56/58>
Trace; c0115ef7 <do_page_fault+353/480>
Trace; c0115ba4 <do_page_fault+0/480>
Trace; e2821f41 <[reiserfs]inode2sd+85/94>
Trace; c012f3ff <__alloc_pages+3f/15c>
Trace; c010874c <error_code+34/3c>
Trace; c011fe45 <add_timer+b5/dc>
Trace; c0116886 <schedule_timeout+6e/94>
Trace; c01167d0 <process_timeout+0/48>
Trace; c01417b1 <do_select+19d/1dc>
Trace; c0141b50 <sys_select+338/474>
Trace; c010865b <system_call+33/38>

Code;  c012056b <timer_bh+10b/368>
00000000 <_EIP>:
Code;  c012056b <timer_bh+10b/368>   <=3D=3D=3D=3D=3D
   0:   89 46 04                  mov    %eax,0x4(%esi)   <=3D=3D=3D=3D=3D
Code;  c012056e <timer_bh+10e/368>
   3:   89 30                     mov    %esi,(%eax)
Code;  c0120570 <timer_bh+110/368>
   5:   8b 41 08                  mov    0x8(%ecx),%eax
Code;  c0120573 <timer_bh+113/368>
   8:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c0120579 <timer_bh+119/368>
   e:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)

 <0>Kernel Panic: Aiee, killing interrupt handler!
earny@lidl:~>############################################################=
#

PS:
If you need more oops'es, wait until i have a null modem cable and
the serial console up and running ;-))


-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
