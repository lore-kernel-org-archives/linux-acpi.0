From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/70] ACPI: fix acpi fan state set error
Date: Fri, 20 Jun 2008 03:43:35 -0400
Message-ID: <009733ab59c05c4331c5504001587562e66a0d2b.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40470 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYFTHoh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:37 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00EHS46C17G2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:37 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yi Yang <yi.y.yang@intel.com>, Len Brown <len.brown@intel.com>

From: Yi Yang <yi.y.yang@intel.com>

Under /proc/acpi, there is a fan control interface, a user can
set 0 or 3 to /proc/acpi/fan/*/state, 0 denotes D0 state, 3
denotes D3 state, but in current implementation, a user can
set a fan to D1 state by any char excluding '1', '2' and '3'.

For example:

[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost acpi]# echo "" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  on
[root@localhost acpi]# echo "3" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost acpi]# echo "xxxxx" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  on

Obviously, such inputs as "" and "xxxxx" are invalid for fan state.

This patch fixes this issue, it strictly limits fan state only to
accept 0, 1, 2 and 3, any other inputs are invalid.

Before applying this patch, the test result is:

[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost acpi]# echo "" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  on
[root@localhost acpi]# echo "3" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost acpi]# echo "xxxxx" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  on
[root@localhost acpi]# echo "3" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost acpi]# echo "3x" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost acpi]# echo "-1x" > /proc/acpi/fan/C31B/state
[root@localhost acpi]# cat /proc/acpi/fan/C31B/state
status:                  on
[root@localhost acpi]#

After applying this patch, the test result is:

[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost ~]# echo "" > /proc/acpi/fan/C31B/state
-bash: echo: write error: Invalid argument
[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost ~]# echo "3" > /proc/acpi/fan/C31B/state
[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost ~]# echo "xxxxx" > /proc/acpi/fan/C31B/state
-bash: echo: write error: Invalid argument
[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost ~]# echo "-1x" > /proc/acpi/fan/C31B/state
-bash: echo: write error: Invalid argument
[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost ~]# echo "0" > //proc/acpi/fan/C31B/state
[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  on
[root@localhost ~]# echo "4" > //proc/acpi/fan/C31B/state
-bash: echo: write error: Invalid argument
[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  on
[root@localhost ~]# echo "3" > //proc/acpi/fan/C31B/state
[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  off
[root@localhost ~]# echo "0" > //proc/acpi/fan/C31B/state
[root@localhost ~]# cat /proc/acpi/fan/C31B/state
status:                  on
[root@localhost ~]# echo "3x" > //proc/acpi/fan/C31B/state
-bash: echo: write error: Invalid argument
[root@localhost ~]#

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/fan.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 6cf10cb..55c17af 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -148,7 +148,7 @@ acpi_fan_write_state(struct file *file, const char __user * buffer,
 	int result = 0;
 	struct seq_file *m = file->private_data;
 	struct acpi_device *device = m->private;
-	char state_string[12] = { '\0' };
+	char state_string[3] = { '\0' };
 
 	if (count > sizeof(state_string) - 1)
 		return -EINVAL;
@@ -157,6 +157,12 @@ acpi_fan_write_state(struct file *file, const char __user * buffer,
 		return -EFAULT;
 
 	state_string[count] = '\0';
+	if ((state_string[0] < '0') || (state_string[0] > '3'))
+		return -EINVAL;
+	if (state_string[1] == '\n')
+		state_string[1] = '\0';
+	if (state_string[1] != '\0')
+		return -EINVAL;
 
 	result = acpi_bus_set_power(device->handle,
 				    simple_strtoul(state_string, NULL, 0));
-- 
1.5.6

