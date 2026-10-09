Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A043A63F3;
	Fri,  9 Oct 2026 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539277; cv=none; b=SQmV2Kqe+Dd8EPmVifwKD4MHl02s5iQmrng/t9AdTa+YpZMViSM9vphzj1zK7uIRfhMuynrj59YwJ+ZyXgTzyIxY69Ut4pA0UBid/Dfkl4oAmnWD/6pysoDE/qS9jj8JDnF+Gmu4PFY8gnLMuiWgORzwNVJyOHsQ3w2CEv3n//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539277; c=relaxed/simple;
	bh=yJepcYmlQxR8Y7YRLHd6q8k582WSRyNa3NK2YU+Wux0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRXjqqBW1cy+MOZeHWwqU0chHv8IPaJ62pj0qR6gJArJqJvkXRi0d701obIcbbvgZFYKCqOiaLhs/9s+0FPAvxpYH12gAzyqY89DHs2dLFbvhH1yAgBO0rKOm9Rz9vfXKU3CO2tnbJ/JAM3AVs7Sce9S5YXObaV5uOp8AnwuzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du+JcPxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du+JcPxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15E01F000FF;
	Fri,  9 Oct 2026 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791539276;
	bh=auvhK7ffgL1FPg7XbmVEOxEa9GBZxXbchYY4I/Bc66I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Du+JcPxrxrnPSwjhxaYZqnTKozLxdVHm1be6v9bBCcNXbChZGFJEVkWx5zm6p6rEn
	 5MWi2LdX/djUS0cnUJCBmcS3vTzPSjOG4LK8+lIQNGQBBqTo7CpCtRfLwjSy5H54iR
	 te7+X6ktybTfm6FryiRVcioJNHy7NQZeyehJd1fEWegiLuXbHKMWvQFeubXDN2HtZc
	 N/IK6kGZgCIUKbzLs2ByJ+/cQNxi5krL6O18xzrS7r9rHlDhUSwq4Bd9cCWdw+v4Qq
	 GD5u6nzynFeOQvPnwMxrPFlqm0AYVZTvWcWpsd8Rk2vj7W3iGglGLIDkV7OfBGYe6O
	 me7GFbfqMmDMA==
Date: Fri, 9 Oct 2026 10:47:50 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, zhenglifeng1@huawei.com,
	zhongqiu.han@oss.qualcomm.com, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Shubhang Kaushik <sh@gentwo.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>, jonathanh@nvidia.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH 2/2] MAINTAINERS: ACPI: Add a separate CPPC entry
Message-ID: <20261009-almond-mandrill-of-glee-e23f9b@sudeepholla>
References: <20261008212832.354382-1-christian.loehle@arm.com>
 <20261008212832.354382-3-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008212832.354382-3-christian.loehle@arm.com>

On Thu, Oct 08, 2026 at 10:28:32PM +0100, Christian Loehle wrote:
> CPPC is a distinct part of ACPI, with its own CPU performance control
> semantics and register access mechanisms. Add a dedicated MAINTAINERS
> entry to help direct changes to maintainers familiar with those details
> and the various platforms implementing CPPC.
> 
> List Rafael and myself as maintainers for the implementation, public
> header and sysfs documentation.
> 

Thanks Christian for this.

Acked-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
