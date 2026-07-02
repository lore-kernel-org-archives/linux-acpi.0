Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F143803C1;
	Thu,  2 Jul 2026 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029997; cv=none; b=pcDEfJQN48hS9ILCAl+9xqcQEDTzPRT27+BpIiF/8DRFpgaYJBL0hGMQ/bR33Ki8eOK1Jrio1Y866X73rd8m+tbo2M0q097WwUuyYbaLaO2Crh0QqF4//Q3s6GIRCG1WCWKR0TXRsjkACTqp21tdBOW7Mrw3DBZtyHJNDIZaK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029997; c=relaxed/simple;
	bh=7BFTQqUsF+0HMVaf2cevWXQX0/QTm5p8jpvKJXrcOyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=diOYVMdkB8jkh5DiutXW8Rjl/xe2DY99nAXDm8O+j/4472iOFD0wfsvJdsnaWp9btrBvbB/4CDckvQjaixOQ0HkHs01wgWoIlNOxgyluFQyHEmzijL1Pyo/r8jIVke5UTsmqVGwIZgwrTJmAGN5/byx7tHTu7hNyrKtYlKoeCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK9zRKfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK9zRKfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE261F000E9;
	Thu,  2 Jul 2026 22:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783029995;
	bh=YldsX4jd43WV/T8rAwXpohEVIXGZKBg+iIO76IWhHgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cK9zRKfiNgfb/IUYGmo852wkMiLnq/YT1uclaSTYPnDMXbex3yqtaPlzzd0FAQOWA
	 1wEFUj1egPxGnZmpJaZ4NPj9JYxQgVarGRmQD11ECpIMdf1yQtmn+ZNByWmS9yLgcH
	 YAmnPA/T7SYjxVXHQ2jGkZYP1QEJjJG651E5szZ1FXfh/WoY3Gr420wzTu5FPZ79vO
	 dHF1W/3xepkveX1vq/C4WYggwqUymat17wMy4cRux0LBT1RfvBFwGA4hAW24M0sj74
	 iY2fTTNKPTVh9kC0BL0BmOY9ds6jgm9QMcd90hJRRuBC5jzc1VcyoCtqZfx0dbRoU3
	 TZSeIE2MzN2MA==
From: Thomas Gleixner <tglx@kernel.org>
To: Borislav Petkov <bp@alien8.de>, Vishal Badole <Vishal.Badole@amd.com>,
 dave.hansen@linux.intel.com
Cc: mingo@redhat.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
 lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
 wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
In-Reply-To: <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
Date: Fri, 03 Jul 2026 00:06:32 +0200
Message-ID: <8733y1nj13.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 01 2026 at 17:27, Borislav Petkov wrote:
> On Mon, Jun 29, 2026 at 03:13:48PM +0530, Vishal Badole wrote:
> And it does make sense to me - x86_match_vendor_cpu_type() is supposed to
> receive the *hardware* defined CPU type - not the generic ones. And I think
> that was a mistake because the value 0 on AMD means a performance core type
> but in the kernel we called it X86_CPU_TYPE_ANY. Which is also not surprising
> - all our ANY types are 0.
>
> Now, one fix would be if we define X86_CPU_TYPE_ANY as 0xff and hope that
> Intel will never define it.
>
> On AMD that value is guaranteed to be invalid because the core type field is
> only 4 bits.
>
> But it can happen that one vendor's core type field can match another core
> type of the other vendor. Which would mean that we cannot use X86_VENDOR_ANY
> in any of the match_id tables when using a core type.
>
> Or, we do the proper fix and we map all vendor core types to the kernel's,
> vendor-agnostic TOPO_CPU_TYPE_* enums and then we're all good - we'd only need
> to convert the vendor ones to the generic ones on comparison but we do that
> anyway.

Just do the mapping to vendor-agnostic types _once_ when you enumerate the CPU
and store that information in the per CPU data.

Then you can do proper vendor agnostic matching against that and define
the TYPE_ANY value as you want without ever colliding with vendor
muck.

As a bonus get_topology_cpu_type() goes away too as the translation has
been done already.

Thanks,

        tglx


