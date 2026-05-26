Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648937CD45;
	Tue, 26 May 2026 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782776; cv=none; b=UcvjDK9VRa4H3cIcp3ySfoNIlltartyRoVw6kW/hVCW9eQp3LtM9XazRn5J49PVorjxBfYBFYE5oklCgPds9Fs8wNKfNqDPxd0JMRCAx7/J7uOpWqTyoKJKnqzp0K7236qmCQHzYdKSRbg53eNSyRx+dmc6JC2QxWL9R+odCDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782776; c=relaxed/simple;
	bh=HGapA52ayerj7Adm/fitF7ubF4fZQQHvIgBK9Lzu5Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3xcGKXtFlYP/dUalyML4C8UyjH+WpsvJ+oPz8e1HAS0YkQBt+pFF3eSaE4vtNBlgg+DAXGQuNU4pKflDZAj4PPobvhsseQJpnx2nsJPdo975esu9dMSJiddfUEU3yt117gUBzjWJ31k8dUYH7y9X75Xmvs6IkwBCBoIUzzYrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjjrCFpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjjrCFpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9651F000E9;
	Tue, 26 May 2026 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779782775;
	bh=g6XMMZUVsPZY3zr1bCsuHRKX53Xlum27v7L+XlSyf60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GjjrCFpc7W/uWJBxjHgFnxkFPVfFFFVq+t9oz2m0MynTPoKSQD1tJcaO8PtZUPk3I
	 uTcq4jba6ubS0GK5hI0943sfDtwBQVcE8Z4WF4OZvxllIIy3M2EQvj+c34Lo5ZVLj4
	 b3rfB4k0S8JaWUHAKrebtPBjKNP3AwC+HgCaPLfXU8amyec9wo+EdGh5yVlN0I2gMw
	 9rwPKA0vAFYqKSmpdkHNAw6fI4znsSfArIe503zTeTYvKLIYDQjFNhB+7J8+0JBagJ
	 8YPJiVHIfxXZ8UzNlx8bW/yEO1ohwBwLq4KG4T9x8uUUsdiSDqSYKJZp2KI3U45AgX
	 WNX6SXE33xZcA==
Date: Tue, 26 May 2026 09:06:06 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ge Gordon <gordon.ge@bst.ai>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Yu-Chun Lin =?utf-8?B?W+ael+elkOWQm10=?= <eleanor.lin@realtek.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 01/17] ACPI: GTDT: Account for GTDTv3 size when
 walking the platform timer descriptors
Message-ID: <20260526-logical-ape-of-courage-c1ccbf@sudeepholla>
References: <20260523140242.586031-1-maz@kernel.org>
 <20260523140242.586031-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523140242.586031-2-maz@kernel.org>

On Sat, May 23, 2026 at 03:02:26PM +0100, Marc Zyngier wrote:
> Since ARMv8.1, the architecture has grown an EL2-private virtual
> timer. This has been described in ACPI since ACPI v6.3 and revision
> 3 of the GTDT table.
> 
> An aditional structure was added in ACPICA, though in a rather
> bizarre way, and merged in v5.1 as 8f5a14d053100 ("ACPICA: ACPI 6.3:
> add GTDT Revision 3 support").
> 
> Finally plug the table parsing in GTDT, and correct the parsing of
> the platform timer subtables to account for the expanded size of
> the base table. This also comes with some extra sanitisation of
> the table, in the unlikely case someone got it wrong...
> 
> Suggested-by: Sudeep Holla <sudeep.holla@kernel.org>

Reviewed-by:  Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
