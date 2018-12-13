From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 61/73] acpi/nfit: Fix user-initiated ARS to be "ARS-long" rather than "ARS-short"
Date: Wed, 12 Dec 2018 23:28:26 -0500
Message-ID: <20181213042838.75160-61-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit b5fd2e00a60248902315fb32210550ac3cb9f44c ]

A "short" ARS (address range scrub) instructs the platform firmware to
return known errors. In contrast, a "long" ARS instructs platform
firmware to arrange every data address on the DIMM to be read / checked
for poisoned data.

The conversion of the flags in commit d3abaf43bab8 "acpi, nfit: Fix
Address Range Scrub completion tracking", changed the meaning of passing
'0' to acpi_nfit_ars_rescan(). Previously '0' meant "not short", now '0'
is ARS_REQ_SHORT. Pass ARS_REQ_LONG to restore the expected scrub-type
behavior of user-initiated ARS sessions.

Fixes: d3abaf43bab8 ("acpi, nfit: Fix Address Range Scrub completion tracking")
Reported-by: Jacek Zloch <jacek.zloch@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index c5d15752dfb3..75b331f8a16a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1303,7 +1303,7 @@ static ssize_t scrub_store(struct device *dev,
 	if (nd_desc) {
 		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-		rc = acpi_nfit_ars_rescan(acpi_desc, 0);
+		rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
 	}
 	device_unlock(dev);
 	if (rc)
-- 
2.19.1
