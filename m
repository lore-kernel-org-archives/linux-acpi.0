From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: can't get standby (S1) to work
Date: Sun, 21 Dec 2003 16:29:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031221142916.GG3587@luna.mooo.com>
References: <200312201644.hBKGiX228156@webmail2.cac.psu.edu> <20031221015427.GC3587@luna.mooo.com> <20031221020430.GA24021@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031221020430.GA24021-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 21, 2003 at 03:04:30AM +0100, Karol Kozimor wrote:
> Thus wrote Micha Feigin:
> > swsusp doesn't give you S1 and S3, only S4. For S1 and S3 you'll need
> > 2.6 or apm and a dedicated partition (if your bios supports it).
> 
> Actually, S-states are ACPI-specific and have nothing to do with APM.
> Moreover, a dedicated partition is needed only for S4BIOS or APM
> hibernation and certainly not for S1, S3 or APM suspend / stand-by.
> Best regards,
> 

Sorry, I missed on the partition thing.

As for S1 and S3 you are right, although I was meaning to the suspend
to ram state more then the acpi state.
To be more correct, afaik suspend to ram is only possible on 2.4 with
apm since S1 and S3 are only enabled in 2.6 and not 2.4.
Suspend to disk is possible either with apm (if the bios supports it
using the dedicated partition) and using the swsusp patch which
suspends to swap space.
I hope I got it right this time ;-)

> -- 
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
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
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
