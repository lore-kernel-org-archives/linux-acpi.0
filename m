Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2C3A63F2;
	Tue, 21 Apr 2026 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765512; cv=none; b=kCmSHjpYg1wtTAUEXl96T9+p9vSXLt1p8sERh1pGm0qxkEprFZ3+hm58nOdPMn2lKrlppfbXE1OiqpICzSrpHNrCd1hLYRMkWa6aaPoYj23ktHsTllobdg7nTeRI7blTIGqTjhDtHrSW1HoXEJb/FmE4vq2OfNLrw5HR+xK61Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765512; c=relaxed/simple;
	bh=fexoY8X6Nq2k603tJTu41pqTFs2zfJKg3RNrn/E/JGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opnys4n/tqluCIvoSL8NIUvIqo57XnlQkTrAh1df2D3YxFYeqkg0Gw9vXHwGrGkS6IVF9eJqgQJH6m7kbFfmdYRzaNzHibEJSNARoByd6S+9KWslSW/rOKegKFPGnUusyMl6jvOKd+IAzGiJnD8nGCTofVMmgedMfprXY38xbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv9mPaLb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv9mPaLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5FAC2BCB0;
	Tue, 21 Apr 2026 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776765512;
	bh=fexoY8X6Nq2k603tJTu41pqTFs2zfJKg3RNrn/E/JGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mv9mPaLbyWMAANPZxFQ2Jqxq5kFDbd1iBmp7XwiQCZ34zvxiCQb7IK7U19EJ8GtjN
	 lStK/YU1TztoxxoMGN8Mn/84E/Y9K3sUSy+rVKnQtkFcroPboRGRl41yDoOkjiyccB
	 cEKvJwFMCY8AI6VIgzizisSEx+xZzU6qh1lrtgWn/Er+MhqcuWVCJqH/NRjentTI12
	 toheS5KdS76FCvNVprwVRY72thTgkj5FLnepiLvc2M4bvwj3hwo6AuFsLMHCXm/STS
	 kwqhEchqckpqu4N6n/vSViRDaNHQjbYX8st7sR2rtHzXKMws2uy/3uIBMXzExC1rKz
	 hAcEKZ2+yuOkw==
Date: Tue, 21 Apr 2026 10:58:27 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Huisong Li <lihuisong@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, pjaroszynski@nvidia.com,
	rmikey@meta.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: arm64: cpuidle: Tolerate platforms with no deep
 PSCI idle states
Message-ID: <20260421-accomplished-ethereal-whale-0e1cba@sudeepholla>
References: <20260420-ffh-v1-1-6b4c10fec442@debian.org>
 <20260420-sturdy-unique-shark-c4ca8c@sudeepholla>
 <aedGoi-Fk5HPK0OO@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aedGoi-Fk5HPK0OO@gmail.com>

On Tue, Apr 21, 2026 at 02:51:42AM -0700, Breno Leitao wrote:
> On Mon, Apr 20, 2026 at 04:12:38PM +0100, Sudeep Holla wrote:
> > On Mon, Apr 20, 2026 at 02:27:13AM -0700, Breno Leitao wrote:
> > > -	count = pr->power.count - 1;
> > > -	if (count <= 0)
> > > -		return -ENODEV;
> > > -
> >
> > Does it make sense to retain this check like
> >   if (pr->power.count < 1)
> >   	return -EINVAL;
> >
> > Though I see the assignment to pr->power.count in drivers/acpi/processor_idle.c
> > is through unsigned int. So I am fine even without the above check.
> 
> I don't think the check is necessary. When count is 0 or 1, the loop
> for (i = 1; i < pr->power.count; i++) body won't execute, and the
> function will return 0.
>

Yes but the point is to handle invalid pr->power.count(0 or less) which
is not possible here though it is signed it because it is assigned from
an unsigned int during initialisation.

> This seems like the correct behavior — if there are no FFH PSCI states
> to validate, there's nothing that should fail.
> 

Agreed, but I was thinking of error in parsing _LPI being propogated here
but again that's not happening here.

> Additionally, returning -ENODEV would trigger the "Invalid FFH LPI data"
> error message, which would be misleading since the LPI data isn't
> invalid, it's just not present.
> 

The point was to throw that error if _LPI parsing fails.

> That said, please take this with a grain of salt since I'm not deeply
> familiar with _LPI states and their expected behavior.
> 

No worries, I agree the check I asked for is not needed.

-- 
Regards,
Sudeep
