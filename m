From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 2/2 linux-next] PNPACPI: use unsigned int in pnpacpi_encode_resources()
Date: Sat,  2 May 2015 17:14:50 +0200
Message-ID: <1430579690-24131-2-git-send-email-fabf@skynet.be>
References: <1430579690-24131-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430579690-24131-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

use unsigned int for port, irq, dma and mem used for pnp_get_resource()
This fixes gcc warnings of type "conversion to unsigned int
from int may change the sign of the result"

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/pnp/pnpacpi/rsparser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 23a08d1..0579649 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -873,7 +873,7 @@ int pnpacpi_encode_resources(struct pnp_dev *dev, struct acpi_buffer *buffer)
 	/* pnpacpi_build_resource_template allocates extra mem */
 	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
 	struct acpi_resource *resource = buffer->pointer;
-	int port = 0, irq = 0, dma = 0, mem = 0;
+	unsigned int port = 0, irq = 0, dma = 0, mem = 0;
 
 	pnp_dbg(&dev->dev, "encode %d resources\n", res_cnt);
 	while (i < res_cnt) {
-- 
1.9.1
