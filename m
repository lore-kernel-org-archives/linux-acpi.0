From: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Subject: Re: Kernel Oops when loading battery module
Date: Sat, 7 Dec 2002 15:22:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021207142228.GA20455@homerelay.wiesner-net.de>
References: <20021207003056.GC8072@homerelay.wiesner-net.de> <1039229157.2913.5.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1039229157.2913.5.camel-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

James D Strandboge schrieb:
> On Fri, 2002-12-06 at 19:30, Markus Wiesner wrote:
>> Today I updated from kernel 2.4.20-pre5 with acpi-20020829-2.4.20-pre5
>> to kernel 2.4.20 with the new acpi-20021205-2.4.20 patch (no other
>> patches applied).
>> 
>> Unfortunately I have some problems with ACPI now. My system is a Dell
>> Inspiron 8200 with bios version A07. ACPI has been compiled as modules.
>> 
> Have you been able to use a battery monitor without crashing your
> machine with any version of acpi?  I have the same machine as you, but
> sustained polling of /proc/acpi/battery/BAT1/state causes a system hang
> with no errors.

I can't even load the battery module. I get the kernel Oops when I try
it, /proc/acpi/battery then exists but is empty and the modules stays in
the state "initializing".

> I use bios A04, but tried A07 and had same problem.  A07 would not
> unblank after a lid event so I went back to A04.

Try switching to a text console (ctrl-alt-f1) and then back to X
(alt-f7). After that my display worked again.

> See thread "[ACPI] Repeatable lockup with sustained polling of battery
> state" for details on how to reproduce the crash.

Wish I could test it with the current version. ;-)

My only "battery monitor" is a script that "cat"s the state of my two
batteries to the console on request. Except a slight delay (that seems
to be normal) and one of the batteries very rarely not being recognized
I had no problems with the old version, even when running the script
fast several times.

Markus Wiesner


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
