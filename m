From: Malte Cornils <mcornils-mcycREo4Un4@public.gmane.org>
Subject: Re: ACPI breakage (was: 2.6.x: local APIC results in hang at boot)
Date: Mon, 1 Mar 2004 22:02:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200403012202.16728.mcornils@usta.de>
References: <200402031047.i13Algrs019289@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402031047.i13Algrs019289-gq7oiAaKCbRt3AgVzhmPzw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(Mail was on linux-kernel, now moving to acpi-devel as requested)

Am Dienstag, 3. Februar 2004 11:47 schrieb Mikael Pettersson:
> On 2004-02-03, Malte Cornils wrote:
> >I've tested this with 2.6.2-rc3 and kernels before that; when I activate
> >the "Enable local APIC" question the kernel hangs with:
> >
> >POSIX conformance testing by UNIFIX
> >enabled ExtInt on CPU#0
> >ESR value before enabling vector: 00000000
> >ESR value after enabling vector: 00000000
> >Using local APIC timer interrupts.
> >calibrating APIC timer ...
> >..... CPU clock speed is 1399.0856 MHz.
> >..... host bus clock speed is 99.0989 MHz.
> >NET: Registered protocol family 16
> >EISA bus registered
> >PCI: Using configuration type 1
> >mtrr: v2.0 (20020519)
> >ACPI: Subsystem revision 20040116
> >ACPI: IRQ9 SCI: Edge set to Level Trigger.
> >
> >and then nothing happens.
> >
> >On request, I can send the boot log from the same kernel without local
> >APIC compiled-in; you can also get it from
> >http://www.usta.de/RefAk/Aussen/privat/apic-works.log
> >
> >As I said, it works without the option. (So, this is a problem for
> >people using distribution/generic kernels with the Local-APIC option
> >enabled)
> >
> >This is an Asus Centrino notebook (M2400N) with 1,4 GHz, latest BIOS
> >update and so on. When I enable the local APIC but disable ACPI, it
> >works too - ACPI is used to reroute some interrupts and make e.g. sound
> >work.
>
> This clearly indicates ACPI breakage on your machine.
> Re-report it as such to the ACPI list.

I've added some further info. You can find the dmidecode and biosdecode info 
on: 
http://www.usta.de/RefAk/Aussen/privat/dmidecode.log
http://www.usta.de/RefAk/Aussen/privat/biosdecode.log

Thanks for looking into that,
-Malte

PS: Please Cc: me, I am not subscribed


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
