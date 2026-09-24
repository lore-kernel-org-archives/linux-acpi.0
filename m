Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8440BCCE;
	Thu, 24 Sep 2026 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242773; cv=none; b=lU6I1DlqtME7pBQr26KzrcLcuALospvvMgppRM/7VjQH951nZT74ZnCntoeoBBdIhYLt9SDeOk97m5Y7l6Zwt7258dQJ4/7xLJbcotW+7Pnv/FL+PxKR6I+PIF59iGQptj8tHHxi2JGt79JV9ai0AHOEoG5f+NGI9MKuM+zmKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242773; c=relaxed/simple;
	bh=QU3evBsNCTidn4YyOEsxPIH04fY4wOmMUntKSIG1RKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8Braqq9aGKFPEkRNv9QQapifJ9TZ0T9FHzraZbciKXSzhjtgVU0T9lIPoG/LCEWBq7MMUDicF85br9ELMnExm9AqLsSn0YLnF/T16VDTAQfYaKwCHyu2ILF0DV0Rc4WqtWlvs5nN/8Fw8LNCrT0FKottFxGslJrcM2YwUVOk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ0q+lRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ0q+lRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5351F00899;
	Thu, 24 Sep 2026 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790242768;
	bh=Etifw2tqT9ICxDurEfSG4oT+/ppV+8zZ5cdDwv4wIuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OQ0q+lRtq0CPdH6owlPg2DZW74wVwFesKIG7KxJfWYHqNP2rS5HJ1DPH2rV8LHkaN
	 6evRxFExNifGKC9SVWF4Kc6thtJzrg7uQl941MsmS3RZhcryN216cF5GDZUW7GDi9S
	 J9Zk4QXxeWmTU/fmoA5WmIpP07iFuEMtG7uv2JU8YEtqbA+BiznMZBWKbMoHRJ8i91
	 ZrwN6YuKj6yDFl4UvGBsAyFnw0vJx8ZFjZdSve7bKWHRAGeZH/tx7D+FZVZACFGhAn
	 NC9WDUOZhfJGpSNsCdCqwAlXXtsRQiLmKniN5iZPUA2N5hj8brsCteYqrqayfHp67F
	 FE9TOBmjoiteg==
Date: Thu, 24 Sep 2026 10:39:24 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jamie Nguyen <jamien@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for
 FF-A (offset 2)
Message-ID: <20260924-tall-oryx-of-attraction-23ada5@sudeepholla>
References: <20260901192906.133670-1-jamien@nvidia.com>
 <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla>
 <20260922155211.676134-1-jamien@nvidia.com>
 <20260922-exuberant-earwig-of-opportunity-4fecff@sudeepholla>
 <20260923124050.3270801-1-jamien@nvidia.com>
 <20260923-lurking-pony-of-fascination-ac6c49@sudeepholla>
 <20260923173240.3710620-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923173240.3710620-1-jamien@nvidia.com>

On Wed, Sep 23, 2026 at 10:32:40AM -0700, Jamie Nguyen wrote:
> On Wed, Sep 23, 2026 at 02:38:28PM +0100, Sudeep Holla wrote:
> > I did try to come up something simpler and independent last evening and
> > this morning, far from completion and I am also thinking of 2 main changes
> > to it yet:
> > 1. Maintain hash for receiver ID list
> > 2. Drop the whole FFA_VERSION fuss as it must be dealt with in UEFI and
> >    that should be sufficient.
> >
> > Of course not tested yet and even not sure this version is compile tested.
> 
> Thanks, this looks much simpler. I can confirm that both patches apply to
> v7.3-rc4 and build W=1 clean with ARM_FFA_TRANSPORT=y, =m and =n. The =n
> vmlinux also links with no transport-driver symbols pulled in.
>

Thanks for giving it a spin.

> On FFA_VERSION: as written, if the transport driver has already mapped
> its RX/TX buffers, I think DEN0077A R0216 has this negotiation return the
> Null version, so offset 2 would report NOT_SUPPORTED for any AML run after
> the driver probes. But if it's dropped, I don't think it's guaranteed that
> a compatible version will have been negotiated by then, right?
> 

Agreed, I need to think it through. I definitely want to avoid any usage of
Rx/Tx buffers here.

> [...]
> > +	memcpy(&args.a4, &buf[4], len - 4 * sizeof(u64));
> 
> This would trip CONFIG_FORTIFY_SOURCE's field-spanning write check
> whenever the region has more than one payload register. I think this would
> cover that case:
> 
> 	memcpy((void *)&args + offsetof(struct arm_smccc_1_2_regs, a4),
> 	       &buf[4], len - 4 * sizeof(u64));
> 

Thanks, will update.

Which version of FF-A is being deployed on your platforms ? Just wondering
if we can set v1.3 as minimum required here and use query negotiated version
feature of FFA_VERSION. It is not a must, just checking if that might simplify
things.

-- 
Regards,
Sudeep
