From: David Arcari <darcari@redhat.com>
Subject: [PATCH] mailbox: PCC: handle parse error
Date: Mon, 27 Aug 2018 15:19:08 -0400
Message-ID: <1535397548-69588-1-git-send-email-darcari@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, David Arcari <darcari@redhat.com>, Al Stone <ahs3@redhat.com>, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: linux-acpi@vger.kernel.org

acpi_pcc_probe calls acpi_table_parse_entries_array but fails to check
for an error return.  This in turn can result in calling kcalloc with
a negative count as well as emitting the following misleading erorr
message:

[    2.642015] Could not allocate space for PCC mbox channels

Fixes: 8f8027c5f935 ("mailbox: PCC: erroneous error message when parsing ACPI PCCT")

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Al Stone <ahs3@redhat.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/pcc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 311e91b..256f18b 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -461,8 +461,11 @@ static int __init acpi_pcc_probe(void)
 	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
 			sizeof(struct acpi_table_pcct), proc,
 			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
-	if (count == 0 || count > MAX_PCC_SUBSPACES) {
-		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
+	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
+		if (count < 0)
+			pr_warn("Error parsing PCC subspaces from PCCT\n");
+		else
+			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
 		return -EINVAL;
 	}
 
-- 
1.8.3.1
