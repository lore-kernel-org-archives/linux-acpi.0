From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Fri, 30 Jul 2004 17:10:28 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040730141028.GE21359@luna.mooo.com>
References: <1091139240.26511.9.camel@6-allhosts>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1091139240.26511.9.camel-0uShlLfvWR/1N/xxgP7OLA@public.gmane.org>
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

On Thu, Jul 29, 2004 at 10:14:00PM +0000, Andrew Barr wrote:
> I just bought a Radeon 7000 video card on-line. What is the status of
> and plans for power management support for this card? I read
> Documentation/power/video.txt, and it says that I can't have framebuffer
> console. That could be a problem as I use bootsplash. It also says I
> need a patched X server. My Google search turned up a page concerning
> S3/Radeon that says the patch is no longer necessary (I can't find the
> URL at the moment, sorry). Any thoughts, tips, tricks, etc. would be
> greatly appreciated.
> 

I am not sure about the current state of things. AFAIK the problem was
with dri suspend support for radeon, and at the time at least, the card
was reset on VT switch to enable suspend. IIRC the patch was
incorporated into main the main tree quite some time ago.

I have no experience with S3 suspend (my laptop doesn't seem to support
it) but it does suspend with swsusp2 if I switch VT.

> Regards,
> Andrew Barr
> 
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
