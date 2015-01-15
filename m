From: Yaowei Bai <bywxiaobai@163.com>
Subject: [PATCH] Documentation/acpi: add the missing '='
Date: Thu, 15 Jan 2015 21:59:16 +0800
Message-ID: <1421330356-4051-1-git-send-email-bywxiaobai@163.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, corbet@lwn.net
Cc: linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 Documentation/acpi/enumeration.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index b60d2ab..9b121a5 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -243,7 +243,7 @@ input driver:
 			.owner	= THIS_MODULE,
 			.pm	= &mpu3050_pm,
 			.of_match_table = mpu3050_of_match,
-			.acpi_match_table  ACPI_PTR(mpu3050_acpi_match),
+			.acpi_match_table = ACPI_PTR(mpu3050_acpi_match),
 		},
 		.probe		= mpu3050_probe,
 		.remove		= mpu3050_remove,
-- 
1.9.1


