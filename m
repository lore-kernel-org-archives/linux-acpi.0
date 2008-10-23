From: Len Brown <lenb@kernel.org>
Subject: [PATCH 114/122] ACPICA: Fix for implicit return compatibility
Date: Thu, 23 Oct 2008 02:39:28 -0400
Message-ID: <b9d1312ad4246e467f333dfe2ac4dc7a79608d59.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37959 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457AbYJWGkh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:37 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600EFEIJ9P617@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:21 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Predicate can be used for an implicit return value.
This change improves the implicit return mechanism to be more
compatible with the MS interpreter.

http://www.acpica.org/bugzilla/show_bug.cgi?id=349

Below AML code from http://bugzilla.kernel.org/show_bug.cgi?id=10686

	Store(0x07D6, OSYS)
	Method (_CRT, 0, Serialized)
	{
	    If (LLess (OSYS, 0x07D6))
	    {
		If (LEqual (\_SB.TJ85, Zero))
		{
		    Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
		}
		Else
		{
		    Return (Add (0x0AAC, Multiply (TP85, 0x0A)))
		}
	    }
	}

Previously _CRT returns 0x07D6, now it returns 0 (predicate value of LLess)

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dswexec.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index 5b24191..396fe12 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -166,6 +166,10 @@ acpi_ds_get_predicate_value(struct acpi_walk_state *walk_state,
 		status = AE_CTRL_FALSE;
 	}
 
+	/* Predicate can be used for an implicit return value */
+
+	(void)acpi_ds_do_implicit_return(local_obj_desc, walk_state, TRUE);
+
       cleanup:
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Completed a predicate eval=%X Op=%p\n",
-- 
1.5.5.1

