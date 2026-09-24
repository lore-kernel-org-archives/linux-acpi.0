Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C143B7B84;
	Thu, 24 Sep 2026 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243327; cv=none; b=rg7wHR1yvXCPi8+HJOEgtTVyNMIPVXh8tdwgFEYov9RAqpaH3cMQoKnFGpTIonu2irqVdki4KRvEIG+gZdPW4XrFcA2JD1g2OECdPWJIbh+wTyo2umkEY5Fp8fVaQFixXlBd33lI8+LkRlRdBMIrDXK/9+AAc5InA2yKnTNvO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243327; c=relaxed/simple;
	bh=aVRK7Q2OuO4ofzcgPceLJuQLOlQq5yMUcrwIVOmwebM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgysauzKXS/s4DOUocQSKym5AkwFzyZ6D1s5zzeTAy3/8p86ac5eLz6JZKEn+KSecjimFFjUMxykZ9gv/H0l82x8mO5iJ2Yrij1Y1K/deQrP/9XF7gS9ezrVPy2nkNGgwUWLtEo8r1DjGMEGeJ5rw1a4t9mWsCzq+bx1w8Teyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbAlI9mf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbAlI9mf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160FC1F000FF;
	Thu, 24 Sep 2026 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790243320;
	bh=OH4SNWg4WxSZv561l9vVZkZSASMw2QsrKpQxbItU284=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hbAlI9mfnuuRp6LUUI6ldVQ2MDxhRSTnKumanSZx1azAPkE+7SYVbJ+gOf9jsyRv7
	 DNptUQabV/jGs7mAQLKybEm6DPkrJYryZqGBibJQDC6p3unAgbGAydbVL09FWvNtIH
	 YBbcsHCRERkQh3DzHyPxADNpJ5PpzcWlLpsJOm7IgztDgDDjeWVkkbqeLKOlEXVqxw
	 r0FEq05XGfoBfGIc819sKhhVDNdp4RLCNxKnPxMLoJl4paHAFeYpePfQ6j+bDCz6OX
	 PqkHaCSS4kkEYHw5Y5nX5qazMSaWAnOdp8V6yMybD8sz59e/3UJkvCvWh/oVQl61lN
	 gnMGqWGkxl9zQ==
Date: Thu, 24 Sep 2026 10:48:35 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
	Ritwick Sharma <ritwick.sharma@arm.com>,
	Gavin Shan <gshan@redhat.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 12/14] arm_mpam: detect and enable MPAM-Fb PCC support
Message-ID: <20260924-snobbish-brainy-velociraptor-06bdd4@sudeepholla>
References: <20260911112835.714162-1-andre.przywara@arm.com>
 <20260911112835.714162-13-andre.przywara@arm.com>
 <3e7bdafd-d6ea-422c-82ff-e278a17280ff@arm.com>
 <a314ee8f-4152-4b29-8348-6cd750eced40@arm.com>
 <d96cbb8f-631c-433f-a553-6a6e20531f68@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d96cbb8f-631c-433f-a553-6a6e20531f68@arm.com>

On Mon, Sep 21, 2026 at 05:28:27PM +0100, Ben Horgan wrote:
> Hi Andre,
> 
> On 21/09/2026 17:09, Andre Przywara wrote:
>> Hi Ben,
>> 
>> On 9/11/26 17:09, Ben Horgan wrote:
>>> Hi Andre,
>>>

[...]

>>>
>>> This looks like the change earlier in the series to
>>> drivers/acpi/arm64/mpam.c makes no functional effect unless the proposed
>>> spec changes are accepted; the default is msc->id. I'd just move the
>> 
>> Yes, but it reduces churn, and more importantly, is more true to the
>> MPAM-Fb spec, which says:"The MSC identifiers are sequential and start from
>> 0 for each agent which uses this protocol." So this requires that we have
>> per-channel IDs for the MSCs, that's why I think it's justified to
>> introduce this already now, even when it's somewhat redundant as the code
>> stands now, as we always assign the system-wide ID to it.
>> 
>> I can of course move that out (and have that already on top of v9,
>> internally), but wanted to check this with you.
> 
> I don't really mind. If Lorenzo/Sudeep are happy with doing the preparation
> work in drivers/acpi/arm64/mpam.c then I'm ok with it. It's currently a
> non-functional change but does make the expected path forward slightly
> clearer.
> 

Sure, I am okay to have it added here if we plan to use it in the future.
We can always rip it off if the spec changes its direction or gets deemed
as broken 😉.

-- 
Regards,
Sudeep
