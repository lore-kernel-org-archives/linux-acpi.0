From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Fri, 30 Jul 2004 22:00:47 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040730190047.GH21359@luna.mooo.com>
References: <1091139240.26511.9.camel@6-allhosts> <20040730141028.GE21359@luna.mooo.com> <20040730162756.4f300a5c@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040730162756.4f300a5c-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
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

On Fri, Jul 30, 2004 at 04:27:56PM +0200, wwp wrote:
> Hello Micha,
> 
> 
> On Fri, 30 Jul 2004 17:10:28 +0300 Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org> wrote:
> 
> [snip]
> > I am not sure about the current state of things. AFAIK the problem was
> > with dri suspend support for radeon, and at the time at least, the card
> > was reset on VT switch to enable suspend. IIRC the patch was
> > incorporated into main the main tree quite some time ago.
> > 
> > I have no experience with S3 suspend (my laptop doesn't seem to support
> > it) but it does suspend with swsusp2 if I switch VT.
> 
> I m just curious: do you switch to VT or do you close X and return to console
> (or even do `init 2`)?
> 

I have a script that basically does

VT=`fgconsole`
chvt 9
echo 4 > /proc/acpi/sleep (or whatever sleep command you use)
chvt $VT

This changes to a console terminal before suspend, suspends, and on
resume switches back to X. This will also reset the card properly. Its
actually a mach64 and not a radeon, but I ported the relevant portions
of the radeon dri driver PM to the mach64. Note though that mach64
needs no kernel PM support, its all done on the X side (didn't find out
yet how to do it on the kernel side, although I hope to do that when I
have them time, that would save the VT switch).

> 
> Regards,
> 
> -- 
> wwp
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the changes on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
> one more big change to announce. We are now OSTG- Open Source Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
