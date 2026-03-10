Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126123E315D
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172852; cv=none; b=NSkMjkrUS0t+RSapI5t3ZcNP8v9WtRuzqDhQ/6kCyZDXvmr1mZrkN+aPq84GF2uOOMG6WOvuHCLo4exyQVFblNIA8Y3KMqLucK9Lk4Ldn/ruZnhuXLb1ZJMVi34/kAoKK5UeYCmCyqGunFyrNaYdocm9o08pBaATqp0vetyopRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172852; c=relaxed/simple;
	bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egJBiUNDe26u/yMH6vUT2eZw+dDNpFtpPgMRZCrVAxG0Wtbv4vs+DNiVLTCTwRayZa+VciVvsQmoBVh14jKQhaUpMhDrA54G7hsvmGaRb9JdTntmm2F9MCUJshEpWOv4Zjd+P6HyP4BbcCGmlJuh7MFQhY6wjycFsfEWZPWPBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6UlQ2d9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6UlQ2d9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aea4ebb048so6095ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773172850; x=1773777650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
        b=u6UlQ2d9kj7DzeV5fPPeyV6YjBaajC4Y/10M+RIt67zJp/T+DHXFprbNcxNI//4Dgo
         4D2o3CIV4ibVYhgE33vsmHrwq72e1aB5Bcx9U64YiMD9yFScHSPz+jQLRCLYLjyPcDGs
         yWJU+Lo565I0bueE3HKWW+HgswTejHKCOhk9sN9q1WxzBQO+VgT7cJnlDoosqCPDy+jL
         SajF5/peb/sSt5YNw1p4pULrTpyBT6fO4smLrbec8V1dzzmWv0e81DHf4s5dVtrkPEcm
         5+tgTJukediSO+FrcY0ynO0uuZPmG9i6fyx/bUVNwhhNvKX3IVE5xYQpEXyGVYRgB2bY
         txvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172850; x=1773777650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRgrUdtpUgdkaRQjebipTE+C+YCciQQD0TojrtBETB8=;
        b=Vk17PFgwUMMaRy0o1urx08f/9lioxOyw7+QCc+G8gVa22enhg8K8qMntqxkSVUhGMu
         HarSK3ZXZhrrfBcyVd0nqWANqca6bmVPkkRbxNBwi/Huuc2+daEQvZysNWThfiUhj5vy
         bWKhIbRmq3AiuTyLaynRJ5S4l/2OaQINrKon65BAyOzWk2ntVDrY+Q8zWqR9dJ7jTxDW
         eIbeyI9Pz2KhnWZGkW6fRJuQMZnvj0SfCnKZJEGlAFoLiGxjTUAP9H/I4y8LdaBammkX
         x5doPnGSR0POqRBuR8QLW6UOX3p1/fKgsi8ps5RxupunYpGdRBVCB9hGEty8SKyGl4v4
         Mtaw==
X-Forwarded-Encrypted: i=1; AJvYcCUAKLhvMnFMir1MDVMHJL/e3qzEyeBj6RRZ2Ct7cOKm+luEvz7om9k60S/8E5DmW3yJnfnBjhTa8lOM@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwoFRmAfzMsjnjdJmTXtKRBtaZMvHulKSeK/aQ2qCoCKoPD1U
	NwSe7noIYhmjrUb/u4k3T4yZIHy4YWq9fPmv+0dwp3LwXlqpf2qaYJNrFfCuNQdxhA==
X-Gm-Gg: ATEYQzyyh0hA/1B2w8IiMfv++xUISVjwjN5NXaJaavWnh3YZ+8lfkwKrshXtquedjZS
	1DdVIsv70U1n31Diu0yyo8A2el+bQJ9M58AwWE+1kH3iAkdxsmkC1OqTEwiNG10obHQmrZ5H1sZ
	8gkEdoRQSJfGMZ02uDiksrAu1PMzsFbuvf+eUzADrsD58QsYM9CH1MuH68o+CVAvUHOlkkmSSiq
	ceWL1Awd8tsCARZUMsGj3/wzc0fYOr2bLBO60PHl89pMD1o9iloOtctbkbF6U+I4hpS51Wc0aVd
	F+fFzzVvJ/jqr0hBaEhPXZogftWBnJkFjENGEQbk5FEkz54gvu3v+9uu9sKEiqej2iq+DHHKW+a
	ZpqCEZ3tHB2FCogqdXe8HwD2j9Jy/gVmo0qHV08epFF5CDpFCUypHHc1sz/uQ7GsdGQNkBFyKMa
	o6ufJusXCWAFtnxZCLNadQRIb/wdURKRcMsgNql0ExevFSUVjG2/mI+nvZwILnDA==
X-Received: by 2002:a17:903:234d:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2aeae708648mr72605ad.3.1773172849749;
        Tue, 10 Mar 2026 13:00:49 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f110991esm3573204a91.13.2026.03.10.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:00:49 -0700 (PDT)
Date: Tue, 10 Mar 2026 20:00:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB1VJ5Op24dMIog@google.com>
References: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
 <aasv1HYOKuuJyi1k@google.com>
 <20260306200321.GN1651202@nvidia.com>
 <aas0dLwKmZyL_iOL@google.com>
 <20260306202652.GP1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306202652.GP1651202@nvidia.com>

On Fri, Mar 06, 2026 at 04:26:52PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 08:22:08PM +0000, Samiullah Khawaja wrote:
>
>> But do you think doing the timeout logic without fencing would be good
>> enough?
>
>It is what ARM and AMD do, so I wouldn't object to it.

I think without any back pressure to the caller, a device will be able
to fill the invalidation queue with device IOTLB invalidations that get
stuck until the HW timeout occurs.
>
>> Currently VT-d blocks itself, until it gets an Invalidation Timeout
>> from HW, and system ends up in a hardlockup since interrupts are
>> disabled.
>>
>> Are you concerned that if fencing is done without an RAS flow, the
>> device might not be able to detect the failure (if it really needs ATS
>> to work)?
>
>Yes, and then the device is badly locked because nothing will fix the
>IOMMU fence.
>
>VFIO might fix it if it is restarted, but other approahces like
>rmmod/insmod won't restore the broken device.
>
>So I'd rather see a more complete solution before we add fencing to
>the iommu drivers. Minimally userspace doing a rmmod, flr, insmod
>should be able to restore the device.
>
>Then auto-FLR through RAS could sit on top of that.
>
>> I am thinking, we can do translated fence and timeout change for VT-d.
>> And the device can use existing RAS mechanism to recover itself. This
>> way we atleast make sure that caller of flush can reuse the memory/IOVAs
>> without UAFs.
>
>Without a larger framework to unfence I think this will get devices
>stuck..
>
>Jason
