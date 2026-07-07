Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AE3859EB;
	Tue,  7 Jul 2026 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402986; cv=none; b=aEBlHujgWzWFZmOaS9n3gnqLA3Zyctq0vFQvDgX2ZFDyXPCbnTxNimUQcCecLFuATKtJdRWUL1MU21V+dY/9hxPnoTQwsAZIpKAsgK9iAB0Aw8U5AC56gwZzC8tBcAnMHQX2R58s5ZESnk0UTJKziGfSiQcAtYv5tKoKI8X0AfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402986; c=relaxed/simple;
	bh=QjLXdrRS003b9l+CLjSmiRx/cZg6+FZNVWWVVX7FsO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWzr9JKfRsxJzj8iA0gH6TPPUl642LY5nmXW3IoG77AXkj2P5tme7QK5ZXuKTvAHI4b3jKNlGz4JrSdtU9OJOPnmXDqcDJnYrU/3zz0goYYlUO2mzhdLl/9K0gquJ2wpNCXps+wJLqwSquL1QVAIYu2ujeH8o6FOzxIVznpUogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqTYmHll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqTYmHll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B811A1F000E9;
	Tue,  7 Jul 2026 05:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783402985;
	bh=vb6vk/n76+X1N8wujPagIhXsh+0Jn+z6BBJscyH3Kl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XqTYmHllZ0LJ4hsvf5fsczmCcUsgkjVWF1LHalZ/skJ7cfyXlAnfBFj9raJC9eN64
	 oONp8nsZazVNONEMYm9ZlPrSoGFxDDMeivRgQJbXL4RZrlO36mzvE/emvT2eC/hOXG
	 /6yMd/smKmHl9FqKIKFc8l/Y5I7vf/ElU1eowglhmxSnerHk7R3OPLidhvQe4W5nXf
	 kDChojB1FUmaplF14wvMSsBFTzMx4ioRwWlHuKttNgdITmT08gqOu6/LFoHwmozJqu
	 N8pxqjFdUUhwAbvJf3hGFx2O2jCYPujZEUpsYUwitMCmQnqKlijP0lHr/3Ea9SpUs8
	 lb4se/5Nv1lBA==
Date: Tue, 7 Jul 2026 08:42:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Danilo Krummrich <dakr@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v2 2/9] ACPI: NUMA: remove redundant numa_nodes_parsed
 node_set()
Message-ID: <akyR4OFOb8qLlVra@kernel.org>
References: <20260703041329.2797584-1-ekffu200098@gmail.com>
 <20260703041329.2797584-3-ekffu200098@gmail.com>
 <CAJZ5v0iq+SjMvFVwsfwh0Zyp+h5MUJ7eeejQAOir8ssSu7yO3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iq+SjMvFVwsfwh0Zyp+h5MUJ7eeejQAOir8ssSu7yO3Q@mail.gmail.com>

Hi Rafael,

On Mon, Jul 06, 2026 at 07:57:55PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 3, 2026 at 6:14 AM Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > numa_add_memblk() now sets the node in numa_nodes_parsed itself, so the
> > caller's own node_set() is redundant.  Remove it.
> >
> > No functional change.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  drivers/acpi/numa/srat.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 62d4a8df0b8c..5c407dc6401e 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -399,8 +399,6 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
> >                 goto out_err_bad_srat;
> >         }
> >
> > -       node_set(node, numa_nodes_parsed);
> > -
> >         pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
> >                 node, pxm,
> >                 (unsigned long long) start, (unsigned long long) end - 1,
> > --
> 
> Applied as 7.3 material, thanks!

This depends on patch 1 in the series, so I think it's better to keep the
series together and merge via the memblock tree so I took it there a few
days ago:

https://lore.kernel.org/all/178306815065.2173096.9480193260074524906.b4-ty@b4

Would you like me to add your tag for this patch?

-- 
Sincerely yours,
Mike.
