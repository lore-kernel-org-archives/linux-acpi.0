Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546718;
	b=ruC/NHeejLLkeOS4r2K62T3+Z663SFJWLD3L4WhR50keOf00zXX1SFjl8X4UQ+qAATsv
	 SZ+Ggvj5EfHfNGHIEa8/acS567JXxbe4JAjeFV1hY8VaRMWJU+kHMsDoepdD+ESyzk2qs
	 PwftYT2H988NVmV+hm+fs2rg0VF395yom/uQlREJvDNVUffCgFnV7JiObQbkwHBPTV+82
	 df9P2tFz37ebluzn6VBp33+h2IW+hCYqG0qYde+jsPcaSxWYtcJ2GDTKVlyfvChj8SDt2
	 4NQFq1SL9q+0MYQHYVn+g75+xhXYljEzytw3rLacPm2OEXVyRmawveTZGaFLI26iavQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rKVd0WB9GKER5oLiGhqXKhoz1U/fSQCfKOepi4KUjiM=;
	b=zY+zMZaJ1QZV6EImE2sC7wG4bxKtWFw1AhDsowUX4vFS9uFev5VpaPULFJmkOSxRW3iE
	 ZmlH+NQUU4gbToH3GWLYBCh8cHoMOFTGI8R4Y8ZoKdFJ3ZeufUcG0RHm96dhVneZxNIsd
	 aUE0LZgpMlj3BvsAdveOj5of5txjtw3ZUAHfPsJ3KX4K1pZy/z8KR/q6IzYxGwLdXfoj2
	 y2b+efOe1SkSu0FEN8knDW9kkOzi8ptAK/Wk2aRur22MuxkVsOSKmZGcxozstSOZV3wbo
	 5uWmAkxVEJrvEdl5CSqidBD9fuSLhaJLVQxIYqp5gSqo1AbR71p3KaHp3MCz3FktKEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bDP7tg7r;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332B606A68B
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 18:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1332B606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bDP7tg7r
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so3476578f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 10:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795546716; x=1796151516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rKVd0WB9GKER5oLiGhqXKhoz1U/fSQCfKOepi4KUjiM=;
        b=bDP7tg7rXIWgB+hAPfjr5hkfXqq3/feAOEYjiTHuNZrQlhTtTN46nfDNyfwQbJPZFF
         9dIgjYOemEri6j3ST+69bdA6wEwAor2eTWvN7U35JZAsxdhhRIUlxX9rIE9vYUa4xshh
         me3UKBz9ojnotyqPz1jk4D5mb5c58YTf5H6Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546716; x=1796151516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKVd0WB9GKER5oLiGhqXKhoz1U/fSQCfKOepi4KUjiM=;
        b=ZcFrFsZljL22yWRbO/LJ3K/d+aiow8U1/I1SLKre9iSxElNasDEYn+OP7v90M4Opa8
         RBl1aOF5HHj1KXvjY6whStC7yANRDeFBS4pSyaOqdpypYWB3XDaT5bergxTzkMlMxRSe
         T/N+vwGP6CpjlW35LYb+ihS8A24t6qsg5UbVrugflUD5Q+pTnn8RqRSWDvKnkrCiLDnp
         2oPkapEmxWBG/LTdfZk2f012msVTKQqOqj8E4fG/bKf1KA3Sr/ilqFe3f74oVlxEiw0D
         6DghGzLZ8x4oiIU2QuZtskO14TmLCqckCwDX2Hrr0rSJXWFYe3/7wVLkH1RC4VzBxMkn
         sp4Q==
X-Forwarded-Encrypted: i=1; AL+hErGS6OXw6qVCepK+u3Nx5lUU0rD7w1rc5zT38kWtmiStAKpNc2n1ZQpVv9bKwc5NlZf0SXrjVzeJbVGF@vger.kernel.org
X-Gm-Message-State: APuU4Z/MNsrcATPuqL/hIOgW8mVSmgdInKz8rqrDqEd/Bw4+OpEYV4jX
	ZnWBkk3MoCiaX2oC2oaq5qjOrWgPtE4nRWWvBkiUrCSpVMfmpzmBkWdJyzqFFdnHmQ==
X-Gm-Gg: AZFdTZf4L09mxXKIBFOlOy6zpHxCMSexFk/EhNpMOeq/3YP58u/3gGe6QiIccb1/wVw
	heUVXVYbEVzQzRtXCH+hdFta4fgrreWpfEpwv9jcQpRe4mhP6sggOsToGX81YDqamLf20kzawSh
	Fa9RhbrSMKKDDYYDsPxZ59ZEARcQsBhK9zfUbKHUMdV09T0mUV4dErrmcmc0jXS1wBY9O5QEFfK
	fzP9rjn2x7yUbkTkkvngUMX0rbq2Ync9i8bdHCLUHSb8jP4vkGaCENjncJ/9C3oisqvr46Wig9E
	fUWDZAzgzfQqmB8uyGIVtrwnhUi0TgP0FHv6m409BHZp2P+3Vda090J8AOv+Ku9aS9h0XXJ7Urk
	CjSNeAsUDN61toggP5WTai4t/CdrLODtAiNKk8xQ2p46kYT4LTHJE8yQgyEirlddwRZjZQFA9Ex
	Xux5QBCukiUDcgY5W6b0Nz78feQ/NgHF1OlWbMHQdCm8yto9BqU10szK6XRrfz8v6Qfog+Dd+ti
	gFNCaMuy2qO6enkdnEYZCR572nyZH1/bDPlh7BqHIQkbIrInm5iuhS5vtPIpiPKPeDWjHQdMbp1
	3xTqFg+vGKYvvEp4DprW1DsIO5UYFmuerTUCXsWze/bH0VSmjWGB1wuiXuaCk/BL
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4bb8881b8e4mr321879025e9.17.1795546716413;
        Tue, 24 Nov 2026 10:58:36 -0800 (PST)
Received: from google.com ([2a00:79e0:285b:8:af0c:c5f1:ee8a:b81f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm445870355e9.15.2026.11.24.10.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:58:35 -0800 (PST)
Date: Tue, 24 Nov 2026 19:58:31 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Torokhov <dtor@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, iommu@lists.linux.dev,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Joshua Peraza <jperaza@google.com>,
	Jesse Barnes <jsbarnes@google.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Tomasz Nowicki <tnowicki@google.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: Re: [PATCH v11 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Message-ID: <awXeV5Jo4WTjLc8c@google.com>
References: <20261123235845.564027-1-dmaluka@chromium.org>
 <20261123235845.564027-2-dmaluka@chromium.org>
 <sashiko-outbox-230247@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-230247@kernel.org>

On Tue, Nov 24, 2026 at 12:15:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] PCI/ACPI: platform_optin_force_iommu() ignores DmaProperty
>   devices
> - [Medium] PCI: SR-IOV VFs do not inherit untrusted flag from
>   DmaProperty PF
> --
> 
> commit 534ec8c0dc4ebcebaa88d905d9760f867ca5b38f
> Author: Rajat Jain <rajatja@google.com>
> 
> PCI/ACPI: Support Microsoft's "DmaProperty"
> 
> This commit adds support for the Microsoft ACPI _DSD "DmaProperty" to mark
> PCI devices as untrusted when the property is set to 1.
> 
> Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 1150f2fbabf41..5971ffc2a375a 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1427,12 +1427,34 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
> >  		dev->external_facing = 1;
> >  }
> >  
> > +static int pci_dev_has_dma_property(struct pci_dev *dev)
> > +{
> > +	struct acpi_device *adev;
> > +	const union acpi_object *obj;
> > +
> > +	adev = ACPI_COMPANION(&dev->dev);
> > +	if (!adev)
> > +		return 0;
> > +
> > +	/*
> > +	 * Property used by Microsoft Windows to enforce IOMMU DMA
> > +	 * protection from any device, that the system may not fully trust;
> > +	 * we'll honour it the same way.
> > +	 */
> > +	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
> > +				   &obj) && obj->integer.value == 1)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> >  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >  {
> >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> >  
> >  	pci_acpi_optimize_delay(pci_dev, adev->handle);
> >  	pci_acpi_set_external_facing(pci_dev);
> > +	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
> 
> [Severity: Medium]
> Should platform_optin_force_iommu() also check for devices marked via
> DmaProperty?
> 
> In drivers/iommu/intel/iommu.c, platform_optin_force_iommu() only checks
> has_external_pci(), which tests pdev->external_facing:
> 
> drivers/iommu/intel/iommu.c:has_external_pci() {
> 	...
> 	for_each_pci_dev(pdev)
> 		if (pdev->external_facing) {
> 			pci_dev_put(pdev);
> 			return true;
> 		}
> 	return false;
> }
> 
> On systems with CONFIG_INTEL_IOMMU_DEFAULT_ON=n where firmware sets the
> DMAR platform opt-in flag and marks internal ports or devices with
> DmaProperty instead of ExternalFacingPort, has_external_pci() returns
> false.  platform_optin_force_iommu() then returns early without enabling
> DMAR_FORCE_ON, and intel_iommu_init() disables the IOMMU, leaving those
> devices without DMA remapping protection.

Makes sense to me. As I understand, prior to this patch,
platform_optin_force_iommu() was technically not buggy, since
pdev->untrusted was only set for devices downstream of external-facing
ports; whereas with this patch, internal (e.g. SoC-integrated) devices
may also be marked as untrusted i.e. requiring DMA protection, thus
platform_optin_force_iommu() should check pdev->untrusted along with
checking pdev->external_facing.

Baolu, do you agree?

> [Severity: Medium]
> Do SR-IOV Virtual Functions inherit pci_dev->untrusted when DmaProperty is
> placed directly on an endpoint Physical Function?
> 
> When VFs are created via pci_iov_add_virtfn() -> pci_iov_scan_device() ->
> pci_setup_device(), set_pcie_untrusted() checks pci_upstream_bridge(dev).
> Because pci_upstream_bridge() resolves pci_physfn(dev) first and returns
> the bridge upstream of the PF (or NULL on a root bus) rather than the PF
> itself, and VFs do not share the PF's ACPI companion, virtfn->untrusted
> remains 0.  IOMMU and DMA paths then treat the VFs of an untrusted PF as
> trusted.

Yeah, similarly agree. Looks like pci_iov_add_virtfn() is implicitly
relying on an assumption that pdev->untrusted is *only* true for PFs
downstream of external-facing ports, which happens to be the case
without this patch, but is no longer the case with this patch.

...Although, independently of this series, looks like
set_pcie_untrusted() is completely buggy on non-x86 since v6.13, since
it solely relies on arch_pci_dev_is_removable(). I've just reported that
at https://lore.kernel.org/all/awXXSfrhLHK7TNbp@google.com/
