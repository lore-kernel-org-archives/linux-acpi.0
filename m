Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787584;
	b=vHNXhRIsO818P6mP8mkZEYXFds51Tg6btXmLvA1uPLIYA0iP3HshNDOEldu2DB7C8nhZ
	 0fnfu3MrGQwC+TgKHZF6HO82jJ6h4EemHCqYks5tol/9qckRoj9nj5G0mA5qVSIKvMHBV
	 8Lap7M7tP3m0zZEfn0S6F7avuLdPSUvGyn/8Uk01zmPYdT3qUqDGk5OQvq5/KKRlAiv8v
	 eFkjgK2mnWpXs2JqN4TNmO7l5UH1dwFA2rjZIlZpkwkmnrJmWg/g4hbxw7ZDiv9y98WxR
	 4tZp1z0mAtlIsPE4bg1EdCpJVJ4B4N1i8hSCut5UjlBqGA5L3jYp35zMKgL+txC2DXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787584;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Md52We6EawhTcuECQ8x+adEJlS+dU9v2Pis/Pu6Ub5A=;
	b=x4JJgCxy04fl3XlaF/4DomCMsRnrFXqzKAm/tzFlD/4Fkcc4QLf6yV+C8hmHfU8GPUlS
	 dI3EfIQ0l8/TaeiUuepY/hjUSA45yx35tsv8LOQ1ycXoTQChQdMHtr4Cfg5PKdGkBJlTf
	 3B4PWJPsBVZw5lIF0nHMAy6ydMGG598ZrYEmACMDvoDgsOfPCzYkLh1I1n0/s+a44hvaX
	 arjrelt3dj/cxLxWrirPw9yL0DAXs23PUMJDH1c+lBZg7oViBppd56C7/4zLzC216T8FI
	 P/LZdHpu9aHRxwxekYMSlQuBg04FJwmEu06Pn+HPhPcLBEYb06nZDKODHE73AH9TcyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYHnvV4I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE1606A31B
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYHnvV4I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6191F00A16;
	Wed,  4 Nov 2026 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793787584;
	bh=Md52We6EawhTcuECQ8x+adEJlS+dU9v2Pis/Pu6Ub5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYHnvV4II77lPPk5cOSgv9l8j+UyOfgshMlcd60x60lvpLzogv3+5DEClbxxvT6hh
	 wslnToi5rCVDwSJP+/utVblFObqgj2fBaYCwsxaDg8H45nsHJ2JuFWyvsoeBm46+hK
	 gm2n7HZbCRxOZISGv+TuMkFqcR5O8m9Coz1Nk+qvCngxRcqyjauYjll1wO0V3Dorli
	 Si3Miqlv4YmA4cXcs7gZdGz94nLbD1qNaYK6fJEQVWpc4HnncJsJpGrp3TylRFoxsW
	 bv6RYCEJSMlxCSUYAdaCmd/BlA+yLDtoXZCfhwCSuceISSo4/1iqy1jeIB758VqoVb
	 RmtU3qcLDKiCw==
Date: Wed, 4 Nov 2026 10:19:40 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jamie Nguyen <jamien@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dat Mach <dmach@nvidia.com>
Subject: Re: [PATCH 2/2] ACPI: FFH: Support FF-A direct request 2 calls
Message-ID: <20261104-effective-wolverine-of-novelty-4e49fc@sudeepholla>
References: <20261103173907.1996118-1-sudeep.holla@kernel.org>
 <20261103173907.1996118-3-sudeep.holla@kernel.org>
 <20261103145335.000026ea@oss.qualcomm.com>
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
In-Reply-To: <20261103145335.000026ea@oss.qualcomm.com>

On Tue, Nov 03, 2026 at 02:53:35PM -0800, Jonathan Cameron wrote:
> On Tue,  3 Nov 2026 17:39:07 +0000
> Sudeep Holla <sudeep.holla@kernel.org> wrote:
> 
> > Arm Functional Fixed Hardware specification v1.3 defines FFH
> > OperationRegion offset 2 for issuing FFA_MSG_SEND_DIRECT_REQ2 calls.
> > The arm64 FFH handler currently supports only generic 32-bit and 64-bit
> > SMCCC calls, so it cannot implement this standardized interface.
> > 
> > Add a standalone FF-A path using the existing SMCCC conduit. Negotiate
> > FF-A v1.2, discover the sender endpoint with FFA_ID_GET, and use either
> > the receiver supplied by firmware or resolve a unique receiver from the
> > service UUID with FFA_PARTITION_INFO_GET_REGS.
> > 
> > Convert the ACPI ToUUID representation to the FF-A register encoding,
> > construct the direct request, resume interrupted or yielded calls with
> > FFA_RUN, and return the defined FFH status codes to AML.
> > 
> > Register-based partition discovery avoids RX/TX buffer ownership and
> > keeps the FFH implementation independent of the Arm FF-A transport
> > driver.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> Hi Sudeep,
> 
> I was curious so took a quick look. Some drive by comments inline.
> 

All good point, will be updated accordingly in the next version. Thanks
for the review.

-- 
Regards,
Sudeep
