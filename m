From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: testing ACPI under 2.5 with / on LVM
Date: Fri, 11 Oct 2002 16:54:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021011145413.GA708@elf.ucw.cz>
References: <21870.1033647384@www63.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <21870.1033647384-0mmRn995n8Bmcu3hnIyYJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Markus Weiss <mweiss38-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I would like to test ACPI under a recent 2.5 kernels on my laptop
> (especially 
> because of S4 support). Unfortunately I have the root filesystem on LVM, a
> fact 
> which makes testing under 2.5 a little complicated. Someone on linux-kernel 
> suggested to use a recent version of evms for 2.5, but I am afraid that evms
> will 
> not play nicely together with S4/swsusp. 
> Does anyone have suggestions / comments ? 

There's no reason evms should collide with swsusp. Of course probably
noone tested that. ... Just dont have your swap partition handled by LVM.

									Pavel
-- 
I'm pavel-7aPAsKgELzg@public.gmane.org "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss-q33YXrgyAoMgsBAKwltoeQ@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
