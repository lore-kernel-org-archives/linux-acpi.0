From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Thu, 26 Sep 2002 04:06:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209260406.48808.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <20020918055456.H202@toy.ucw.cz> <200209260237.25534.earny@net4u.de>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209260237.25534.earny-euM3SP4ZHrg@public.gmane.org>
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

On Donnerstag, 26. September 2002 02:37, Ernst Herzberg wrote:
> Oopses if CPU is too hot? I've seen that on a gericom M6-T too. Previou=
s
> versions of the acpi patches has no such bug.  Ok, i am no absolute shu=
re,
> i have seen that starting with arround acpi-20020728 or acpi-20020815. =
It
> is not easy to reproduce, summertime is over ;-)
>
> <earny>
>
> On Mittwoch, 18. September 2002 07:54, Pavel Machek wrote:
> > Hi!
> >
> >
> > HP Omnibook oopses if CPU is too hot during boot. Can you try booting
> > from cold system?
> > 								Pavel
>


Yupp, i can reproduce this. Heated up with burnP6 an a little 'partial co=
oling=20
preventer' to aprox. 65 to 75=B0C (the temperature display jumps between =
this=20
values in the thermalzone, fan is forced 'off', means running half speed)=
.=20
The laptop is doing his job without problems...  i type reboot:

[.... the kernel loads ....]
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols ICMP, UDP, TCP, IGMP
Unable to handle kernel NULL pinter dereference at virtual address 000000=
04
 printing eip
c011fe45
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011fe45>]  Not tainted
EFLAGS: 00010082
eax: c159bea8  ebx: 00000206  ecx: 00000000  edx: 00000000
esi: c02cf168  edi: c0284473  ebp:  0008e000  esp:  c159dfa8
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 1, stackpage=3Dc159d000)
Stack: c02cf0e0 000001f5 c01fd0b5 c02cf168 c02cfb54 00000000 c02eafba c02=
cf0e0
         c02eb1c9 ........
Call Trace:   [<c01fd0b5>] [>c010502f>] [>c0106ff0>]

Code 89 72 04 89 16 89 46 04 89 30 53 9d eb 14 53 9d 8b 44 24 08
 <0>Kernel panic: Attempted to kill init!

[... a couple seconds later again Oops 0002, Process swapper ....]
 <0> kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

-------------------------------

The laptop is running without problems at  temperature above 70=B0C. The =
oops=20
only occur during boot. If i power off for a couple of minutes it will bo=
ot=20
without problems.=20

lidl:/proc/acpi/thermal_zone/THRM # cat trip_points
critical (S5):           90 C
passive:                 65 C: tc1=3D4 tc2=3D3 tsp=3D600 devices=3D0xc158=
c5e0
active[0]:               50 C: devices=3D0xc158c8e0

'active' is not the problem, boot with temp > 50=B0C but less about 65=B0=
C will=20
not oops. Looks like that 'passive' is the boot preventer -)

lidl:~ # uname -a
Linux lidl 2.4.20-pre7 #5 Thu Sep 19 22:51:02 CEST 2002 i686 unknown
lidl:~ # cat /proc/acpi/info
version:                 20020918
states:                  S0 S1 S4 S5
lidl:~ #

<Earny>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
