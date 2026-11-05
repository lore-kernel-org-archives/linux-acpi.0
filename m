Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887594;
	b=nPGlx3TUrBQ5y9k9ydfVeFCZKM/CbuU3ZPCDKfaOyVAPmKO0yPCzDM3F4RhU0LgB149K
	 s2rE3D0RVHALLCpBuLzVUB/FZMzDEEAdu6BW6ahUoE2bTPK3GlQ1kftOFBGGlvpHxcBn4
	 nbNKkNJOjGCrYM/grdI0INq73//LzbrBOwLYtu5D5PL8hZ/6HsMxyncP0e4o0BzE9P2A2
	 NExNeFFeeosK2nQlv3xzOl2jhF3gla9WypnLrTkehYbAdJ2lHL4xCaGPYCN6RQPO4bf6E
	 pa/6BL2YoOj2FsSWbRxwM1Du7Ou4qOEwnmqRvlEgVRqbi6Bd0pY/LUTUX595qSYEyRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
	b=U73xBQz/423IkX/pAkY/1CeAImv79ye1Q7VTOazXLFLkxUznT6JT7sxrhtEioS94c5xO
	 CsWE17J+C5OHJb08Cde60jDVQjxp4ISLAy3d6pDbv323oNem0BmuAINGmlDx4cEC2jxiN
	 7AaMuEo3hKK4HQOLbINjOauSXYAVS58hwaJWorXw1CE8odAmvY88ZqMUSABoyh80pnqud
	 Uyeqb5A0LUyAb6/VZXK3DMxFWsxGm8woTqLWtqRy5/P+osb2JZyH696H30dpe+mCwZ6Bi
	 PNo81TZENJAaLFtef3eIlEnAR3T2aoDGVhkT2ppaSqkd3FaSfICWmuBZ+S7A36PeP5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RnR9WnLw;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A0606D805
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 167A0606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RnR9WnLw
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-98301b325c4so547296241.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887593; x=1794492393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=RnR9WnLw6ZCMoaFK9OfD+Z3SyEdhvj+uf0rMG8hHCJ508GqyJ6ANwZoUk4+aGiOUw2
         /BkiFTe3GFbXdlDhgGNTyo1p8KbFcLTeuViDrXT0G8rPqBzVVo12Ao+p4Nr1qmRZcl61
         4eaArBRyBLbC70PWW9D8DSwCjUpFcwxnrtfrVG8awSc3G2DLBl7ue9/tyD5BZlfo0PwR
         zdxT7MPa5WtJxCqrk+LMM1B4PGIKPha9YDx2d3ZgVPNqHnLfPw9K0SbdoIeozyBU6kJV
         fXJaMOJT5b2NTv+4F4NS5Cw1swAwWPhfu1r6zxddYwAc/lzTbX1ed12Z3pRWm4FFq8m7
         OBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887593; x=1794492393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=AL9FEIm8lolgjdxljq3xdHR8xbdVVBxMSW+oGaNhnOVW30JiKWfCAWP1Iq4yFnrIhB
         2OXasX1XrfIpRuTdLgUIu+q4DexRYpenZH7djYD4ro7KQhT4MCqE7aNpLCGZM2racdHu
         2jtH2pBkW0L+I5jmChZ/xku6/lQursGxoXMyq1l4b6RJ73gB7Kq/V0L15UpjkJCKRokW
         8iHzHVU2ZHwOt04yd6HLHjXEs2j8U6Hlh9cy63Rh16TvYO1tWdJsam99J441UZ94GFZ6
         iRGmVbYUV3AiDNK5jOZER80ROCK4q7OK6LrcT2gnyeaXhiGmxN0ms17SBd7rZMQ5osto
         s85A==
X-Forwarded-Encrypted: i=1; AKwUvBwU9iHgDDfwBgdfY3jHk9Ep+uiSOgbud6Q8LNifCKL7s6uOgyvwCNJNyke5+ZxTJLcQyK1c7YAVzFJC@vger.kernel.org
X-Gm-Message-State: APuU4Z/ae9+VBKNPqtrSwlQf8jLF1AhMLjtimhPJgAmG9dftBuqcabS2
	OAqyugzkctbyEcCLyRIt1JIzvH4TU/blsoShf5EuqMhgcKTMwT4SfZF9g4YWSf8BVMc=
X-Gm-Gg: AYBFou3sBXIyOItvbx5P5fxgTAU91QfLuls+nsbNjD/S9qPUewCqZqSDJxGmTSkadvo
	vT6pdKaxS/Z2oEFxxdzRyymMrGFtHa6TWQsnLfY/sb95mqho4PqIfslvEcBZN31JdLK72oVRWNn
	kDbxqkANDFjFshBckLK/mHbRsPS8yU2/ugdI3xu4fKVKh7z/oCY1ceaSa7rNxe/GyTj7pXbo4FN
	qUvUy7dhprBXCkF0s2UoLvmCT0PrmyHfKyzUkDIWigSm8/qIeenByKq+weA6yCn1VLsiwQDqYlu
	8B+VnJfS59/2mJTq7ue+qwrouUZ1aR9rZwk3TujXEbSkB5+6LT12amXuaibsqxhDd8OBm1ORnPl
	omnXavlMrplA5bfVt5zEDnyDhwUxxKP0nD3Ae8CE8kGswbRtTEmAeoe48elJApx6OJNF5PIJ7j2
	Z/EjokZ41yzY/7T8cmchzCzIKdU983EkmUdXrv3x1FHg+kWoGAd+WMtj5LVr60ntfA8QaE9zxB/
	878y9si2rGn6TIHgWijTd21+wZ7kTNjPSjZHLvk9qX9PrUxRpBN8YAF3LBfF7Zz6gzbTXZ4dRTn
	QA7tBLQkZodDvAEV5oNWE5y/mI+6pGs5GU9mlbihrD5faKIrsTz90qpmcOEfamspxLiloR+cpIM
	eYNAyd61DKA==
X-Received: by 2002:a05:6122:4f9f:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ec68949c50mr9274698e0c.17.1793887592873;
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm4161881e0c.8.2026.11.05.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy6p-00000002ezu-00ao;
	Thu, 05 Nov 2026 10:06:31 -0400
Date: Thu, 5 Nov 2026 10:06:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105140630.GG3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
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
In-Reply-To: <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>

On Thu, Nov 05, 2026 at 01:59:20PM +0000, Robin Murphy wrote:
> Yup, and that's true even in the PCI TDISP case - there's a major amount of
> "communication" and "configuration" involved in that. The principle which
> should (hopefully) generalise is that a bus/host controller driver can
> always interrogate its child device to perform whatever attestation and
> general configuration is appropriate, but we won't hand off any _control_ of
> that device to a specific device driver (nor enable potentially-impactful
> bus-level features like DMA, interrupts, etc. if relevant) without the
> requisite agreement between the bus code and the user.

+1, I think that captures the idea very well.

Jason
