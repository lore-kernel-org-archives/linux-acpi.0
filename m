From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Kernel Oops when loading battery module
Date: 08 Dec 2002 23:08:57 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039406937.1443.5.camel@sirius.strandboge.cxm>
References: <20021207003056.GC8072@homerelay.wiesner-net.de>
	 <1039229157.2913.5.camel@sirius.strandboge.cxm>
	 <20021207142228.GA20455@homerelay.wiesner-net.de>
	 <1039273263.2913.23.camel@sirius.strandboge.cxm>
	 <20021208132229.GB21604@homerelay.wiesner-net.de>
	 <1039367266.1416.3.camel@sirius.strandboge.cxm>
	 <20021209000245.GA22707@homerelay.wiesner-net.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021209000245.GA22707-aCYJ90g6FbN3mO1V46hDx7oZL2q1Rlic@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2002-12-08 at 19:02, Markus Wiesner wrote:
> James D Strandboge schrieb:
> > Well, I recompiled with 20020829 and 2.4.20-pre5-- still have the same
> > problem.  Can you run the attached script with your working
> > configuration and let me know if your laptop locks up?  Feel free to go
> > in single user mode-- I don't need X or anything running to get the
> > lockup.
> 
> Test 1:
> ac-adapter attached, output redirected to /tmp/acpi.log (tmpfs) so that
> the svga-framebuffer console does not slow down things. No lockup,
> stopped test at 10000.
> 
> Test 2:
> Output to console, somewhere between 4000 and 5000 i removed the power
> chord. At about 5800 the system locked up! Sysrq-key still worked, as
> well as ping from an external host, but nothing else. Alt-SysRq-k (kill
> programs on current console) did not help. At least I could sync and
> unmount before reboot. :-)
> 
> Test 3 (after the reboot, nice to have a journaling filesystem :-) ):
> Output to console, system running on battery. This time as in the first
> test no lockup, stopped the test at 10000.
> 

I get the lockup circa 16000 without having to remove the ac adapter. 
My host is pingable too, and some keyboard keys work (like CapsLock),
but otherwise dead.  I can also use Fn+F10 to eject the cdrom.  I didn't
try SysRq.

Sorry it is affecting you-- this bug will bite on a regular battery
monitor that continuously polls every 2 seconds (like gnome battstat),
but I am glad to know that it isn't some hardware issue or something on
my end.

Jamie

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
