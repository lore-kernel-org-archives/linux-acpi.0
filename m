From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Fri, 05 Mar 2004 21:21:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4048E12D.6040508@pca.it>
References: <404459FD.1000406@pca.it> <20040302110946.GF2869@poupinou.org> <40448169.6090507@pca.it> <40449D8E.4060402@pca.it> <20040303103528.GG2869@poupinou.org> <40463D80.8040800@pca.it> <20040304111240.GN2869@poupinou.org> <404734E8.7080104@pca.it> <20040305113921.GS2869@poupinou.org> <40489FC8.4000605@pca.it> <20040305183737.GT2869@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040305183737.GT2869-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/05/04 19:37, Bruno Ducrot wrote:
>>>>>I think also that the bios will only allow C2, not C3 nor C4 if you are on AC.
>>>>
>>>>You're right, but even on battery I get only C1 & C2 (as from the attached).
>>>
>>>Well, there is a stupid bug, I guess.
>>
>>on the above 2.6.3 there're no changes, always C1 & C2 in battery mode and on
>>AC. The same behaviour on 2.6.4-rc1 + ACPI 20040220 + your patches.
>
> I updated that on bugzilla.
thank you, I tried the new one on a fresh 2.6.3 + ACPI 20040220 + ACPI DSDT in
initrd (so just the last patch and no more the old ones), but still the same on
battery mode (only C1 & C2). With a fresh 2.6.4-rc1 + ACPI 20040220 nothing
changes. The same results on AC mode and the 2.6.3 above.

> Could you please also send me the output of
> /proc/acpi/processor/*/power
> if that still fail on battery?
Sure, here it is:
===== (2.6.3)
luca-HSB4nKSusd8@public.gmane.org:~$ dmesg | grep Processor
ACPI: Processor [CPU1] (supports C1 C2)
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/*/info
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      no
limit interface:         no
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/*/limit
<not supported>
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/*/power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:         type[1] promotion[C2] demotion[--] latency[000] usage[00000010]
   *C2:         type[2] promotion[--] demotion[C1] latency[001] usage[00067837]
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/*/throttling
<not supported>

===== (2.6.4-rc1)
luca-HSB4nKSusd8@public.gmane.org:~$ dmesg | grep Processor
ACPI: Processor [CPU1] (supports C1 C2)
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/*/info
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      no
limit interface:         no
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/*/limit
<not supported>
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/*/power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:         type[1] promotion[C2] demotion[--] latency[000] usage[00000010]
   *C2:         type[2] promotion[--] demotion[C1] latency[001] usage[00142674]
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/*/throttling
<not supported>
=====

> Thanks again for your time,
Once again, *I* should thank you :-)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFASOErVAp7Xm10JmkRAh4BAJ98yHK8GuxBdEJCbelhJoEKBlBQKgCeKYBs
/k0jX4ZkkjXml7njNaKZEts=
=GnKH
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
