From: Maier Gerfried <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Re: Oops when unloading thermal
Date: Tue, 12 Nov 2002 08:01:37 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037084497.3dd0a751f1bb9@sbox.tugraz.at>
References: <1036566482.3dc8bfd26902e@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1036566482.3dc8bfd26902e-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The patch from BK

| --- 1.9/drivers/acpi/bus.c	Mon Nov  4 09:59:35 2002
| +++ 1.10/drivers/acpi/bus.c	Fri Nov  8 14:33:09 2002
| @@ -1072,6 +1072,8 @@
| 		return_VALUE(result);
| 	}
| 
|+	device->driver = driver;
|+
| [...]

made the Oops disappear. Modules unload now as I expect them. Thanks for this 
suggestion!

Maier Gerfried








Zitiere moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org:

> Hello,
> 
> I was now able to compile a kernel which boots correctly with acpi
> enabled 
> (2.4.20-rc1 with the recent patch). Loading all the acpi-modules (fan,
> battery, 
> ac, thermal, prcessor,...) is done without any error, but when I try to
> unload 
> thermal
> 
> > modprobe -r thermal
> 
> Oops 0000
> CPU: 0
> EIP: 0010:[<d0a39490>] Not tainted
> EFLAGS: 00010286
> .
> .
> .
> code: Bad EIP value
> <0> Kernel panic: Attempted to kill idle task!
> In idle-task - not syncing
> 
> What can I do about this?
> 
> Thanks,
> Maier Gerfried


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
