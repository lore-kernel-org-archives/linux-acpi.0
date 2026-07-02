Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA954E3772
	for <linux-acpi@vger.kernel.org>; Thu,  2 Jul 2026 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003422; cv=none; b=YUfeZtasjPXFUttSHZsX8js/x225iUOmA2Zz3LOR5QkDTeA0+3VW2GfsKT7fFw35nYAvEIXu18Pkt8pWnXpQSoejnw2tUCtQYR0P64ObSJIhmzZ0Nk9GQHYR6/nuyOSGBz0huOgfOiT9/GVM1WWKyvIGaqt69MV7kPhmR0ydJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003422; c=relaxed/simple;
	bh=UOPiJT8T7uTyFa7QTYmnZ8k0B56Jo1xH8oEC173P8GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iixS6GbbDiZXBpaKswAeKuQcc0irYWeAuldcWt4hU1AEIVK0Obm9GcCym9/Qqorw5c+QCHuNPwkN7r3UuDV66/aQRZ4vYCqkfD/f8vjuYdOpUdfIJ6kN0zayXcaU7qcqqiyjebYOXoCmx3jbuMj9Q/5Viq/FLpsTQ6IpHuDNl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ayunlWRd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ayunlWRd"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e501244f5so100435585a.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2026 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783003420; x=1783608220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMKSwJv9NceXHRupMFvzinKFBnJD1eW/sagn2nvHuck=;
        b=ayunlWRdwo1ZKRVKw16NsgB+qTK+qFJAAEUTf5SM+0iGWp5pN8hLxcrEW/OdWGbiJ6
         /BjubPu9ZidIRzJqdXnXSO0cZ9k63jSeRiaqz5dpoTh+2Cu27tueCfoNGXjTj7J6nQSo
         2SHx2cIUyUMYsE27PaOXA8QgJQsj2m2lDE9Hn94Ktpyl6wyZfaDu+yjQx75vg9X+7XNp
         Prg2agPlyT+dDdB6DZmKba6RNXvkYoaGNzWOadSidvzX1Xkg00ZQvotNLmoW0hebJ09w
         qQLt79Mo6QA+M6+YJh+lgGKjBwU4wUvrQ44VUDgxAUXm6fiwr9qw/Fq6nSuPlv1pBvWW
         zlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003420; x=1783608220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMKSwJv9NceXHRupMFvzinKFBnJD1eW/sagn2nvHuck=;
        b=eAnacuP9FfHbfBIykTLh5xyQsHoW+YFZn7MLnpWd/ojdIT9hHq6fBA/84z4E5lyf13
         hhFcw3dh0UAXf0IuC+7c5J7/8rHSj05YiQ7A/T7u0GE2R92P3wzDQQxHaXbT7OQ0yFM2
         lfI7JkV+ZKk+8YRNIa7K//sFtQy+EtWaXVmVtc5/ZjoXb3eaSK75DIc3tzTxkiCA1kHx
         s7mKgVH4XJX38h4g+dV+7L3Q500/B9Nz/zieZwn36HGa/FtCfKBzE4xRLUTP+IEZfLTt
         GbhTmzAWe9RMXnmDvs236uwqKlehQZQJXLC6tTUada4tMr1rGaslrcd1hePBrXuclHNt
         r35A==
X-Forwarded-Encrypted: i=1; AFNElJ/GbA8YJiUaInPoGlCGQXPCTUOr/08RDaIzbk3bebfW06PTj9Ri6nN+mfdVaA6Pg4kufXvX/s8tPjis@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGz76yTo5A4Q9gv8d1fYddR0Y3SQ6NH4Gz4MHi4tzx2pS1JBU
	fOMWtTMtczDi2muXbWFnZPZ2FcwuxY50gCk5l8Z3Oz1PxmlmwOdmdw4QAzsEf+jGYk0=
X-Gm-Gg: AfdE7cl7JbAOcnUaThIaZTU/oi11Aoi/Hjjo1iXna1x9oUifW1ZeEeYN4QUIcDF94yM
	7MO+Osu+NsP5OgrdZ2yDwFyxH5rv89jHZoxU63ZW3Mdu4dqqq/2OD2dcCZXxAGfTEOOnViuswA9
	mPUQHCAKtuqi0Ujbe3bUpCsIYqRGu59CoSr21nTyD4HgdnZVWPFMMRqaeaR/LMol/EEC4fCxkyj
	FiHp9h/H1zZwg5ydyyFAFHAmkWuDxqHyqk7sAz7SDCACNfMxK3v6qpYzXmsth9AWIcWbSOvWmK0
	1eU3q9lhb9hnSk9bSlcazTRUGs45u7JJrntz+PFSL899ksLiDtDNIq2X6lV5VWryQ2g3TK2pI4C
	VyrqiW+cRpJeok0dBP/+MkSFY0gkQRnoqryd8brqCnbA9Fu8aZVswlaBwjbUzBQVbLugbrP7RFw
	NGY6ywdq3ivToghCowhA34sj8mpX3TNsWqgbjhSO16HjttJocO5AXcCsesUvAz0jKXNDpE
X-Received: by 2002:a05:620a:4708:b0:92b:774:da66 with SMTP id af79cd13be357-92e7b42debcmr706158085a.56.1783003419654;
        Thu, 02 Jul 2026 07:43:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801bbec0sm236826085a.45.2026.07.02.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:43:39 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:43:34 -0400
From: Gregory Price <gourry@gourry.net>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <akZ5Fs5aSO89KqKE@gourry-fedora-PF4VCD3F>
References: <20260610014517.253609-1-gourry@gourry.net>
 <20260610014517.253609-2-gourry@gourry.net>
 <aip5IWmxg9CWg8hQ@kernel.org>
 <airAUSrNjbSEwuti@gourry-fedora-PF4VCD3F>
 <ai5vj_RjSxl_FLu-@kernel.org>
 <ajq2A9GUOBWjzYM6@gourry-fedora-PF4VCD3F>
 <akZG0sb1pXFZQQqA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZG0sb1pXFZQQqA@kernel.org>

On Thu, Jul 02, 2026 at 02:09:06PM +0300, Mike Rapoport wrote:
> On Tue, Jun 23, 2026 at 12:36:19PM -0400, Gregory Price wrote:
> > On Sun, Jun 14, 2026 at 12:08:31PM +0300, Mike Rapoport wrote:
> > > On Thu, Jun 11, 2026 at 10:04:01AM -0400, Gregory Price wrote:
> > > > On Thu, Jun 11, 2026 at 12:00:17PM +0300, Mike Rapoport wrote:
> > >  
> > > > So really i think you're pointing out that futex_init() here probably
> > > > shouldn't be using num_possible_nodes?
> > > 
> > > I'd rather say that num_possible_nodes() with and without CXL (or other
> > > differentiated memory) has different semantics.
> > > Maybe we need to add a new primitive for possible differentiated nodes and
> > > keep num_possible_nodes() to mean "number of possible nodes with normal
> > > memory".
> > >  
> > 
> > We'd have to define "normal" here a little more discretely.
> > 
> > Normal = N_MEMORY at __init?
> > Normal = N_MEMORY in the future?
> 
> Normal = not differentiated, no matter at __init or in the future.
> I.e. memory that kernel will use with existing allocation primitives.
> 
> > We also use the possible_nodes() mask to allocate per-node pgdat, so
> > the futex example is largely just another "hey look at this thing,
> > I wonder what other stuff is out there".
> 
> Right, futex is only one example. My point is that with multiplication of
> possible and not populated nodes the possible_nodes() mask may not reflect
> adequately the limits its callers look for.
> 
> And that maybe it's time to audit possible_nodes() callers.
>  

Totally reasonable, I have been thinking the same thing.

~Gregory
