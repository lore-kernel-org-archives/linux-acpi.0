Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898126;
	b=aKhpa9Cmsa0m9VB7rJKugXFW6Y4nVg1tB4/gC4DvoewaVrpYKdGZYRgQwhs/i6tI035b
	 JJp4mmHKg3fAYNUeEwajmqGzyJG0TV/6YcyqV6njSuHqCy91b44KLBvLzfB0+C7G1WVC8
	 RFznY+v8IH/2c0Uwt4iqNoDTgsGVJH5qZyXFUvB+2FRF36g7fHGhZ49FOurn1fl/8Ok8g
	 G0co1lScu/KXa7eHOB6QWo8d6KWwYLFwxrcXAC61EfUB5l+cX50xhjZ6uPMMG8JHAHUBb
	 FVpYpO0OV5AiJB1M+0nkyoS6itwjzFf7DqenGZFFGeu67BW28Vq8/74bFsIpDffkYiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
	b=kGCMe8RyUE1K/ai3MK/N+SwMJ4J1IkDZThy/DIzFSWke/rjbNZFgJbnbjzxjfk4n4SWk
	 hiJq6jzf7yclmnMmJdEd9M5trfAWbXDlY/RSJveyr9N5XknkQnFETDkXhXMIGB/MRJtpi
	 nVZodX80yzxCaCVjxxgec0Efi8NHUGW9R0J2b7Bcj+VCZwhHaKyBCMKdz7lBuhCnQqZzW
	 9IYjdtVhmjV55n8PXKeTJ6b2AEIJa47E9zpwtchlI4w5l8AnsCrcMOJ6H4qDMbp4CBk5k
	 brpAAtbehT/MjBoN/OMYKIb+O8CiIU/KoqZ5OLu6KZ3pTq4nlaYn+2tXvrBAQqH9jDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="UT/D8aSt";
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC8606A32C
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 17:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09BC8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UT/D8aSt
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-990703f817fso1030007241.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793898125; x=1794502925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=UT/D8aStYb7dPEp/Z1PTR1znD76pBm0Z1nPlORuFlgDbzwSX/aHEaMIKgxREgduhMs
         7b184i+9WuyWU3kP4ECdvxL5tqJCBp+sE58xftFr07RVMuYSe2D0AHX1L8wkHJuC4lcP
         6d7IEtulMVc64pTkfBc/dFTnsuyCXdHVpF//V/K2Xgp9mPmSNI4/p7tLi2H5V42yljeY
         GtO1ChQ2JjqDeaKC4B9biWxL+z3aUuPX/f+FWBrD4U/FW4Q80YjAWhMK/Up13oskn2O3
         3V6ObKXKjzYpPS1tL8mHYVexmV3sD/kfJUj7ToJWfvaytzTBimAL6fO0bssiuf+AQf9l
         4B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898125; x=1794502925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=eAjigyt8s6LD9zaJuWlH7b34IDeYu/6MQvgfg5qarINPBYL+bNBn0VnSHqQ0kq+IYJ
         fu7kqq2c+eh9HjiwCaDRz/Jdr3OSUx+RWzyyKBLKhr/PIu42MShyMRa4K0byQs3V/+4A
         s1hwdrjMDZAjIuRA2ffdwr/1/d/wm1ctw96Q7AuLoHZws91Nrsl8ni+0kJ7PMCbWfHuz
         aIdrKHDgVJG1IfIazjZZkZ8c1jlQiqdDohjDVSU5XQNhRRNLHRLjlbyM8Va7zUKaJzVI
         7WOMAyhZRuRZRE+aO+QZZTJ6Sj3VpNAOubZIi+Y1oTjWeTpPNammFP5UDXpwfux5eYTs
         kzEg==
X-Forwarded-Encrypted: i=1; AKwUvBydkodlTdt75g8KlXWcN2mhMtscsnC3nzwkSq0llWtPokE/Fd8aizDFhCNCHmgIwv/1HYWxifbnzlcp@vger.kernel.org
X-Gm-Message-State: APuU4Z8VaLbvXeCtBqMYvED0AjyAEuK2ayH9CEwUAXw7ZJaEkvihqkyw
	jK9Y/oIQ2NYmXf9i88HFoeVa5QZEnKaEVLZAX5wo8ftgJfTqqiG12GY3DYKyEE3mIkA=
X-Gm-Gg: AYBFou2c0ExWERbWsyzyPx++4PwQ8r0WgSdt/mpkRI0499y0rnawexcQ5eIp+MYRsS0
	8ieFlPxdg/vsEctCimwaRut2qVQPwEVX/S0t4yLq9L4brI53bSV6RBYod3PuS1WzjUtIgQNDmin
	l2sI7qmVrDw54fl/IClL2IUTgB2xKQaod3NRu3o1tM3ikfOrSAgZpOVp3F42zm0n8Bv3iBq+MJ+
	ZSVuhNsbJpRX7rM0d20r/U+7UJcXtjh8N2PSxPPu1wgS1OA68FGsBkkolVgF4LdToDX/FHroBKo
	pGrwocqhN0UA3z67qINK7SbLM+3Fbaf8YRg/X1CNm6cHrHlU/qTHcnNEjNiQPWX9gPiRndUL/Dp
	fda78EboiyJofQRu44b2p4JSxKpDpT6iemSM0JthvBIEwvUuAdG7HJ6vgO4G/iUCBVJwjbDGNpN
	VwEp3TyWC9lgigEtPs8WDGjnlrV0mmff3olPpaDrBQn4lV/kQW06tOKiIQSTvG6I4C3PhAS6sJ+
	pJmoenxdpNuypzqSyh34AOsW1pFVQ5B1F5xQcNY0hrVfXTTqRzUZZ2ss9zGY7SeKJKFvrjZmpvY
	2sok4OMhXuiIRESkHNJp/sg/QsF9B0A2G/WyT+g5zkPYaKbaKNPEK1ibuQDwDN8PjzxkctPEDGJ
	wBYG+DVVrP7MfajpOU4/Gz0cYl9csDfs=
X-Received: by 2002:a05:6102:2c1b:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7d2a16c7f35mr120203137.33.1793898124846;
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm4619225137.3.2026.11.05.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0qh-0000000388I-28Zd;
	Thu, 05 Nov 2026 13:02:03 -0400
Date: Thu, 5 Nov 2026 13:02:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105170203.GC663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:23PM +0200, Leon Romanovsky wrote:
> +		(RW) The requested trust policy for the device. The initial
> +		value may be selected by the bus before the device is
> +		registered; otherwise it is "default". The policy is resolved
> +		to an active trust level before the device is probed.
> +
> +		The values are "default", "disabled", "adversary", and
> +		"full". "default" lets the bus select the active trust level.
> +		"disabled" prevents a functional driver from binding.

For making this more general:

"disabled" prevents a driver from binding and informs the kernel to
provide containment of the device. For example a PCIe device should be
unable to DMA to memory.

> +		"adversary" requests operation with the restrictions that the
> +		bus and DMA layers can enforce for a potentially malicious
> +		device; it does not isolate DMA by itself. "full" requests
> +		normal operation.


"adversary" informs the kernel that the userspace wants to opt into
any security defenses the kernel may have to restrict and further
validate interactions with the device. This may have a performance or
functional cost compared to "full". As an example the DMA API and
IOMMU layers will avoid exposing unrelated nearby memory to the device
during DMA.

> +		Successful resolution to an allowed level commits policy
> +		and operating level before driver or DMA setup. Both remain

"before driver startup"

> +		fixed for the device object's lifetime, including through
> +		failed or deferred probes, unbind, reset, and driver reload.
> +		Later binds must resolve to the same level, including when
> +		the policy is "default". A resolver error or disabled result
> +		before commitment leaves the policy's writability unchanged.

Not sure what "resolver error" is.

Jason
