From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Radeon S3/resume: VGA ROM POST from kernel
Date: Mon, 19 Jul 2004 19:38:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200407191938.17104.stefandoesinger@gmx.at>
References: <yzoy8lggx6v.fsf_-_@localhost.localdomain>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <yzoy8lggx6v.fsf_-_-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: ole.rohne-vJEk5272eHo@public.gmane.org, aman-e31a5gnSYeGubukWoKzokaxOck334EZe@public.gmane.org, emmanuel.thome-/zGXu1G9BXs@public.gmane.org, software-v2/BnvaKusE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
> I've implemented VGA POSTing using a real-mode tunnel from kernel
> space. IMO, this has some advantages over user space methods:
Great!!!!
For some reason, it doesn't work for me(Kernel 2.6.8-rc2). I cleaned up my 
source directory and I'll try again with a clean build again. If it doesn't 
work I'll try 2.6.7.

Do I need any other patches?

> 1. It works with the aty/radeon_pm.c resume code. I don't see how to
>    easily achieve this with user space methods.
Do you have radeonfb and fbcon loaded(or compiled into the kernel)?

> 2. Real mode seems faster than userspace vm86

> 3. It is the right way. Bringing up the hardware is clearly the
>    responsibility of the kernel/drivers resume code.
Agreed. Someone wrote that this reset can't be performed by kernel code.

This is really great, and as soon as it works for me I'll upload it to my 
website.

Cheers,
Stefan


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
