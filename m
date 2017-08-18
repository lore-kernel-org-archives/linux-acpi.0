From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 4/5] EDAC: add edac_get_owner() to check MC owner
Date: Fri, 18 Aug 2017 13:46:43 -0600
Message-ID: <20170818194644.14538-5-toshi.kani@hpe.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:33036 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbdHRT4k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2017 15:56:40 -0400
In-Reply-To: <20170818194644.14538-1-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>

Only a single edac driver can be enabled for EDAC MC.  When ghes_edac
is enabled, a regular edac driver for the CPU type / platform still
attempts to register itself and fails in edac_mc_add_mc().

Add edac_get_owner() so that regular edac drivers can check the owner
of EDAC MC without calling edac_mc_add_mc().

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/edac_mc.c |    7 ++++++-
 drivers/edac/edac_mc.h |    8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 4800721..48193f5 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -53,7 +53,7 @@ static LIST_HEAD(mc_devices);
  * Used to lock EDAC MC to just one module, avoiding two drivers e. g.
  *	apei/ghes and i7core_edac to be used at the same time.
  */
-static void const *edac_mc_owner;
+static const char *edac_mc_owner;
 
 static struct bus_type mc_bus[EDAC_MAX_MCS];
 
@@ -701,6 +701,11 @@ struct mem_ctl_info *edac_mc_find(int idx)
 }
 EXPORT_SYMBOL(edac_mc_find);
 
+const char *edac_get_owner(void)
+{
+	return edac_mc_owner;
+}
+EXPORT_SYMBOL_GPL(edac_get_owner);
 
 /* FIXME - should a warning be printed if no error detection? correction? */
 int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 5357800..4165e15 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -128,6 +128,14 @@ struct mem_ctl_info *edac_mc_alloc(unsigned mc_num,
 				   unsigned sz_pvt);
 
 /**
+ * edac_get_owner - Return the owner's mod_name of EDAC MC
+ *
+ * Returns:
+ *	Pointer to mod_name string when EDAC MC is owned. NULL otherwise.
+ */
+extern const char *edac_get_owner(void);
+
+/*
  * edac_mc_add_mc_with_groups() - Insert the @mci structure into the mci
  *	global list and create sysfs entries associated with @mci structure.
  *
