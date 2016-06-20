From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v4 1/5] ACPI: table upgrade: use cacheable map for tables
Date: Mon, 20 Jun 2016 13:56:09 +0300
Message-ID: <20160620105615.15538-2-aleksey.makarov@linaro.org>
References: <20160620105615.15538-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160620105615.15538-1-aleksey.makarov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, "Zheng, Lv" <lv.zheng@intel.com>, Jon Masters <jcm@redhat.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The new memory allocated in acpi_table_initrd_init() is used to
copy the upgraded tables to it.  So it should be mapped with
early_memunmap() instead of early_ioremap().

This is critical for ARM.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Acked-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/tables.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index a372f9e..f829e6a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -578,10 +578,10 @@ static void __init acpi_table_initrd_init(void *data, size_t size)
 			clen = size;
 			if (clen > MAP_CHUNK_SIZE - slop)
 				clen = MAP_CHUNK_SIZE - slop;
-			dest_p = early_ioremap(dest_addr & PAGE_MASK,
-						 clen + slop);
+			dest_p = early_memremap(dest_addr & PAGE_MASK,
+						clen + slop);
 			memcpy(dest_p + slop, src_p, clen);
-			early_iounmap(dest_p, clen + slop);
+			early_memunmap(dest_p, clen + slop);
 			src_p += clen;
 			dest_addr += clen;
 			size -= clen;
-- 
2.8.3
