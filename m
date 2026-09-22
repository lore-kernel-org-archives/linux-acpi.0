Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422E40B38A;
	Tue, 22 Sep 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100368; cv=none; b=SrJJZN7WA+yrrUShQOBJT/91f47tot4SipV0VRIhbZlsM/XeBoivghiaX11lij5/j8BOHJk6FzY+WzcopryZTYB4zAJalZ0czg8gyejcmPUnfKz5wxuof9v19xGMbqc1837ncwcxIEA8amirXytFLstmMzEIDuaXqJNSx7NG5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100368; c=relaxed/simple;
	bh=JLND+G43VOYhXVnSUeoSEgdGb/RD72trH1G5HX3w/o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy48T7doNGs22RaYzqo0Ua2tX50F0q54T+8kOQJicQziN74/dnTXBovW/fCffg6LNM4iCLpJ6Sax64psHrj3hrvv1T2Q6rMOJY5wBc4eKRoaqSxUye8blynyhV58wzBCWyKyC5OQSqjuHVGDMJUVo/HdF8xyAIr9GppvxqVNAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjeaxxhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjeaxxhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170AB1F00893;
	Tue, 22 Sep 2026 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790100367;
	bh=8aha4/q4JfCKqnw/sQC0ZeUyw5tRBX2jwelFYVzPtMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BjeaxxhixCSh56rNWbZEIjrdJO5kUvDB4KCFv+qdZp2oxY1Zaf15Xg8lUKiwCYC5x
	 k9yo5iOInVtGXByVspjtza0DjyYVyyOTJp+OxHfatoYu209tvHbj871SzMeQNSkYdC
	 i186KSrYYfZIcW9pwYkUOCQ2OO/bmGizH6+GjchokKRatbsuAgUaMi1KFa1HCZQ/0n
	 VycmhrWGd4Y6UM7JWwS+c8vX65o+J1ucaflNimSgFpqTKbAfMGMHURS/0T+e5qYplz
	 iADoYCr2hvJaZDNJ2ykfI6VKaKS9qlPa9WeyRrv8KJ6t+WtNDh3NVEiDyYBbzL8d2/
	 /5Ke/biuqSr1Q==
Date: Tue, 22 Sep 2026 19:06:02 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jamie Nguyen <jamien@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for
 FF-A (offset 2)
Message-ID: <20260922-exuberant-earwig-of-opportunity-4fecff@sudeepholla>
References: <20260901192906.133670-1-jamien@nvidia.com>
 <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla>
 <20260922155211.676134-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922155211.676134-1-jamien@nvidia.com>

On Tue, Sep 22, 2026 at 08:52:11AM -0700, Jamie Nguyen wrote:
> On Tue, Sep 22, 2026 at 09:46:59AM +0100, Sudeep Holla wrote:
> > Could you clarify how the build and runtime behavior are protected when
> > the FF-A driver is disabled?
> 
> There is no build-time dependency from ACPI FFH to the FF-A driver. The
> registration direction is from FF-A into FFH: the FF-A driver registers an
> optional backend after probe and unregisters it on removal.
> 

Equally ugly. FF-A spec doesn't talk about ACPI FFH, so it doesn't
belong in FF-A driver.

> With CONFIG_ARM_FFA_TRANSPORT=n, no backend is registered and an offset 2
> access returns FFH_FFA_NOT_SUPPORTED. With CONFIG_ACPI_FFH=n, the
> registration functions are static inline stubs.
> 

So if on a platform, ASL has FFH with offset 2, we fail if FF-A driver fails
to initialise ? What if this FFH offset 2 is used in some other device
methods that need to be executed before FF-A module is inserted ? We pull
that device down as well ? Is that acceptable ?

> I have also built CONFIG_ACPI_FFH=y with CONFIG_ARM_FFA_TRANSPORT=n.
> The W=1 build and full vmlinux link are clean, with no unresolved
> references to the FF-A transport driver. I'll mention this case in the v3
> cover letter.
> 

Fair enough, build dependency was one of the concern and not the only
concern.

> > Are there any other technical justifications for this tight coupling?
> 
> FFA_MSG_SEND_DIRECT_REQ2 requires FF-A state already owned by the driver:
> the selected SMC or HVC conduit, the sender endpoint ID from FFA_ID_GET,
> UUID-to-endpoint resolution through the partition discovery ABIs, REQ2
> feature detection, and FFA_RUN handling after FFA_YIELD or FFA_INTERRUPT.
> 

Yes but are they strong reasons to break some use-case like above.

> Open-coding those operations in ffh.c would duplicate FF-A initialization
> and state management. The ops registration lets FFH use that state when the
> driver is available while degrading cleanly when it is not.

There is no state management with simple FFA_MSG_SEND_DIRECT_REQ2, it is
synchronous send request if you look at it along wih offset 0/1 and without
FF-A driver knowledge.

I need to think apart from duplication, we shouldn't have much issue.

-- 
Regards,
Sudeep
