Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B26355F57
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171249; cv=none; b=uqnr/DGWfMaxs9QmRdTdOwJsMDT2jFf2R1W/Dadu+eaY8vQjR5iKxBzj0ME+hWq1dgW8t4oUcLLKnKA2U7F1c9DCUDbUpjfmXPSv8O8AD5U8w7Zsh1SILMTpGrit2Jp4k2W4xvMuWy2PngIqmb2oXdwO7yjVsrwhtf+OG26agAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171249; c=relaxed/simple;
	bh=L12BluinyjkXyqIU2kYvAjopMSiSYL6fkPARo8pB4dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnKsVJury4LDVoliyZkhRywNMB1szMsfkVbtx3++ern8pH3EIV1mJSAr95ghl+/7NpE6rFrzaLDiW2a3DEXFdoe3IwUz5UPvKWbHQuJnUkiQcVQYIuXOfCaD9ymtmwzuAQQ8vJ740rSMia9bGLGVYWiTOt+mA2SsG3KomsApi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUMjQXCi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUMjQXCi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aea4ebb048so2425ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773171248; x=1773776048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXGSMdyPLPak8eP7BVwmVxBskx1z5iRhXJhm2M1XFP4=;
        b=sUMjQXCiFWPQ5tlDPRqpNkwz1K2jpMHfpkK4EwM4RZBQJPgxgv6Zxkh99vXccgplk1
         aF/u5WoZmbrEqevcIESXDoPzYFOslxzoL4jAaOwzA9wSDC2q+yVfKLDqvnUMVtxWkMF0
         eJXvjINw5i/1WgpjhWLyibo6j1DNkGrrNr4xiAz53AcquSAhpcEm1eUyvteoxBZqTPFt
         p8n0e27ljaRnN9NlUt45D4WeMYqQ3RARNGHm5SHhWrn6w/ieTDKe+ya31oVFJOU/mPaA
         LCJXSlMHh6dzLo/RaxlJ0ilJJsNarqh9tmiQ95yerrATzHCy+dOaF87J2bqwt9zsoOls
         AqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773171248; x=1773776048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXGSMdyPLPak8eP7BVwmVxBskx1z5iRhXJhm2M1XFP4=;
        b=R03fvvUEjKdFxzvmEthbyBroY90S51/jeiaaAYZvgl99I0+wz+UeZj5E2ErX6gp6Ve
         TVfSz7bourVCFydOQOMEpkvt/J5QRrVQ9rG8nVnJ1r++MoAt37DLsCLUihHgLsmC4HWT
         AR3xcIMyfq+6fbApgkM9J/g665lRInT2n7rIg1/6YEdrlMEZXC1kx6VgBMs4+Qz3F0rS
         c96vZVQLlPM9cg5U3Rs/9AADR4W5COirrjMbtdJtQW8oHyCVYLLTZ2WpB6czOB3bfi1O
         9NRbtMDhTdq98iwOC1ziIaozsszQ0oDLGe5Kkq7d42iHJjajRZ++v6YwOKmIEvJwsrnJ
         m6eg==
X-Forwarded-Encrypted: i=1; AJvYcCVqRgz40Vofw0jHhMDgeGNLWYjWvprxFBfarajvaNJbiS37102U99G4yMD7iu6xxby0tQz+8WYclVgq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxed1s/vdgsZTt5gT93nq/9g9u+HMTSAylEm+peeByuhNAuoOA0
	bl6/L+2UMNZIzGRstvSeqoonwNLqkGQqErdxk5bfjafSjYyR+OoLbi+546yLhAGU0A==
X-Gm-Gg: ATEYQzzuOEMyneeQKj+f7hX3OfxKjRRUr7cqq2pDdjJ53ZMbE4E5fh98oom3yZMf7N9
	lZxMJI4MVOEYO3JMQECLdTelkvT4spZ6yPDbP5OZmJL2UY4xdJlDL+FKuzJeEzH8OUYKZ4ouuGn
	ZnIIhGE9T9seUj908ibYggOWtt22/JNKXYiHqblOBHcnuQh/IFPg/lR/PQOYHvY57kD/k5U4KlF
	mylAUfq5h8QVoWILDCekLsB7dJby7MVUMdC+t1R+3dVl49h0FX+WHYdjeFTej+ARiK1jSlM9A7o
	bMuv1GlZE6mZFKW9fOnLHzI094oogcjlOSW9B4yw/XNTere9S1MaGE4FaAmP97PZiFlixtwDvT7
	2c0fSHA0EKcmLwjTLsrsHpCY0HpgJWet0rIcimvVQzQIIgagLXzpbOzbP6kp7PsUf7O+WWngzpZ
	2y4jzktC6cmZST5w8wptWUznIl9C82zbukURDkfn4RuRlqBja4wJTXVi4L3w==
X-Received: by 2002:a17:902:f710:b0:2ae:4e8e:954e with SMTP id d9443c01a7336-2aeae7082d4mr4705ad.5.1773171247142;
        Tue, 10 Mar 2026 12:34:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34d873sm382665ad.42.2026.03.10.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:34:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 19:34:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	will@kernel.org, joro@8bytes.org, bhelgaas@google.com,
	rafael@kernel.org, lenb@kernel.org, kees@kernel.org,
	baolu.lu@linux.intel.com, smostafa@google.com,
	Alexander.Grest@microsoft.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abByKCl4xZlgF74z@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
 <aanwTQtMMplXY3du@Asurada-Nvidia>
 <20260305235252.GC1651202@nvidia.com>
 <03461707-783e-403a-86fa-ae7a5107fa30@arm.com>
 <20260306155646.GI1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306155646.GI1651202@nvidia.com>

On Fri, Mar 06, 2026 at 11:56:46AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 06, 2026 at 03:24:20PM +0000, Robin Murphy wrote:
> > On 2026-03-05 11:52 pm, Jason Gunthorpe wrote:
> > > On Thu, Mar 05, 2026 at 01:06:21PM -0800, Nicolin Chen wrote:
> > > > That sounds like the IOPF implementation. Maybe inventing another
> > > > IOMMU_FAULT_ATC_TIMEOUT to reuse the existing infrastructure would
> > > > make things cleaner.
> > > 
> > > I think the routing is quite different, IOPF wants to route an event
> > > the domain creator, here you want to route an event to the IOMMU core
> > > then the PCIe RAS callbacks.
> > > 
> > > IDK if there is much to be reused there, especially since IOPF
> > > requires a memory allocation and ideally we should not be allocating
> > > memory to resolve this critical error condition.
> > 
> > Yeah, sorry, for a moment there I somehow forgot that we can expect to use
> > ATS without PRI, so indeed tying this to IOPF wouldn't be appropriate. And
> > given the general difficulty of trying to infer what went wrong and what to
> > do from the CMDQ contents alone, I do like your idea of trying to return a
> > new kind of sync failure back to arm_smmu_atc_inv_{master,domain}() so that
> > we can take any defensive action from there, with all the information to
> > hand. We'd just have to ensure that if a large set of ATCI commands needs to
> > span multiple batches, every batch must contain its own sync (since if some
> > other batch of unrelated commands could get interleaved in the middle and
> > issue a sync that then fails due to someone else's ATC timeout, everything's
> > likely to get confused and go wrong).
> 
> Yeah, that all makes sense to me.
> 
> The batching issue is scary, we definately can't allow an ATC
> invalidation to be pushed without a SYNC that localizes any failure to
> this specific thread, or we can't properly disambiguate the failures
> anymore.
> 
> My feeling is when the sync "fails", it can bubble up the error and we
> can get back to the invalidation list processor which can then see it
> failed to process an ATC batch and take an appropriate action.
> 

+1 just saw this thread (replied something similar)

> > The fiddly thing then is that we might also have to be prepared to "handle"
> > CMD_SYNC timeout by manually checking for GERRORs, in case the whole
> > invalidation is in the context of an dma_unmap within some other device's
> > IRQ handler, which happens to be on the same CPU where the GERROR IRQ is now
> > pending, but can't be taken until we can complete the inv and return out of
> > the current IRQ :/
> 
> IIRC didn't the PM patches propose to add this anyhow?

If this is regarding the runtime pm patches, I've tried to address the
Gerror issue (pointed out by you in v4) in the v5 [1]

Thanks,
Praan

[1] https://lore.kernel.org/all/20260126151157.3418145-9-praan@google.com/
