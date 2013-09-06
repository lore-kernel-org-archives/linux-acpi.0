From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH 2/4] ACPI/Resource: Add address translation support
Date: Fri,  6 Sep 2013 10:24:44 -0400
Message-ID: <1378477486-8758-3-git-send-email-tianyu.lan@intel.com>
References: <1378477486-8758-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378477486-8758-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tianyu.lan@intel.com, lenb@kernel.org, rjw@sisk.pl, yinghai@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

According ACPI 5.0 spec Section 19.1.8
"For bridges, translate addresses across the bridge, this is the
offset that must be added to the address on the secondary side
to obtain the address on the primary side. Non-bridge devices
must list 0."

This patch is to add address translation offset to the start/end
of struct resource in the acpi_dev_resource_address_space().
Further more, non-bridge device's translation_offset should 0.
So this change will affect other devices.


Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 929f416..84bc3db 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -192,8 +192,8 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 	if (ACPI_FAILURE(status))
 		return true;
 
-	res->start = addr.minimum;
-	res->end = addr.maximum;
+	res->start = addr.minimum + addr.translation_offset;
+	res->end = addr.maximum + addr.translation_offset;
 	window = addr.producer_consumer == ACPI_PRODUCER;
 
 	switch(addr.resource_type) {
-- 
1.8.2.1
