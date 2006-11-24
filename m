From: Len Brown <len.brown@intel.com>
Subject: [PATCH 47/65] ACPICA: Add new subsystem state bit that is set after SubsystemInitialize is called
Date: Fri, 24 Nov 2006 02:18:57 -0500
Message-ID: <11643528083991-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10249 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934492AbWKXHQM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:12 -0500
In-Reply-To: <1164352807227-git-send-email-len.brown@intel.com>
Message-Id: <128d1711966b7242572b7b68e1522a21790a372c.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utxface.c |    1 +
 include/acpi/actypes.h           |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
index bec0f54..0a3202d 100644
--- a/drivers/acpi/utilities/utxface.c
+++ b/drivers/acpi/utilities/utxface.c
@@ -67,6 +67,7 @@ acpi_status acpi_initialize_subsystem(vo
 
 	ACPI_FUNCTION_TRACE(acpi_initialize_subsystem);
 
+	acpi_gbl_startup_flags = ACPI_SUBSYSTEM_INITIALIZE;
 	ACPI_DEBUG_EXEC(acpi_ut_init_stack_ptr_trace());
 
 	/* Initialize the OS-Dependent layer */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index fe9eb0e..6fa3f2a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -412,7 +412,8 @@ typedef u64 acpi_integer;
 /*
  * Initialization state
  */
-#define ACPI_INITIALIZED_OK             0x01
+#define ACPI_SUBSYSTEM_INITIALIZE       0x01
+#define ACPI_INITIALIZED_OK             0x02
 
 /*
  * Power state values
-- 
1.4.4.1
