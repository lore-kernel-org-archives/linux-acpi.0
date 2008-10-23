From: Len Brown <lenb@kernel.org>
Subject: [PATCH 113/122] ACPICA: Fixed a couple memory leaks associated with
 "implicit return"
Date: Thu, 23 Oct 2008 02:39:27 -0400
Message-ID: <d8a0ec914afa1a994d2f6184ac4c6668b5f8068f.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbYJWGoM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:12 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:09 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Fixed a couple memory leaks associated with "implicit return" objects
when the AML Interpreter slack mode is enabled.

http://www.acpica.org/bugzilla/show_bug.cgi?id=349

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    3 +++
 drivers/acpi/parser/psparse.c      |    4 +++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 4613b9c..279a5a6 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -103,6 +103,9 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 						    NULL);
 		acpi_ex_enter_interpreter();
 	}
+
+	acpi_ds_clear_implicit_return(walk_state);
+
 #ifdef ACPI_DISASSEMBLER
 	if (ACPI_FAILURE(status)) {
 
diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index 52caaf6..68e932f 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -635,10 +635,12 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 					    ACPI_WALK_METHOD_RESTART;
 				}
 			} else {
-				/* On error, delete any return object */
+				/* On error, delete any return object or implicit return */
 
 				acpi_ut_remove_reference(previous_walk_state->
 							 return_desc);
+				acpi_ds_clear_implicit_return
+				    (previous_walk_state);
 			}
 		}
 
-- 
1.5.5.1

