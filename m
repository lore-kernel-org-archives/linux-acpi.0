From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Kernel Oops when loading battery module
Date: 06 Dec 2002 21:45:58 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039229157.2913.5.camel@sirius.strandboge.cxm>
References: <20021207003056.GC8072@homerelay.wiesner-net.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021207003056.GC8072-aCYJ90g6FbN3mO1V46hDx7oZL2q1Rlic@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-12-06 at 19:30, Markus Wiesner wrote:
> Hi!
> 
> Today I updated from kernel 2.4.20-pre5 with acpi-20020829-2.4.20-pre5
> to kernel 2.4.20 with the new acpi-20021205-2.4.20 patch (no other
> patches applied).
> 
> Unfortunately I have some problems with ACPI now. My system is a Dell
> Inspiron 8200 with bios version A07. ACPI has been compiled as modules.
> 
Have you been able to use a battery monitor without crashing your
machine with any version of acpi?  I have the same machine as you, but
sustained polling of /proc/acpi/battery/BAT1/state causes a system hang
with no errors.

I use bios A04, but tried A07 and had same problem.  A07 would not
unblank after a lid event so I went back to A04.

See thread "[ACPI] Repeatable lockup with sustained polling of battery
state" for details on how to reproduce the crash.

James Strandboge

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
