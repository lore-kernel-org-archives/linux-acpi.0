From: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Subject: Re: Kernel Oops when loading battery module
Date: Sun, 8 Dec 2002 14:23:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021208132315.GC21604@homerelay.wiesner-net.de>
References: <20021207003056.GC8072@homerelay.wiesner-net.de> <1039229157.2913.5.camel@sirius.strandboge.cxm> <20021207142228.GA20455@homerelay.wiesner-net.de> <1039273263.2913.23.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1039273263.2913.23.camel-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

James D Strandboge schrieb:
> While we're at it, can you use the Fn+F1 and Fn+F3 keys while in linux
> with acpi?  They do nothing here, but others like Fn+F10 (CD eject)
> works fine.  What about Fn+D to blank the screen (doesn't work here)? 

As Matthew Tippett already wrote: a certain module (can't remember which
one, acpi or i8k) disables those functions.

> Is acpi compiled as modules?  Do you have an nvidia card, and if so are
> you using xfree86 nv driver or Nvidia's nvidia driver?

ACPI is compiled as modules and i have a nvidia card with the 1.0-3123
driver from nvidia.

Markus Wiesner


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
