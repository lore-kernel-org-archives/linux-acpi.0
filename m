Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF82C11F1
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173063; cv=none; b=OCWE7mWpZWtOjuqhR8px5T7IK93HcWxr5Mt4J2bqMsAENcz1kGgj4vMV67bQvyq/xWxkgd+J1m/1ytVtFqZljuPfGQ8mx68yMx9MQvJrQywWydwTL6mD41obUfP4k3EWozcrD/nPtkZqhIP03mhDIeybyHAB0loCqOrw6hpl0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173063; c=relaxed/simple;
	bh=GCUo1Xk02JN/TcsFOEXfGC7rEnRqBWxkbpmyl49gUY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXg6lq7L36SMsxYyliFRpimS48TTlWxKJc2/7Mf5NaP7ANV1VVGbeSS6wT8bIg9W4D25ePctekVP5AdEiQw/WyYfckT5iMrBl9w4NHFWWiJ8QI4gP34MWMwDQmGm8xLymxrDeaOaQBZEPusLJcsnvIgQ2bJ6FMW4n/U2X2gbpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGgwgf6g; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGgwgf6g"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae49120e97so24175ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773173061; x=1773777861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pouRMyraIJfJRyRFv87tQoZjJ+P4d5SAB0a9EGBIRqk=;
        b=BGgwgf6g9Ch2jh8xXwiD4EWfisLK87du4z7v94LHrFDyQoPsEUUU95b3fcdPq/H8v+
         I3YTvAnxFMX8V/3Hzq5uO8r775yaWA95P3tEbxBT3foq1DS1R1rN+RNqchcDmY6LgJRs
         EHZ29oaKiD5SwG9fiaFQstNVOjZQOGklQy5zrvgFUx2VBcygpDEZoK0tYH2fUmnP/bHu
         XA/oJxgPxLQO8B0ZMJVT06fI+UNTCYptZ6z/LSYLtw9SPelrSDpxwT93jFUYswhOP0iR
         jnOHeQqIK2ouj9sr6wHQVJK9L1VbgaRD0UVFJKR1WHkquBlFOr6CzA8zaDUDwrqR/cfL
         eYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173061; x=1773777861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pouRMyraIJfJRyRFv87tQoZjJ+P4d5SAB0a9EGBIRqk=;
        b=NlQHqCe3+L4f5thuxYJxN2iFP1jSAcJLpiCzoadZ46vmIjIV6SlZg2ZovEr4jVaofd
         ytJxYMTQnBZJVZIaZsM3Bc83djN40eSF/spgHU+jF9F/UaARANeXgAyhDxT4adZRAJBt
         E3dkVyZJOaVHxpkJ6YXMVJUXw0fYaRTRW3Nb5RM4kkleOg3Ohsod45d1twCo4WAvu1P4
         dc0Zedoq2jHQytGpIr02XrsdluXMWjKMagMZ356PMbz7elcz5RMr4+jXdMWemNuqNe2B
         QGJBXjJgYIQdM0keOvjL3p5MPs8PHEr/HmTt4o/i7u4+Fw2ITAL45+Tq74xWZqatBgRi
         Y+2g==
X-Forwarded-Encrypted: i=1; AJvYcCUX4EjMx1+96tcMLN5mpLGBtqEw4WOQIxEpNF0biDWInRMXepSxYkRMTTFbA87goIT4bGar8eAd9pEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZb+lvckKWLttbQE9+zSraDhgbr41/MT4k60R01RbbjuGzAzi
	UNvuTFFxFMf4QCBNBo5ZBjSr9J1C6gIQqdaJYv9rW/WpeoXcryi6v0SU8dA+lgUWhA==
X-Gm-Gg: ATEYQzzBc3QvzGgEMRmsf4jdgPFWZDBuR9G7pXgAKSd28U9bgl2y00MMuBiDm1p5LwL
	AcSfYG2ikxDXsSC3cAk8Ydf0uQu0xjl2wETzrN/auntR+ydPfFkjN7ndjaAEyAnwBLeb3Mo0WeE
	u0m+mVn6flTmaoIBx86EqhzdJJAYzYbZhC969wGI5S9lyywSctSrhiBokRl+7DAfqmVrCDrIxf9
	WB2LM9R6t7Vw1fyI2SOrxiJ//zrMthkd2bAf7kPIvvp5ZMFopT4nw/LhjpuEwMwPZG7L5ADqtHd
	Z6kUgr7Gsl28JbkGmh4hIy5pHpWYFJgGL5iFz282DXohIzPnl1JsWXcLeKjP/1w650opIj8lxrp
	F0DlUSPLQkO71Frt/vMPG+hGbPmbBA0rJSaunmTNJI1ghp/O3IadObVDiOMmre8nB0PLVLEbQlj
	8CSCWJDsB2SDg9DBit96Z2k/1nLxlx7OB7SCLRgLE99NU0BPc17XggUll0iA==
X-Received: by 2002:a17:902:cf12:b0:2a7:4151:2c74 with SMTP id d9443c01a7336-2aead3dfdfemr722415ad.16.1773173060930;
        Tue, 10 Mar 2026 13:04:20 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359ffdae223sm100059a91.0.2026.03.10.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:04:19 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:04:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, bhelgaas@google.com, rafael@kernel.org,
	lenb@kernel.org, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB5PsFiBvCOjmnW@google.com>
References: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
 <abBzyKNZRzRykRV5@google.com>
 <abB3qt3QTroym7D+@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abB3qt3QTroym7D+@Asurada-Nvidia>

On Tue, Mar 10, 2026 at 12:57:30PM -0700, Nicolin Chen wrote:
> On Tue, Mar 10, 2026 at 07:40:56PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Mar 06, 2026 at 09:02:02AM -0400, Jason Gunthorpe wrote:
> > > On Thu, Mar 05, 2026 at 09:06:17PM -0800, Nicolin Chen wrote:
> > > > On Thu, Mar 05, 2026 at 09:33:47PM -0400, Jason Gunthorpe wrote:
> > > > > On Thu, Mar 05, 2026 at 05:29:22PM -0800, Nicolin Chen wrote:
> > > > > 
> > > > > > But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
> > > > > > CMD. In my case where ATC_INV irq occurs, the return value from the
> > > > > > arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
> > > > > > are also matched. Actually, at this point that NOP ISR has already
> > > > > > finished.
> > > > > 
> > > > > Yes, you'd need a sneaky way to convay the error from the ISR to the
> > > > > cmdlist code that didn't harm performance. Maybe we could come up with
> > > > > something, but if it works replacing the NOP with flush sounds fairly
> > > > > appealing - though can you do a single WORD edit to the STE that will
> > > > > block translated requests? Zero EATS?
> > > > 
> > > > Yea. I can give that a try.
> > > 
> > > This also really needs to go after the invalidation changes because it
> > > is feasible to also edit the lockless RCU invalidation list from the
> > > ISR and disable the ATC for the failed device too.
> > > 
> > > > > Also, will the SMMU start spamming with blocked translation events or
> > > > > something that will need suppression too?
> > > > 
> > > > CD.R=0 can suppress fault records, but we would need to override
> > > > that in every CD of the device.
> > > 
> > > That's too much to do from ISR, but maybe we can do it from a WQ..
> > > 
> > 
> > (Skimming through these, apologies if I'm losing context), shouldn't we
> > do all that (marking it as an inv STE / abort STE, suppressing the
> > faults) in the worker instead of trying to reset/recover the device?
> 
> EATS should be unset asap to avoid memory corruption. It's best
> to do in the unmap() context where the page isn't reclaimed yet
> by the kernel.
> 

Makes sense.

> Worker thread will be a bit late, but it is good enough for any
> further step.
>

Ack.
Praan
