Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39E30F816
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232586; cv=none; b=tofuxH/TRNfJ+WinzuhTW/oijWn0T9ixcjpfq1VT+DAHVFi/m9HBZS2DL1CjXxsZp8v3iSThkoeR48ADIWeu/agW7izI/RuCO+TMPKxRJh9eL9T629r+Bdv/DQZjyj+zS0TAA2P/oadj9YRcV3sfxEZ6iBDcA3ikGOPG/Yd8ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232586; c=relaxed/simple;
	bh=6BUYor2v9oAXOWo+th16C0IQkWGTKnuLB8YOp3bBc2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzHcLAvVFhYkyUTFVzBCnDP4w2Vz7/L98tGz+L6cRiloszBp4Z/bPjlhQir18jw8wf7tZIO2XqP2nlfc5rP6ztxZPW34D54v7G9jHs7YWaA0oxb0s3NTpMgt5QKUurn79xuRDpF6UWa23AX89cBOPUDXgX9SkMyxO14boEVZef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=R4GMjLmn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="R4GMjLmn"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8dc87f7d68bso1266426d6.3
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782232584; x=1782837384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpQ1AwczYKCoguf7Vbwxx1q5Epc4lMpg8aH6LEWm7xE=;
        b=R4GMjLmn0arvDB4+Un795q2xqhDjmxjthBqzgWGObQc3ESfgovs34aiTSMyMy1yF5E
         80DlkCo4r5weSWG5Ygw0QiQVHVOF654BOESLmt/SQYhbCL/A26ju3K/FRwUU9lr5XBnW
         M/KF33YaH4v79Kf1uO0IeGt8c11yUtqLsrMj2svKdec6NQsMbB9hUMVowTYjtX1vLVU5
         ADm5GU1jpIIvaFSGbLhzPz7NkYM+ToGH6EFZ9dVWuRRMF4Yas+/E2y5HQQ6wdpM8T0wT
         Ti1eP4AksVu8ZjB1F42lqMPB+1joERVRqxJd56SBXcmQbkhzasBXCuwjiVbVm8txxlpV
         OvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232584; x=1782837384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpQ1AwczYKCoguf7Vbwxx1q5Epc4lMpg8aH6LEWm7xE=;
        b=qKOuldd6acEXfiI4A7uQPYF9w+WAtKMypKrYCGGazngBbJEJclL9mKQSw4abCE77Mc
         gEwQyIr/IegwPAeu1z3+2YF/DBHDj4sDyeBE4cr6/5KWFCEupoNPB8elh5nofLp/ueGd
         +JJoZMcnJgLPCWk0yYMAdkeIvjGp9VnNEPUxcy2rT9AhW5OmDFflZPpapz3s0uP/JmMB
         OHCkGH2rutfEcFKnHcA9O1CBk+H+poo5HIGUITZAol7Z1Fzhs6vrdSGHD8FAh1uibtcw
         enQvJDog0PdP60Qmphkt5x6myLuozmDOHxky9lrsMmiB2ZiFh0D6MTBBIX/ayzMnfKp8
         WOnA==
X-Forwarded-Encrypted: i=1; AFNElJ/TYfYVecHvWd3EvI1bXo2recaTqZNLvndsqqqra0wnjZWCoiydB1KznEUsDFGERfWUKTLAffs16F3G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/CYBDMPheeEoOsdb6Kc9ol4ezsOneX71lknroK89hgK4OpQLl
	jYqzHaQKsz/8ScLb+aePieAtgppiYUgChnmnaK83sKyaSu0PZZnDr7NA1dQuYU8TO6k=
X-Gm-Gg: AfdE7cnO37PHRGB0UyIqmQK08LnCyw9nGY3qc6jbiZnZUH7zqktOc3iR0YFWYtz59zz
	mjeVbC5zlGrVeBahekjlu41RjcfpYnIMORBu59YCHjv5YdEHMb4bAcKZNkNSfudgD8rUniQt/MA
	Zk353qnilqS5TJIXQJkmURqJMDfgNxrB7zeAaq9HNEGdFaiFChnnLec+XU4i2zXGAXrnIknSfcO
	++vLNnld4Ju2hkVPWAwKqmmtylSDlwSJFEaFP7moLB7p1xZcmSUCuPfIexWv48P9E9vTJ/caJO1
	at8uILiSc6ajijNeu2NVRY2n9qxjnR/9OrGFGprpzM84a99+SzTnzGPxMLokJdMOey7XISI8xXF
	4Qj0HoDj8GWXwDpIQv6sqEkeVwomv4vxRmWIcOnDKKZPCXdEwSODKJxMRH12RFOsmZlD5rDFt6k
	84sVb9B3HsDJ4BWVJzCLbnTEtSgU69XjghHTqEoizhKF0mTrdm1jXlS8nrQRqJAQcgpMIrO+jIV
	b8l3SE=
X-Received: by 2002:a05:620a:6892:b0:926:a969:89d9 with SMTP id af79cd13be357-926a9698aaamr393123185a.7.1782232584382;
        Tue, 23 Jun 2026 09:36:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c2a09sm306953585a.31.2026.06.23.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:36:23 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:36:19 -0400
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
Message-ID: <ajq2A9GUOBWjzYM6@gourry-fedora-PF4VCD3F>
References: <20260610014517.253609-1-gourry@gourry.net>
 <20260610014517.253609-2-gourry@gourry.net>
 <aip5IWmxg9CWg8hQ@kernel.org>
 <airAUSrNjbSEwuti@gourry-fedora-PF4VCD3F>
 <ai5vj_RjSxl_FLu-@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai5vj_RjSxl_FLu-@kernel.org>

On Sun, Jun 14, 2026 at 12:08:31PM +0300, Mike Rapoport wrote:
> On Thu, Jun 11, 2026 at 10:04:01AM -0400, Gregory Price wrote:
> > On Thu, Jun 11, 2026 at 12:00:17PM +0300, Mike Rapoport wrote:
>  
> > So really i think you're pointing out that futex_init() here probably
> > shouldn't be using num_possible_nodes?
> 
> I'd rather say that num_possible_nodes() with and without CXL (or other
> differentiated memory) has different semantics.
> Maybe we need to add a new primitive for possible differentiated nodes and
> keep num_possible_nodes() to mean "number of possible nodes with normal
> memory".
>  

We'd have to define "normal" here a little more discretely.

Normal = N_MEMORY at __init?
Normal = N_MEMORY in the future?

We also use the possible_nodes() mask to allocate per-node pgdat, so
the futex example is largely just another "hey look at this thing,
I wonder what other stuff is out there".

~Gregory
