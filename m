Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E33FBEC6;
	Thu, 30 Apr 2026 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538125; cv=none; b=Cj/67khrkRvdjIeJBjywKECqoNXq9cc4QbqxGxA62P/gRbvA40ea3QXcTi440uhXngq+CnbZ6vKoZS/QUJRjMq9PwpQcz6zVNuSvJYQsM+BnuMfp3tiCd8JxZGrN7I9/qJfb3e/JX9zdkxvqTkbw4e6xNKLNWqnsNaVPR4/6is8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538125; c=relaxed/simple;
	bh=B1L4jrLvkgWyY4sva0PycJP8nG8fvfd2BFEdcx4wZeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQCDPwUIPAhiqY68CN2m+V443je/ckXnX+rMXzn5mqoUle/MQk1TneTMQb4caSm/t2rdw5OITIXK/aQ2wftFMa4MOsragm2+CiE3WHD2A27lMLQg/ZRSYovWblSGyNJMaCAdo30fJuKTR/dUpULlDiiJRCrQ2OcLq0xbv1/ndnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZNECNYk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZNECNYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C2DC2BCB3;
	Thu, 30 Apr 2026 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777538124;
	bh=B1L4jrLvkgWyY4sva0PycJP8nG8fvfd2BFEdcx4wZeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZNECNYkAKYJRFmTJ8tAqAZ1lNS2lLXqCCwQ+muWoxIcLZArzRyyn8ZlLA27GCaC8
	 hCreoKB9vwo54z+8fnFXnoTbiC8jeVvJe+EE/COTGIc1LcXf7PKCf4Ah0+2IgwDjtZ
	 tPuMkp0QTZMIVhE9I/QQ73XaKpNY829XvKwPqV4ULW1kiOXaefKLOSuLSZsE8FFYD1
	 1sQ1lnMbk2e2jluAhnaGvU+oeGCyJFoCb+K24SR06S0vZ0zcqg94Jf1lhxWWXkc45C
	 kP9Mq0WUC95uR8ZJgcUqf1LQQuzAEeAvtUmr7kiJSBpsWjfqPePTuUpUC/vwqleIen
	 i8GQXcnR9hfaQ==
Date: Thu, 30 Apr 2026 09:35:19 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm_mpam: detect and enable MPAM-Fb PCC support
Message-ID: <20260430-brave-hoatzin-of-fascination-e7d4ad@sudeepholla>
References: <20260429141339.3171205-1-andre.przywara@arm.com>
 <20260429141339.3171205-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429141339.3171205-6-andre.przywara@arm.com>

On Wed, Apr 29, 2026 at 04:13:39PM +0200, Andre Przywara wrote:
> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> registers through a firmware interface. This requires a shared memory
> region to hold the message, and a mailbox to trigger the access.
> For ACPI this is wrapped as a PCC channel, described using existing
> ACPI abstractions.
> 
> Add code to parse those PCC table descriptions associated with an MSC,
> and store the parsed information in the MSC struct.
> This will be used by the MPAM-Fb access wrapper code.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/acpi/arm64/mpam.c      |  2 ++
>  drivers/resctrl/mpam_devices.c | 46 +++++++++++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> index 99c2bdbb3314..edb4d10e8dc3 100644
> --- a/drivers/acpi/arm64/mpam.c
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -341,6 +341,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>  	} else if (iface == MPAM_IFACE_PCC) {
>  		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>  							tbl_msc->base_address);
> +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
> +							tbl_msc->identifier);

I may be looking at the wrong documents, but neither DEN0065 nor DEN0144 carry
any definitions of pcc-channel and msc-id for the device with HID
"“ARMHAA5C". Since "pcc-channel" is already merged, I think I am looking at
wrong documents, please point me to the right one.

-- 
Regards,
Sudeep
