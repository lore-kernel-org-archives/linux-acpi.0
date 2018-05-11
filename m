From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v9 11/12] ACPI: Add PPTT to injectable table list
Date: Fri, 11 May 2018 18:58:06 -0500
Message-ID: <20180511235807.30834-12-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com, linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com, Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@codeaurora.org, ard.biesheuvel@linaro.org, Jeremy Linton <jeremy.linton@arm.com>, Geoffrey Blake <geoffrey.blake@arm.com>
List-Id: linux-acpi@vger.kernel.org

Add ACPI_SIG_PPTT to the table so initrd's can override the
system topology.

Signed-off-by: Geoffrey Blake <geoffrey.blake@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 849c4fb19b03..30d93bf7c6a2 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -457,7 +457,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
 	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
-	ACPI_SIG_NFIT, ACPI_SIG_HMAT, NULL };
+	ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.13.6
