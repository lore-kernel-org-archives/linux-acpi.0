From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: a bit confused
Date: Sat, 22 Nov 2003 22:54:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031122205430.GB5895@luna.mooo.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00147D322@hdsmsx402.hd.intel.com> <20031121230021.A18194@winksmith.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031121230021.A18194-Wx4BgtDyjI+1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 21, 2003 at 11:00:21PM -0500, mark.acpi-Wx4BgtDyjI+1Z/+hSey0Gg@public.gmane.org wrote:
> On Thu, Nov 20, 2003 at 10:41:26PM -0500, Brown, Len wrote:
> > If it does not and you'd like to try the latest ACPI patch, the oldest
> > kernel we support is 2.4.22:
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.22
> 
> i have a debian 2.4.22 (some small amount of magic foo patched in
> already).  would you happen to know if that patch apply to my kernel?
> i've read some conflicting stuff about it.
> 
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.ACPI
> 
> debian isn't mentioned in it.

Can't tell you definitily. I don't think the debian patches include the
acpi patch (probably not the latest).
If you have the debian kernel sources, you could try applying the patch
using the --dry-run flag to patch (will not actually do anything on
disk, just display the result). See if you get any rejects. What you
should be looking for is wether you get a message in the form patch
already played should assume -R (I don't remember the exact wording
now).

> 
> thanks.
> 
> -- 
> Mark Smith
> mark-Wx4BgtDyjI+1Z/+hSey0Gg@public.gmane.org
> mark at tux dot org
> nova-instructor at tux dot org
> F: 775-522-8479
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
