Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321541DDF2;
	Fri, 24 Jul 2026 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888325; cv=none; b=WHa965jH/Fbt3MAFmUtICe+Xp9VTEflW5yggqg6SNu9oDsPT+y/zs2tw9iGiNNeUZZkG/ZpKVCkPttoUyJ0cUhWOlJVGs9vIX6xi5EAMLR5wFGbTTW8oJZmp2lR++YC9o/VMabzUPfoxLyeEwrbUWK9oHKMwtkxQeKyymcZNmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888325; c=relaxed/simple;
	bh=fUwUBmDPdtgIfdqEIOxLaPVoY66CHK+kA0Yi/fCs0Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHo4GEpZAQL4reTgkhjs5PiHSq3Mb1wI75B35qi60y7sTTwc/Qg+B0ZqQ0qoUu19b+AOnhTbPylmaT5rmgQU9KvXUrkH4xu/0ZipVO/HIgJAAAVtWS/M6G1D7dy2bpHAuITZs9chlel1Cm/lvBTe+O0PVL6pI7pewUfTqsP/ojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNeONbs9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNeONbs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7381A1F000E9;
	Fri, 24 Jul 2026 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784888318;
	bh=fsRwQ/MRXKU69Cz45TMuvT7xD7rCK/lcxMRZ0uHACwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eNeONbs9jDDO8unvLRenY4oHMgcT8mI+O7v/PPOsAMqDi1as36v3ligFWXjWwEWKH
	 vNK0ja7HvbVS21kyI5aJBjj2v36Y+LYDRe7nSvEPWHce06WYY1nnww7zpxPaNEr1L6
	 U7TrsL0XPQjRIR4qWb8ar0g08f32jYwvFZmd46Uwkg9Wkk9jUD8BOLnxmNYTtayl0g
	 hcgCy0LQ1ZwId5iSeUJoClHXuebZaHum3wSOcbFlEajhFHxkApxXFe6IyeolKbNeaM
	 aG3qDLDvX/VTeu4frVCkNwC+BCNO13pToBrDvw+dWgO9OKgeRgaXoowS8BQxWKCpba
	 BXBmNI+0FZP2A==
Date: Fri, 24 Jul 2026 11:18:32 +0100
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
	Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
Message-ID: <20260724-finicky-knowing-foxhound-df1e56@sudeepholla>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-11-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723155454.1760823-11-andre.przywara@arm.com>

On Thu, Jul 23, 2026 at 05:54:54PM +0200, Andre Przywara wrote:
> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> registers through a firmware interface. This requires a shared memory
> region to hold the message, and a mailbox to trigger the access.
> For ACPI this is wrapped as a PCC channel, described using existing
> ACPI abstractions.
> 
> Add code to parse those PCC table descriptions associated with an MSC,
> and store the parsed information in the MSC struct.
> There can be multiple PCC channels, and each channel can serve multiple
> MSCs, so we need to keep track of the channel usage, using a list and
> a refcount.
> This will be used by the MPAM-Fb access wrapper code.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/acpi/arm64/mpam.c      |   6 +-
>  drivers/resctrl/mpam_devices.c | 127 ++++++++++++++++++++++++++++++++-
>  2 files changed, 129 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> index 84963a20c3e7..ca9b8754ae5f 100644
> --- a/drivers/acpi/arm64/mpam.c
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -220,8 +220,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>  	struct platform_device *pdev __free(platform_device_put) =
>  		platform_device_alloc("mpam_msc", tbl_msc->identifier);

Looks like tbl_msc->identifier is getting stashed as pdev->id...


>  	int next_res = 0, next_prop = 0, err;
> -	/* pcc, nrdy, affinity and a sentinel */
> -	struct property_entry props[4] = { 0 };
> +	/* pcc, msc-id, nrdy, affinity and a sentinel */
> +	struct property_entry props[5] = { 0 };
>  	/* mmio, 2xirq, no sentinel. */
>  	struct resource res[3] = { 0 };
>  	struct acpi_device *companion;
> @@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
>  	} else if (iface == MPAM_IFACE_PCC) {
>  		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>  							tbl_msc->base_address);
> +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
> +							tbl_msc->identifier);

Why is this needed then as you can fetch it as pdev->id ?

-- 
Regards,
Sudeep
