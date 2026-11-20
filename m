Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795135314;
	b=bKea6C2mjuhn75yp/rAhy3G5D1wYSVciX7CgWW6v8RjeU8wpWpmX5w3n0OgMKHfIg3ON
	 E67yzNp1+LzDNbDa0ZMSUh6oyO4555QCqq2uRrBsgSzHQcc4idsdCD8JYR6xFldRq9f4o
	 sbcnxBVf34ejV+2uDoPTaux8Nt5DIe4DR6T3B4qpbDpsDVXoOSaazdJpIBZyxPfuYTkv2
	 iJH0J8GSYJwTgHeftNqr9Ue0ByFw2uYBr8hD2kGjW56aG8sUhx5Wll8lFKyCwNrLd5+c4
	 VOuE278rZwisX7MhDT3kY2l1l+FTyB2FE61Bsap0vaTUHSJFqz5+yt+rI+Hp9S1tcBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135314;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cnjKBIJ05Q1s49fHgd6kk3d8IJTU42NYzeIDTxhsvQQ=;
	b=4dr+Q5mgBA27VYEe2/MBkV50eBVglaCZS+g+HFC0nhNqCDbCBE3Es1vSsg3n81JkJDl2
	 dMcLBD3Chcf62UGz08kwwtDVkJP5vpG7kK6OtnmicS3iGVB8ZFnNAHMuWBHfbH7ESiaw6
	 dnqwj0rk8vDhIS9IpgObvoBl3agjMCSJKWaUVjjNdkjLBpNDD+bu/1/mVVHrtgCEPZ6vA
	 TKt/QhM2K99Px2fFwX6P1ZU/r5fCOdhk/qm1G/XWjGqepUaNzt9cIaox03wH36qzKQy3n
	 A+9G+r57Rv3yb3770LMR9WM6+oUx06EU0AcG9C9B0YmGtucgfkvKeDi6h9/AUoaJqWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHohB7cf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA507606A320;
	Fri, 20 Nov 2026 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHohB7cf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9ED1F000D0;
	Fri, 20 Nov 2026 00:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795135314;
	bh=cnjKBIJ05Q1s49fHgd6kk3d8IJTU42NYzeIDTxhsvQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hHohB7cflFrPXH1DBkE8glqGnVd+IsAmoLc7ukWBvBnR1BeIaPKaRlWLmmPNS8Ieh
	 +MYMV099B/96z11uJTZZWyRStZNsQn4+N3ihrdjICgZM04esn89DfwdHHEUPjffmcP
	 gUjDx/Hslg2E1Qzf877wBd8XUWuWQsPCgBkOo4g/P3yjcbay+HIMFK5G7hdECknuBb
	 b0r8AzreSblmCwqvvowxPfpXEZY8J8zLH8WntFEnTmBlPa4/mDSKlKRqMCG+MObDv3
	 pefvxsgF+Wi/nbxPuiVJbiqQGJlQXpDZ3PhiSNryZQnhvLFlFBlJLzijbgg8uMQYD4
	 ic44T3Kwp986A==
Date: Thu, 19 Nov 2026 16:41:52 -0800
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Sunil V L <sunilvl@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup.patel@oss.qualcomm.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
	Zeng Heng <zengheng@picoheart.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Ben Horgan <ben.horgan@arm.com>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Samuel Holland <samuel.holland@sifive.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, Dave Martin <Dave.Martin@arm.com>,
	Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghuay@nvidia.com>,
	Peter Newman <peternewman@google.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] [PATCH 3/3] riscv_cbqri: Bind to RQSC platform devices
Message-ID: <av-XUDYxM9laU1_W@thelio>
References: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
 <20261117-acpi-rqsc-v1-3-381ce645751e@kernel.org>
 <CAEEQ3wnnYTdVvH+NVWLSG+rk2bTZrDF4bF1F74R0jSuhQWzaGQ@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEQ3wnnYTdVvH+NVWLSG+rk2bTZrDF4bF1F74R0jSuhQWzaGQ@mail.gmail.com>

On Thu, Nov 19, 2026 at 07:12:10PM +0800, yunhui cui wrote:
> Hi Drew,

Hi!

[..]
> > @@ -101,15 +154,13 @@ static int cbqri_capacity_probe(struct platform_device *pdev)
> >         ret = riscv_cbqri_register_cc(&info);
> >         if (ret) {
> >                 dev_err(dev, "failed to register capacity controller: %d\n", ret);
> > -               goto out_put;
> > +               return ret;
> >         }
> 
> The same multiple-controller case applies to RQSC-described devices here:
> 
> https://lore.kernel.org/all/CAEEQ3w=voZYrfcMuKC_SQG9U8hYN_thcc02nf_PgMu5UyuG32Q@mail.gmail.com/

I would prefer to handle that scenario in a future series as I am not
sure how I would test it.

Do you have hardware that you can test it on?

Thanks,
Drew
