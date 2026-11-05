Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896027;
	b=NbfvwCSnzWe7u8TdB5NTssc1q1Y2Yd9vDjddsBLVS1+ebOl77v0ddBfgmff2dgZn4EJw
	 dSYuVXNuHD1qleZJX8sPVUTI6KCz3xptVfprDOMaoHOE8vKv3US0RjDyjNBLhXA6uFOjB
	 czZkR9ORcS81vk9O9hckQk53+6GnSiYUxky9PaZQBgbih+IdLYAtIlytvJQ2lfUzzP9Pz
	 Ved3dKw+nag6bh32GB7jE6dMgODSQTw/p5KUJqKUhsfiZLuGXefaayotIamFX7uYw/9dw
	 No5n98we1NHna1MUMcieI66dfez2ZGodZS44rTYgWCEfMCGi6F9I3gpG5X//D/smDmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
	b=HExoXYzxtH2C02tb3jiXNNW6TxmPRPDLkMc1KvD5Ebj/9TAeV30fR0x2pP5d9m5gl2rM
	 WniW6XaoNddhdSf8FrqGxUANZW0hSv7By3RM+4MCCeKldSEwm0OCCABNJVmD6jRBK6C0R
	 Xjru9gwQ+YC6ItWMBAR2UZFO352Bww5XerII5J+icqwoi2LZr/swW1JpPRffhbLa76vV3
	 Uay5GaoVYwB9JoBhSXqT+zBv1bkoWUHgAxoodupA6c56rOxHMi5HAl95rQ13rDXvElnmd
	 cpwmHpcOU88+TZhcz8KWmiLaa3lNKN/V1mzRB3mqO1bUayqvcAD+aJhRjJxt9YSSvjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5F606A33C
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F5F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ecbfea5f51so155828e0c.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793896021; x=1794500821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=TH080M2b2W5GU83fC4bkAl8rc89cXnFJ2JUZ1DQM2E1G7nxV0uZ+iMHWJDX5M/hBR0
         v8Q4S1dZz9e+Wy709/pkQPJoJ382ui88GBuCa7YwB1Pwv+V08ySzbQGdCs4et9sFRxVX
         1a78LWa2r/qDmkC73yn92WJjnMydzWl2HaDmNekF7y5RHwsZB7YPGLTTr3xjjmuI4LbR
         sgpTrG1DSTm++FzIJZEq0knZSmQ9xxE9IezNyVfi/1ZtU95O+iPlQHI5LWAc3/YmXStT
         Vgy3IZE07Q/+XWoEa8k60w3BygO7yb8zhuyYBqBwOLPUaUevbalW8R2MAA5wjUpSFz6r
         zz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896021; x=1794500821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=hZE/GsWCBG5bCee0eklyPS8y7/7iKY8HvEdLshdzcubJry5t4QAAV3TywNSc4ipKdX
         AVj2y/xZrboaCn9n/XtJvJJ4N/YwkA3wNccZIma7DzU8XUTk49KfRqRD8T43owoCNYBM
         k/nfXmShJ2n/fcVkAu2n6S3RGuFgXwOm146OMFNUk9+NdOVIm4Tv2BuMnvmtj5qiQUQU
         uxznCwGPR2qLn8/6OeUkujCY8/Rf7y1nzk+ww+joY8GhyyZq5smT2Xbk9AUsU3lpE4ED
         qh14S/fAbX8wbw82JLUbbxxs9kVy3QDKyU5gYJ/pKr/P+LivIK7XHr8cE41YBCL7WHHD
         X6wg==
X-Forwarded-Encrypted: i=1; AKwUvByz0O4t7JDGsWcz4DZdUA22iKVwNRvl0Dx2NlG76jIq7yblEPW3PEZk4v9dAFJWjJkagxlOCrMxdMrK@vger.kernel.org
X-Gm-Message-State: APuU4Z/tvdkJnUEX2HCIKx2c/IKxI6Y30cXF1mBEVZ5Uf0XCULdRu3O2
	jBi9OE0sj2+akpvP5P1BDB15HDPCyWBegqTNkfy0BaDfO7sqozem4cTQkpQIANWXG+s=
X-Gm-Gg: AYBFou3aRIS9ZH2UTenBsI//jQ0nag0fL4XvFtSu1PkEXQwSf7BMRvt5Y4yiJpiJJJB
	+SIDd3CK6ez3VRtCtnp2P/EuJY+ugwOe75oh3pNFO8+icgbgSaMYW85zZnX/mASxQyzyH/rmjK/
	Qf78Z1TGPK4yM3vSZVOCayskof5L+rn9kRxTWdmR8RmD5lYKCrSyB0XQDe8Bg+rP3mN8NvTjioB
	dubZLNCTffOspBu50kz3dk3JiD5NsMSg+VdF65XWinZ5BVtXPs9Cqe146JRMpi++oHW7udbTwRp
	qL/KPWlY2Ks307j2e9G8w91fdsv89L7RVg3faWm2k2uF4pKAM+HMdPV7eeG8FvEVlBfFOE9UCoQ
	qmuqKl9FBNQmyCAjWQNmV522Kf06WMahlSrPWyIK7ZUatZcKYHhKpUsss880etTOYEaiPv5PLK0
	4S9VnAz3u1hFoNw2rMAP53BeZYBqUv7q3YN4DTwzD/+AG78dLEhgoCP4t6JeMh7sJh4zeDBe/dO
	/nkqOytQcswynTTPUGvTGWD4EgGcbq4cb5WctWS41gAKwxOr//X/EJfKob8VXd2C8warN3fR9/d
	PLBCrqn5nkZEVAyQ/YKdx25S4Na/bWrgw3UzD5yNK4/JNefTiu5tmSX0NxDAqVGmmgAV32IlNlC
	MZ9Edyn2yhHXjeRy2+Xw7hLNxJJogVto=
X-Received: by 2002:a05:6102:3f9f:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d2a15715c3mr29296137.15.1793896021174;
        Thu, 05 Nov 2026 08:27:01 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm4667110137.11.2026.11.05.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:27:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0Il-000000032XP-37xT;
	Thu, 05 Nov 2026 12:26:59 -0400
Date: Thu, 5 Nov 2026 12:26:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20261105162659.GB663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
 <20261105140352.GF3889730@ziepe.ca>
 <2026110558-tartar-juicy-036a@gregkh>
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
In-Reply-To: <2026110558-tartar-juicy-036a@gregkh>

On Thu, Nov 05, 2026 at 10:43:00AM -0500, Greg Kroah-Hartman wrote:

> > But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..
> 
> Yes, that is exactly what I am asking about.

It looks like that does the same basic idea of delaying driver binding
that this series does. Hopefully Leon can harmonize it to use the
shared trust level flag instead of a usb specific flag and retain all
the uABI around it.

But, even with this v1 the user can choose to use the generic trust
level and ignore the USB specific authorized and get the same
functional outcome.

> And I know there are other types of devices that will want to use this
> type of thing (i.e. SPDM seems to be spreading to other new bus types),
> so it's good to have and get right.

Yes, we are investing alot of time right now in trying to get SPDM
uAPI right when we bring the general framework into the
kernel. Everyone needing SPDM should be able to re-use it.

Jason
