From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH] ACPI button: don't try to use a non-existent lid device
Date: Wed, 7 Oct 2009 14:39:46 -0700
Message-ID: <20091007143946.3fad3fa8@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-152.bluehost.com ([67.222.39.32]:60669 "HELO
	outbound-mail-152.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754439AbZJGVrO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2009 17:47:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org

If a call comes in to check the lid state but there's no lid device
present, we should return -ENODEV.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/acpi/button.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9335b87..0c9c6a9 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -251,6 +251,9 @@ int acpi_lid_open(void)
 	acpi_status status;
 	unsigned long long state;
 
+	if (!lid_device)
+		return -ENODEV;
+
 	status = acpi_evaluate_integer(lid_device->handle, "_LID", NULL,
 				       &state);
 	if (ACPI_FAILURE(status))
-- 
1.6.3.3

