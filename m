Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855860;
	b=kS2pcCRzBKf3jtYuzTMzw2z6054+/ahYuIUxZDBBcxkbY2lkEGLN3yX7XxErUtU0Udul
	 h7aNApYzVL5wij3Hw+UVItpd8xq9iDS7FMUM5ttLAoYhsUydWMduEdp7HuDxtvSLAr28m
	 dYJtLSG9uispv7Ym/En6wX34h3EL/E3ZYLqnD5Ofe4q6OseUeqswqpX1VaZXXjGzl4Sa2
	 1ql/oqTXhw/YVIo3RH9lUF1Sk/Ne24uVSLKIcFZQe1ItzDbaWvifYx7a5+xD7Jd2dVxet
	 n0kLUSgxI6qEtbXNIEcqimIv/JV9dIajMNm6v8jAE1HcUfF2phkrLt6bcxwbQaPZugA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WvOfbKHC1YhEa2QpW290x7cG/RSkj9nU3s9Pf1uScWc=;
	b=njfOTRtaGeb2eeEBoAXQGAMzCNFJe040sQxWsIiXU55tMi0qgR9qr5AvPw+jH+847Act
	 cg+PYNvektAJkqs/7Z+3EcPhJNPo0imbkbMAFjA/otIy3oEStRCTaQHkk7dl89d49F9Ou
	 DkJoaXjLGosvwtw4NRdwrlX4LRkP19M2D7qxLCGAFcK495V58Mw7ULtkSQSYzigK9/MF9
	 sEfFW8WTs4B18mxGBKlBRrKz0Rj3K0arNyDv5pGHP8z6ufjuDTpU+hK+z/DMFChJRHdQD
	 ivTl0igMtxCL97QxkwaCPZJ5DuTs9rOB5oIaUVdvQwNdps4mOpd3GWEmhVAg4BuLwWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=cV6xCUYW;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4F606A332
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 19:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC4F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=cV6xCUYW
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55d2f5f1e26so19968801cf.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794855859; x=1795460659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WvOfbKHC1YhEa2QpW290x7cG/RSkj9nU3s9Pf1uScWc=;
        b=cV6xCUYW6Nj32ATgj9pR3hPHUcXMAswfWFmbofUn9Kj8O2h0vBxKz+gKkblkAcoZs4
         3Sksf2uZJcrqFHnWfbGA31BNzwsf2S1dv95GJqgZVMfFGYLSB6zg6g2Fr+yuwov/in3t
         kzMGwphN2MWZmbFV+wYJtbSpA7Il47XDSpoenMocuugAiDnZMkgQe82N6D/LNCvFdxrw
         g4Vs+tRlvNQP2aXotTXnhkPG5j8fWm0uVGtEmoX6U112LRHDjo2Qmq5iAcSLMow6gR3a
         CP6w8W/FgL6u2p7O81zc788TpdcCz8lIWVKQDNRHCpvZKfTuZAAb/gE598LmoW33C074
         z1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855859; x=1795460659;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WvOfbKHC1YhEa2QpW290x7cG/RSkj9nU3s9Pf1uScWc=;
        b=xb8I8ywvHpb3t8K6hbEo5sJYFwlNQKEfww+EAS/lOtgcwVXgYnornjeldaAhXj0QZ7
         eLLFw4zm6rWNrqpXgw6thmn/Aboq5bOM2GTHTAa7Gm7rMIX7t1qjaRez8sa93Y+ZxWxO
         fDx3AW9T525vYd9Y8kmQyB9CN692m/cRx80azjN+Zawf5yMZMPCZY/XXbqEczQZZ3+Mu
         q/Din2jBzORsoYN3Mq5RawApWgkwkUH/d36xR+LZ1ryY+rfaHZYhDXvGvBj00CaRy131
         bU3aaXnfAGgpOb6AFQdD9oFAirBKp3hFzm2enuhKO0pEn9uyj9u6DB2CGrPLcoL5PSOH
         ERKg==
X-Forwarded-Encrypted: i=1; AL+hErHuXonGBNqWNqHeTKcLYsypuqMJYMGh+1ybh+52jqocm6LeQ8bGpique4gQDBz1jj0YzQRZ8M646JZd@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qemp9YbjrgDtESrF1Jqpv30jkgwNXd6jD5ogpJ3cd18/5lIM4
	9yuMTILNW/7RyY1TC2RsaOGCk5WaAjpB+Lh0SrybtQ+fgwQpPIav4Taib5H5ljp91z8=
X-Gm-Gg: AYBFou0nvbi3uizp9hqfJwZbVZAlF6sABLbm79Ki9jUaP3bq0GHi4z4Zn/NhhLYtaR/
	GrlfI1eJtJaT0w6WhFDKeSphPlevB5+OGYz0c6Fpi4yVdfZ1T7aVCGoUr18ZO4Fq/+isMKLZxNl
	9R9BawMDu6OllUikLehiVdewmK9MVrhlcRKFyrLob6m1QtGIOSlRnsouk8tGbbNxC4GTeYYRCen
	BFXf6bj4xtZGMMbe0Fed5utZSyHy1tlMI746uEdjeDIDkUJ4I4LisXdsf+ihkhczsEnSs5Q2Hb3
	pF0yGquDFuexK1pn4rpzcD7mr2HWQ4xd7A8oldg1AlD1pENMZR+rLk/PSHP5yHB91tmy90w7Z61
	PfTUnwGSLCt88BHn0mAloLIZc2TG3MDPoQGQXF0erKk6S/4rSUnnD1sn2fVcTvlIcZZoq/sw4kb
	dQLiH+fnT9DslVIkkMgdFxgA0ZN4rrcv2qUyWls9BULx4Av28ivUL06kdeJ3BKU8gC9bpU2pu9q
	foU4pFoCtqDautxhkAUoGXkz9siMF0HDiKR0dsqxukagvi64jig5zj9QQl9C0Of1S2AwuV2PDR/
	2196+w==
X-Received: by 2002:a05:622a:124b:b0:536:9140:e2be with SMTP id d75a77b69052e-55ac948cc41mr174359441cf.74.1794855858824;
        Mon, 16 Nov 2026 11:04:18 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad1b13917sm87667361cf.29.2026.11.16.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:04:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT201-0000000AFsj-03Yl;
	Mon, 16 Nov 2026 15:04:17 -0400
Date: Mon, 16 Nov 2026 15:04:17 -0400
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
Message-ID: <20261116190417.GD2299285@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
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
In-Reply-To: <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>

On Mon, Nov 16, 2026 at 10:46:25AM -0800, Kameron Carr wrote:
> > @@ -1738,24 +1738,24 @@ static void set_pcie_cxl(struct pci_dev *dev)
> >  
> >  }
> >  
> > -static void set_pcie_untrusted(struct pci_dev *dev)
> > +static void pci_set_default_trust_policy(struct pci_dev *dev)
> >  {
> > -	struct pci_dev *parent = pci_upstream_bridge(dev);
> > +	struct pci_dev *parent = pci_physfn(dev);
> > +
> > +	if (parent == dev)
> > +		parent = pci_upstream_bridge(dev);
> >  
> >  	if (!parent)
> >  		return;
> 
> Hi Leon,
> 
> The default policy here works for physical hierarchies, but there's no
> opportunity for a paravirtual host bridge to participate in the trust
> resolution when the host bridge driver itself knows the appropriate
> trust level for a device.

HW doesn't really "know" the trust level, it can suggest a default but
the kernel command line and userspace should always be able to
override it.

> My scenario is pci-hyperv in a confidential VM with a paravisor. The
> paravisor is inside the guest's trust boundary and owns TDISP. It locks,
> attests and accepts the device, then answers a VMBus query describing
> which BAR ranges are private and whether the device's DMA may target
> private memory. Before a driver can bind pci-hyperv has to:

Sounds like a user in such an environment just wouldn't use the trust
level mechanism at all.

What use do you see for enabling trust level but having all the
devices unattestable and accepted already?

Your bigger issue is the below:

>   - query the paravisor,
>   - refuse to operate the device if the query failed or if the response
>     is invalid,
>   - decide whether the device may operate.
> 
> The modular host bridge driver in this scenario needs a hook to be able
> to participate in trust resolution.
> 
> I'm also looking for the right place to setup MMIO and configure DMA
> in my scenario. Let me know if you have guidance.

Well, you are very far outside what Linux expects for a CC flow, and
these special requests conflict with the arch code flows we need to
have.

So, I don't know. Maybe somewhere in the arch code hyperv can hook and
say the device is special? You'll have to see when we get more of the
CC stuff layed out.

Though, FWIW, I don't like it at all as a model. Denying the tenant
the ability to directly attest the HW is far away from what I'd
consider as necessary for CC.

Jason
