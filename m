From: Herman Sheremetyev <hsheremetyev-yhWOWVs/RhdYAqn04ObX1A@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Sat, 20 Mar 2004 12:27:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079803656.32419.15.camel@djinn>
References: <404459FD.1000406@pca.it>  <405C1D0F.3030209@pca.it>
Reply-To: hsheremetyev-yhWOWVs/RhdYAqn04ObX1A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <405C1D0F.3030209-wlebWZzHoyE@public.gmane.org>
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

Hi Luca,

With a little DSDT tweak I get the following output:

$ cat /proc/acpi/processor/CPU1/*
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      yes
limit interface:         yes
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000]
usage[00024090]
   *C2:                  promotion[--] demotion[C1] latency[099]
usage[00991232]
    C3:                  <not supported>
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%

The fix requires simply changing one value in the DSDT from: 

Processor (CPU1, 0x01, 0x00000410, 0x07) 

to: 

Processor (CPU1, 0x01, 0x00000410, 0x06) 

You can find more details on the forum I started dedicated to Linux on
the M6N series laptops:

http://mrhammy2.ath.cx:81/forum/viewforum.php?f=1

-Herman

On Sat, 2004-03-20 at 05:29, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> I tried kernel 2.6.5-rc1 with a new BIOS 0206A, but still the same problem. It
> seems that Bruno's patches (which at least let me have C1 & C2) haven't been
> applied yet.
> 
> On the other hand, without Bruno's patches I get:
> =====
> gismo:~# cat /proc/acpi/processor/CPU1/*
> processor id:            0
> acpi id:                 1
> bus mastering control:   yes
> power management:        no
> throttling control:      no
> limit interface:         no
> <not supported>
> active state:            C1
> default state:           C1
> bus master activity:     00000000
> states:
>    *C1:                  promotion[--] demotion[--] latency[000] usage[00000000]
>     C2:                  <not supported>
>     C3:                  <not supported>
> <not supported>
> gismo:~#
> =====
> 
> This output is the same if I use the original DSDT or a modified one to have
> battery support.
> 
> Question: with Bruno's patches, I never got C3 (neither the 'C3 <not supported>'
> message), so, could it be that my laptop doesn't support C3 but C4?
> 
> Attached the new DSDT from BIOS 0206A.
> 
> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQFAXB0PVAp7Xm10JmkRAoEWAJ45t856zXKbUIy3GvtWvccmqp36gwCfXQLF
> R7Sgufi/xSxec77YWZLYhj4=
> =93t0
> -----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
