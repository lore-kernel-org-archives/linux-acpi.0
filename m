From: "Francesco P. Lovergine" <frankie-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Bug#262383: kernel-source-2.6.7: Modular fan support could result in hardware damage
Date: Sat, 31 Jul 2004 09:19:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040731071936.GB29756@ba.issia.cnr.it>
References: <E1Bqe9k-0004hY-Oi@cavan.codon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1Bqe9k-0004hY-Oi-6jgAdWC8pTB4fZfdAStnibVCufUGDwFn@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, 262383-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

severity 262383 important
severity 259481 important
merge 262383 259481
tags 262383 upstream
thanks

Sorry for cross-posting guys, please reply where appropriate only.


Ratio for changing severity: A bug which has a major effect on the usability of a package, without rendering 
it completely unusable to everyone. ACPI issues are not of general interest. It depends on processor, 
kind of system (laptop or desktop). Moreover the issue can be approached by loading fan and thermal module 
in initrd, that is almost at startup.

Debian kernel team: 
Please, consider to set CONFIG_ACPI_BOOT=n
by default in 2.6. I see no reason to have it OFF in 2.4 and ON in 2.6. What's the ratio (if any)?

Acpi-devel list: 
is this a bug in current implementation? Should not the fan stay ON after initialization
up to fan/thermal loading? Or (as I think) it that a damn DSDT bug of some vendors?
Some references for you: 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=259481&msg=20
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=262383




On Fri, Jul 30, 2004 at 09:39:08PM +0100, Matthew Garrett wrote:
> Package: kernel-source-2.6.7
> Severity: critical
> Justification: breaks the whole system
> 
> If the kernel notifies the hardware that it is acpi-aware, then the 
> hardware may hand over control of cooling to the OS. However, if the 
> fan module (and possibly thermal.ko) is not loaded, the OS is unable to 
> do so. This will probably lead to the hardware overheating, resulting in 
> either instability (the hardware will shut itself off) or damage (if the 
> thermal cutoff threshold is set too high). hotplug and discover are 
> unable to automatically load acpi modules at present.
> 
> The acpid package will load acpi modules automatically. However, it's 
> not clear whether it can be installed early enough in a d-i run to be 
> helpful (if the d-i kernel is acpi, then there could be some time before 
> a sensible number of modules have been loaded - a laptop being floppy 
> booted for a network install, for instance).
> 
> -- System Information:
> Debian Release: testing/unstable
>   APT prefers unstable
>   APT policy: (500, 'unstable'), (1, 'experimental')
> Architecture: i386 (i586)
> Kernel: Linux 2.6.7
> Locale: LANG=en_GB.UTF-8, LC_CTYPE=en_GB.UTF-8
> 
> 
> -- 
> To UNSUBSCRIBE, email to debian-kernel-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org

-- 
Francesco P. Lovergine


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
