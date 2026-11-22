Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371340;
	b=iSXBghfLW3bTqdqk2EvqsJoeMtO8VxF58zkHHmIuJyhR3TK8C3MUi5dPFPJ4Ct6QHglw
	 ceVajcivYXff/ZH5EYiEKpsJYJHDJP0l95nCOdCH1iHj1TXyBLOJxexBgpbfoQSllcwLZ
	 Uv8dz37qS4I+KcuSZVxXPc3nWh/Xm4MPxEhZZI7BU5mGd9r3DUW9/AmGi2UdSeEoHmmTU
	 lNafB7uV5toiAo/nsLEJZ8QW31CCUQ51TU8u8AbwSM/aJwtwQLuADeeOxAFE8e54UP9bz
	 3II6MYQQJaIBKHbP/ryN5S/K/aJ5Luf2PNEYOakRURpffkng0BlCsjKC+W8biT5Rp5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371340;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ly0Qb7LtoPAwxIdNSlMhGXbiCyBmYz2wYY8MTMYeang=;
	b=IYAd9ZZKYIYeW5ObYr7B7qFMJwvkh7OJ/soSbxNWAU0fqEM3+oDOPsE2xlqf8YbAED4k
	 dPYan6zgyNvS2nd/yM8isWeHgM0N0wQEHSc3Qp2l39ZoCHyI/Ry25L/1BtYrWZxYN7TtE
	 Qplz/JXdJ0yq0aHIDPSvcbp8ZiXyL8B993wy2TV+VnFe1Q90+SglIhMvr6UKcQGcziDE6
	 vDUPRyJ6Ix3MUVdLBFqLYH/RDHdyilksDn6dOKB3Ybem/DnC1q8BB8G+qYMX0DfHmNHy2
	 0jWhGWbx4+ILEbffEYqU3fE0ff2/Jzrw8VmB2qZEtM/OWy7WL6elNNrgG7ZjQr0TSyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owuPPTBd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB7606A330;
	Sun, 22 Nov 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owuPPTBd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7793D1F000C4;
	Sun, 22 Nov 2026 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371340;
	bh=Ly0Qb7LtoPAwxIdNSlMhGXbiCyBmYz2wYY8MTMYeang=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=owuPPTBdy3mYxA1P7qyCUk7OH/zCw+ch3NE4bxilYoIrx/hGHfvw8+ACUg8nnTODh
	 IgJShCeTIxn/4nF73AorMZrGEo4vU6cs4HAirzO5u1D3sEmIkVCkxXLHjXmZBfxO+V
	 y8m7kzqf/g4l/mTcg0zgEh9FddQ6SzB4ovx9aYTdxwfUClhdRabFzrTrsnor9DEWS4
	 3NLgE7TM0t2AoC8xHVcth20jul8I/IY+QO0OSo2PMzyzWPSDfSAhXz5EtBnnRlpaVG
	 zxXCpDJ9f8eElgaEm6wa0MYOln/bapLKRAlnABnG5sC4SyB7d6xspPJdSTk3p1q6Rf
	 q4cwQ6jh1+xKQ==
Message-ID: <1fafa3c2-3f8d-4672-bf84-c474d0e4f7f7@kernel.org>
Date: Sun, 22 Nov 2026 12:15:37 -0600
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org
References: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
 <20261122143557.2412982-1-mike@fireburn.co.uk>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261122143557.2412982-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/26 08:35, Mike Lothian wrote:
> Mario,
> 
> Thanks for the CPM _L05 quirk. I've tested it on the G513QY (BIOS G513QY.335) with the dGPU runtime-resume patch on top. The boot log shows `CPM: \_GPE._L05 notifies missing \_SB.PCI0.GPP0.VGA, using \_SB.PCI0.GPP0.SWUS.SWDS.VGA instead`, and the external displays come up after a dock attach with the dGPU in D3cold
> 
> Feel free to add my Tested-by
> 
> Mike

OK I've sent that out for review separately.

https://lore.kernel.org/linux-acpi/20261122-fdo-gitlab-6061-v1-1-8380b1ec4e09@amd.com/
