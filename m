Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844785;
	b=xRXu2f6qJPfXCr7rzMc8nWBUiRdD8IfJDMSOfJxTw38FOtZZfHjaTsyiQBSqDS9mfz8d
	 by2jH+F0SmVfyIHvztcYaW2OGfTtas23QSKvFm+581FmSBrkB1hsjGU9lIc837vl/qxBf
	 i8HeyBBDj8FAjHt2U5xxjoX7jze1rlt5LGJhdJs7NCr/3WRuczT6Yo8YzlchAYjbtbcuw
	 kaX9fdlgU0YZK8f4v3xy8nOPN1LNgwLuI9+e+sOEzbQSCRVp/jajqwtbaPj7J5WwRuPbq
	 e2LrzftnUvgE2m3gFrw7BuRFSBvxpYmyLcT/meUWeFv8zxgtnKJMejHCCxcRUe7w9nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
	b=sJrweyNDoeSQfSjsa4w1s0cKGnfMypmbZaecQ/TtPvju0Y6T0i3y8FpyFzXOdrtO4nmf
	 AJGJm0PO5rn8dUrmhnw5z3SPXnuzb6DbDpLzraRrzv7GFe/DJxisNO6Tq6BfpyHw4wdut
	 p2cFTAlhBNRhjA5fDJXKZ6MkvlxXnA8GiuABv668NFXW990ct8//3wSwhdW4ZVhfi/mfe
	 pu/ky80IFboEDuHn8K7VdxbOxvlYjc92HNZ4+5Get+gb9qUMRKIbFx3i+ma5JoPG92nhP
	 aHufShbRbnyXpRenMT1rpUVKFsfXqG5o6FzEnXKdW3Wo1af0LgiOKQj7182L+j1d42Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="T4EaFVj/";
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AE606A331
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 15:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 093AE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=T4EaFVj/
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91eb3fea2a9so42080366d6.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794844784; x=1795449584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=T4EaFVj/Db2Oh0QQIN6fEsneaLWasSmYdaomNevHcWQV9XfC0eku9uiWRA8yiTc/gq
         beN2zhlEBUDpPwvlJXNnJXYG7SLeGP2RUl/CIxz8vHb+CRPGvwOGP84P37zc/ASqwdCv
         a2ZImH/j9PEIljcRTrH9YjQx1m9XzvHX9w4v1GGAYhpr16oDLUf0JwGEJPe+tOCosZjE
         d53ULE5uBklWCIuWvycUfx9hIvJ8w6anXEcNacgC3MbLl4k/Apkhq6kLpk0rmKpAkcTv
         Trqjo9GQ8ASe6EH/m27mrq6sK/GeD3Uc4wVkpatMXBaBSojYeEkRpq+DgrGx3awVmJv/
         hg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844784; x=1795449584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=0+rWF86EY4XYLH0KEX3o++kTa8osoRgo306GieZ0WKz7Uf8hBRpY5VHA2HPNbFMVYh
         HFoWmVtkd/unNMnTCwypmZmdZnRubGiN+RKkt+eDYa3iuyGU9VnqxlGc7dv7xcTVSp/u
         DKcb7rUtyAI+8ac9nEexh7o2v3lIJxrC3yd38qSME1u3t1dF9gUHJwo79MnAjJ4KhdyZ
         kWiwSNeo+q0WUBs5NnFRebumDoMrluJUhYe2XrO5dBuKPLUo1vO/4aII9dfZv6njEhTo
         tfXxnkrOy6BHsf/keyHvvIueJ54FDMUBoggXYgIZCU/BCqhtz3uYfwT0mdMxGNsIDb7W
         kogQ==
X-Forwarded-Encrypted: i=1; AL+hErFINWAplP4UWJk2eZG8Q4/N3Wyynl4eaBXbNeF4VXgkeLN3WqeqadUuRPLR7m+mqLhoagD9O2DH+ETc@vger.kernel.org
X-Gm-Message-State: APuU4Z+k6bX3lTxegpZ/jC0FMaHm3GsOM6FSAyhSqDdrTL+8afQiAt+D
	eQ7zJAf0kdWaMfuAjzL+T4st3KuFkicCIRCSU6hwHeNRJXLYYgJ0TeuJ+oAjVYBUaE8=
X-Gm-Gg: AZFdTZdGUAKlqHfVPq4UC/Kqfz4ZM1NjPT+OJBW9335yM1Ct48k9EW+3b6aunaFF1Ez
	fMKK8E1Uns2jNUj9BNN5hxg61CGPa/sKMOyanZDJeBhXFUW0SXY6kOQxKhWhO7mDxI8YIRJ2i0u
	8qgtuwLWUKFm+hbPQn/SJkP1J3351FtGv3Vn+5x1tfgbOPgvy2ydQplW9Yt/f1jO/yOKDzQMik3
	e0oU4GRySfWOaqiROXnGlNPK0q0G8k2o9s9HisrkBTM+RVYfOlffHrLxwnfsK6vJirQwjSfpjSx
	iqJuiXRLvQcb9gfFwjGVaXAHOEq54IVjzESDjL9YAtzzGYKJAvyorDsHF+Q3qhIIuz5HZMIHilR
	1ou5zxhC4+tmCbJ01go7/DcNeIBjQhurOmciXxvxGtXf1Eg50o/WKJu30XnaFuR33LQZ8CfwbKB
	6vhqsmftKV9p3/doWp9/FN5Rmwje+m/7ptT5xQOluqcW2Ax3Z2ikrKeFECOzvsum+9RJNPnuzF9
	zYpW9aWN9WWwvOlVxKSaQilRUSmgTLr/2hfZuZGn8VErARjx2owgcvw7iyuW9U9ql3YOqV+HuR+
	vb3q0A==
X-Received: by 2002:a05:6214:2467:b0:91c:7f1f:2c9e with SMTP id 6a1803df08f44-91f24209db6mr171122396d6.55.1794844783992;
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d93f10sm87735096d6.30.2026.11.16.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSz7O-00000009eOI-3Mx3;
	Mon, 16 Nov 2026 11:59:42 -0400
Date: Mon, 16 Nov 2026 11:59:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116155942.GA2299285@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <yq5aa4n8ydsk.fsf@kernel.org>
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
In-Reply-To: <yq5aa4n8ydsk.fsf@kernel.org>

On Mon, Nov 16, 2026 at 09:22:11PM +0530, Aneesh Kumar K.V wrote:
> > Once you turn on TDISP you effectively activate DMA, just like turning
> > on the IOMMU.
> 
> We considered two options for doing this:
> 
> 1. Via the ->accept() callback in pci_tsm_ops.
> 2. Via pci_dma_configure(), based on a combination of device trust and device acceptance.
> 
> If I understand correctly, you are suggesting that we stick with the
> former?

It should still be done in #2, just with nothing to do with device
trust.

You can't run a TDISP run device at all if DMA_ENABLE is not done,
there is no half step here so it has nothing to do with device trust.

Jason
