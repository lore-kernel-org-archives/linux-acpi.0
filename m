From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 16/20] ACPI / APEI: Split fixmap pages for arm64 NMI-like
 notifications
Date: Tue, 26 Jun 2018 18:01:12 +0100
Message-ID: <20180626170116.25825-17-james.morse@arm.com>
References: <20180626170116.25825-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20180626170116.25825-1-james.morse@arm.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: linux-acpi@vger.kernel.org
Cc: jonathan.zhang@cavium.com, Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Punit Agrawal <punit.agrawal@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Now that ghes notification helpers provide the fixmap slots and
take the lock themselves we can support multiple NMI-like
notifications on arm64.

These should be named after their notification method. x86's
NOTIFY_NMI already is, move it to live with the ghes_nmi list.
Change the SEA fixmap entry to be called FIX_APEI_GHES_SEA.

Future patches can add support for FIX_APEI_GHES_SEI and
FIX_APEI_GHES_SDEI_{NORMAL,CRITICAL}.

Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v3:
 * idx/lock are now in a separate struct.
 * Add to the comment above ghes_fixmap_lock_irq so that it makes more
   sense in isolation.
---
 arch/arm64/include/asm/fixmap.h | 4 +++-
 drivers/acpi/apei/ghes.c        | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index ec1e6d6fa14c..c3974517c2cb 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -55,7 +55,9 @@ enum fixed_addresses {
 #ifdef CONFIG_ACPI_APEI_GHES
 	/* Used for GHES mapping from assorted contexts */
 	FIX_APEI_GHES_IRQ,
-	FIX_APEI_GHES_NMI,
+#ifdef CONFIG_ACPI_APEI_SEA
+	FIX_APEI_GHES_SEA,
+#endif
 #endif /* CONFIG_ACPI_APEI_GHES */
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f196f8797fc1..15d472048aa8 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -982,7 +982,7 @@ int ghes_notify_sea(void)
 	int rv;
 
 	raw_spin_lock(&ghes_notify_lock_sea);
-	rv = ghes_estatus_queue_notified(&ghes_sea, FIX_APEI_GHES_NMI);
+	rv = ghes_estatus_queue_notified(&ghes_sea, FIX_APEI_GHES_SEA);
 	raw_spin_unlock(&ghes_notify_lock_sea);
 
 	return rv;
@@ -1013,8 +1013,8 @@ static inline void ghes_sea_remove(struct ghes *ghes) { }
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
- * NMI may be triggered on any CPU, so ghes_in_nmi is used for
- * having only one concurrent reader.
+ * NOTIFY_NMI may be triggered on any CPU, so ghes_in_nmi is
+ * used for having only one concurrent reader.
  */
 static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
 
-- 
2.17.1
