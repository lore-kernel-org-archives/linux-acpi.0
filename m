From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 16/28] xen,
	irq: Call irq_alloc_reserved_desc_at() at first
Date: Sat, 10 Aug 2013 19:48:02 -0700
Message-ID: <1376189294-32022-17-git-send-email-yinghai@kernel.org>
References: <1376189294-32022-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1376189294-32022-1-git-send-email-yinghai@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: xen-devel@lists.xensource.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

To make x86 irq allocation to be same with booting path and ioapic
hot add path, We will pre-reserve irq for all gsi at first.
We have to use alloc_reserved here, otherwise irq_alloc_desc_at will fail
because bit is already get marked for pre-reserved in irq bitmaps.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com
---
 drivers/xen/events.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index a58ac43..1a3647c 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -507,8 +507,12 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
 	/* Legacy IRQ descriptors are already allocated by the arch. */
 	if (gsi < NR_IRQS_LEGACY)
 		irq = gsi;
-	else
-		irq = irq_alloc_desc_at(gsi, -1);
+	else {
+		/* for x86, irq already get reserved for gsi */
+		irq = irq_alloc_reserved_desc_at(gsi, -1);
+		if (irq < 0)
+			irq = irq_alloc_desc_at(gsi, -1);
+	}
 
 	xen_irq_init(irq);
 
-- 
1.8.1.4
