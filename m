From: Len Brown <lenb@kernel.org>
Subject: [PATCH 016/112] ACPI: detect invalid argument written to /proc/acpi/alarm
Date: Thu,  7 Feb 2008 04:33:38 -0500
Message-ID: <975c30257e75c3d067d4858f60963b80fc6bd0e4.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757147AbYBGJfi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:38 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Signed-off by Yi Yang <yi.y.yang@intel.com>, Len Brown <len.brown@intel.com>

From: Signed-off by Yi Yang <yi.y.yang@intel.com>

/proc/acpi/alarm can't be set correctly, here is a sample:

[root@localhost /]# echo "2006 09" > /proc/acpi/alarm
[root@localhost /]# cat /proc/acpi/alarm
2007-12-09 09:09:09
[root@localhost /]# echo "2006 04" > /proc/acpi/alarm
[root@localhost /]# cat /proc/acpi/alarm
2007-12-04 04:04:04
[root@localhost /]#

Obviously, it is wrong, it should consider it as an invalid input.

after this patch:

[root@localhost /]# echo "2008 09" > /proc/acpi/alarm
-bash: echo: write error: Invalid argument
[root@localhost /]#

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/proc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

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
-- 
1.5.4.23.gef5b9

