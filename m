From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2 3/4] hpet: clean up io mapping when hpet_alloc() fails
Date: Thu, 18 Mar 2010 11:59:40 -0600
Message-ID: <20100318175940.15143.53027.stgit@bob.kio>
References: <20100318175852.15143.2124.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100318175852.15143.2124.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Venkatesh Pallipadi <venki@google.com>, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


When hpet_alloc() fails, we should iounmap() the timer so we don't leak
the mapping.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/char/hpet.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)


diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d132fef..8961985 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -904,7 +904,7 @@ static int hpet_pnp_add(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct hpet_data data;
 	struct resource *mem, *irq;
-	int i;
+	int i, ret;
 
 	memset(&data, 0, sizeof(data));
 
@@ -924,7 +924,11 @@ static int hpet_pnp_add(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	data.hd_phys_address = mem->start;
 	data.hd_address = ioremap(mem->start, resource_size(mem));
 
-	return hpet_alloc(&data);
+	ret = hpet_alloc(&data);
+	if (ret)
+		iounmap(data.hd_address);
+
+	return ret;
 }
 
 static void hpet_pnp_remove(struct pnp_dev *dev)
