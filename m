Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7DA23EAA6;
	Tue, 17 Mar 2026 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779950; cv=none; b=ExjrmcqiHxiTqRHH2bAWX25ndx8nt+hwrcufYFrBrm/hjnMTEDu8RBBM8SLIVxtsuIq4u60aOduO5HZDL3ABZ9HvhLqVjGEBsmLMblX+xDFzUchv7t8bD+XczJsLPouXSotiXEKjnZtD+x7hQEBRANgJtk5GcOVVhNu76jNHSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779950; c=relaxed/simple;
	bh=tjv0o8ygWqW43na2H3jbrB+YIg6FjSdyGagdFsLzl/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XM8HEcF/eSOMjuxi/ORney/injIhgukcEZo3jtnAc2+5s26U/8E3k0xjNgOIqT7Wq6DYKoQ7Fwj5slk0WUTGCXXp3P3LrHDAQufg9Epme3PUKRESab04qebcRDoVbD8X/hCHMdDJPkd6WiGb+HFFu8O9rP+BIygx762GxEo8QqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQg0GV0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQg0GV0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898C7C4CEF7;
	Tue, 17 Mar 2026 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773779949;
	bh=tjv0o8ygWqW43na2H3jbrB+YIg6FjSdyGagdFsLzl/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQg0GV0YY1+OdPXLqfrkJh5i3o2dJ3fRXEVRuUj2ozfnNof2NGQL3pm73ILun5Sk8
	 AOx+fa0nKICA+8fzU0abqdQ9i7vg5MseSbZ48ijTEJlpLhTRkN4Kiz030eZ3SGuSig
	 ZwkItSyXGItn2+KvtAsv8zN/SZW1SS5XtRtgwD8OSOArRzpFlo85XKsCqsFvL1XTg8
	 HPdSrxzCM7trn2IRgpRq5V2seQBjL6waHdem0JQLU8XflivVVPLy+puZ8vDCTTWS11
	 3Lpn8/vIqlx0d2c9SAZp3QkGfKERYvgQOI+tI89WdfI52R81bZtYMqF/uRjvoNYXTo
	 AWS6JLmxdniJw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Tuo Li <islituo@gmail.com>, linux-kernel@vger.kernel.org
Subject:
 [PATCH v1] ACPI: processor: Fix previous acpi_processor_errata_piix4() fix
Date: Tue, 17 Mar 2026 21:39:05 +0100
Message-ID: <5975693.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net>
References:
 <20260111163214.202262-1-islituo@gmail.com>
 <938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday, March 17, 2026 6:26:59 PM CET Guenter Roeck wrote:
> Hi,
> 
> On Mon, Jan 12, 2026 at 12:32:14AM +0800, Tuo Li wrote:
> > In acpi_processor_errata_piix4(), the pointer dev is first assigned an IDE
> > device and then reassigned an ISA device:
> > 
> >   dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB, ...);
> >   dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB_0, ...);
> > 
> > If the first lookup succeeds but the second fails, dev becomes NULL. This
> > leads to a potential null-pointer dereference when dev_dbg() is called:
> > 
> >   if (errata.piix4.bmisx)
> >     dev_dbg(&dev->dev, ...);
> > 
> > To prevent this, use two temporary pointers and retrieve each device
> > independently, avoiding overwriting dev with a possible NULL value.
> > 
> > 
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> 
> AI review feedback inline below.
> 
> I don't know if the device lifetime issue is real, but the now unconditional
> debug message is definitely a functional change and potentially misleading.
> 
> Either case, why not just move the debug messages into the code setting 
> errata.piix4.bmisx and errata.piix4.fdma ?
> 
> Thanks,
> Guenter
> 
> > ---
> > v3:
> > * Initialize the new variables to NULL and drop redundant checks.
> >   Thanks Rafael J. Wysocki for helpful advice.
> > v2:
> > * Add checks for ide_dev and isa_dev before dev_dbg()
> >   Thanks Rafael J. Wysocki for helpful advice.
> > ---
> >  drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > index 7ec1dc04fd11..de256e3adeed 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
> >  {
> >  	u8 value1 = 0;
> >  	u8 value2 = 0;
> > +	struct pci_dev *ide_dev = NULL, *isa_dev = NULL;
> >  
> >  
> >  	if (!dev)
> > @@ -107,12 +108,12 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
> >  		 * each IDE controller's DMA status to make sure we catch all
> >  		 * DMA activity.
> >  		 */
> > -		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
> > +		ide_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
> >  				     PCI_DEVICE_ID_INTEL_82371AB,
> >  				     PCI_ANY_ID, PCI_ANY_ID, NULL);
> > -		if (dev) {
> > -			errata.piix4.bmisx = pci_resource_start(dev, 4);
> > -			pci_dev_put(dev);
> > +		if (ide_dev) {
> > +			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
> > +			pci_dev_put(ide_dev);
> >  		}
> >  
> >  		/*
> > @@ -124,24 +125,24 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
> >  		 * disable C3 support if this is enabled, as some legacy
> >  		 * devices won't operate well if fast DMA is disabled.
> >  		 */
> > -		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
> > +		isa_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
> >  				     PCI_DEVICE_ID_INTEL_82371AB_0,
> >  				     PCI_ANY_ID, PCI_ANY_ID, NULL);
> > -		if (dev) {
> > -			pci_read_config_byte(dev, 0x76, &value1);
> > -			pci_read_config_byte(dev, 0x77, &value2);
> > +		if (isa_dev) {
> > +			pci_read_config_byte(isa_dev, 0x76, &value1);
> > +			pci_read_config_byte(isa_dev, 0x77, &value2);
> >  			if ((value1 & 0x80) || (value2 & 0x80))
> >  				errata.piix4.fdma = 1;
> > -			pci_dev_put(dev);
> > +			pci_dev_put(isa_dev);
> >  		}
> >  
> >  		break;
> >  	}
> >  
> > -	if (errata.piix4.bmisx)
> > -		dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
> > -	if (errata.piix4.fdma)
> > -		dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
> > +	if (ide_dev)
> > +		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
> 
> Is it safe to dereference ide_dev here? It looks like pci_dev_put(ide_dev)
> was already called above, which drops the reference and might lead to a
> use-after-free.
> 
> Also, does this change the logging behavior? The original code checked
> errata.piix4.bmisx before logging, but now it logs as long as ide_dev
> was found, even if the erratum is not actually enabled.

Well, it has a point.

The patch below should fix this.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] ACPI: processor: Fix previous acpi_processor_errata_piix4() fix

After commi f132e089fe89 ("ACPI: processor: Fix NULL-pointer dereference
in acpi_processor_errata_piix4()"), device pointers may be dereferenced
after dropping references to the device objects pointed to by them,
which may cause a use-after-free to occur.

Moreover, debug messages about enabling the errata may be printed
if the errata flags corresponding to them are unset.

Address all of these issues by moving message printing to the points
in the code where the errata flags are set.

Fixes: f132e089fe89 ("ACPI: processor: Fix NULL-pointer dereference in acpi_processor_errata_piix4()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-acpi/938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_processor.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -113,6 +113,10 @@ static int acpi_processor_errata_piix4(s
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
 		if (ide_dev) {
 			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
+			if (errata.piix4.bmisx)
+				dev_dbg(&ide_dev->dev,
+					"Bus master activity detection (BM-IDE) erratum enabled\n");
+
 			pci_dev_put(ide_dev);
 		}
 
@@ -131,20 +135,17 @@ static int acpi_processor_errata_piix4(s
 		if (isa_dev) {
 			pci_read_config_byte(isa_dev, 0x76, &value1);
 			pci_read_config_byte(isa_dev, 0x77, &value2);
-			if ((value1 & 0x80) || (value2 & 0x80))
+			if ((value1 & 0x80) || (value2 & 0x80)) {
 				errata.piix4.fdma = 1;
+				dev_dbg(&isa_dev->dev,
+					"Type-F DMA livelock erratum (C3 disabled)\n");
+			}
 			pci_dev_put(isa_dev);
 		}
 
 		break;
 	}
 
-	if (ide_dev)
-		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
-
-	if (isa_dev)
-		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
-
 	return 0;
 }
 



