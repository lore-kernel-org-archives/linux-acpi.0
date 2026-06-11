Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10D2DC78C
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186646; cv=none; b=DApfCMaO+b5bBgycDENv85Ga1yboU98qyEwrcnP2W6bINnxDe/0kYxkICGkN3Zt1rdnbdMVthirMb1w2EAeqUKVpXeWkCm00DGEUC9kKZyINY7Ol1ByyDyDe2l3s+zfNiwzcTUyB9xn8WquteYXMp/K8pEIHudcEmKUaj+v3mXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186646; c=relaxed/simple;
	bh=t6vDzwAQf6m71cw7ZAaMH7giGD8b6mi1NLg41KRjFFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnq9ej2HazVszYeojYmQ2U32TTPc+qIRPXQfhmJcU9/WN62MudH7KXypT87AIuNgJNqndzxooExYL7nwBIbnMWfOv+CYolSHasOii/fSfSa9DwlpRAEJLKLa2Cf6WdeG07qbwuB883TqDG9rvObRSWdOSG+cxkzMq3gHdCckCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fesk3KIa; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fesk3KIa"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-915aa0a9293so110684485a.1
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781186644; x=1781791444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENvnRZyJjnEps3yiVgsX7HBb3e0UX6vr9hqD2coNcvo=;
        b=fesk3KIa2WZaCF+S33hAhBQlzcwgCxoS72qeS4zMaDv1u8hLG2+dxR+gahznY+1fk6
         DdxjwFARz8yW5Ys721g364lxZLjkhn6xTd6ikbmtvEiJBmWJoTRWhSN5AJ6r0KX1QV+b
         9nUwHhJ75yfxTKwMb0WCC6TNjkN4iYr5RLiy3c9Akgaldc+OKrH3bIohcOWiui0OEAML
         NrA6Z9JidbKHkAOQGGXGBujsPYodSd+xmp2K22NFQBCc/R3uYeSQyTeqBUndoWVTRpMi
         jnz1vMzfj+9asJSZuj/UjynhNATlXabH9DaZ3zXsXXDedUucxRS5U5RCtc0UQZSJLtnm
         /Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781186644; x=1781791444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENvnRZyJjnEps3yiVgsX7HBb3e0UX6vr9hqD2coNcvo=;
        b=mShsV3ancl7gYQt6RcjHiNFgF657nMcSsAio0SVWF9TRjhFLfhmzF73mKvcYvL58BB
         THttsmomDb48Kg4p5Zo5qxVGd8lvT2nF/1Pj1hhOD7pJYqrgLhzfzighxob10DtlG+dr
         g3MfE7rRRhyVDpwhdsVXL9rcUQ96TYNNBW2ZtZjN5Bs6EHY7t9fdi014QtR7or6qB3Ai
         l8SqCLlu23oVBLOHsVo9AaUS1qn9bKW7xm0ain1UwpGz8Rdp1vJxQDElyhVbZAdwZOnd
         Oy3FAObX4wxXDCZVVc/NXQVgC15+Uq+bIbd6Jmgg7RW98PqdBNMaqtou0lFeVb2Jim+H
         THXg==
X-Forwarded-Encrypted: i=1; AFNElJ99VgDivQ9+LQes5klUf66gJKKckAH01U3lKhSwf7uILlT0LvPZ5SKq4VBhubk5bfYBqIRObT+4kAkk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61TIM/a5QjD272Pt9D9CBb5eE3K8ryf7vcB1wgMfKpGuO6ABz
	SgZCCzXFBQoPe/BR6nWkPsLed08eosqONXjy2LHtvjSogcrWQIONxPDLm9W4p51jFPg=
X-Gm-Gg: Acq92OHVHpfak2r0IaNGtdiMg2q0qCNghowwzZRtP0JED8kAq5yLlDG/5YoHIPenfEh
	zmBOhvg/bmRO3OCvlEhq49Ovv6KFQpiaoRo09zVqYslJXdL7Czip8tTuQuJLMGhkrgXiu0UOawR
	5CAk3DxvUWwKR1L9zZC9poOKnoqA1SAi+9+8dywTLJdWHVwKxwKchiigHugfMCq9faQeL5h8Ixu
	kq9Vh2U9VbrAhrz4dkl+TcvOtHsu0dbYtsYNgWaAEZllcz6tQYiu9fq0UZe460HMxo24bH98gmz
	G/ofJDhguwNzfDRqC0xmXR2IQOXMyZXSlrCC+VMoqR43MzGEtati8w4J3pD3OkYA4d81xaQCmuI
	nnDwRpje3vfQzjprLmHbvSD8d6kZ52Ug+8qPGPc9u9mrBiq/f8/yw6havw/DgKqaIK5+gMGG957
	35JvxOtc0dApGER+RJsrzlev1TflisQ4HUiUMXE5i9MZyZ3mJPtFpSEaFkYIuSc5FKYBOqRGXD0
	0oQh7BevzUJK9iScQ==
X-Received: by 2002:a05:620a:2728:b0:915:9fde:9da3 with SMTP id af79cd13be357-9160ade2a98mr334272485a.27.1781186644129;
        Thu, 11 Jun 2026 07:04:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160aca4293sm196905585a.14.2026.06.11.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:04:03 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:04:01 -0400
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
Message-ID: <airAUSrNjbSEwuti@gourry-fedora-PF4VCD3F>
References: <20260610014517.253609-1-gourry@gourry.net>
 <20260610014517.253609-2-gourry@gourry.net>
 <aip5IWmxg9CWg8hQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aip5IWmxg9CWg8hQ@kernel.org>

On Thu, Jun 11, 2026 at 12:00:17PM +0300, Mike Rapoport wrote:
> > 1) Can we do dynamic addition of nodes?
> > 
> >    Not Trivially
> > 
> >    Some services utilize num_possible_nodes() as a static value to
> >    calculate the amount of resources to use at runtime (bpf, md/raid5).
> > 
> >    Example: futex_init uses num_possible_nodes() as part of its
> >             hashsize calculation during __init.
> 
> AFAIU, we don't add the additional nodes for generic hotplug memory but
> rather for exclusive use of by drivers/applications that are aware of these
> nodes.

The intent is to use for "non-generic" hotplug (see the whole private
node series [1]), which would eventually still use the hotplug mechanism
just not for generic memory.

[1] https://lore.kernel.org/linux-mm/20260222084842.1824063-1-gourry@gourry.net/

> Wouldn't adding them to possible nodes actually skew the calculation of the
> resources by the services utilizing num_possible_nodes()?
> 
> With the futex_init() example, won't be hashsize scaled down two much
> because we've added these special nodes to the possible mask?
>

The result is the same as BIOS reserving nodes with PXM entries that
don't get used.  The CXL ACPI Tables do this for CXL Fixed Memory
Windows that may never be hotplugged.

So really i think you're pointing out that futex_init() here probably
shouldn't be using num_possible_nodes?

~Gregory
