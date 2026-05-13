Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7339A815;
	Wed, 13 May 2026 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711605; cv=none; b=TT8EZU5U8zO4wdVzeojlh5Lb3Vi8KhRqIxexiSEZ6KlN356wJ5CHpYajUYC10ceoDUhuzTtmyB53JeumVSHfWUuM61MOodah1l3Qaa4U0uZmznbLQfB2YZInU1YduTbhlmAGHK7wH8J+SCp6Dk6qFFzM7l0R4sDsYJh5iflri6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711605; c=relaxed/simple;
	bh=hwTH+6hUhoEyj5JZNYIPEtUSA8SkvfuKwQ7mDWYWBoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvwZhKS+HDTJiI+boXCc0ObtDe4HfAOQ5CUDlVjYFUzRWcwOdW7bgoxRNnBl6rXvf4tFdQJlf7KHOclUvikIXrGu2hPuOYQNyjb6jxRriEY9XbNqlCV/uG1arKPvQCt4J5SaoOG3m2wXVU7t5lYlw54dRJOTGGwJXbtgRuyCu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGKO7okS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGKO7okS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC8C19425;
	Wed, 13 May 2026 22:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778711605;
	bh=hwTH+6hUhoEyj5JZNYIPEtUSA8SkvfuKwQ7mDWYWBoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGKO7okSgOVQ9IZrUm25mf71fR/4z438lhcaWg5EFEAt6bMnUoUYv7uyYc2jyW1RO
	 ZvNRX/He8KuHhzu2WbQYVDNit4HiSaJ3OQIVQNRdAolxdLHYGvD9P9a27K5o1aLjq0
	 xDlVkx0srUtuzR6L2cyChOIZnSNRpj/yDv4ADydw6HSgxp2TnS0Qb0QJ39rrzrn/vP
	 qruV+E04+ScJ4ihorRjadeGcbtwiKjaQOV3z4t2oWZwVPOMn6ujEATAPj3wfGD2JGm
	 vCW8dOyZZhFP+Q+JK2xZ733PW7zArcH9Fz1KMGpxpSNxtlpPlDMXW+1SdqfBVo2RUo
	 OUXl5sG+9LZtw==
Date: Wed, 13 May 2026 17:33:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	linux-acpi@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Will Deacon <will@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lars Persson <lars.persson@axis.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Orson Zhai <orsonzhai@gmail.com>, Ge Gordon <gordon.ge@bst.ai>,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Samuel Holland <samuel@sholland.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michal Simek <michal.simek@amd.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>
Subject: Re: [PATCH 03/16] dt-bindings: timer: arm,arch_timer: Fix
 requirements for interrupt description
Message-ID: <177871159980.2167014.13931408615582570920.robh@kernel.org>
References: <20260507125544.2903406-1-maz@kernel.org>
 <20260507125544.2903406-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507125544.2903406-4-maz@kernel.org>


On Thu, 07 May 2026 13:55:31 +0100, Marc Zyngier wrote:
> The arm,arch_timer DT binding is extremely imprecise in describing
> the requirements for interrupts.
> 
> Follow the architecture by making it explicit that:
> - the EL1 secure timer irq is required if EL3 is implemented
> - the EL1 physical timer irq is always required
> - the EL1 virtual timer irq is always required
> - the EL2 physical timer irq is required if EL2 is implemented
> - the EL2 virtual timer irq is required if FEAT_VHE is implemented
> 
> The consequence of the above is that the minimum number of interrupts
> to be described is 2, and not 1.
> 
> Finally, clean up the description which made the assumption that
> the timers are plugged into a GIC (unfortunately, that's not always
> true), drop the MMIO nonsense that has long be moved to a separate
> binding, and use the architectural terminology to describe the various
> interrupts.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  .../bindings/timer/arm,arch_timer.yaml        | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

