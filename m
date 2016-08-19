From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 1/2] trivial: ACPI: remove extraneous whitespace from a comment
Date: Fri, 19 Aug 2016 17:16:34 -0600
Message-ID: <1471648595-7365-2-git-send-email-ahs3@redhat.com>
References: <1471648595-7365-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471648595-7365-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Al Stone <ahs3@redhat.com>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 9f0ad6e..fa6fd19 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -416,7 +416,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		return -ENODEV;
 }
 
-/* 
+/*
  * The BIOS is supposed to supply a single APIC/MADT,
  * but some report two.  Provide a knob to use either.
  * (don't you wish instance 0 and 1 were not the same?)
-- 
2.7.4
