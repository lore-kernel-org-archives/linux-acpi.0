Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516788;
	b=2EpwRjdCjFeCexUqUTi1UjwUF4uwlxD1VtyuZjnucn3mvPEHFBQOIUf2vbFLXnvKQmuA
	 fFAmodfApG4fxQT7g6+hMJY97e4m+01+2fk+Q95Jsb2zE7uHsqzTdRmQeP8GlmZkpealt
	 GwcOnHq+/w0WWMUa0FUAxrf1lcE2hE38p0aJSf1vC/M1CpLjv3V3cpTOcaP9/Su/F7WIj
	 oqUC7JQfo+KlepTfpygczLFqvICmEce76zVOCae97t704ejcNuubx5YVRjCAXRRHolR85
	 ZWfJgh/rbUd92tACRMx0Tx2ti4dPeF1JiMd2QebGIEtRxOQolTW9rlNYRW2eyLhgpQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
	b=ahzp0XJjfEFw2bNqN6Rtb5QgHH3Yc+lFQ7ezt7/NsnvitRbV/MnDxqqdJuOq9cT20d8q
	 N44AYjxITnBB2YOwdJkVpvq9gpB4EGr/9QbALrFbcxUBDIcPX8WjMJ150/r22e7DDfOgx
	 ffMPbAN+Rz5rKdn9xv7A2inM0JkWluD7sJQF5OtmG3vvGducCBkkW34GP9xsD7ASHIswv
	 yShmZb6ACV1zHRpD53QGAF2IYEt+5slryOygveZiwU7fzfx8S80uTVBNgx2gqI3Z0X7ak
	 wUkLirogqGoqG/HxOEgJmJcfTsWnluVy+6YtM+z9lSrqaDuJTVdHGsV/QllBJX2/OMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KjiX7YWe;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C3606A331
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 10:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301C3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KjiX7YWe
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so39789375e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795516786; x=1796121586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=KjiX7YWeSkA9Dw0WA5xjWaOqnyEHCedD00sUzMhE3sKEAvQ2TPIHmIyS+enWPn9hqU
         UHnNtz+vsI9HdnLLJLRNEHpW3n0qDPjDGGb+MMmUEkY4+DtknEToZAEEAwd6ErlDRM4U
         sl6ks9V8P+KgBQBXge6XtIwqjU1IX32GeqDZpfsQ5053CJLA98ICyRMFUcjrF7GwSx6y
         mLBhDMnek6X1+TiwUBOkVQB80sS1Z2oue9zDTiR4H+wlMmpVb+6EJ+EZoBBfGsOtxa1G
         85CHt1w3B0RFKCYDolOV20zywTKINPHyMkeAAvRZwyufXjasNY7vVq1oJTMaEgpAJPJ9
         588Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516786; x=1796121586;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=zDUc4GyWmQVyZZ5smT5Dq4xjcgmiW5MNr5Iahl6iycE8N6jUYjiBsrtipeyjqjwFZd
         CzMuDlTCmdxyNBXxg0xOhaDOry8ib+I8GHt79qiduIQGiOSD/pxKtSAH95r1+fEja/+w
         LoKt2B/UXONDhWWcFN/ckiswo7FWTpArrscj9rogHckE82Y7+Tjnp8BjytyACidmwGwb
         /X3ZsDpsZUhuw3spb10v9XbOYxkmZN5cqtku2UNlYEzgtWGWOCQJEWnDAvaqB5Z0fjhE
         Ptl0aLpYYpQd2lKeCjVdUyoIfOI1ajgB6Sqik4jrs1P9L6s116N9E81V7TgNEtA4acmG
         phYg==
X-Forwarded-Encrypted: i=1; AL+hErHb7pLQGn6CxWhvGfiAYZZsi6YTWXHtzRh6K5KeAt2VS2HBKkPXLjqiB/JGYHdpg1iDE2qNLiwhCwhD@vger.kernel.org
X-Gm-Message-State: APuU4Z9l6HPzxxRme9IiNRjfjxzJb5BPZeGLX3JaUwe4MALnAiKEDLQ1
	tP1tjZXWNwu3g5WT659bPiNmar4/fpD6uMb1qfDCJzpgw0rP6LA+UcfMSRjQE2vFxzo=
X-Gm-Gg: AZFdTZcS9XuegoACFSI2JIi0lyfKpXWd1mn0sdditGgWkUP4bE5xohJxp3W9QRU2vW7
	mAd91IZRfelkm089ZnFxOfvUbI9N8eeKXLgDxsYjSgRU078vdn08mzgO+kUvxcyBR6i4PK0UGSl
	gbUNIYFPOX9i27CvNu9eVM6p5eOxM0P2bteDTfpr5kbfWk0SsJFy5/yf7F3wg1EdVvlXJfyb/pE
	Y7wVRQuhs1SVZIwZ+1p4MHfoNHI4tqDDBvgngGoLkSGhAIida0FmXpXlV0vZgx3OwWwfmrhgQkD
	r3bR3Sja/dJfgxa2HOTzXAnvZJ3+MStvTsHOSmBuU1tMHsZeEYjPCbG2BTV0QsD1PbuPCLRQU1S
	JeAwjiBapmi1zfTtnEzrjxnp/LSeVFcYEbXL9fabdHnlgAFN0B6/e/MTOiAlniEaMWAkMSAPdRG
	fQxKtFzkamSAhlVQJOC3sa8SL9Bnayb9IRHDT/mBmEMVL3xTtpTbHlAWWIczBOFt5LtDxYi113v
	SOacwCnDmXXPWnGF8C0YwkR7r6zjh5GQ4q3mOCXgrBI7AaX6sw3VM3fM1607+c6uQ0scV6Buf7A
	ssXqoIpkoikxdkzsqodgs5nt7otMs43TsaygR4AZBuiczpVrms3WGVk/ooSVsFRXcbBi
X-Received: by 2002:a05:600c:64c8:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb8881d141mr281064655e9.26.1795516786433;
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Received: from ?IPV6:2001:a61:132b:a401:6cb8:7c28:11e1:499? ([2001:a61:132b:a401:6cb8:7c28:11e1:499])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm425218335e9.5.2026.11.24.02.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Message-ID: <65749362-927a-492d-8bff-573c277fe456@suse.com>
Date: Tue, 24 Nov 2026 11:39:40 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/33] Bluetooth: btusb: Fix MediaTek ISO claim locking
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Chris Lu <chris.lu@mediatek.com>, Mans Rullgard <mans@mansr.com>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
 Jeff Garzik <jeff@garzik.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Bart Van Assche <bvanassche@acm.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.11.26 10:43, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> MediaTek ISO claims are performed from HCI setup work outside USB probe.
> Locking only the interface does not protect the claim against teardown
> of the parent device. Unconditionally waiting for the parent lock can
> deadlock with disconnect while it drains the setup work.
Hi,

your patch raises a question. Can usb_claim_interface() ever be
used safely outside probe() without this kind of locking?
If the answer to that is negative, should the locking be integrated into
usbcore?

	Regards
		Oliver
