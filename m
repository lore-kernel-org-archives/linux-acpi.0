From: linux-JhLEnvuH02M@public.gmane.org
Subject: [PATCH] acpi 2.6: consistent user-forced throttling (9/8) [Was: Re: [PATCHES] ACPI Processor update [idle, throttling, thermal, cpufreq]]
Date: Wed, 10 Sep 2003 02:17:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030910001716.GA10324@brodo.de>
References: <20030904222434.GC6350@brodo.de> <20030908132939.GD3944@openzaurus.ucw.cz> <20030909172135.GA4106@brodo.de> <20030909231303.GH211@elf.ucw.cz> <20030909232916.GA9561@brodo.de> <20030910000041.GC217@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030910000041.GC217-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

As Pavel Machek has noted, it may be desireable for an user to force a
ceratin throttling level which is kept even if a thermal "decrease cooling"
commands are issued. So, save the user input, and make sure throttling is at
least set to this user_state

diff -ruN linux-original/drivers/acpi/processor_throttling.c linux/drivers/acpi/processor_throttling.c
--- linux-original/drivers/acpi/processor_throttling.c	2003-09-09 23:07:10.000000000 +0200
+++ linux/drivers/acpi/processor_throttling.c	2003-09-10 02:13:05.491536944 +0200
@@ -77,6 +77,7 @@
 struct acpi_processor_throttling {
 	acpi_handle		handle;
 	int			state;
+	int			user_state;
 	u32			address;
 	u8			duty_offset;
 	u8			duty_width;
@@ -211,8 +212,9 @@
 
 	seq_puts(seq, "states:\n");
 	for (i = 0; i < throttle_data[cpu].state_count; i++)
-		seq_printf(seq, "   %cT%d:                  %02d%%\n",
+		seq_printf(seq, " %c%cT%d:                  %02d%%\n",
 			(i == throttle_data[cpu].state?'*':' '), i,
+			(i >= throttle_data[cpu].user_state?'u':' '), i,
 			(throttle_data[cpu].states[i].performance?throttle_data[cpu].states[i].performance/10:0));
 
 end:
@@ -252,6 +254,8 @@
 	if (result)
 		return_VALUE(result);
 
+	throttle_data[cpu].user_state = simple_strtoul(state_string, NULL, 0);
+
 	return_VALUE(count);
 }
 
@@ -536,6 +540,9 @@
 	if (throttle_data[cpu].state == 0)
 		return -ERANGE;
 
+	if (throttle_data[cpu].state == throttle_data[cpu].user_state)
+		return -ERANGE;
+
 	ret = acpi_processor_set_throttling(cpu, throttle_data[cpu].state - 1);
 
 	return ret;




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
