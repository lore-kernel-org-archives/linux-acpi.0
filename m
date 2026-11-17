Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873921;
	b=bJp6evgas0La58gSO3zGpS9jy+rqFvzl5fB+h/PLqIK/xrfDWtdUAnfj+KmvYYxIEKFn
	 NMEvV0IDzxc9SU/QtYSzbSnM9agXcXeEegOChrPSs05Dz0dlZ1mw2TlfgEt+7bSbXSoJS
	 Z/Wb3xNSdCbEwrC8SmBg8NgKzkMms+TBsDx7ribr67vUBU0t9JYfldCHxzK5RlT0Ljnzi
	 hAgMAorekUl9UywveFdUQvk3EXpCozzrlNF1jcyQMXDP2Wf777oTEIru/Y+Lay4oA4FTu
	 qTUEsXLDJ0/K8LUEQlHsAWYcjp8cnYGP0x2ZnmKQ0/6qk844bg2MXA4/tmAJ5iVLf2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eMx+CTkXv1VoOtSvi+6D1nYsmWu0vpvPd8N8huVVt6c=;
	b=fHd93z1S3zy5VvMSR9MDyC/uOlCeItseumN3EQbHClWsOSMuKsmezkUMrbi5bN8GJTae
	 imm69/LrKgxZVdXNVE5/HwE7YTNjfN/KyrxKv7LT6FxyIwDdKSGvUyIsFASY3QZDdt20H
	 U9VrUnxNuCukSxk8yaqEKQBTN8QPhQK+BPBXIOes1zAKNRuyC8/Odn+JIC31B5sauGfdb
	 1BFQ9GAiVVHRoRn17a/agWW9XQmvNzHDax71/N8Qi3/TTVMLUyjq8A5wN1CqkPinqew5H
	 zirklgW/Cda5EYso+DrgckXJa/bvNDmwkxZyWcjKBWlv501pvea8azu0LrbRMMbF0Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=o+1molFf;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F436606A32A
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 00:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F436606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=o+1molFf
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f2049ea7aso309716885a.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 16:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794873920; x=1795478720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eMx+CTkXv1VoOtSvi+6D1nYsmWu0vpvPd8N8huVVt6c=;
        b=o+1molFffc9e6T9ddIDnNeseSjzEf2bQKujHs4vpOVw4OzSSGS4YQo8BJrSN9kd667
         k9JFBOotGGRYa0PkAFx2E0FiQp1pgsnwgn6pcnUL3Eya4+1ObVIZXwVWtTnGOXsLpAKM
         Qm4w4F5jBIoZdwaJAnrycuNhvr/nMKvlaRPWeoY+KemZwqtCHlIRV3pKlOZAan8ZiPyk
         dg+rWFVtziAEodqueYjujOY8FQIiLOIqi0nCOki4SNuEx/vo4myxz/px2YhfTxnQyYx8
         5SnT2fX1BMMsw9KBqqyDMrnK6kEETUe11lAAN+nPzvpxO9VlnJiaiLVZSGU+NSdcdbag
         q8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873920; x=1795478720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMx+CTkXv1VoOtSvi+6D1nYsmWu0vpvPd8N8huVVt6c=;
        b=HVrp6iXTg3HBoJthGXkEhkn9Y6BfcalfKd8Y4FmptWQg+DsH0xlh2FLHGQ18wodlf1
         0pNh865eqlDW6lhrwLbaQsZWC2zRYEBZTMgbQoNiWF/zrOX3litCpY+mpIIcYNxgpJK3
         V9kEUnGn3pYhdw+2flHD9tyQSVr1rysIzq8oaKER1PcB/XAkQUMEtZD1iv2r/Iw0vSa+
         sJ7HSfs3Blgkpl2lC2xhZM+uNqZDXIVgiQMNhZSw9XUeLFm35h5c/hwnJIc2m92+7NXc
         w+l7CWZl76U6coYmyEtKkCknoMQoLlzD13JYrWCIlmofSSLPYeYnhuRvprscI743OVXR
         4EMA==
X-Forwarded-Encrypted: i=1; AL+hErGpmFun4A0IwI8lR2QHufOzkKpQjgoDTYHHxxRjE/VQqsEWqgF47ittF2KTkTWmqfa6B/y8X6Y+9yCL@vger.kernel.org
X-Gm-Message-State: APuU4Z86xS03WaRe0z1CpRpqQt1I4eUPdSA1zAdFewSU8PirsdHlTtQG
	VZoHXlEPSmCItjHxCU2SqnuNHvqWvTRw43xj3VkATdM19+yLU/1llVpSMcP2x0rVVDI=
X-Gm-Gg: AYBFou11+c3HjMFWVZ1p+3a0Uqnvu5fHKFVA0tQhsocV5wwaYcAD10f7bjOyznsXGHT
	7fthV+CfLaUIVdra3EQZaC8D2jbPcIeSlkgBt8epZPvEZUIZXq+jT9QhiuHXHraHShOVIImXj75
	FQT+7YQpZbI4ev0OXTcv2IbR2ch9oXrX2tinXSDtZwAOllwjgVkm5ffPyzYgfY9FuKRjOL0RS2I
	E7APYCgW1cbwflc9+3IeV3PwdMLfwicMtEiDsqhjNEBXmk42XAWtQbVnn0sAlfFBEgNRE2wHwng
	kqH+eogsclo9wawFOni8BThCMnTRaXGmuREKHHYfBndLK2R/dUVFJERzuZ7Y/YxMcn8bMJlkreb
	QhS4JrKLX0BMT9eprU2ooWfAERvhzhwit4irDK4QQqwPVFVEBfBcRc3+td8KHudcCiDcfKRSYnu
	z30r0VA0vejwwV81RhsQSWoeoOzPx5mrXZZo+7oUFPAX+B0r8i7S7pPRgSC8rF0IyDtcbf8mOY8
	Eo9ir89+/7DKzu1+Z8p52IZGXmmqYF66IAbcGhom49nt1PVDvMHQAAbHoAOI8MP66C4B5AeM53s
	IEScZg==
X-Received: by 2002:a05:620a:aa0b:b0:949:7473:b1a5 with SMTP id af79cd13be357-9497473c077mr807892285a.55.1794873920005;
        Mon, 16 Nov 2026 16:05:20 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8b889csm969866585a.32.2026.11.16.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:05:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT6h7-0000000Apgy-1pGN;
	Mon, 16 Nov 2026 20:05:05 -0400
Date: Mon, 16 Nov 2026 20:05:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
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
Message-ID: <20261117000505.GA2488304@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
 <20261110122237.GG8635@unreal>
 <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>
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
In-Reply-To: <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>

On Mon, Nov 16, 2026 at 05:13:59PM +0000, Robin Murphy wrote:
> Even with the slightly dubious argument that this series only intends to
> shuffle the existing PCI code around rather than fully introduce the generic
> abstraction that it claims to, if the PCI behaviour is still just based on
> propagating the internal "untrusted" flag plus the new global override, both
> of which *are* known at add_device time into the common trust state, then
> there seems little excuse for not doing that up-front so that the new API
> *can* just work as expected.

The desired iommu flow is to start out as blocking and create the
default domain only right before driver binding when we have the
correct trust level.

If we try to do that without this series then we have to do it all the
time, which I'm really scared will break some embedded thing that
expects scanout to work or something like that. My hope was this
becomes opt-in based on the new command line stuff in this series.

On the other hand this series works properly on systems without an
iommu, which is pretty much all CC VMs today.

There are probably around 15 series to complete all of this PCI device
attestation. Without everything it isn't really usable, IMHO. I'm not
that worried about the series ordering.
> > We have two levels: policy - that describes the default of all devices
> > for that bus. level - actual decision on how that device is going to be
> > operated.
> > 
> > "Disabled" prevents driver probing until the device is authorized,
> > "Adversary" permits probing and requests the available protections
> > for operating an untrusted device.
> > 
> > Both need conservative initial IOMMU setup: a disabled device may later
> > be authorized as adversary, and authorization does not rebuild its IOMMU
> > domain.
> 
> Urgh, I can be absolutely certain I'm not the only one who is going to be
> confused this way... I see "disabled" and instinctively take it to mean
> disabling the device_trust *mechanism*, as the logical thing that people
> will reach for in terms of "I don't care what this new thing is, just get it
> out of my way and let my drivers work like they always used to; I want to
> disable the new thing."

Maybe "isolated" is a better word?

Jason
