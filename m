From: Yi Yang <yi.y.yang@intel.com>
Subject: [PATCH linux-acpi] Fix /proc/acpi/alarm set error
Date: Thu, 27 Dec 2007 14:47:02 +0800
Message-ID: <1198738022.8950.3.camel@yangyi-dev.bj.intel.com>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34743 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbXL0GrT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Dec 2007 01:47:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, acpi-bugzilla@lists.sourceforge.net

/proc/acpi/alarm can't be set correctly, here is a sample:

[root@localhost /]# echo "2006 09" > /proc/acpi/alarm
[root@localhost /]# cat /proc/acpi/alarm
2007-12-09 09:09:09
[root@localhost /]# echo "2006 04" > /proc/acpi/alarm
[root@localhost /]# cat /proc/acpi/alarm
2007-12-04 04:04:04
[root@localhost /]#

Obviously, it is wrong, it should consider it as an invalid input.

This patch'll fix this issue, after applying this patch, the result is:

[root@localhost /]# echo "2008 09" > /proc/acpi/alarm
-bash: echo: write error: Invalid argument
[root@localhost /]#

Signed-off by Yi Yang <yi.y.yang@intel.com>
 
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 1538355..fce78fb 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -178,6 +178,9 @@ static int get_date_field(char **p, u32 * value)
 	 * Try to find delimeter, only to insert null.  The end of the
 	 * string won't have one, but is still valid.
 	 */
+	if (*p == NULL)
+		return result;
+
 	next = strpbrk(*p, "- :");
 	if (next)
 		*next++ = '\0';
@@ -190,6 +193,8 @@ static int get_date_field(char **p, u32 * value)
 
 	if (next)
 		*p = next;
+	else
+		*p = NULL;
 
 	return result;
 }


