Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05A3E8661;
	Tue, 14 Apr 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175808; cv=none; b=fwIyY/Gi48P5fGf/7+MaEWa5vEyStB5z+Qx2LDUvdWeyhTfs+gXzK2Jlh20BzhOnozKRh1YYXsDr7ymZgiaZry8z+QivfwAWIeZqC+FKIhcetpoCGX2oeQ9OyjhFlyeptD6auYIQbxAO/MpFdCX1LwGsnuvQhjAW2Xvt0hdcbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175808; c=relaxed/simple;
	bh=ujt1Wt+EHyK45REV4tnk5H2K0RDbN6WthFKYktWz0aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAO3BIpSjj3s4xFzb2CpOhEl+wLyTxDnD1gUllSYC5X1NfCdTReKi0lVRr3XHS4vZt+JiRbSw5tqpTtfPnw47C+tvRA/6mZ96WuzMWgFcvg5gdRp2r4JP/J3rRcKu7W/8SupS/ZIImh++7tfvVTB0yTKn8JgIIzUMG7vND3l/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tntm/tJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tntm/tJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284F7C19425;
	Tue, 14 Apr 2026 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776175807;
	bh=ujt1Wt+EHyK45REV4tnk5H2K0RDbN6WthFKYktWz0aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tntm/tJV0yEUAmNgCeT7BuOsltvC61vjKBGdC9Ru9fWVc9t1sXyHHm7lXxaSRlOw9
	 PXe+G52WHGeCNJu9w/WUOv0pe1B5Ki1ijmSQxEwJkoDJUbV7lSCKrN+AaYjwkL8AHT
	 mwuURbkwx+nV+kNLCCtWn0AqnCzxSvrFpubEEDx3heMp2PCuuJ6erh1iL15ToY50yM
	 Eb49z+eP5VqH7u6iuk+gQcGLZl/WCdLm9ytvCUWIVBg+Hh+DlVG+pe/Gydn4pZLzp7
	 BwPvzjizpvySwWrFmG3+Ngct9gaZLQoI1Mh6hlKI4BSTOlWfdQVU4hundoNpPRM+0m
	 ttKXmL3on20xA==
Date: Tue, 14 Apr 2026 15:10:03 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "lihuisong (C)" <lihuisong@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>, Len Brown <lenb@kernel.org>,
	lpieralisi@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	pjaroszynski@nvidia.com, guohanjun@huawei.com,
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
Message-ID: <20260414-excellent-hidden-dodo-5bb98e@sudeepholla>
References: <20260413-ffh-v1-1-301704f69e2f@debian.org>
 <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
 <ad4UWJ__dnDQtrj8@gmail.com>
 <6694ca7c-13bf-4e7d-9621-bc992cbf96a7@huawei.com>
 <20260414-cute-shapeless-dolphin-c5b2fc@sudeepholla>
 <ad48gItCwrC-ar34@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad48gItCwrC-ar34@gmail.com>

On Tue, Apr 14, 2026 at 06:14:19AM -0700, Breno Leitao wrote:
> Hello Sudeep,
> 
> On Tue, Apr 14, 2026 at 01:25:53PM +0100, Sudeep Holla wrote:
> > So while I understand that the kernel did not report an error previously, that
> > does not mean the _LPI table is merely moot on this platform when it contains
> > only a WFI state.
> 
> Can you clarify whether datacenter ARM systems are expected to expose
> deeper idle states beyond WFI in their _LPI tables?
> 

Of course any system that prefers to save power when its idling must have
these _LPI deeper idle states.

> Backing up, I'm observing 72 pr_err() messages during boot on these
> hosts and trying to determine whether this indicates a firmware issue or
> if the kernel needs adjustment.

I consider this a firmware issue, but not a fatal one. What matters more is
the behavior after those errors are reported.

If you force success, either through your change or through the PSCI approach
suggested by lihuisong, then in practice you are only enabling a cpuidle
driver with a single usable state: WFI. That is not inherently wrong, but it
also does not provide much benefit.

When the idle task needs to enter an idle state, it will ask the cpuidle
framework to choose the appropriate state. In this case, however, the
framework has no real decision to make, because the only available state is
WFI. If that is all the platform can support, then the same result can be
achieved more efficiently without registering the cpuidle driver at all, by
falling back to `arch_cpu_idle()`, as I mentioned earlier.

-- 
Regards,
Sudeep
