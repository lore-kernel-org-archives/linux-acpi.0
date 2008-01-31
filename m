From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH/RFC] powertop non-ACPI: use CPUidle for C-state details
Date: Wed, 30 Jan 2008 21:06:50 -0800
Message-ID: <87y7a6bn2t.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:22363 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYAaFGw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 00:06:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: discuss@lesswatts.org
Cc: Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On systems without ACPI, query the CPUidle sysfs interface for C-state
details.  It uses the CPUIdle stateN/usage and stateN/time files for
the 'usage' and 'duration' values used for calculations in powertop.

For now, if both ACPI and CPUidle are present, it will read data from
the ACPI /proc interface instead of CPUidle, but if ACPI is not
present, it will fallback to CPUidle.

Tested against a CPUidle enabled 2.6.24 non-x86 kernel (TI OMAP3.)

Patch against powertop-1.9.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

diff -ruN powertop-1.9/powertop.c powertop-1.9-KJH/powertop.c
--- powertop-1.9/powertop.c	2008-01-30 17:24:27.000000000 -0800
+++ powertop-1.9-KJH/powertop.c	2008-01-30 21:02:54.000000000 -0800
@@ -35,6 +35,7 @@
 #include <assert.h>
 #include <locale.h>
 #include <time.h>
+#include <sys/stat.h>
 
 #include "powertop.h"
 
@@ -236,7 +237,7 @@
 	fclose(file);
 }
 
-static void read_data(uint64_t * usage, uint64_t * duration)
+static void read_data_acpi(uint64_t * usage, uint64_t * duration)
 {
 	DIR *dir;
 	struct dirent *entry;
@@ -286,6 +287,97 @@
 	closedir(dir);
 }
 
+static void read_data_cpuidle(uint64_t * usage, uint64_t * duration)
+{
+	DIR *dir;
+	struct dirent *entry;
+	FILE *file = NULL;
+	char line[4096];
+	char filename[128], *f;
+	int len, clevel = 0;
+
+	memset(usage, 0, 64);
+	memset(duration, 0, 64);
+
+	dir = opendir("/sys/devices/system/cpu");
+	if (!dir)
+		return;
+
+	/* Loop over cpuN entries */
+	while ((entry = readdir(dir))) {
+		if (strlen(entry->d_name) < 3)
+			continue;
+
+		if (!isdigit(entry->d_name[3]))
+			continue;
+
+		len = sprintf(filename, "/sys/devices/system/cpu/%s/cpuidle",
+			      entry->d_name);
+
+		dir = opendir(filename);
+		if (!dir)
+			return;
+
+		/* For each C-state, there is a stateX directory which
+		 * contains a 'usage' and a 'time' (duration) file */
+		while ((entry = readdir(dir))) {
+			if (strlen(entry->d_name) < 3)
+				continue;
+			sprintf(filename + len, "/%s/usage", entry->d_name);
+			file = fopen(filename, "r");
+			if (!file)
+				continue;
+
+			memset(line, 0, 4096);
+			f = fgets(line, 4096, file);
+			fclose(file);
+			if (f == NULL)
+				break;
+
+			usage[clevel] += 1+strtoull(line, NULL, 10);
+
+			sprintf(filename + len, "/%s/time", entry->d_name);
+			file = fopen(filename, "r");
+			if (!file)
+				continue;
+		
+			memset(line, 0, 4096);
+			f = fgets(line, 4096, file);
+			fclose(file);
+			if (f == NULL)
+				break;
+
+			duration[clevel] += 1+strtoull(line, NULL, 10);
+
+			clevel++;
+			if (clevel > maxcstate)
+				maxcstate = clevel;
+		
+		}
+
+	}
+	closedir(dir);
+}
+
+static void read_data(uint64_t * usage, uint64_t * duration)
+{
+	int r;
+	struct stat s;
+
+	/* First, check for ACPI */
+	r = stat("/proc/acpi/processor", &s);
+	if (!r) {
+		read_data_acpi(usage, duration);
+		return;
+	}
+
+	/* Then check for CPUidle */
+	r = stat("/sys/devices/system/cpu/cpuidle", &s);
+	if (!r) {
+		read_data_cpuidle(usage, duration);
+	}
+}
+
 void stop_timerstats(void)
 {
 	FILE *file;
@@ -530,7 +622,7 @@
 		memset(&cstate_lines, 0, sizeof(cstate_lines));
 		topcstate = -4;
 		if (totalevents == 0 && maxcstate <= 1) {
-			sprintf(cstate_lines[5],_("< Detailed C-state information is only available on Mobile CPUs (laptops) >\n"));
+			sprintf(cstate_lines[5],_("< Detailed C-state information is not available.>\n"));
 		} else {
 			double sleept, percentage;;
 			c0 = sysconf(_SC_NPROCESSORS_ONLN) * ticktime * 1000 * FREQ - totalticks;
