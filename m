Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051635E955;
	Tue,  2 Jun 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412295; cv=none; b=lvAGyCDI9Eg8k8xWwiE5r+pxnkYGqJ7w0DpvaaLqa2zdsJbh+UndvQcltAbNRXFA6tPZflygenLXc0Rt4NM8WwmeK4CaPjlhJ+SHiH6bldRqsgKWxrJI9pJLvuq2canEkeFUxAsLNeFeaZ0nKSNPxC+neoCV+KKWlzZ+Ao0S7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412295; c=relaxed/simple;
	bh=vvMxxFVLVeAlxiZc6cIUu1pEXq21KZqE9RkIAmXu/og=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsAJ1hF1f6pHi1mj8c2iKnvn3RSWNl06nPDxRHkkxIWhhJOrtz9HIuEBMlAfzzMr+vaAV1W3KUbtNoCVCt/SpEYBbUIL4Hn3L3sxj2JWvzRn0M8YkxJ+WzLhK2aNMoAYhDHtB7jRT6HXe00mZpP1YMFEOAH4GGTxrS7Gx963zXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUjAXOVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUjAXOVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957A71F00893;
	Tue,  2 Jun 2026 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412293;
	bh=DnM2hO41RX1ZjYT2K0TjVIZOoePCgu/n2TLpxGi/ANw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dUjAXOVAK+ks3hrv+Xa685ts0MW2Cl+aSZOl+l2Szs7WY1c9D6SvOlw3sE9mYacz0
	 n43WjYamFByyiiCExlI5ilvpZHWIGxqrMKsmokFnr5mw8+Y7DSUPTffryjzWlW741p
	 pqgU1q19ny15e1j228qYReoiHWBTzmggf4ohzcjbZqFcOk2+yCOA4Nf2bsi/y8OMem
	 a8/gKXDQrAFQwza0edc/eiefAzd70BZvfONWdljFPhtsL05epaN907a4idbsqUzy3Z
	 iwH/fqeAp2wNJ2h9/dBHnfxz7aY9KCBsZGPdZSE+iBSdiYxJUqDA7ctTm4MV199biX
	 FOIEZHiyz2Iig==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wUQZG-00000008e1B-22sE;
	Tue, 02 Jun 2026 14:58:10 +0000
Date: Tue, 02 Jun 2026 15:58:09 +0100
Message-ID: <8633z5ugzi.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: 	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,	Hanjun Guo
 <guohanjun@huawei.com>,	Sudeep Holla <sudeep.holla@kernel.org>,	Catalin
 Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,	Mark Rutland
 <mark.rutland@arm.com>,	Thomas Gleixner <tglx@kernel.org>,	Rob Herring
 <robh@kernel.org>,	Krzysztof Kozlowski <krzk+dt@kernel.org>,	Conor Dooley
 <conor+dt@kernel.org>,	Chen-Yu Tsai <wens@kernel.org>,	Jernej Skrabec
 <jernej.skrabec@gmail.com>,	Samuel Holland <samuel@sholland.org>,	Neil
 Armstrong <neil.armstrong@linaro.org>,	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,	Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,	Ge Gordon <gordon.ge@bst.ai>,	BST
 Linux Kernel Upstream Group <bst-upstream@bstai.top>,	Jesper Nilsson
 <jesper.nilsson@axis.com>,	Lars Persson <lars.persson@axis.com>,	Alim
 Akhtar <alim.akhtar@samsung.com>,	Ivaylo Ivanov
 <ivo.ivanov.ivanov1@gmail.com>,	Frank Li <Frank.Li@nxp.com>,	Sascha Hauer
 <s.hauer@pengutronix.de>,	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,	Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,	AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,	Thierry Reding
 <thierry.reding@kernel.org>,	Jonathan Hunter <jonathanh@nvidia.com>,	Bjorn
 Andersson <andersson@kernel.org>,	Konrad Dybcio <konradybcio@kernel.org>,
	Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,	=?UTF-8?B?Ill1LUNo?=
 =?UTF-8?B?dW4gTGluIFvmnpfnpZDlkJtdIg==?= <eleanor.lin@realtek.com>,	Heiko
 Stuebner <heiko@sntech.de>,	Shawn Lin <shawn.lin@rock-chips.com>,	Orson
 Zhai <orsonzhai@gmail.com>,	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 00/17] arm64: Use EL2 virtual timer when running VHE
In-Reply-To: <20260523140242.586031-1-maz@kernel.org>
References: <20260523140242.586031-1-maz@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: daniel.lezcano@kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, 
 eleanor.lin@realtek.com, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 23 May 2026 15:02:25 +0100,
Marc Zyngier <maz@kernel.org> wrote:
> 
> This is the third version of the series initially posted at [1],
> which
> 
> - updates the ACPI GTDT parsing to deal the v3 layout and the EL2
>   virtual timer,
> - moves the architected timer driver to use it when running VHE,
> - fixes a number of DTs to reflect the reality of the HW.
> 
> This results in significant performance uplift in deeper nested virt
> scenarios, at no overhead to the host.
> 
> Patches based on -rc3, tested on Amlogic SM1, QC X1E, Ampere Altra,
> and Apple M2, as well as KVM NV guests.

[...]

Daniel, can you please pick the first 3 patches? Or would you rather
have them routed via the arm64 tree?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
