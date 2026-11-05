Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890796;
	b=f2qOz64hilSLYb4gxEOvEKICd2+9N4ImrN09gkgbTVwgcC2eT8IDvA9o+vgBdtYbc6Et
	 czbCjLzq++oSioojot4mDLkJ8E8f1nqz304evv0Rr/qEDgnzJhGtWvlmVGkZBIagqW7qX
	 GX7s3e1wH5wDMGkpQUAvmmlVTHC05v9brPX44y5vF0ezDNbG7vOTRAhQhx8Kb0xi3B9vj
	 RGkOs5SxkifNxA1xZz8rwAuypY1s/uKWSeKRN6bkxl3GXMJ2Oext/lIvNChWSOg2wCtgZ
	 THdP6IuPRkhbZ+NjzSITrkC7jWVuy4wWM6D24TLxwXf0XsHtsFsrH+EvyAs342u7PZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
	b=biL2Oifk8jV3JsLCojNEoWfaaBkKAFVdhokXC7sbXdDyphX65I9tXChLhx1VAmAxCJOO
	 015T7BCWg7B0a+G1eTHJ37dCBKvdE2SY40qA0Dla1ye3IcxzsgxJf9Ntj2EYc2bokSOhR
	 u29i+uhar+qzQc6pF3GiFfs6KCevgd/Kik9n1ZHw/69wtcfxcQ6nV9h+c6KfVQ6MEdP5R
	 J9er2I+eaVyvwF+p5+e5Z5UlBX1GkX5yGMaIxtxPPuvCP3LJM7lrlbcELkTGUuIhmsyAQ
	 +enu080dfk+qMCXv/3GJfYZWByvHkbZhs+s+SaGN28MXfeAJg0BE5Mom0AUTicWceVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bpBlGkKK;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0467F606D807
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 14:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0467F606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bpBlGkKK
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so745677e0c.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793890795; x=1794495595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=bpBlGkKKYmX68RAsE9EkcMc+aPwep+Jt4D7c/OZg3kVQeHpZyfmkntRrTHho6EP8wd
         Ydil1svNY3g9CpIhj2GHYQ7d434gL/SpPpSr+DXV/upiAZMCvC9nreTgfts3zuhMwCcm
         Qskdy4s4owr7KaU/9VifToG4uoaZc2rkAAcVF19z0f6dAbM64dHUzvDPxywg/TCQt9WF
         2ooxRy05KElc/DdqHagH2RzabKyRAsKGjv0e7Kqhd2EeSxnmqf8lncs0n6nLDm8+XKat
         ++mZs0G+SfgC2WTprHf/u2SbYhDe7xP1yG7Q6zYRZWtdxX3hRx/GELgc/Kk/Jaz7fcIZ
         8CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890795; x=1794495595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=BlkYo/gLaHqUoqSTca06j5cHqvZ29KVft1c0SNuXg3C8xwMVlT8rWOnl4HbwSPRDr8
         PmSSIRXZLH3wfvGEBh8ypRarqb0RssQU+oO1IwtK0UsydZTXar6UzfKhnU5G0kRueDMQ
         P9tiffFDYw5brSm03MtW1D76V9FRUse5vvUwclnmR5judZ7x3iC9vX8f4mVsx2J7PvEX
         k4WCw2zZV3CUQYS5OZU76jx/kLq0jlX3irNmB4AUtWrHTyOA8RQzb3S7lsXAYxJHhAk4
         BSUMfvoaVowkOOm84UG2miXHWDEiVjd8a19WegnZTx4yEmXo/BlMYFQUrs6tquljKmv4
         ENaw==
X-Forwarded-Encrypted: i=1; AKwUvByh/KDl0nesE1qQJuH19Z48tUUS6vn0VtUOsglkDMj20ovGHM6ZV0ejDOE9FfEnKsYqorxHik+k79Cz@vger.kernel.org
X-Gm-Message-State: APuU4Z/gP9R6qYZsyr3kwntsZQKKC3OTI8bNZ2jAZvyIy/GKz5EvzOXQ
	bMCRTGsm5f/maPez5UwRR3mqWrdQ4OUY6Bl8JWxZLKKR/JLboJZnLdEcf3ygLwlH1s4=
X-Gm-Gg: AYBFou2rw+MhigKoWEemVU5qbwq2SNivBiMr0NsLjy7ehLrebXiWTEvq2WzrvdNl9Ag
	oNwTaQhw4zT8vGrkZcP2+QRXEQ+n5SCjDvhMGwO0MeZo+OW5hNSjuoZoAYA+DcYs2EjDago5I32
	0Z998n7qipxFK2L20zFGC6o/B+rwL7dP176+f2Ggw2o0pX5ikEfpKj+L/EOsaC/yf/dKv0LfrAY
	whP/nQp8aDcJ9CBvb0arAOd/BXmmJ0cIAqcOQTickP7CifbJzs4a/upMVxOd/TjESsluLiKpi0c
	hA8wFZH2AzGS5ywZETWtKckoNE3ymaynENvkw8XjQMqAdu+Diyq1WZrnnBHXDaLWZL9xOQgrO4t
	dv5u8lIOsGppNuk86rumxNJKbfMXlTUeViJrWbMbYWuj5dPCOXQL8kwVrJhB+e9rp5I89fSouws
	L3pI2DD2wswcMzSkjOsDU+gbVo5ePh/sUgZirwx2OPJBrOmoUQrPTp90NwVwvFsqKCuO9c/wtJq
	7Xw82PBtOyfrO8fNSL2iCrVCGx+pbuiOxdnrNdpw2HFvhrgExEhcqxoMIKlaY0at1cmTP5t8q5Y
	Rhe7NLtm7xZr2N5oK/C+b3kwB45IuC5ZpLCy6YlTwkhqjetatTf3rFKViztfudtTWUSStZeLaIR
	qNHBsv53apqU=
X-Received: by 2002:a05:6122:6c0a:b0:5d9:302a:8243 with SMTP id 71dfb90a1353d-5ecb429571cmr1423011e0c.12.1793890794801;
        Thu, 05 Nov 2026 06:59:54 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8df2a38sm4234612e0c.16.2026.11.05.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:59:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOywS-00000002o7b-2oaN;
	Thu, 05 Nov 2026 10:59:52 -0400
Date: Thu, 5 Nov 2026 10:59:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Message-ID: <20261105145952.GA663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
 <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>
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
In-Reply-To: <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>

On Thu, Nov 05, 2026 at 03:43:53PM +0100, Andrew Lunn wrote:
> > Yup, and that's true even in the PCI TDISP case - there's a major amount of
> > "communication" and "configuration" involved in that. The principle which
> > should (hopefully) generalise is that a bus/host controller driver can
> > always interrogate its child device to perform whatever attestation and
> > general configuration is appropriate, but we won't hand off any _control_ of
> > that device to a specific device driver (nor enable potentially-impactful
> > bus-level features like DMA, interrupts, etc. if relevant) without the
> > requisite agreement between the bus code and the user.
> 
> Maybe it would be good to list subsystems which the bus driver can
> use, and cannot use.
> 
> You list interrupts as potentially being dangerous. What about reset
> controllers, GPIOs, regulators? At least in the embedded world, the
> bus driver might need to enable power, set a clock ticking, and take
> the device out of reset via a GPIO, before the device pops into
> existence and will enumerate on the bus.
>
> I don't see why interrupts are dangerous, which makes it hard for me
> to determine if GPIOs and clocks, and regulators are also dangerous?

IMHO we shouldn't try to over think this.

The overall point is to give the userspace a place to inject policy.

Bus drivers should try as hard as they can to contain their child
devices. Like PCIE should activate the iommu, disable ATS. USB should
limit the messages it exchanges, and so on.

When userspace accepts the bus driver it also accepts its containment
capability. So if it accepts one that uses gpio, etc then that's fine.

We are not the point of trying to describe what threat models various
kernel drivers can support. Userspace has to figure that out on their
own.

Jason
