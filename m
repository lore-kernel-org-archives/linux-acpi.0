From: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Subject: RE: Processor C states and USB problem
Date: Fri, 9 Jan 2004 11:05:23 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0401091102120.20682@pcd403z.vsb.cz>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84E6C@PDSMSX403.ccr.corp.intel.com>
 <1073640699.10144.14.camel@ltspc67.epfl.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1073640699.10144.14.camel-TVkb0Wta32GnwOLKaxbZ/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Diego SANTA CRUZ <Diego.SantaCruz-p8DiymsW2f8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


in 2.4 kernel I have to unload all usb modules. Then power drop to C3
state. If I remember, only usbcore can be loaded (on my D600).

poli


On Fri, 9 Jan 2004, Diego SANTA CRUZ wrote:

> Hi,
>
> I picked up this thread and I'm interested in knowing a bit more about
> bus mastering and C3, as my laptop never goes into C3. I own a Dell
> Inspiron 8500 (details at
> http://ltswww.epfl.ch/~dsanta/resources/dell-i8500-linux).
>
> This is what I get for the power states:
> # cat /proc/acpi/processor/CPU0/power
> active state:            C2
> default state:           C1
> bus master activity:     ffffffff
> states:
>     C1:                  promotion[C2] demotion[--] latency[000] usage[00039800]
>    *C2:                  promotion[C3] demotion[C1] latency[050] usage[00573330]
>     C3:                  promotion[--] demotion[C2] latency[050] usage[00000004]
>
> I tried booting with init=/bin/sh and manually loading the processor
> module, without any external hardware attached, so that no special
> hardware is initialized, but still there is non-stopping bus mastering
> activity. What could be causing it? Any ideas how could I find out?
>
> BTW, I'm running the latest Fedora Core 1 kernel (2.4.22-1.2140.nptl)
>
> Thanks for any info,
>
> Diego
>
> On Mon, 2004-01-05 at 10:06, Li, Shaohua wrote:
> > Hi,
> > C3 is a kind of idle, it means deep power saving.
> > Actually, I observed the same symptom as you: USB devices caused many bus master activities, which make processor can't enter C3.
> >
> > Thanks,
> > Shaohua
>
> --
> -------------------------------------------------------
> Diego Santa Cruz - PhD
> Publications available at http://ltswww.epfl.ch/~dsanta
> Signal Processing Institute (LTS1 / ITS / STI)
> Swiss Federal Institute of Technology (EPFL)
> EPFL - STI - ITS, CH-1015 Lausanne, Switzerland
> E-mail:     Diego.SantaCruz-p8DiymsW2f8@public.gmane.org
> Phone:      +41 - 21 - 693 26 57
> Fax:        +41 - 21 - 693 76 00
> -------------------------------------------------------
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Perforce Software.
> Perforce is the Fast Software Configuration Management System offering
> advanced branching capabilities and atomic changes on 50+ platforms.
> Free Eval! http://www.perforce.com/perforce/loadprog.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
