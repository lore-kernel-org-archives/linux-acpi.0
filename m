Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887436;
	b=Mu7YBmqB+e3vyJ/zcQLDsHIM6igJKOYvAdM+4Lo9xE9wN6/Ag9N2E9dg++Pjmjej8qul
	 rkEktc0JShs83OeNsXQyfcwHrAbwkmOoUwWCYWec+f2dqKSNKhzKNNXBCVxtGSOuHz4d0
	 7+Y0uaakycuIN9W8qtkAZS7B/gAje5l7RlrRhMxnT3bubgybf2TWEb2bvrwo0ypIpSBKf
	 DPLy1sYKpo1Pg7B/heS/nfG1TB29tUDE3kd1pZ1F0RDbLhKtJnvmi1XNBhJ+bvUDDkGl5
	 effLOyDkppCFO9fv9UXenM3rmOU6FeShBuRY0BrQiAaIKe7noF+Vtbwal3ljR6nayDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
	b=DhPz3Z0+tCdCYUoMB1EdgZGQTkrEC7E7xkHrAa1rqVW+Xf0p5+PfHfm+Z1lNlEUGdU/z
	 wW2P+n67dHIfe0h591ro/h6xUEIxfGuePe3iKfxHs5muHI/PsCQW/yKuLIhuJChtpfYKe
	 SAltp7cnOPbCFJlcix3dK+FjB0RWzmKdbE4XtM5Vam0pL5q6qiWlIpsnoZ5+Im5XVXA1A
	 dsRiNrSVH+Z5GO/+gZPvZRQUNk8okyzHkZd0FJT30/ryTRmWyWzO+/NeWfka9PgssUFMG
	 JJuSoQqulb7D6LtO+IHLS39CquvsrehOTC88/M+js0lyKNLrtJZKWrsgeq9CLvAkUxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kz1XgIBb;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AA606D80E
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 14:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649AA606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kz1XgIBb
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so701113e0c.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887434; x=1794492234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=kz1XgIBbrvBVV82jfLwzl2boDjAIVUbeNVQas9Wo1Dk5Xdi6H+C3KcpCevzEdclNJ0
         lzsSeS+uRFo6w/gIJIYGLA5nYX/ZA7GDEfg8ye+MEqBYoDAQ+XWmrXIScd3vjjxi3P0s
         TM9V8bmM9C1gt69mu+eIyGDX/aC+cI4xa87K7AUD6ZNwyr7bJjPSJ34eRy3oL+DhO4T4
         z9GIW8q+b2I5fYq6rzeAUUwY6D1cOnVfqLouPYFCQGVgJUGlc0n72Hhgr3e5/i+LRsW4
         Jqs+IOHbUmP6UlpI+ifiIR6Yqw/evL4R0NFbQH8ocPPe+5gcxWg4oty37gZrialLDEod
         LNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887434; x=1794492234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=yQYZOF2/kRC31pCz9yrqigOo5vZEF5b5bIlR7CEw90VcaBAQLAk/vzTCoTwX/spVMX
         M4Tze0nlILrZrwOCl5+3iE1Fv1x6xp8YEwvBUYe49+P4a0XaVsYN+kybB8/QI9oL+i/j
         3zeYtQLRrhc0DJSAM4JiRe4ixECLA6mwOlL7V8JxugoX2KozBb7SgRuWG6bYuka/q4Hw
         IWCoZDXL+MsIeXTKhBtYTyHxMg/tLHwwzvzvWOZdBOxEdFrmezb/KECZcDQxuC8ilfeY
         Hn5o94yc8SGsVgd17aD2rraqPRDzruKmn5a4D1E8Eg2mshlEv7xwnOTJLnRyqJY1Yjyy
         IV9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzO3ekx0oGr90OBu7FAXKnpWTrHC6tVQ7dUfhlfMhc5N5L9hA/OFPrHkIK+NRAZxgEqL7lZcDTAF2Fb@vger.kernel.org
X-Gm-Message-State: APuU4Z90MDZxY0ZnDmuT9T5OAuSuIPmxshbPEEPPj+SndIEAicG+B/JB
	P9Fci5dGFNXK9mEf2rf/umznSxT+WVbcuqeO52oXUZpW6BiC3TVNb+xtOEotAQaeH6g=
X-Gm-Gg: AYBFou1AFmE24R9VJubYFDYL0j4zLPO4pir4AB2DagT49I5MYrK038z5I4CUk8xB8+u
	EZRGxiayuV01QKxXW3yyE546yZs1poqKQpGgYSb/zNAKvaWm0MzPy6fVR40QDD9YAk8FNycAzuM
	nmovQY1X/3eM1E5YAQq7NSo/oTS0BLkWTxZc9HhgHqlWsxECkoKyfgUUzWYdBksclrjM+k4IYwx
	2WIpdT9PQTyEMWJ1eehqhsA3pIjbtqFSza5CZ8Ea8SBlPKdNrLp/HmX6KICxCQ20lmuvHFlDBZG
	sN0pQCMy6piC6p0UTJZVtuhUL9Mk3JN6+vCr5WjjVt4NX83zFLWEd20mzMMv5lBOx0+LhD6dOkK
	+joRHzFe1CetX/pRWvIoY8rVUo+h2MNJ98LHX1djCPNCZP0xm+NSVaTLgM3/p2ahPObIzca+D/a
	80mclG/39xaRgngaE1WeUE8GrvINLU2aQeBHx03eWiCbj9gLuDnTrClLnL3y/ygoMOxa/5tBJ6e
	9BiL0CbNtMmgB61h4EiIe6HsxsyDyIbgiOnw8ZxKB6uWK1w5dextfMFdAnLq1mwto7QgMpYqbbJ
	OZL+TtY8KRmwehn1LNSMUZszn1AuCrqm9WPRXnRwhOmjvr5UUdP6j5+Uq9P5eNG++LBvTSGowRe
	y+dEm2XPgEQ==
X-Received: by 2002:a05:6122:8f88:b0:5ea:cfd9:8fbd with SMTP id 71dfb90a1353d-5ec689b0f30mr9760208e0c.17.1793887433885;
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8de4908sm4235128e0c.15.2026.11.05.06.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy4G-00000002ecj-0pCb;
	Thu, 05 Nov 2026 10:03:52 -0400
Date: Thu, 5 Nov 2026 10:03:52 -0400
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
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261105140352.GF3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
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
In-Reply-To: <20261105131856.GA8298@unreal>

On Thu, Nov 05, 2026 at 03:18:56PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 08:12:51AM -0500, Greg Kroah-Hartman wrote:
> > On Thu, Nov 05, 2026 at 01:42:30PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Convert the PCI specific untrusted to use the common device trust
> > > level. Adversarial means the same thing untrusted does.
> > 
> > What about for USB?  Will that "move" to use this common trust level?
> > If not, I don't think it's very "common" :)
> 
> It supposed to work for all buses out-of-the box, at least this is the
> intention.

You mean DISABLED/FULL should work with this patch series on USB
right? Meaning the core code will not bind a USB driver when DISABLED?

I was wondering if some of the broader things we are doing on PCIe
also apply to USB, like device authentication. I don't know alot about
USB, but I got AI to help me find some relavent spec information.

 https://usb.org/authentication

This looks like the parallel to PCIe SPDM device authentication. I
would expect it to work broadly the same way as PCIe if anyone wanted
to implement it:

1) USB discovery discovers authentication support and creates an
   attestation subsystem device for it
2) The struct device starts up with trust = DISABLED
3) Userspace runs the crypto flow through attestation subsystem. This
   is extremely similar looking to PCIe SPDM:
    1. GET_DIGESTS -> device returns a hash for each certificate chain
       slot it has.
    2. GET_CERTIFICATE -> device returns its certificate chain, read
       in pieces.
    3. CHALLENGE (nonce) -> device returns CHALLENGE_AUTH: the chain
       hash, a salt, a hash of its descriptors, and a signature over the
       challenge and the response.
4) Userspace inspects the above and approves the device
5) trust = FULL, driver is probed.

But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..

Jason
