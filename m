From: "David Cougle" <dcougle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: how to get Fn key working on compaq 2100/2110
Date: Sun, 22 Jun 2003 13:40:51 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Law9-F13aCdhxJKocJq0002f84d@hotmail.com>
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
To: markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

cat /proc/acpi/sleep
S0 S3 S4 (swsusp) S5

I just have heard of people who are able to skip past kernel and force 
suspend to ram.
was wondering if i could do this.


>From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
>To: David Cougle <dcougle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
>Subject: Re: [ACPI] how to get Fn key working on compaq 2100/2110
>Date: Sun, 22 Jun 2003 20:22:43 +0200 (CEST)
>
> > nevermind, fn and some keys work, but fn and the suspend key does
> > nothing. does this mean my laptop does not have suspend to ram? i have
> > compaq 2100/2110
>Try to do 'cat /proc/acpi/sleep' and see if it supports S1 or S3.
>Then do
>echo 1 > /proc/acpi/sleep
>(or echo 3)
>If your laptop supports sleep, then it should work. The sleep button alone
>only creates an event, it is not directly associated with sleeping. This
>way you can run a script that asks the user if he really wants to suspend,
>etc.
>Generally, suspend with ACPI doesn't work on many laptops yet. This should
>become better with kernel 2.6.
>
>Markus
>
>--
>__________________    /"\
>Markus Gaugusch       \ /    ASCII Ribbon Campaign
>markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org     X     Against HTML Mail
>                       / \

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
