Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E52D8760
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171665; cv=none; b=soWpcM3PpF0K/t/MpJfvlLIFU7QfCbmH7SpeUn0G431ssGT6XiugRT2Q6LHw6U0UjcPbKtPyvy5Tkm/tN4/dofk6XG7804LoxW7b3/nHqzO80YIBjN0F/rqkYgAacU2F4JzVL0RtEZjr/+kGW7arm7Gmg7q4XwLTeF1AHng19CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171665; c=relaxed/simple;
	bh=z/fFABH/LSxyYxaRcuJi/CZHyJnomjsXZwC51ucCpW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erubjPITQBN0PfFWQ9moI9kllJEFW2iLZEFsXB22D5Yo75vCB+7UfZQzfJgfUYyqMfERHEOMYfOsxWaiwSH1gKiIWgslAElLER9jU9d6IUIwOas3w+LxjvytT6X0a8HigAohp+kXeSH2+flKovELXQEqScyXh2wHaPJTpkcinxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wh3Y8P/x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wh3Y8P/x"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aeab6ff148so6205ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773171664; x=1773776464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7vY2UrB9SGH6OvdmDiCHyzJiFowvOHfRjqE+9AkweY=;
        b=wh3Y8P/xDvnE7gJaZNpSBS3fcetxBRzXDMslBBdt0STM1rq4ll2JAAWMFvWVcwZvB1
         upBLEBLfKUxQnWb5VBpxk1UKnVTeKd2nKKs4j9/kPLcYexQJEwB2XK8Ri40wi0JkIL6+
         wfaH1sfy6uiYu/EaTvb+PMVrwo+K6e5eV1QnV2lNI/19kG19eLK7jUdS3kIMohDWyYUo
         8Zw3wcf+V+sTlWXGXXczF0oPHnGTvCE93fMYChNQffPMu0eK+5xhbJQOD3AnmBnPi7rB
         i9NwzCbVXrgADPbAfwB+59zVWTKJGRCToYBpijIUL65rDBJYC9BAVO37VV8+YSIu7kbu
         a9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773171664; x=1773776464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7vY2UrB9SGH6OvdmDiCHyzJiFowvOHfRjqE+9AkweY=;
        b=Q6Jl0xT7zq8Z8+I5VsIPQ4ag51vx6BCxKZ99maDbQBB3Lbvzj2YCZJgxUaH7AplO7B
         4feKehjyRkAVfsIpiqE7qseT3c2kwTzFQsHrqXGo+qHF5lsK9WHu7i3pJF0u+VAcm/7L
         6zx4MWUjBzX0/0652PQdNpd5rpfH0qqV80dtKZKxnb0G9oOiC4HAct4+rrGpTAWhFAYz
         qMQ4MC1TPe5nLCVgrmz0o9xs35GYd5/Nf1b7AzdhBoK5XBGAb7XhQZLE5kFCBBW0+RdS
         CtQV3HMTDKEF8p611obcFbSfa+O6d0XUZa95eKMhvzlYC+fnOGe+yxRTtRUTUSKSbXKU
         zdOg==
X-Forwarded-Encrypted: i=1; AJvYcCVq2WZIcS6tf5FlOaAdaAxRPeeboOfj8fVg7cDNzmXXN7eY+luWeQEZhjaOdfK0hzMAL3K2AhkG3lxr@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbVu0N8XPO8srSbrG0o70rt8eCQIeq8FhII4M/PCQee9l/63z
	BlRmlj6UfBudXwoZrP0Hp+APYkva9xri2TMiYRLiLGJ+pdEj9k6sQ4474Pxjh4P6OQ==
X-Gm-Gg: ATEYQzwFM5nFQOjD2hwTyk+YGMUzVR8nK1jXIGbOfi/v+2EWcCL3vdDEWBLy4B9uGGF
	GB75d0Ew6U04IVbXQtNTubeY5khVqIfnaDWEu0kp7JcNEQhTmAZhYqSK57GFOQyZxfbHzuT3kCj
	J/4656XcL3FcsSpFQRJ6zyJNdjTFycHmA+il50If+zVAUISAdfSTxKfcJ1AxiWXJ0L9Uy2ES6VF
	6wI57305x2LMrSumMbWnAR37skiw83QJd82M08d8Z4+z9dLwmnIYC/xteWpnDZMNtO+iBR0TJIV
	+P0Qe2Kbi0vcC6EONJOQABODiSjqVIxdblipxDT5jwavsbCKYKfXOlKQC8inTdTHmQtO/yXMU+x
	IpacXUB6JaPXibGucM2/f4j77Nh6rCTwnTJSTEjWjXQDxWkm1Ve+nQRfL/UToj4jyrbyFcnO3qd
	H33ZrYB/gV1TaQGAxSkA8gsx1P6vH1MKsO44gdrd03hO0H8MnbmaPlsyarsA==
X-Received: by 2002:a17:903:191:b0:2ae:44ff:5f42 with SMTP id d9443c01a7336-2aead3e3606mr687905ad.20.1773171663319;
        Tue, 10 Mar 2026 12:41:03 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f05edd69sm3807665a91.1.2026.03.10.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:41:02 -0700 (PDT)
Date: Tue, 10 Mar 2026 19:40:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	rafael@kernel.org, lenb@kernel.org, kees@kernel.org,
	baolu.lu@linux.intel.com, smostafa@google.com,
	Alexander.Grest@microsoft.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abBzyKNZRzRykRV5@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306130202.GG1651202@nvidia.com>

On Fri, Mar 06, 2026 at 09:02:02AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2026 at 09:06:17PM -0800, Nicolin Chen wrote:
> > On Thu, Mar 05, 2026 at 09:33:47PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Mar 05, 2026 at 05:29:22PM -0800, Nicolin Chen wrote:
> > > 
> > > > But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
> > > > CMD. In my case where ATC_INV irq occurs, the return value from the
> > > > arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
> > > > are also matched. Actually, at this point that NOP ISR has already
> > > > finished.
> > > 
> > > Yes, you'd need a sneaky way to convay the error from the ISR to the
> > > cmdlist code that didn't harm performance. Maybe we could come up with
> > > something, but if it works replacing the NOP with flush sounds fairly
> > > appealing - though can you do a single WORD edit to the STE that will
> > > block translated requests? Zero EATS?
> > 
> > Yea. I can give that a try.
> 
> This also really needs to go after the invalidation changes because it
> is feasible to also edit the lockless RCU invalidation list from the
> ISR and disable the ATC for the failed device too.
> 
> > > Also, will the SMMU start spamming with blocked translation events or
> > > something that will need suppression too?
> > 
> > CD.R=0 can suppress fault records, but we would need to override
> > that in every CD of the device.
> 
> That's too much to do from ISR, but maybe we can do it from a WQ..
> 

(Skimming through these, apologies if I'm losing context), shouldn't we
do all that (marking it as an inv STE / abort STE, suppressing the
faults) in the worker instead of trying to reset/recover the device?

> Jason

Thanks
Praan
