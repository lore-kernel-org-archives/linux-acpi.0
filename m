Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034277;
	b=TcpEj+51W4qeXPJELXFPyCvSgbprduNLaSuJUU/YqYCJpQvTkYDzc5maLOmVbxtIdXaV
	 6VInn/K+3zCkUXC061gL26AiEtT+X744L/uaMb+4kLIpxsqyE59JjCWdBQ+jTIKKYxXRE
	 BdcEE4+o8Jy+m23qslK6fJpVKXeUl4E6x2YYYJbYMshkgVQoQyC/8JXhb9mtk0Mnra15I
	 ruMC504y4P27r1HYf3PCDJZBwwR9Wq8kwvnscE4lJonftI9yGOQ3miwgIDViiSEFawu8B
	 DVXWdAX9CDUCgUnIfTvqozszsDGwP9a4kcr8yAoErezcDPxNOkkNQDlszveGdk7FNow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034277;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2cuhONM8tokOY6Ih2LLraw+3pjiarMHBsNi3yDnlHxs=;
	b=rxZshN4YifNtXsKxZrMoVXf70Pk7pFYPEd4yiUTdj8HKs3CoB0Vx5cXdkrrsWan3CRau
	 oaAJScKTjW/gB7VEGChFXoqNOGnkcBLO7ez0oru4ijT5BxMXxXEHvOxHkzrBUX5ldtBQG
	 kEZJjOddPbq5HA9IdJJVw4A3YZY0F91+zLqJc9MCY8M8APWJp7YQMdAX4xeDLdGaRB1vU
	 sRS+GjEigHxRi3lphdN+pIweFzURuy09NtJYPgZgwEcrQ2nQSaB6TdNGeqimmXNXBmahu
	 ksaP0EPYKqDeV7c9PMy7wgAyXA310pL+ux2cM9/EQeL5J643j0ROw+zCvYlmqdMli/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwXC2s41;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA656606A325;
	Wed, 18 Nov 2026 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwXC2s41
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462381F000C4;
	Wed, 18 Nov 2026 20:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795034277;
	bh=2cuhONM8tokOY6Ih2LLraw+3pjiarMHBsNi3yDnlHxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BwXC2s41z10sgJKrVM5iZd/sEN8mYUFkSR8MDy48xNArsbyphkNbsD3Q+Zi7cgiWz
	 xHf9udXZBYTRq+JuBxUFi8lDsXfiB80HJSecQ/Yv1Dz0hYFkJ+JOi3GXCftneKsJku
	 znDm7HJU8Ud/Zehgu/SOoT19DSp5Xq8bSI4b/61wR0hLjPk6CRbg/59uaEG9P5grp5
	 eGrao647D+EaUZyZfXzBFGvTACyal8Sm6wy7x0Um/FehCWqIA3JWYVhOmqxzJagLOg
	 rTbJi3v/lSUO6FF9+G2PC+rXeSsoZiSvHnWCBqTStnurIOVicemLBQdZLNHwktGdjR
	 ZW6aRu8ZL8BDw==
Date: Wed, 18 Nov 2026 20:37:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Drew Fustini (Tenstorrent)" <fustini@kernel.org>
Cc: Sunil V L <sunilvl@oss.qualcomm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Atish Patra
 <atish.patra@linux.dev>, Anup Patel <anup.patel@oss.qualcomm.com>, Chen Pei
 <cp0613@linux.alibaba.com>, yunhui cui <cuiyunhui@bytedance.com>, Reinette
 Chatre <reinette.chatre@intel.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?=
 <radim.krcmar@oss.qualcomm.com>, Zeng Heng <zengheng@picoheart.com>, Conor
 Dooley <conor.dooley@microchip.com>, Ben Horgan <ben.horgan@arm.com>, James
 Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Adrien
 Ricciardi <aricciardi@baylibre.com>, Zhanpeng Zhang
 <zhangzhanpeng.jasper@bytedance.com>, Gong Shuai
 <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Kornel
 =?UTF-8?B?RHVsxJliYQ==?= <mindal@semihalf.com>, Samuel Holland
 <samuel.holland@sifive.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn, Dave Martin <Dave.Martin@arm.com>, Babu Moger
 <babu.moger@amd.com>, Fenghua Yu <fenghuay@nvidia.com>, Peter Newman
 <peternewman@google.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ACPI: RISC-V: Add RQSC table definitions
Message-ID: <20261118203744.6201beaf@jic23-hlaptop>
In-Reply-To: <20261117-acpi-rqsc-v1-1-381ce645751e@kernel.org>
References: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
	<20261117-acpi-rqsc-v1-1-381ce645751e@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 14:11:27 -0800
"Drew Fustini (Tenstorrent)" <fustini@kernel.org> wrote:

> The RISC-V Quality of Service Controllers (RQSC) table describes the
> CBQRI capacity and bandwidth controllers in a system. RQSC v1.0 was
> ratified in June 2026. Add structure definitions for RQSC.
> 
> The definitions stay in drivers/acpi/riscv until ACPICA carries them
> in actbl2.h.
Hi Drew,

This seems unusual.  Normal path for this has been to
put them in the right place and just flag the pull request as
you have done.  Then no one merges the series until acpica
pick them up and Rafael pulls that in.  That way it 'should'
not require a change, Rafael just ignores that patch and
picks up the rest.

I haven't been paying attention so maybe this is being
done differently here for some reason.

Has added benefit that no one reads the patch as it is another
projects problem :)

J
> 
> Link: https://github.com/open-acpica/acpica/pull/1262
> Signed-off-by: Drew Fustini (Tenstorrent) <fustini@kernel.org>

