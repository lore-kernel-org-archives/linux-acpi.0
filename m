From: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Subject: Re: Kernel Oops when loading battery module
Date: Mon, 9 Dec 2002 01:02:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021209000245.GA22707@homerelay.wiesner-net.de>
References: <20021207003056.GC8072@homerelay.wiesner-net.de> <1039229157.2913.5.camel@sirius.strandboge.cxm> <20021207142228.GA20455@homerelay.wiesner-net.de> <1039273263.2913.23.camel@sirius.strandboge.cxm> <20021208132229.GB21604@homerelay.wiesner-net.de> <1039367266.1416.3.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1039367266.1416.3.camel-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org>
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
> Well, I recompiled with 20020829 and 2.4.20-pre5-- still have the same
> problem.  Can you run the attached script with your working
> configuration and let me know if your laptop locks up?  Feel free to go
> in single user mode-- I don't need X or anything running to get the
> lockup.

Test 1:
ac-adapter attached, output redirected to /tmp/acpi.log (tmpfs) so that
the svga-framebuffer console does not slow down things. No lockup,
stopped test at 10000.

Test 2:
Output to console, somewhere between 4000 and 5000 i removed the power
chord. At about 5800 the system locked up! Sysrq-key still worked, as
well as ping from an external host, but nothing else. Alt-SysRq-k (kill
programs on current console) did not help. At least I could sync and
unmount before reboot. :-)

Test 3 (after the reboot, nice to have a journaling filesystem :-) ):
Output to console, system running on battery. This time as in the first
test no lockup, stopped the test at 10000.

So there is something wrong anywhere, but it's a bit difficult to
reproduce.

Markus Wiesner


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
