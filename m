Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D943C7DE1;
	Thu,  2 Jul 2026 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990562; cv=none; b=BgpEGF+jZrFXTh4dXxo9dssBDYvNYW5bQuBE7nEYsFtotvrXVQJBvZ8yl5Vvipjl06+W9YDU9OisiRQfMvmgcE+Sw1gtCs+YDcDy4Qkzsna+8/ytG4IRA8627uQsxOrppDMLxDPLJAmS4GiDTGnPChGFQmWued9MUDFTBtzNvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990562; c=relaxed/simple;
	bh=7qRG6+K6X0dNRACwZKja+sVhu1BbFMotfd0j+/WKOnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv2Dv3k5fTCavwXK7+WPLUGzsektgbfCydwwOSOnjH5xLcBxRE45RqQG9qzZWDaYVlx/qwaiQCZOuhrl15TUL2Q1pUysWqRM6Z6to5gBS1FoSvQZz9ocZ6owpSkg9nCd1QxWVtFLF8aBW5MNMozozptvmCjgRttMoMWmse1CtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1RGPcRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1RGPcRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04F31F000E9;
	Thu,  2 Jul 2026 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782990560;
	bh=WNu+kvsuLssp3Vf5MRt2fyVL+Kj30QkUvpulkiVPbKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c1RGPcRVZDTUzx+5ZOWBET2EzXxK5SZJxndVk1Td3gIrtLa/797DSLHLnB7JbtpqP
	 7INq1GJa/XzkiG8YXhZGgFEdx473b3nn7EFtpsILfb8MVnXkRpZVhuLG0Jxqg4o7S4
	 grJ7vQtu+4aBIztbW9KDz8GYhT2X2PMSxJivbWjWecvZrlFs2eJzo8s3qWXqhd4IG2
	 BSEE/wBeqDkXI3Y/Ey58866xrA+IxZVw1Vm3PMbtACSlvkcbLX6j+x8gKEzLt6t+9c
	 B45bYzZN3B87tyUnYvDlYc+b9zbrOmRn3+eTkVMEeLD/3EzVmyPFqaUSXEMsRASuto
	 LcTCWZrY5+SHw==
Date: Thu, 2 Jul 2026 14:09:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, kernel-team@meta.com, corbet@lwn.net,
	skhan@linuxfoundation.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
	akpm@linux-foundation.org, rdunlap@infradead.org,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	elver@google.com, kuba@kernel.org, ebiggers@kernel.org,
	lirongqing@baidu.com, paulmck@kernel.org, dave.jiang@intel.com,
	jic23@kernel.org, xueshuai@linux.alibaba.com, kai.huang@intel.com
Subject: Re: [RFC PATCH 1/3] mm/numa: add exclusive node pool and
 numa=standby boot parameter
Message-ID: <akZG0sb1pXFZQQqA@kernel.org>
References: <20260610014517.253609-1-gourry@gourry.net>
 <20260610014517.253609-2-gourry@gourry.net>
 <aip5IWmxg9CWg8hQ@kernel.org>
 <airAUSrNjbSEwuti@gourry-fedora-PF4VCD3F>
 <ai5vj_RjSxl_FLu-@kernel.org>
 <ajq2A9GUOBWjzYM6@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajq2A9GUOBWjzYM6@gourry-fedora-PF4VCD3F>

On Tue, Jun 23, 2026 at 12:36:19PM -0400, Gregory Price wrote:
> On Sun, Jun 14, 2026 at 12:08:31PM +0300, Mike Rapoport wrote:
> > On Thu, Jun 11, 2026 at 10:04:01AM -0400, Gregory Price wrote:
> > > On Thu, Jun 11, 2026 at 12:00:17PM +0300, Mike Rapoport wrote:
> >  
> > > So really i think you're pointing out that futex_init() here probably
> > > shouldn't be using num_possible_nodes?
> > 
> > I'd rather say that num_possible_nodes() with and without CXL (or other
> > differentiated memory) has different semantics.
> > Maybe we need to add a new primitive for possible differentiated nodes and
> > keep num_possible_nodes() to mean "number of possible nodes with normal
> > memory".
> >  
> 
> We'd have to define "normal" here a little more discretely.
> 
> Normal = N_MEMORY at __init?
> Normal = N_MEMORY in the future?

Normal = not differentiated, no matter at __init or in the future.
I.e. memory that kernel will use with existing allocation primitives.

> We also use the possible_nodes() mask to allocate per-node pgdat, so
> the futex example is largely just another "hey look at this thing,
> I wonder what other stuff is out there".

Right, futex is only one example. My point is that with multiplication of
possible and not populated nodes the possible_nodes() mask may not reflect
adequately the limits its callers look for.

And that maybe it's time to audit possible_nodes() callers.
 
> ~Gregory

-- 
Sincerely yours,
Mike.
