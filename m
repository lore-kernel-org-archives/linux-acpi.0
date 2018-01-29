From: Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH] ACPI / processor_idle: Set default C1 state description
Date: Mon, 29 Jan 2018 14:22:49 -0600
Message-ID: <20180129202249.12522-1-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The acpi_idle driver will default to ACPI_CSTATE_HALT for C1 if a _CST
object for C1 is not defined. However, the description will not be set,
so users will see "<null>" when reading the description from sysfs.

Set the C1 state description when defaulting to ACPI_CSTATE_HALT.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/processor_idle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5f0071c7e2e1..abb559cd28d7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -292,6 +292,9 @@ static int acpi_processor_get_power_info_default(struct acpi_processor *pr)
 		pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
 		pr->power.states[ACPI_STATE_C1].valid = 1;
 		pr->power.states[ACPI_STATE_C1].entry_method = ACPI_CSTATE_HALT;
+
+		snprintf(pr->power.states[ACPI_STATE_C1].desc,
+			 ACPI_CX_DESC_LEN, "ACPI HLT");
 	}
 	/* the C0 state only exists as a filler in our array */
 	pr->power.states[ACPI_STATE_C0].valid = 1;
-- 
2.14.1
