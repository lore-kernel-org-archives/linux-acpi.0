Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FE2D739D
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768424; cv=none; b=YK2xRfMY9mLDdUZ4NinoQUU3WN4dOzlF1j97jMwj1qEOh4wyEg6/Ld2Pv89QJHld3KwWSN/tYIbVa0VlWm8TewLTYNVDOn74CRtgnPDs7y+uHe1c5Hh1VoP1PVmYjArc32QPUAph3iqb8BRx3j3iSUcpWfFQ7P80C6cKz5fs5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768424; c=relaxed/simple;
	bh=6eoeDXeo46cITuavdjHK9nlaMQnpmRyGUu4eVwi1lIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTfak2wJVo85c+koHv9y7vpIFXWdVa6FrDt5UzJaOHQBTg2N3qlvQDxCxajEImif0O9ol11/hBs0Q1XiBjxSIxyo0Anwz1fB7ANmebGGQby2PK9XtsSiTSL5iYdaFEm12FliTcZuKKM0+yoUiK+5xrR4UTSa7ikaqgrWArlJ3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAQFaFA2; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAQFaFA2"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-128b9b7e3edso3032571c88.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773768422; x=1774373222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeRUD2lyo8OTEnvxnhxL/ZUJ8lFblgX1fXUnBw0EO9o=;
        b=aAQFaFA22DgaeNF23g0x/R2uWAgSR3uyaSjc/i2MasEnvIUrSmf4l+tUcUjHZ8Bbox
         42eC1BSk/n5PbywrP3pY7NDf6Tk7t9Gy7P/qcS0cXHAOmHjMJo+OA793s6sKqDb3SVw8
         /pbLQmsouRFHsgbiXre/eBNoMN+yVd/yjl3dgbCbZ1fU8nP70yy/KpKauv8psRZVY4Kj
         Ds5KDlMRp6v2+XToTjwCQf41EaAsvbTTUMJTRqWlqdmQ+C6r7/PouHBijQpTTiYC0FUq
         mnjyMsr8b+o7PrHrYB6Yt0ZjMdbMCotCWRuAJMqMW3uN9o141G7DB+S3TTo3TBfIMlYM
         J8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773768422; x=1774373222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EeRUD2lyo8OTEnvxnhxL/ZUJ8lFblgX1fXUnBw0EO9o=;
        b=BgeFv69hwbwZjBF2sSE3/HL2cwpqEoLCvQmuaUjcPB/RCP2t91g8mbsu+85rz/8bPD
         FRFFUp0XWPVgt2sKtF0NbwOeTEPG/X3Iu9bMwhVVvsFiEGHi6zVYvZEsG7mpWOmzzTwc
         8KSFzXBvRY3D60aulDVmeXaN+WhnJV2iicibAgNaEw00tgG0i4pHCcZXsgTol6kl5gv6
         d54DTSwWAe6K59r/5LCYKzwJpTs7pUBLauQElWKVXjeb+JUc7TKgt3qxNwkOqh3gCgsK
         IJTDofz1rQe5Dj7fJfdKSMe5Pt4E6TDs68T6VnHotVpz6p6nawnDDq3nUDRtUJVT7rU4
         juuA==
X-Forwarded-Encrypted: i=1; AJvYcCXWYEQBtGy3VgpuwGd+w3X62fUE21XQvFVZA/1Rvj/FiaKXRPidR0RAzfqnfyDbKKy0m0PqDhsbA4ne@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3iVaUdYgYG4nLIRiASqa4DBylXGCMdsSCxbbL4KCo5A6mCAvV
	uP+HCbLv2GGh2gbv9Qvc9mKYp5QsVYtbvs5s3Vl+qnEg7CkvsKbcI1wtRlJzmQ==
X-Gm-Gg: ATEYQzzLvkaZvVNxRBDZLy11RLY7mP1y3BeD2ljnKsRYrqdb/Cjcj3U58YTwwGzMjEg
	KarzVTJ69HfNXwpgCtJJc0rln8mt6khlx7MMJ9KEsAU54Cut/QtjKuL6qXAe+XazQyFrJZseYbo
	JbODABkH+gYQ5IqhJx0SW5D4bBlxo8l/olhsmys8T2Q4p5n5A3BIHFS6NXfXZ1U4hZLF49QhH++
	tBZMM3oU/KDpAuliFMxIgAyt7kmfrZRbHcMLgcKZBDxa5bn0gVR7pivuM5wzy0k+LCeOPSivqrt
	9HjIjZ4lk3DibqVeMBUoZKR1VYf5iz58ln1992h9TH9gc5DvxM/xzmpyATG96rgfvT4LXY+VshQ
	/FmsweZRnSRnkKry5O3qdlkhxXVX+ei80W0L4Mykxjcf2mZS2Hwreek/VpJy4oCgFRpDrBQCZR9
	V4YeJWqJnQw+YlbXrW+WQ9mledzGAjx2WHKnlM
X-Received: by 2002:a05:7022:7a1:b0:128:cf5c:5352 with SMTP id a92af1059eb24-129a70f9cbfmr173193c88.4.1773768421895;
        Tue, 17 Mar 2026 10:27:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129a7256263sm277843c88.4.2026.03.17.10.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:27:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 17 Mar 2026 10:26:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tuo Li <islituo@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: processor: Fix a possible null-pointer
 dereference in acpi_processor_errata_piix4() when debug messages are enabled
Message-ID: <938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net>
References: <20260111163214.202262-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111163214.202262-1-islituo@gmail.com>

Hi,

On Mon, Jan 12, 2026 at 12:32:14AM +0800, Tuo Li wrote:
> In acpi_processor_errata_piix4(), the pointer dev is first assigned an IDE
> device and then reassigned an ISA device:
> 
>   dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB, ...);
>   dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB_0, ...);
> 
> If the first lookup succeeds but the second fails, dev becomes NULL. This
> leads to a potential null-pointer dereference when dev_dbg() is called:
> 
>   if (errata.piix4.bmisx)
>     dev_dbg(&dev->dev, ...);
> 
> To prevent this, use two temporary pointers and retrieve each device
> independently, avoiding overwriting dev with a possible NULL value.
> 
> 
> Signed-off-by: Tuo Li <islituo@gmail.com>

AI review feedback inline below.

I don't know if the device lifetime issue is real, but the now unconditional
debug message is definitely a functional change and potentially misleading.

Either case, why not just move the debug messages into the code setting 
errata.piix4.bmisx and errata.piix4.fdma ?

Thanks,
Guenter

> ---
> v3:
> * Initialize the new variables to NULL and drop redundant checks.
>   Thanks Rafael J. Wysocki for helpful advice.
> v2:
> * Add checks for ide_dev and isa_dev before dev_dbg()
>   Thanks Rafael J. Wysocki for helpful advice.
> ---
>  drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 7ec1dc04fd11..de256e3adeed 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
>  {
>  	u8 value1 = 0;
>  	u8 value2 = 0;
> +	struct pci_dev *ide_dev = NULL, *isa_dev = NULL;
>  
>  
>  	if (!dev)
> @@ -107,12 +108,12 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
>  		 * each IDE controller's DMA status to make sure we catch all
>  		 * DMA activity.
>  		 */
> -		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
> +		ide_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
>  				     PCI_DEVICE_ID_INTEL_82371AB,
>  				     PCI_ANY_ID, PCI_ANY_ID, NULL);
> -		if (dev) {
> -			errata.piix4.bmisx = pci_resource_start(dev, 4);
> -			pci_dev_put(dev);
> +		if (ide_dev) {
> +			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
> +			pci_dev_put(ide_dev);
>  		}
>  
>  		/*
> @@ -124,24 +125,24 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
>  		 * disable C3 support if this is enabled, as some legacy
>  		 * devices won't operate well if fast DMA is disabled.
>  		 */
> -		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
> +		isa_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
>  				     PCI_DEVICE_ID_INTEL_82371AB_0,
>  				     PCI_ANY_ID, PCI_ANY_ID, NULL);
> -		if (dev) {
> -			pci_read_config_byte(dev, 0x76, &value1);
> -			pci_read_config_byte(dev, 0x77, &value2);
> +		if (isa_dev) {
> +			pci_read_config_byte(isa_dev, 0x76, &value1);
> +			pci_read_config_byte(isa_dev, 0x77, &value2);
>  			if ((value1 & 0x80) || (value2 & 0x80))
>  				errata.piix4.fdma = 1;
> -			pci_dev_put(dev);
> +			pci_dev_put(isa_dev);
>  		}
>  
>  		break;
>  	}
>  
> -	if (errata.piix4.bmisx)
> -		dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
> -	if (errata.piix4.fdma)
> -		dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
> +	if (ide_dev)
> +		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");

Is it safe to dereference ide_dev here? It looks like pci_dev_put(ide_dev)
was already called above, which drops the reference and might lead to a
use-after-free.

Also, does this change the logging behavior? The original code checked
errata.piix4.bmisx before logging, but now it logs as long as ide_dev
was found, even if the erratum is not actually enabled.

> +	if (isa_dev)
> +		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");

Similarly, could this cause a use-after-free on isa_dev after
pci_dev_put(isa_dev) was called?

Additionally, does this unconditionally print the "Type-F DMA livelock"
message if the ISA controller is present, skipping the original check
for errata.piix4.fdma?

Since the original `dev` parameter is no longer reassigned, would it be
better to keep using `&dev->dev` and the original errata checks here to log
against the original PIIX4 ACPI controller?

>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
