From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] ACPI: remove unwarranted use of strncpy
Date: Mon, 20 Aug 2012 18:55:20 +0200
Message-ID: <1345481724-30108-2-git-send-email-jim@meyering.net>
References: <1345481724-30108-1-git-send-email-jim@meyering.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345481724-30108-1-git-send-email-jim@meyering.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jim Meyering <meyering@redhat.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Jim Meyering <meyering@redhat.com>

strncpy is best avoided in general.  Here, using strcpy would have
been clearer and semantically equivalent, but we can do better still
by removing it: i.e., use kstrdup in place of kzalloc+strncpy.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 drivers/acpi/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 7c3f98b..20cc627 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -674,10 +674,9 @@ void acpi_irq_stats_init(void)
 		else
 			sprintf(buffer, "bug%02X", i);

-		name = kzalloc(strlen(buffer) + 1, GFP_KERNEL);
+		name = kstrdup(buffer, GFP_KERNEL);
 		if (name == NULL)
 			goto fail;
-		strncpy(name, buffer, strlen(buffer) + 1);

 		sysfs_attr_init(&counter_attrs[i].attr);
 		counter_attrs[i].attr.name = name;
-- 
1.7.12
