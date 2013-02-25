From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [rebased-again][PATCH 3/4] acpi: add clock_domain field to acpi_srat_cpu_affinity
Date: Mon, 25 Feb 2013 10:38:36 +0800
Message-ID: <1361759917-5195-4-git-send-email-lig.fnst@cn.fujitsu.com>
References: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361759917-5195-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, hpa@zytor.com, pavel@ucw.cz, rjw@sisk.pl, lv.zheng@intel.com, jarkko.sakkinen@intel.com, dave@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: liguang <lig.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

according to ACPI SPEC v5.0, page 152,
5.2.16.1 Processor Local APIC/SAPIC Affinity Structure,
the last member of it is clock_domain.

Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 include/acpi/actbl1.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 0bd750e..e21d22b 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -922,7 +922,7 @@ struct acpi_srat_cpu_affinity {
 	u32 flags;
 	u8 local_sapic_eid;
 	u8 proximity_domain_hi[3];
-	u32 reserved;		/* Reserved, must be zero */
+	u32 clock_domain;
 };
 
 /* Flags */
-- 
1.7.2.5
