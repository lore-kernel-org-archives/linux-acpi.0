From: "David Cougle" <dcougle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: PLEASE, patches after pre6 lock up!
Date: Thu, 19 Jun 2003 20:40:17 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Law9-F694db6OrYXPM600016745@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

thanks, that worked.

if you have compaq 2100/2110, removing enhanced rtc from kernel should make 
latest patch work.

>From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
>To: David Cougle <dcougle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
>CC: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] PLEASE, patches after pre6 lock up!
>Date: Thu, 19 Jun 2003 11:18:52 +0200
>
>Hi,
>
>On Wed, Jun 18, 2003 at 10:22:08PM -0500, David Cougle wrote:
> > I have posted this repeatedly, but never get a response, and there
> > continues to be releases which have the same problem.
>
>I should be blind, but I see only 2 post from you on this topic
>this month in acpi-devel mailing-list?
>
> > Starting with acpi patch rc1, it causes lock ups. rc2 and rc3 did the
> > same(on boot).
> > I am now having to use 2.4.21 with acpi pre6 patch.
> >
> > i have compaq 2100/2110
> >
>
>If you have an ALi based system, do not use Ehanced Real Time
>Clock (due to probably a bug in acpi?).
>
>Cheers,
>
>--
>Ducrot Bruno
>
>--  Which is worse:  ignorance or apathy?
>--  Don't know.  Don't care.
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: INetU
>Attention Web Developers & Consultants: Become An INetU Hosting Partner.
>Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
>INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
