Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859754;
	b=Hs1yqmYeCCiOhgzU4SmT/IfbE4AoCGqGsV2VhRVwe1IAhfsJCha+41Dbx0nSPxcCYYd+
	 zNlv2snXG7Jon59ILE++spT45hedd6viWjRZRGX4AjzLUe3rHbA5rbjurGyhgDvQreKlW
	 sWm3XfIf0tpmSiOL5h8wteG5BC0RyVQ8bD4d2APePxEYQXtCGnRjXYK0uVNjagVlDFm2S
	 FAGSBTDgP1aFiroki01Ls1bnLCAa2U6vMFNdLcIO8LlevUTR00mySIabQeopAXoNP+md4
	 YUeTU4eywIENzqIvX6HSfN+bLvrx9kfyqd/7cEmuNk2GJdsRNyRdqPdGj2nxqDlvYzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
	b=Bmw01weaMPz+uZBANpC9+VmcKk2CQu+A3EYNTgral7I7OFCheNrIblKysV1iHHVe4VEf
	 MKVAi08KXY80E2r1rmwMiwy6Q827NnCjTT0rIuc8Czj7y5cpQIc10IYJon0eOOxXDEHEO
	 dKSVa39cEyF0YzUTjZwVOgsNsZrmOOdsXAztymr9G9y3vYxZXdxTDBDTdvqYR39IsE7i2
	 ViyxfWjRT9oPdN+HhWWeQIPN8glHPhLdXZcEI+0cZY01aCKKmcG/pZwDtGMk10t+c+sjd
	 ey9LfNUe2fbkBDs2gM/alpaulgCHAfiVKaZcyXsanaThvgrw8gvXYrVp5Z3ZcwH7FUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbZUyxTk;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7B606A338
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 20:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC7B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbZUyxTk
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-536717a4d83so40754581cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794859753; x=1795464553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=nbZUyxTk1xDDi9/JiN9In9kNH24m3xvR3W8MPaMB063K/nb6P74sDih4ebpP83k2np
         SjqTAYuPLCHW+FRVrjLKSTbDX5aM/IVbZZxu+ASYJ/ssH0gDFbMJvSJmLcdHAAsDSEL+
         FG47SOuU8PRulqvpOebFRdp+iKyncNtYeoKxWrzhMSjcb9i+1jD4cThvDUO+7PnMd3zc
         ImV7NXhI8pI4k1LW/eM2oLltJhXP6hUveoFekGEVH6+oWgooyZkYdcVCIAs0jW9hoXxW
         5IGbSHDAmwoeFMTug5VO+bv+VKknP1f2hoIrUsvWYeNqALAO8eTePO8ZOjSwRNnR3p0b
         L2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859753; x=1795464553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=G4Uktd61aam0Q8VcCKi0qZZIjiI/k4DBIMtWA0vaKj09GlvGjr+mqVlBdf4PUUw36i
         7GRvKDBmRZR7OZl1ehQvkEAatWq2fPBODrKd/GATrExY4zKSocReTXvQC9e2D2o61QCJ
         TpgFiHseD+/AXR0FuIyXIWtLS8surCo1FKTYZQVuxkruQyqLL11pog9otogKd6b0ayZ9
         xDg1V77IwixToaPmtGlAdgKp8TqCrcUwEreeQpKm1rc3oaytD1GdcJ5FZ45JE69g6Zbz
         s0vqUep7OhkrMhGKNBt5xWZ/PAYnCONpnHTPlQZOWrnHUjsoHPzQs8AdqoueMBK1yaqO
         mbjA==
X-Forwarded-Encrypted: i=1; AL+hErHxM5u+9WfgYmiZamxuRW0KcHzNvAz4Fx12A0xwW5nuUEYsCe6h1Nrh4LITUBuaT1PX/9ue4dDWFvLH@vger.kernel.org
X-Gm-Message-State: APuU4Z8s3HIthjquSqtlbm3z2J1rnXQLRian8MzESMzojh1N/0r56sm9
	KXXI1ePSZQJnLTUrm5ky3qOF/m0e/74b7yLWd0zQnm6dHyMCaDoCNjLVzltIRqja4M0=
X-Gm-Gg: AYBFou3xYRRAEsUFry6ByXWkdJG0HGtWFPJYsRM2Tv8NsBx47v4FfATtMDjmtKLAhzj
	Oy4JY6T0mXv3AtgUF342TABUTlZcHD3+mMrC0WqQfjx+BRUn4RQBEKea3VUHQy+VExj2tcYRb5K
	CCWrqezZK8Bq5myxhYvyC5oVwx6mf9Az4hxmFPMbfYhUSSihBD+x+nlbOE6EQClewOl9c76A6jv
	tXviIhepLabHaDThChm+0s/aWUIfVBMNrLA/67+5MMgan2s5mbCzTiuB0snLBteaGVqHs700liH
	SueyRHdKce62RXffTDN7gGiYb0RfrbKnHZ7KBEJ1nmCPVsrZJlsr7DRW99GJkcnf5XeQDRqerLq
	lIf8BWHWgiFlusnWvzrK56dJlwDn0mOstZxjjtcJVjOYdfxQ38LFx05sMuRNdfJayH8NTew1lO4
	gzXH2pCulp8GO5zBM8ku1HSQOpWHzL7HwFqV/FGigiuG8mOSS5WVsZ8fEPaqj9IFh5g7gmA1A+g
	6JMzH/OWy0fvgqyI1N66lGhTpRLzW76rWjg7p/79BqRW8a7Xo34SQEHd45JFMpk/vmalltuC0w/
	F/QnmQ==
X-Received: by 2002:a05:622a:5144:b0:536:98da:f790 with SMTP id d75a77b69052e-55ac43909femr187873791cf.6.1794859753196;
        Mon, 16 Nov 2026 12:09:13 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d445d1sm92856046d6.8.2026.11.16.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:09:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT30p-0000000ANtb-30lh;
	Mon, 16 Nov 2026 16:09:11 -0400
Date: Mon, 16 Nov 2026 16:09:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261116200911.GA2473219@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
 <20261116190417.GD2299285@ziepe.ca>
 <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>
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
In-Reply-To: <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>

On Mon, Nov 16, 2026 at 11:24:17AM -0800, Kameron Carr wrote:
> >> My scenario is pci-hyperv in a confidential VM with a paravisor. The
> >> paravisor is inside the guest's trust boundary and owns TDISP. It locks,
> >> attests and accepts the device, then answers a VMBus query describing
> >> which BAR ranges are private and whether the device's DMA may target
> >> private memory. Before a driver can bind pci-hyperv has to:
> > 
> > Sounds like a user in such an environment just wouldn't use the trust
> > level mechanism at all.
> > 
> > What use do you see for enabling trust level but having all the
> > devices unattestable and accepted already?
> 
> Previous iterations of device trust used the trust level to make
> decisions around DMA bounce buffering, etc. Is that no longer the
> case?

It is not, this is now just about userspace attestation really.

> I am looking for good hook candidates. I was hoping that trust levels
> would end up directing DMA behavior, etc. but maybe I am
> misunderstanding the design direction for these trust levels.

I don't know, I broadly expect some flag in the struct device to
indicate that it can access private memory, but how and when hyper-v
could get involved to set that flag I don't know.

Jason
