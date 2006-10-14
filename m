From: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/28] ACPI: sbs: check for NULL device pointer
Date: Sat, 14 Oct 2006 04:05:46 -0400
Message-ID: <1160813174246-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14872 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752126AbWJNICw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:02:52 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <963497c12acb4d43caa9751b9291b014eea51a1a.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Tue, 5 Sep 2006 19:49:13 +0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lebedev@vger.kernel.org, Vladimir P <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Lebedev, Vladimir P <vladimir.p.lebedev@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 62bef0b..79f38f0 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -1685,10 +1685,16 @@ static int acpi_sbs_add(struct acpi_devi
 
 int acpi_sbs_remove(struct acpi_device *device, int type)
 {
-	struct acpi_sbs *sbs = (struct acpi_sbs *)acpi_driver_data(device);
+	struct acpi_sbs *sbs = NULL;
 	int id;
 
-	if (!device || !sbs) {
+	if (!device) {
+		return -EINVAL;
+	}
+
+	sbs = (struct acpi_sbs *)acpi_driver_data(device);
+
+	if (!sbs) {
 		return -EINVAL;
 	}
 
-- 
1.4.3.rc2.g23bed-dirty
