From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] ACPI/EC: Call acpi_walk_dep_device_list() after installing EC opregion handler
Date: Wed,  1 Apr 2015 09:47:18 +0800
Message-ID: <1427852838-6443-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, valentin.lab_bugzilla.kernel.org@kalysto.org, lompik@voila.fr
List-Id: linux-acpi@vger.kernel.org

On some machines(E,G Mircosoft surface 3), ACPI battery depends on
the EC operation region and it has _DEP method which contains EC.
Current code doesn't support such devices whose dep_unmet will be
not be decreased after EC opregion handler being installed. This
blocks battery device to be attached with its driver. This patch
is to fix the issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=90161
Tested-and-reported-by: Lompik <lompik@voila.fr>
Tested-by: Valentin Lab <valentin.lab_bugzilla.kernel.org@kalysto.org>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/ec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a362f20..220d640 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1147,6 +1147,9 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	ret = ec_install_handlers(ec);
 
+	/* Reprobe devices depending on the EC */
+	acpi_walk_dep_device_list(ec->handle);
+
 	/* EC is fully operational, allow queries */
 	clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 
-- 
1.8.4.rc0.1.g8f6a3e5.dirty
