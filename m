From: downtime null <downtime-4ZEeE0JWFE8uNY9OAzV8TA@public.gmane.org>
Subject: ACPI on Travelmate c100
Date: Wed, 01 Sep 2004 11:33:20 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094056399.6160.17.camel@zen.localnet>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I'm trying to get the ACPI stuff working an my Acer Travelmate c100.
I've seen a couple of posts about this, but I'm not able to get it
working. I found the patch from John Turney at
http://sourceforge.net/mailarchive/forum.php?thread_id=3854113&forum_id=6102 and manually applied the changes to my kernel, but upon reboot with the new kernel, the system reboots very early in the boot process. I don't understand the kernel code well enough to do much hacking on it, so I was wondering if anyone had any good resources on getting this working. I'm using Fedora Core 2 with the updated kernel.

$ uname -a
Linux zen.localnet 2.6.8-1.521custom #6 Sat Aug 28 18:12:02 CDT 2004
i686 i686 i386 GNU/Linux

Any help is appreciated.

Thanks,

Russell


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
