From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: ACPI/ECDT on gateway 200x notebook
Date: Tue, 13 Jan 2004 10:26:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040113102659.63abd927.greg@morningdave.org>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84E7B@PDSMSX403.ccr.corp.intel.com>
	<20040107105424.GM14031@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040107105424.GM14031-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

   I just wanted to send along an update on this, rather than continue to clutter bug 1744 with potentially unrelated issues.

   First off, the AE_BAD_PARAMETER issue is defiintely caused by the DWordAcc in the _GPE method. Using the bit_width patch from bug 1744 masks this error. Overriding the DSDT with the new Gateway 200X DSDT on acpi.sourceforge.net fixes it. Both of these options restore fan, thermal and button functionality. The lid is not fully supported with the bit_width patch, but the fixed DSDT restores the lid fully. The adapter and battery are still missing after applying either solution. This is apparently because of the missing ECDT.

   To fix the ECDT problem, I have now tried both this patch and the fake_ecdt patch that can be found somewhere in this thread: http://sourceforge.net/mailarchive/message.php?msg_id=6514510

   I have used them with kernel 2.4.23 and 2.4.24. As far as I know, neither will apply to 2.6.x. Both patches restore the ac adapter and the battery, which is terrific. The parameter to pass to the kernel for the fake_ecdt patch is:

   ecdt_fake=0x66:0x62:0x1c:0x01:\_SB_.PCI0.LPCB.H_EC

   There are two differences between the approaches. The fake_ecdt patch yields a single H_EC subdirectory under /proc/acpi/embedded_controller, while the bugzilla patch gives me two. However, using the fake_ecdt patch gives me an error in dmesg which is not present with the other patch. The relevant section is:

ACPI: Faking ECDT
schedule_task(): keventd has not started
evregion-0249 [21] ev_address_space_dispa: no handler for region(df6d0188) [SystemMemory]
 exfldio-0282 [20] ex_access_region      : Region SystemMemory(0) has no handler
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.H_EC._REG] (Node c15dfae8), AE_NOT_EXIST
ACPI: Could not use ECDT


   Note that it says that it couldn't use the ECDT, but I do have my battery and adapter info, so I think it is. I'm not exactly sure what this error means, or if it is anything to be concerned about, since I dont see it with the other patch. Any ideas?

   Also, please let me know if I should append this to bug 1744. I think that we already have two unrelated problems being covered there (buggy DSDT and missing ECDT), and I didn't want to introduce a third ;)

   Thanks,
    Greg



On Wed, 7 Jan 2004 11:54:24 +0100
Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:

> On Wed, Jan 07, 2004 at 09:04:25AM +0800, Li, Shaohua wrote:
> > Yes, the patch may resolve some problems, but it is just a workaround. I guess a possible solution is if ECDT is lacked, scan namespace to get EC device's info, such as GPE, IO ports, then use these info to automatically make a fake ECDT. Because getting info doesn't involve any operating on EC device, it's feasible. A problem is if a system has more than 1 EC, how do we?
> > 
> 
> Yes, exactly.  Anyway, io ports 0x62, 0x66 are the legacy access
> for the "main" EC.  Perhaps checking those ports and initilializing
> that one only may be OK?
> 
> -- 
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
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
