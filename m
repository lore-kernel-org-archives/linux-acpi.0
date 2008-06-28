From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/84] eeepc-laptop: static
Date: Sat, 28 Jun 2008 01:43:19 -0400
Message-ID: <eac9c2dc06e1ea25efebcd3d508c0ae40f4a9ece.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:36217 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYF1FpD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:03 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K350032VRYQV6VD@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:51 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

make the needlessly global cm_{g,s}etv[] static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/eeepc-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index 6d72760..9e8d79e 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -87,7 +87,7 @@ enum {
 	CM_ASL_LID
 };
 
-const char *cm_getv[] = {
+static const char *cm_getv[] = {
 	"WLDG", NULL, NULL, NULL,
 	"CAMG", NULL, NULL, NULL,
 	NULL, "PBLG", NULL, NULL,
@@ -96,7 +96,7 @@ const char *cm_getv[] = {
 	"CRDG", "LIDG"
 };
 
-const char *cm_setv[] = {
+static const char *cm_setv[] = {
 	"WLDS", NULL, NULL, NULL,
 	"CAMS", NULL, NULL, NULL,
 	"SDSP", "PBLS", "HDPS", NULL,
-- 
1.5.6.1.89.gd544

