Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828236C5BF;
	Tue, 31 Mar 2026 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984186; cv=none; b=m2KJC+grGPnGrM/AQDh+Wvv1DcwFvMSpmZ//7idO+sfCojmFD8i/OfMCcr7GMor/mn5H1OXKQdCa7yRpmlYIUQ5ixhd5S3rJzQbKWjW2KGL6CN6wcWuuGkghJsqDXZZqn1iKDJS33k3G1Ek1810Sg2Bznp6e6+A5ncZd6SsOv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984186; c=relaxed/simple;
	bh=YkgqYldSOAFFfBUN/vchHKzsCZIPrj7SKpq+a+KJ/n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s8WzzuANi+OpWnwI7KPtrPywSE0wNdPqXjyW410/A4iafmHJ4/b67tum0F2uTEq8vRLC0p9OE3G2vTw16aV/UYO6Xy9y7ZxqWzj26RSD2OqZIHw8cZ6XQeIVhvK1K49YOhkxGUaFqzJx4et6Rb1yj8pH25e/Cs+rRwv8M01hkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBGOnxbW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBGOnxbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A26BC19423;
	Tue, 31 Mar 2026 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984186;
	bh=YkgqYldSOAFFfBUN/vchHKzsCZIPrj7SKpq+a+KJ/n4=;
	h=From:To:Cc:Subject:Date:From;
	b=mBGOnxbWOA8hCnVSiP8DTNXkkzT9kuVRnnti2i/fRT+V0Capu2iFfd1IowNlvVz6M
	 0N1lifm0GflUxffVtKB4ZQLG7q8mYXMqhVfWLNvUpuHf+TYijjIYljbYl01pq6sbL/
	 4mm+QnLPOZv4Y3ybmZj3AToVKmO/bek5hbKgKQAr0yGMW7vdRxSUDMqwJZCJOMYdrT
	 Y/4QLEw60r1is2IxuGd0zgjIiATEaBYFD5SomCeFeA4ZmsNS+EQ/TaMZb17ZFxexL9
	 5Klxt5mQWUEqnRGTOSJ0HMViRhwyQnEuP2W6j8tSUdx8XYlytt/SA6oEZhYF1HGps3
	 NQKoI4fOmjq2w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tuo Li <islituo@gmail.com>
Subject:
 [PATCH v1] ACPI: processor: Rearrange and clean up
 acpi_processor_errata_piix4()
Date: Tue, 31 Mar 2026 21:09:42 +0200
Message-ID: <2846888.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In acpi_processor_errata_piix4() it is not necessary to use three
struct pci_dev pointers.  One is sufficient, so use it everywhere and
drop the other two.

Additionally, define the auxiliary local variables value1 and value2
in the code block in which they are used.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_processor.c |   29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -48,11 +48,6 @@ acpi_handle acpi_get_processor_handle(in
 
 static int acpi_processor_errata_piix4(struct pci_dev *dev)
 {
-	u8 value1 = 0;
-	u8 value2 = 0;
-	struct pci_dev *ide_dev = NULL, *isa_dev = NULL;
-
-
 	if (!dev)
 		return -EINVAL;
 
@@ -108,16 +103,16 @@ static int acpi_processor_errata_piix4(s
 		 * each IDE controller's DMA status to make sure we catch all
 		 * DMA activity.
 		 */
-		ide_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
+		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 				     PCI_DEVICE_ID_INTEL_82371AB,
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
-		if (ide_dev) {
-			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
+		if (dev) {
+			errata.piix4.bmisx = pci_resource_start(dev, 4);
 			if (errata.piix4.bmisx)
-				dev_dbg(&ide_dev->dev,
+				dev_dbg(&dev->dev,
 					"Bus master activity detection (BM-IDE) erratum enabled\n");
 
-			pci_dev_put(ide_dev);
+			pci_dev_put(dev);
 		}
 
 		/*
@@ -129,18 +124,20 @@ static int acpi_processor_errata_piix4(s
 		 * disable C3 support if this is enabled, as some legacy
 		 * devices won't operate well if fast DMA is disabled.
 		 */
-		isa_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
+		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 				     PCI_DEVICE_ID_INTEL_82371AB_0,
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
-		if (isa_dev) {
-			pci_read_config_byte(isa_dev, 0x76, &value1);
-			pci_read_config_byte(isa_dev, 0x77, &value2);
+		if (dev) {
+			u8 value1 = 0, value2 = 0;
+
+			pci_read_config_byte(dev, 0x76, &value1);
+			pci_read_config_byte(dev, 0x77, &value2);
 			if ((value1 & 0x80) || (value2 & 0x80)) {
 				errata.piix4.fdma = 1;
-				dev_dbg(&isa_dev->dev,
+				dev_dbg(&dev->dev,
 					"Type-F DMA livelock erratum (C3 disabled)\n");
 			}
-			pci_dev_put(isa_dev);
+			pci_dev_put(dev);
 		}
 
 		break;



