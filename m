From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: ACPI + IO-APIC power off by button problems
Date: Sun, 2 Mar 2003 14:46:47 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <33039.4.64.238.61.1046645207.squirrel@www.osdl.org>
References: <3E6270B8.4070805@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E6270B8.4070805-nc/lrvXPQ4s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: voloterreno-nc/lrvXPQ4s@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> I can't post my dmesg , or , better, it will be unuseful , because I use
> Software RAID, and Software RAID makes very much output that delete the
> first part of my dmesg (the part that you need). If this can be useful  to
> you when the system starts I see a message like "No IRQ Known for  device
> X.XX.X using IRQ 255 " and " try to start with option pci=noacpi"  or
> something like that.

You could modify the kernel's log buffer size, rebuild the
kernel, and save the boot log from that larger log buffer.

I don't know what kernel version you are using, but in
2.5.recent, there's a config option to change the log buffer
size, and in 2.4.recent, you can edit
linux/kernel/printk.c (cut-n-paste below) to change it:

#if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
#define LOG_BUF_LEN	(65536)
#elif defined(CONFIG_ARCH_S390)
#define LOG_BUF_LEN	(131072)
#elif defined(CONFIG_SMP)
#define LOG_BUF_LEN	(32768)
#else
#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
#endif

Just make sure that you set it to a power of 2.

~Randy





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
