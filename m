From: Tobias Grimm <listaccount-ztmIXtBW4J6sTnJN9+BGXg@public.gmane.org>
Subject: shutdown comand and wakeup
Date: Mon, 23 Feb 2004 00:16:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40393853.9090704@e-tobi.net>
Reply-To: listaccount-ztmIXtBW4J6sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I'm running a kernel 2.4.24 with patch acpi-20040211-2.4.24. Generaly, this 
seems to work. I.e., I can do this:

echo 2004-02-22 15:00:00 >/proc/acpi/alarm
echo 5 >/proc/acpi/sleep

As expected, the computer will start up at the given time.

But when I shutdown with "shutdown -h 0" instead of "echo 5 >/proc/acpi/sleep", 
the computer will not wakeup at the programmed time.

I've disabled APM with "apm=off" as kernel parameter, so I thought shutdown 
should use ACPI to switch to S5, shouldn't it?

Any ideas what I did wrong or what I might have missed?

Thanks,

Tobias



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
