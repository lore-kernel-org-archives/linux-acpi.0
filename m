From: "Polevoy, IgorX" <igorx.polevoy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: enabling ACPI on RH 8
Date: Tue, 8 Apr 2003 11:09:52 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <DFDDBBFBAF6C634BAE34B5F175A29F0227F406@hasmsx403.iil.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
after adding kernel options with "append"  the following appeared
in dmesg, reporting that ACPI was enabled OK: 

apm: BIOS version 1.2 Flags 0x0b (Driver version 1.16)
apm: disabled on user request.
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully
loaded
Parsing
Methods:...........................................................
59 Control Methods found and parsed (196 nodes total)
ACPI Namespace successfully loaded at root c03bd640
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode
successful
Executing device _INI methods:...........................
27 Devices found: 27 _STA, 0 _INI
Completing Region and Field initialization:.......
7/9 Regions, 0/0 Fields initialized (196 nodes total)
ACPI: Subsystem enabled

Still there is no /proc/acpi entry... 
Could be that the problem is now in the old BIOS ? 
Also it reports on reboot about "AWARD Modular BIOS v 4.51PC" and 
"ASUS P2B-N ACPI BIOS Revision 1012", there are no ACPI config options
in BIOS 
setup.

Thanks,
Igor.

> -----Original Message-----
> From: Sebastian Henschel [mailto:shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org]
> Sent: Monday, April 07, 2003 11:20 AM
> To: Polevoy, IgorX
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] enabling ACPI on RH 8
> 
> 
> hello...
> 
> Received at 2003-04-06 / 18:28 by Polevoy, IgorX:
> 
> > I'm trying to enable ACPI on Linux RH 80 (kernel 2.4.18-14) 
> and to run
> > acpid.
> > I succeeded to re-compile and re-boot the kernel with all the
> > ACPI support options selected, however there is no 
> > /proc/acpi created (or other signs of ACPI driver is up). 
> > 
> > How do I enable it? 
> 
> dunno what redhat uses, but:
> 
> check the boot parameters of your kernel, for instance in
> /etc/lilo.conf:
> - look for the line which conains the "append" keyword and 
> replace "apm=on"
> with "apm=off" and "acpi=off" with "acpi=on".
> - save lilo.conf and rerun lilo with "/sbin/lilo".
> 
> if you are running grub it is quite similar, look for the 
> aforementioned
> parameters and change them.
> the important thing is to _not_ have "acpi=off". acpi usually 
> overrides
> apm if both are "on" (either explicitly or implicitly).
> 
> if this does not help, please send the output of "dmesg" after a fresh
> reboot to the list.
> 
> > Has it anything to do with the fact that the APM support is 
> currently
> > enabled ?
> 
> well, compiling both, acpi and apm, into your kernel is usually no
> problem.
> 
> hth,
>  sebastian
> -- 
> ::: sebastian henschel
> ::: kodeaffe
> ::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import
> 


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
