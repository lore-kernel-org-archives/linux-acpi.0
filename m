Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1B36DA0F;
	Tue,  7 Jul 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452577; cv=none; b=kaOvJJbP4vA/FMLUB51NX7rfPWap1AlwRSitYKbo3SJz+hy7LzaE8ZmcNkl8seozY5ijFUKOhaqh85wvxxOuh6/y5TX7Q7pytbloJHW09ee7Dn96e/OtP9neakn6yXN+Ay7VFepmz3j5Oa6BsRU0d04EWSjxE29kgiSBb8d7zMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452577; c=relaxed/simple;
	bh=g3UAs1wv8bHXBKAnuXrI47x6KaIn9nHjWvZrMjS6ZOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M+bY180oNS07/R+yZ19PVVm5apBb5ikPYLibMTIVFWgTABeFSdiwJYC1IQRCQVmuwL8Gv32azMg8Ph5qPWvfpQXYFAxwhCkQhuUu2WliThleFveOkefxmYqa7BARXN5F3RYApDYAvxyt7457FtV0ox2VqjpUvc3suUmRQPgrkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ49OOl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ49OOl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEE71F000E9;
	Tue,  7 Jul 2026 19:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452575;
	bh=0NX3p2glw6j8K/quOBU3J4938KShtYYGDT14nz9CIp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZQ49OOl6AMo+RQ7no8BdKLTtoazBT1xNFyilwQBV14lmY24g9+yaAu5IUo5OPEnGf
	 RFQYcDHDEKoXIYEuL8K+xcDqruGYg0rj8ljcB1DnfRtZZqMne0S9UU1WkhMjHwpIM8
	 eRdNut2Z2yMZphpJ70H3mtiy67zBNAZo8FPBmtuXkgSAdIIAHVVDTu69i2NSk4RC2P
	 tY9Ii823E5KiOLQGSEiYuFgKYtfz1VDtf3In+8OM+6k5GcTXlgR1TrdF9yAhXGLJJI
	 34MbPTSbM1D6L2LrDA2Du1+wwTMQZj9nhLxKeQu88jlUw8bNEnJjzn++M9x/0kf4MB
	 FN86zZMuLalPA==
From: Thomas Gleixner <tglx@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Borislav Petkov
 <bp@alien8.de>
Cc: dave.hansen@linux.intel.com, Vishal Badole <Vishal.Badole@amd.com>,
 mingo@redhat.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
 lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
 wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
In-Reply-To: <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local> <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
Date: Tue, 07 Jul 2026 21:29:32 +0200
Message-ID: <87wlv6sin7.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 07 2026 at 10:52, Pawan Gupta wrote:
> On Mon, Jul 06, 2026 at 05:47:13PM -0700, Borislav Petkov wrote:
>> On Mon, Jul 06, 2026 at 11:29:07AM -0700, Pawan Gupta wrote:
>> > >  /**
>> > >   * x86_match_cpu - match current CPU against an array of x86_cpu_ids
>> > >   * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
>> > > @@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>> > >  			continue;
>> > >  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
>> > >  			continue;
>> > > -		if (!x86_match_vendor_cpu_type(c, m))
>> > > +		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
>> > 
>> > ... matching a hybrid CPU to any cpu_type.
>> 
>> I don't know what you mean here.
>
> Vulnerability enumeration is done on the BSP, for a hybrid system with BSP
> as a performance-core, a vulnerability that only affects efficiency-cores
> would not be enumerated. So, x86_match_cpu() currently returns a match for
> any cpu-type on a hybrid system.

Abusing the type, which enumerates performance properties, for
vulnerability crystal ball logic is simply broken.

The type is a per CPU property and has nothing to do with hybrid or
not. Hybrid is a packet property.

Just because it is convenient does not make it more correct. If you need
to enable mitigations on hybrid systems, then explicitely check for the
hybrid property.

Thanks,

        tglx



