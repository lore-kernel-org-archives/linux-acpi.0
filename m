From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: 8259A initialization oops after resume
Date: Tue, 17 Jun 2003 22:03:51 +1200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1055844231.3126.24.camel@laptop-linux>
References: <m2ptlf3vlb.fsf@tnuctip.rychter.com>
 <20030617095829.GX19556@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030617095829.GX19556-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

I've got a small patch in the latest swsusp version that disables
reinitialising the 8259A after swsusp. This seems to fix the issues
under 2.4.

Regards,

Nigel

On Tue, 2003-06-17 at 21:58, Ducrot Bruno wrote:
> On Sun, Jun 15, 2003 at 02:00:00PM -0700, Jan Rychter wrote:
> > People are getting a particular kind of oops after resuming from S4
> > (implemented by swsusp). I'm posting this here, because the problem
> > seems not to be specific to swsusp.
> > 
> > Hopefully some people on this list will know how and why the 8259A needs
> > to be initialized upon resuming from S4 and why it fails.
> > 
> > The oops is reproducible -- one may do a number of suspend/resume cycles
> > without it, but once it appears, it will reappear on every subsequent
> > resume.
> 
> This was done but with S4Bios in mind, not with S4 via swsusp, and is
> actually a (bad) hack, since that can not handle all cases.
> A better way is done under 2.5.
> 
> Actually, there are many others troubles with
> 'echo 4 > /proc/acpi/sleep' and swsusp (fe, the devices are powered
> down twice, via ACPI _and_ swsusp), which is bad.  Better is
> to use the swsusp own way to suspend, not via 'echo 4 > /proc/acpi/sleep'
> which is IMO broken.
> 
> Under 2.5, the situation is different.
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
