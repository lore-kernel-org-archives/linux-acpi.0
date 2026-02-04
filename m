Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373F30E83F;
	Wed,  4 Feb 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241566; cv=none; b=OOsAk69aZHxHdlYhtrvQ68w47+TNqr5xJGqsiDt5PoKdznOGW+8u/awkcLSjW37Dx5ABy8bySXNfttPJ0cusMUWGPkD2WlPViJ5wsqWuWte7fq6kLM3iXRfJ5YuBiBUhvD/5zo0+0j5Q7hsaR6nYiXaL9UEvBjqn7OnzDT0NYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241566; c=relaxed/simple;
	bh=mwTo5uNsZwGtSVPLSr9e5EaE1emi7vUgXEx1hWYZYzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r3JjZ+Pma/JtCYCk+9Atuj2IMc3RBNIjLVkQ6iGPJGqd89h2fF7f7ZmvQXyIV8TT2OIeIijpQ6+DRd5laXgJLlwUIyd86na/30MT34srKO2s9kultXt9VDLD2C18siGI0rCrATxAcwWDSzdWW2jad1Il+pb0VFkEyH4J/Yel5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS+tnWTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS+tnWTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B812EC4CEF7;
	Wed,  4 Feb 2026 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770241565;
	bh=mwTo5uNsZwGtSVPLSr9e5EaE1emi7vUgXEx1hWYZYzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YS+tnWTpu/h6IPLauHkcCgdgqNNT1HHbUkuBJ7TMrgbfO+SFLsUic5/re3XHHBfYM
	 iBYvWHe0BN26NyqjnLbyjGnM9rVPENmsFN7YE+YV1ak05AhD8h4ajkzECeivED2rKu
	 PxpWQnWHOiB4fVjHHCDv0UyD6Z6+8EctEkIfxbn8bbrFwMWEwjnXXKNYX4LbcYVlCU
	 osR5ENTpafgT43kh11rQzK4mV4qYgFFd/k7xe0NYIvee+0PtYjkVFaYvxaA4e30FZ1
	 dc61FhRKQEVZCRU4IZu56hafsRLpUagYukF1Wq1f9O01d1ypEwGimONUtipoijfBn6
	 VWxKjDGbDzq8Q==
Date: Wed, 4 Feb 2026 15:46:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	'Tony Luck' <tony.luck@intel.com>, 'Borislav Petkov' <bp@alien8.de>,
	'Hanjun Guo' <guohanjun@huawei.com>,
	'Mauro Carvalho Chehab' <mchehab@kernel.org>,
	'Shuai Xue' <xueshuai@linux.alibaba.com>,
	'Len Brown' <lenb@kernel.org>, 'Shiju Jose' <shiju.jose@huawei.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in
 ghes_estatus_pool_region_free
Message-ID: <20260204214604.GA17868@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ed01dc957a$7823c0b0$686b4210$@trustnetic.com>

On Wed, Feb 04, 2026 at 10:03:34AM +0800, Jiawen Wu wrote:
> On Wed, Feb 4, 2026 6:55 AM, Bjorn Helgaas wrote:
> > On Tue, Feb 03, 2026 at 10:12:32AM +0800, Jiawen Wu wrote:
> > > The function ghes_estatus_pool_region_free() is exported and be called
> > > by the PCIe AER recovery path, which unconditionally invokes it to free
> > > aer_capability_regs memory.
> > >
> > > Although current AER usage assumes memory comes from the GHES pool,
> > > robustness requires guarding against pool unavailability. Add a NULL check
> > > before calling gen_pool_free() to prevent crashes when the pool is not
> > > initialized. This also makes the API safer for potential future use by
> > > non-GHES callers.
> > 
> > I'm not sure what you mean by "pool unavailability."  I think getting
> > here with ghes_estatus_pool==NULL means we have a logic error
> > somewhere, and I don't think we should silently hide that error.
> > 
> > I'm generally in favor of *not* checking so we find out if the caller
> > forgot to keep track of the pointer correctly.
> 
> "pool unavailability" means that when I attempt to call
> aer_recover_queue() in a ethernet driver, which does not create
> ghes_estatus_pool, it leads to a NULL pointer dereference. 

I guess that means you contemplate having an ethernet driver allocate
and manage its own struct aer_capability_regs to pass to
aer_recover_queue().  But I don't understand why such a driver would
be involved in this part of the AER processing.

Normally a device like a NIC that detects an error logs something in
its local AER Capability, then sends an ERR_* message upstream.  The
Root Port that receives that ERR_* message generates an interrupt.  In
the native AER case, the Linux AER driver handles that interrupt,
reads the error logs from the AER Capability of the device that sent
the ERR_* message, and logs it.  In the firmware-first case used by
GHES, platform firmware handles the interrupt, reads the error logs,
packages them up, and sends them to the Linux AER driver via GHES and
aer_recover_queue().

What's the PCIe hardware flow that would lead to an ethernet driver
calling aer_recover_queue()?  An Endpoint driver wouldn't receive the
AER interrupt generated by the Root Port.

I suppose a NIC could generate its own device-specific interrupt when
it logs an error in its local AER Capability, but if it conforms to
the PCIe spec, it should also send an ERR_* message, which would feed
into the existing AER path.  I don't think we'd want the existing AER
path racing with a parallel AER path in the Endpoint driver.

Bjorn
