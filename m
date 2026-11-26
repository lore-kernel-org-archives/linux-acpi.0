Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700545;
	b=jCwj5N/TYkD+9+hSsJFfHFL4MUvU/1n7QHjrzKyID6pmvl14vRGoVxir2sYJJABg4orr
	 RdD8Ho5QjcwNciC1fvtCBk0hyRmJt39R2pOJkDSJzusqRTsVBU731ridMCeWKolj0oH3j
	 qLQN3IVdHbTRsfWIUzCED9gTQ1yc5RIiPZflAWFmvwbIBgAO1t8ZNrGtb1efvQ6KSJ110
	 Ck+NXoka/nQFjDBKDZH+Gl8WZqGry0P1VXC1V0+o0PtuAzZDGGzG7tL/TN6oUWKnjA2ZI
	 68j1q0xPBcCnQSaxENUGflB3eB8mGcxY2vNM5drsfQgfF/0JXMSxa5FdGm8Fg9mRD4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700545;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4X783mAcXkSHJGPRS1PqaX2SCx8TtwFkAQ4+3APQlu0=;
	b=qAZOZodJc6DpVDuZITxACjaUls2mlI+/ma3SEu8GR8Rk0D+mkGLyhZGUNlAzxy+NW//G
	 9aE81LVQZRELg5HwSc4bmSHICQT/M29JQsk3zh7lSqWe3PtGnJXGZPloNwvRAl2O+dLSP
	 12D/9koYCtAxbjYJJu4hQgV9OpI6L8NFUf2XI37Mq7XoygTg82FrnWG4NwSiyT28+ieKN
	 gCsHF6EYZe8C631hxuwUh/UFQrdfig9TAqRD+AK8t2h8LbeWMWeDCLArfrlcjNX0Q5dSo
	 onudYKw5keMufSPWgx+eIlkSPnInjZ+yUo2qUHE+XQj/YDwnKhvRAyCY9fWfS+liTig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWFpH75T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C6606A31C
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWFpH75T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB6F1F000CF;
	Thu, 26 Nov 2026 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795700544;
	bh=4X783mAcXkSHJGPRS1PqaX2SCx8TtwFkAQ4+3APQlu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GWFpH75Tdu3tO1BQHJN+rOTS7Ame2mO+5Licvq/tYNrg2DSEXo96wLm6JnQq6xjuM
	 9VZHKcuTI4vwZSu/3VneW0Eq7I15bKjQbPQRgSDOcKtEbML5U+fdgxHHJSKV7XMWMr
	 83RCC4QuwHOJJYbJXlVInnBz0XOJZ9Lhow9VfLQxVFFR4NmLYJ5tBsHjnhBizsnVE1
	 0vAPLr2Kzw4zMcRnir1iAb2nlpJQb/Ude6GozqCrBMbr0KonoBS15MmQriORnlc7CY
	 mEVL/yTmyUbnTmxcffxXhUG3hnz8N9G+751Tz+mIJvh0Mo4GQMhBGyQqXtdghQJ2/+
	 6UxhHXhMuF1Gg==
Date: Thu, 26 Nov 2026 13:42:20 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: Jamie Nguyen <jamien@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, Dat Mach <dmach@nvidia.com>
Subject: Re: [PATCH v2 2/3] ACPI: FFH: Support FF-A direct request 2 calls
Message-ID: <20261126-incredible-python-of-honeydew-981b28@sudeepholla>
References: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
 <20261112-acpi_ffh_ffa-v2-2-575a9dbed22b@kernel.org>
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
In-Reply-To: <20261112-acpi_ffh_ffa-v2-2-575a9dbed22b@kernel.org>

On Thu, Nov 12, 2026 at 11:14:07AM +0000, Sudeep Holla wrote:
> Arm Functional Fixed Hardware specification v1.3 defines FFH
> OperationRegion offset 2 for issuing FFA_MSG_SEND_DIRECT_REQ2 calls.
> The arm64 FFH handler currently supports only generic 32-bit and 64-bit
> SMCCC calls, so it cannot implement this standardized interface.
> 
> Add a standalone FF-A path using the existing SMCCC conduit. Negotiate
> FF-A v1.2, discover the sender endpoint with FFA_ID_GET, and use either
> the receiver supplied by firmware or resolve a unique receiver from the
> service UUID with FFA_PARTITION_INFO_GET_REGS.
> 
> Convert the ACPI ToUUID representation to the FF-A register encoding,
> construct the direct request, resume interrupted or yielded calls with
> FFA_RUN, and return the defined FFH status codes to AML.
> 
> Register-based partition discovery avoids RX/TX buffer ownership and
> keeps the FFH implementation independent of the Arm FF-A transport
> driver.
> 

Hi Will/Catalin,

Unless you shout, I assume you are happy for me to take this patch via
arm-soc tree for v7.5

-- 
Regards,
Sudeep
