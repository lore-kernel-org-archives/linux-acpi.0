From: Karl Weigel <xml-22047-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: acpi-event for online/offline of ac-adapter
Date: Thu, 27 Feb 2003 23:26:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200302272326.58114.xml-22047@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>> do you think it would make sense to generate an /proc/acpi/event, when=
ever
>> the power-supply gets connected or disconnected?

> There is one. Well, two actually. One for connecting and one for
> disconnecting. ;-)

> Jens

Sorry to have bothered you with my less-than-new ideas ;-)

Of course I tried to disconnect and reconnect the power supply, and I saw=
 the=20
state was getting set to online and offline, but doing the same with a ca=
t=20
listening on /proc/acpi/events did not see any events from un-/re-pluggin=
g. I=20
am rebooting my laptop to verify this behaviour. And yes: In=20
/proc/acpi/ac_adapter/AC/state I can see the state switching between on-l=
ine=20
and off-line, while cat /proc/acpi/event does not see a power-related eve=
nt.=20
(After using modprobe button I can see, whether the power-button has been=
=20
pressed)

I am using version 20030122

(And while I was looking for the place, where the on-line/off-line events=
=20
should be generated I found, that my laptop does not react to echo 2=20
>/proc/acpi/processor/CPU0/throttling. Doing the same on my tower does=20
produce the expected result. But I wont try to disconnect the powersupply=
 on=20
that machine for obvious reasons)

To make the long story even longer: I have seen in the source, that it sh=
ould=20
work, and I have seen with cat /proc/acpi/event, that it does not.



Kind regards

Karl


P.S. Sorry for not staying in the thread, but GMX thougt it a good idea t=
o=20
mark your E-Mail as infected and did strange things to it because of that=
=2E I=20
switched that feature off again.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
