Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840359;
	b=IRn8WrsYp3hhXs+PjtLLbtndeILze9g9MRPrAxL+aQJU4Ivh9cYNTMWoYwEQbo6n7tio
	 aj0rStrPYURT88VbVjZJAXCtwPq/UqTrf9iDmZgLBOC+YeA8KFtCZpJNsME9kuGr/1h9M
	 izspZ2AIqb1IMljBxwLH34kriFp6N713rfrhCNy9TUnTUZEAdTo/i8IsRILpQRK3lMP2l
	 0/XZ5R/48cgZkSXBvD6rCkV+gspFFUmgvnT671/ziv22gRfJlKBYgxovT8jZ7MG5pXaAS
	 7hpFJwk5P8PdLH3Na9y4uBMhgBSdE5I+5wn/KFYtCkNexujhVJ3h2a4bXcjSOKiFT6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
	b=UxdyZW6ebS7bUIxAGoUKuFvmmD+R1BCBgnu52L0zPlbSGXhzW6AN0csniVcbbanbzRhM
	 pkLhVoo51yYfonunjwPl0+zJBWpFSKWTiUdxCUBCxV+tBmm9dgRqSpUbeZxTZAWLmCK4D
	 DL/514q6+SGP0cVMqzC94NGTvgzagIu6sJF4M8zPc2/FA/a0rW/TItXcdC23PXQxgHNZJ
	 cYE0HIiXtT/eOw6JwrrZgTtmkgHqoxWvABS8mXHVUA14zrSeoOsvaZ/S/jvI/GUKAFH+S
	 lVBp268htAzbHBOrWHkzdziv2vdK+AqGP0GJaXh2ZEwRv5yum93A4nREfRTDJESLw2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dLdJyonb;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFFE606A333
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DFFE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dLdJyonb
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9496400270fso215429785a.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794840358; x=1795445158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=dLdJyonbx/GT9GciisxRrbnKJNPmXRO37SMr0DcL0fOWPt4npP7q6oSEFPRBxyhYBG
         VwQv88je59xwJGF1tzvO02VHIK2UoI2gFnHM+RoqxVUasg9DyQA32ToeKqV0tOS8H2/F
         utZ+RQHXMciPdHoqR96pmDBV9oFbAflIPtcSFhX2+r9dDE0rLhaGZCPsZ1j517doL9zB
         RpfAbapy98a71EK1akS809jjM1beUX7TmDUaCrtYNcz/JJbJ2sGjj2UfCKl0NoQ68uWW
         NnufbW7FWZvXAJBZh4GXQ7J60xB7eIn/T76+zn9Pq4vvTPBJTSoxoiKRgL0R3QgrjVbx
         3mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840358; x=1795445158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=Dr8Pox/FDTe577jHNxM+ig98lhP36QdGcG4rnQ0Av0a0Gx562B/0EkJNrJUMREyVp7
         Esahj4VerQp1L/20mcz8p0VpIGl0XvgQ0V4C5HlRoE9RSfRI7XNlt9cfQxq/XkedQBjs
         OC/6pQKqHA9exCB6ESOph/uWQMBj6F+rDiErykKBytdCxydMASkZ/848tbmrypMJSBVy
         vjaLGZ5v2r2swkrpLEsIzwC0jMms8TN0RrPuc7J3zRub4DFu9tx2ZiwQAXdHNYLkZgM5
         gfdGLtK9YVvU6rH2wy2qgSN8OPqhiebapmaj5AjRdTD2tXxQXacamtsh2wt3gjnQ6QT2
         zdww==
X-Forwarded-Encrypted: i=1; AL+hErEaRKVKDiwp/m/aqPVOI/BMc5BVTpxJGjI/QtHos7EEVLo04KjPQ74qe1baUAdhMQJUswyNfNVK6iUj@vger.kernel.org
X-Gm-Message-State: APuU4Z/cOPifSK2T4KIHQmDA64YyWB3cwe6UThqBfItITRqxua3K6iXY
	2/iMIwAZ1qbkBL9HhbjIKgNXctPyF68KqY5sF2LE4xdXsFeKOShMsd2Q87waweSX0Bc=
X-Gm-Gg: AYBFou1ONHb9/0fgke2Khe9RhUvj2Co19R0+uaDe1PHa5Cncn7b1tkE8ncQg7GJsL5g
	yrnPiJRS77wj1Noi586hhBYsachusbJQhWxjtSgg7FxeH3D9/V7yNSEyGqGRmwB3K86LLwN3ofr
	m1qUsM+EbEQG/TO4grQwmGT1/DT4Mt//LBrAiMcq5L0+8NUk4jntPu7LfASTSbIZwpyJoyJJNmc
	FmJ27TTjV9fphXi5KpO/FHJLAP4GZPvwqSi+srRht2nvxcQN8FVjO+VP0OepUCrpKPgYzs/H5iE
	u29aPwWoF1R1jLiJYhY+EAtXkAJIcz580V8NDbHtlPvEBnYVutTrCt9eqcww/TTpI5R1ZI1HSWf
	4syofEn0x1sOHZecPKZTXd1peEDD9BuqOui5OdSBozdnwasSWP/fThbiQGAX2BczRmtMyyLoBGN
	MvcbWCGeChpfPRF6GzPAp3X6Y24cQ0RdY+GkdFoGw8m/4GTaht8rvgYiKEg4JAmhkVdsWUrsx/Z
	s2z/zAXH1kJyCtdniL4sOaDaPGzDzHJbDfytvGtp32f0p8Os4F4W3ObtzPkJJteiYnUzKOAHIcP
	8+GTxg==
X-Received: by 2002:a05:620a:a41a:20b0:949:5872:be1b with SMTP id af79cd13be357-9495872d3c0mr1015844485a.39.1794840357475;
        Mon, 16 Nov 2026 06:45:57 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836079sm858473985a.18.2026.11.16.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:45:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSxxz-00000009V73-1sJy;
	Mon, 16 Nov 2026 10:45:55 -0400
Date: Mon, 16 Nov 2026 10:45:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116144555.GM2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <20261116144103.GU11319@unreal>
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
In-Reply-To: <20261116144103.GU11319@unreal>

On Mon, Nov 16, 2026 at 04:41:03PM +0200, Leon Romanovsky wrote:
> > I think it should only be for the duration of a bound driver?
> 
> For now, I decided to disallow state changes because the IOMMU may outlive the
> bound device. Unbinding does not fully reset the device, so we must quiesce it
> to ensure complete security.

When we refine the lifecycle for the iommu this issue should go away
too

Jason
