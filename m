Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3BC3264E7;
	Tue,  7 Jul 2026 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783466649; cv=none; b=jBi6iKWqMlmvsOONcug0HxXVK0wQpzCQjV/N5J2sf0fDvdkqzoGBMUsub6zzkHTp2OIh5At21JSf8rNY/YjBx0mPOEAHdk8kZxDCRaeCpzBzuC7en6Luv8FcbPDwBnIco7yDaegPc+2O2DZcjkXPG5YCVvwlWNQmA/SUg4WdLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783466649; c=relaxed/simple;
	bh=A9iZKRhqcedwjEg+TAejDinCGbkAUfY5mz4rNVQhPR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XnIGr6T9CWGHwKmGTCCcOVzH78FCO0AOEm4ZrNW5P3L5AZ30+jk77IEZu9HAzPutOQuDSAnlVZg6IyKaXDTl6hWByY5sa6YqGTktQLNxSre8nDZIBINU0LbOIDuudhdec7o/U6vVlOVIZ5Q34AWkx/RHlDjfZNy5ONY9TS6FDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJPtN3Qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJPtN3Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF0F1F000E9;
	Tue,  7 Jul 2026 23:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783466648;
	bh=A9iZKRhqcedwjEg+TAejDinCGbkAUfY5mz4rNVQhPR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RJPtN3QgMoMoN35g8fczYMlVnsJDN4tjEDSW/K60KSdbwD2VAoAN5ueRjEbn/N2hX
	 8h+Rxvn4ZI8YUHYzy8XPOti+YrnIY+MLusDKETYUWRqzL3dVbbvwBY9rbnE+y+HVZU
	 lrCaZR0sqHFJjODKoysXLOv5J0rno+TjXflgJ6cAVfy1cmHPQH2ecSaCXjQAbyjNCN
	 Ld4mCC7K2ycKP6oelw6NAHMwT9hWTUXpeo9hgXuUSYaxlX737wFgwuL5F5STE2Jom3
	 bZLfZ4UU+RxZoVB5adE0d992IBjIuqnrelosFeUZd7EfDWnb2XMAVZG7EhPQI5aBjH
	 8ib5tEt3QRg0Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com, Vishal
 Badole <Vishal.Badole@amd.com>, mingo@redhat.com, x86@kernel.org,
 hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 peterz@infradead.org, tony.luck@intel.com, chang.seok.bae@intel.com,
 wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
In-Reply-To: <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local> <8733y1nj13.ffs@fw13>
 <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
 <20260703193222.GFakgORjvxwnZTPRnI@fat_crate.local>
 <5mqpi7ar6dnd7cyxf3wsuwbfj5nl3day5iyzi7zt64wztjbxyt@5mrkexqow4sc>
 <20260707004713.GEakxMkRkAky4_hanw@fat_crate.local>
 <74ekieyxpcriutn35o54ejeoccx4xpmhyg2s7uzgiirsxtitws@5e3mwksftvy6>
 <87wlv6sin7.ffs@fw13>
 <o6lnfms2uw5xpx54bqmc72zbtdblya6bknkx5g6di5s6g3ovjf@gybebdp6p7dm>
Date: Wed, 08 Jul 2026 01:24:05 +0200
Message-ID: <87fr1us7sa.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 07 2026 at 13:46, Pawan Gupta wrote:
> On Tue, Jul 07, 2026 at 09:29:32PM +0200, Thomas Gleixner wrote:
>> Just because it is convenient does not make it more correct. If you need
>> to enable mitigations on hybrid systems, then explicitely check for the
>> hybrid property.
>
> Right, I was convoluting 2 different goals. Vulnerability enumeration
> should explicitly check for hybrid.
>
> Currently, only RFDS needs to check for hybrid. It is probably not worth
> creating a new mechanism for cpu_type check for vulnerability enumeration.
> Below should work with current set of CPUs. Please let me know if there is
> a better way to handle this:

If that's the only case to handle, then sure that open coded check is
fine.
