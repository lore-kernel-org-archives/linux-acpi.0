From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: 8259A initialization oops after resume
Date: Tue, 17 Jun 2003 11:58:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030617095829.GX19556@poupinou.org>
References: <m2ptlf3vlb.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2ptlf3vlb.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 15, 2003 at 02:00:00PM -0700, Jan Rychter wrote:
> People are getting a particular kind of oops after resuming from S4
> (implemented by swsusp). I'm posting this here, because the problem
> seems not to be specific to swsusp.
> 
> Hopefully some people on this list will know how and why the 8259A needs
> to be initialized upon resuming from S4 and why it fails.
> 
> The oops is reproducible -- one may do a number of suspend/resume cycles
> without it, but once it appears, it will reappear on every subsequent
> resume.

This was done but with S4Bios in mind, not with S4 via swsusp, and is
actually a (bad) hack, since that can not handle all cases.
A better way is done under 2.5.

Actually, there are many others troubles with
'echo 4 > /proc/acpi/sleep' and swsusp (fe, the devices are powered
down twice, via ACPI _and_ swsusp), which is bad.  Better is
to use the swsusp own way to suspend, not via 'echo 4 > /proc/acpi/sleep'
which is IMO broken.

Under 2.5, the situation is different.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
