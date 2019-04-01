From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Subject: [PATCH] ACPI / property: restore _DSD data subnodes GUID comment
Date: Mon, 1 Apr 2019 16:26:35 +0800
Message-ID: <1554107195-36076-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Shunyong Yang <shunyong.yang@hxt-semitech.com>, Joey Zheng <yu.zheng@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

Patch "5f5e4890d57a" removes the comment of _DSD data subnodes GUID. This
patch restores it.

Fixes: 5f5e4890d57a ("ACPI / property: Allow multiple property
compatible _DSD entries")

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 drivers/acpi/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 77abe0ec4043..8832d0e13a72 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -44,6 +44,7 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
 		  0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
 };
 
+/* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
 static const guid_t ads_guid =
 	GUID_INIT(0xdbb8e3e6, 0x5886, 0x4ba6,
 		  0x87, 0x95, 0x13, 0x19, 0xf5, 0x2a, 0x96, 0x6b);
-- 
1.8.3.1
