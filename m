From: Dieter Rohlfing <u490248-uKKRHEr75Vc@public.gmane.org>
Subject: Re: Laptop does not reboot
Date: Sun, 29 Feb 2004 17:16:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40421046.7582AFD3@imail.de>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6F8@PDSMSX403.ccr.corp.intel.com>
Reply-To: u490248-uKKRHEr75Vc@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Luming,

> I think you need to set up serial console to monitor the kernel message
> of rebooting process to sort out valuable clues.

Here are the last lines from my kernel log:

kernel: unloading PCMCIA Card Services
kernel: Kernel logging (proc) stopped.
kernel: Kernel log daemon terminating.

The last message on the console is 'rebooting system ...'. That's all
and then the lights went off. As far as I can see the shutdown process
comes to a complete end. On booting the next time there's no fsck'ing
because of unproperly unmounting.

> I presume that if acpi=off doesn't work, then acpi is exempt from
> any accusation. :)

Sorry, but I do not agree. Suspending and power management is one side
of ACPI, but ACPI is also used to setup und configure the system. As far
as I noted, the kernel still uses some ACPI information to setup up the
system, even if you have 'acpi=off' on your command line. In the case of
'acpi=off' you definitely have no suspend possibilities.

As Bernd Schubert suggested, I'll give kernel 2.6.x a try. In regards to
PCI kernel 2.2.x had a very 'simple' approach (compared with 2.4.x).
2.4.x makes a better job. But with my Dell I7500 it broke something
(okay, I admit the I7500 has a broken BIOS, too). My only hope is that
2.6.x corrects what 2.4.x didn't achieve.

Dieter

-- 
Every mail not from this mailing list will be deleted.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
