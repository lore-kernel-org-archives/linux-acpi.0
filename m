From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Kernel Oops when loading battery module
Date: 07 Dec 2002 10:01:04 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039273263.2913.23.camel@sirius.strandboge.cxm>
References: <20021207003056.GC8072@homerelay.wiesner-net.de>
	 <1039229157.2913.5.camel@sirius.strandboge.cxm>
	 <20021207142228.GA20455@homerelay.wiesner-net.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021207142228.GA20455-aCYJ90g6FbN3mO1V46hDx7oZL2q1Rlic@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2002-12-07 at 09:22, Markus Wiesner wrote:
> James D Strandboge schrieb:
> > I use bios A04, but tried A07 and had same problem.  A07 would not
> > unblank after a lid event so I went back to A04.
> 
> Try switching to a text console (ctrl-alt-f1) and then back to X
> (alt-f7). After that my display worked again.
> 
I had this all automated with an acpid lid event script to do this
because A04 needed to go to a console and back too.  I don't see why my
script wouldn't work on A07, but I'll disable this script and try again
manually.

> > See thread "[ACPI] Repeatable lockup with sustained polling of battery
> > state" for details on how to reproduce the crash.
> 
> Wish I could test it with the current version. ;-)
> 
yeah

> My only "battery monitor" is a script that "cat"s the state of my two
> batteries to the console on request. Except a slight delay (that seems
> to be normal) and one of the batteries very rarely not being recognized
> I had no problems with the old version, even when running the script
> fast several times.
> 
Could you send me your script (off list)?  My script sounds like it does
the same thing, but I would get this strange hang.  Could you also send
me your dsdt so I can compare it to mine?

While we're at it, can you use the Fn+F1 and Fn+F3 keys while in linux
with acpi?  They do nothing here, but others like Fn+F10 (CD eject)
works fine.  What about Fn+D to blank the screen (doesn't work here)? 
Is acpi compiled as modules?  Do you have an nvidia card, and if so are
you using xfree86 nv driver or Nvidia's nvidia driver?

Sorry for so many questions, but you gave me hope!  :-)

Jamie Strandboge

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
