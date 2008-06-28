From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/84] ACPI: fix processor throttling set error
Date: Sat, 28 Jun 2008 01:43:13 -0400
Message-ID: <52f2215da8f6916c2f3a0f1f438822364bf2e645.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:34360 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbYF1Foz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:55 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500D17RN3VND3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:37:52 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Yi Yang <yi.y.yang@intel.com>, Len Brown <len.brown@intel.com>

From: Yi Yang <yi.y.yang@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=9704

When echo some invalid values to /proc/acpi/processor/*/throttling,
there isn't any error info returned, on the contray, it sets
throttling value to some T* successfully, obviously, this is incorrect,
a correct way should be to let it fail and return error info.

This patch fixed the aforementioned issue, it also enables
/proc/acpi/processor/*/throttling to accept such values as 't0' and 'T0',
it also strictly limits /proc/acpi/processor/*/throttling only to accept
 "*", "t*" and "T*", "*" is the throttling state value the processor can
support, current, it is 0 - 7.

Before applying this patch, the test result is below:

[root@localhost acpi]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T1
state available: T0 to T7
states:
    T0:                  100%
   *T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost acpi]# echo "1xxxxxx" > /proc/acpi/processor/CPU0/throttling
[root@localhost acpi]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T1
state available: T0 to T7
states:
    T0:                  100%
   *T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost acpi]# echo "0" > /proc/acpi/processor/CPU0/throttling
[root@localhost acpi]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost acpi]# cd /
[root@localhost /]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost /]# echo "T0" > /proc/acpi/processor/CPU0/throttling
[root@localhost /]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost /]# echo "T7" > /proc/acpi/processor/CPU0/throttling
[root@localhost /]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost /]# echo "T100" > /proc/acpi/processor/CPU0/throttling
[root@localhost /]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost /]# echo "xxx" > /proc/acpi/processor/CPU0/throttling
[root@localhost /]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost /]# echo "2xxxx" > /proc/acpi/processor/CPU0/throttling
[root@localhost /]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T2
state available: T0 to T7
states:
    T0:                  100%
    T1:                  87%
   *T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost /]# echo "" > /proc/acpi/processor/CPU0/throttling
[root@localhost /]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost /]# echo "7777" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost /]# echo "7xxx" > /proc/acpi/processor/CPU0/throttling
[root@localhost /]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T7
state available: T0 to T7
states:
    T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
   *T7:                  12%
[root@localhost /]#

After applying this patch, the test result is below:

[root@localhost linux-2.6.24-rc6]# echo > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo "" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo "0" > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# echo "t0" > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# echo "T0" > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T0
state available: T0 to T7
states:
   *T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
    T7:                  12%
[root@localhost linux-2.6.24-rc6]# echo "T7" > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T7
state available: T0 to T7
states:
    T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
   *T7:                  12%
[root@localhost linux-2.6.24-rc6]# echo "T8" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# vi drivers/acpi/processor_throttling.c
[root@localhost linux-2.6.24-rc6]# echo "T8" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo "t7" > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# echo "t70" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo "70" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo "7000" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo "70" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo "xxx" > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo -n > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# echo -n "" > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# echo $?
0
[root@localhost linux-2.6.24-rc6]# echo -n "" > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T7
state available: T0 to T7
states:
    T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
   *T7:                  12%
[root@localhost linux-2.6.24-rc6]# echo -n "" > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# cat /proc/acpi/processor/CPU0/throttling
state count:             8
active state:            T7
state available: T0 to T7
states:
    T0:                  100%
    T1:                  87%
    T2:                  75%
    T3:                  62%
    T4:                  50%
    T5:                  37%
    T6:                  25%
   *T7:                  12%
[root@localhost linux-2.6.24-rc6]# echo t0 > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# echo T0 > /proc/acpi/processor/CPU0/throttling
[root@localhost linux-2.6.24-rc6]# echo Tt0 > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]# echo T > /proc/acpi/processor/CPU0/throttling
-bash: echo: write error: Invalid argument
[root@localhost linux-2.6.24-rc6]#

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index bb06738..4d4d8d8 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -1232,7 +1232,10 @@ static ssize_t acpi_processor_write_throttling(struct file *file,
 	int result = 0;
 	struct seq_file *m = file->private_data;
 	struct acpi_processor *pr = m->private;
-	char state_string[12] = { '\0' };
+	char state_string[5] = "";
+	char *charp = NULL;
+	size_t state_val = 0;
+	char tmpbuf[5] = "";
 
 	if (!pr || (count > sizeof(state_string) - 1))
 		return -EINVAL;
@@ -1241,10 +1244,23 @@ static ssize_t acpi_processor_write_throttling(struct file *file,
 		return -EFAULT;
 
 	state_string[count] = '\0';
+	if ((count > 0) && (state_string[count-1] == '\n'))
+		state_string[count-1] = '\0';
 
-	result = acpi_processor_set_throttling(pr,
-					       simple_strtoul(state_string,
-							      NULL, 0));
+	charp = state_string;
+	if ((state_string[0] == 't') || (state_string[0] == 'T'))
+		charp++;
+
+	state_val = simple_strtoul(charp, NULL, 0);
+	if (state_val >= pr->throttling.state_count)
+		return -EINVAL;
+
+	snprintf(tmpbuf, 5, "%d", state_val);
+
+	if (strcmp(tmpbuf, charp) != 0)
+		return -EINVAL;
+
+	result = acpi_processor_set_throttling(pr, state_val);
 	if (result)
 		return result;
 
-- 
1.5.6.1.89.gd544

