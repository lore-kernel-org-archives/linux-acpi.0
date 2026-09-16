Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674548CD7C
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602477; cv=none; b=YhOaA/5k1F4l9sLrJ9i1PD+XBMD4H524WN0HWrn9fnH0yxnKL+31HJC01cJ6wp5ex8eqSZuTOjgQB0zoIN8QCSwj5S/3RUL0pjvNMVc4Wf0bR291m8w1GCj//KGCjVRiqSuPwS0RvOWrR0cu1TbTE9UFzD3sLSoQZeXRgj38Eks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602477; c=relaxed/simple;
	bh=8ZZmEzmRY5l1Bk+XRrbRnE93cR7GfxYZTezIz2U6scs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GQw1mkxqnpPXAm8Um2vEoMCi9feDKQJ1GjltnvttmuBjk3p8gUvCegOFMhqY72FVqCQ3Ij4DIDvaBbunqbY6+uajfz1F6mf/2ePsXWAudqvxGzy7VqafLjTmNjOHhamPUDU9mHSZlSLr8aT1mScwbmP+P1ButuQTlsEK0ybjjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AuhR4CaE; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="AuhR4CaE"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so208453a91.0
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789602475; x=1790207275; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZZmEzmRY5l1Bk+XRrbRnE93cR7GfxYZTezIz2U6scs=;
        b=AuhR4CaEQLs6pHHrXZ1fJX0VwJHDwk8ESqCuamxrr5LsbfM/OPxm1+1RkeGst14S5R
         P5bdUHRvCwIhMDr+2NAr2xYn0iE2TiBtVn+qQ/v5MLDXvQmB96sJ8FNhU9I4sBBjtI93
         8aHI4FuaCNUuICbTmBiAVl5UCJZ8oX09N2I4iPACHCGj3P19avuDyWO9uHCIwV5FTSCi
         kyglARG9Jcdi86P54OjhehZK8+MTetAEBUgpOjv2U2+43GQIpiQ3hx9Q82f7jv6PM8K/
         ge82122gmdyNeuze2J+K6C0jzZD2JQ+y3qqi2/DwlPhBKa+u5is/oT3PR9ATgifCSlJq
         lFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602475; x=1790207275;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ZZmEzmRY5l1Bk+XRrbRnE93cR7GfxYZTezIz2U6scs=;
        b=KcGn/kQHNHVySDnnsxZi+jnlQhNKDi96+DCETzYeStN88WVG3pjVjJk4wmP3q1dXlT
         /wIVkOzbZ4KnKXaJxii4Ex4BmLK2bjIFlQdFx7FFHlJLxhsiYfC9Oa5IEIdqDwlHi2Gy
         FJdOcft8pnA0hmC8k1aEy3A9P5zL3FDEXeg02uE1VhFsbatv8Yn0Fbes0QCMz19knOcj
         wi46hGEd8FaH86kUmw9rHP/MKr15oUv5o8UgSXcMTC6T14OnBOPBCnYMVfBzEbPDs2T2
         y2XUQgS/iR+0DjVOTI/BWdTXoYJfUPqFaOzGtZNBeC3zH8SUqwflRZep/c+/IpyZGFw7
         HDQQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9tK5LZTS6VTi1M3r8zbOGI3aR5J6uoKl6L98tALWA8ObuhY2HRaA8WjL+59pLP4oYp1dLdrXyL9ny@vger.kernel.org
X-Gm-Message-State: AFuF++meC8ajsqS0aBV8wdfF+6IzNTCI8SXXF7Fwn2pFbll6zo6n2hhJ
	nXCZfzI5aDCThExE1aLeXADq2i25Cjl2SdSSQXZ+NB+pRPzKqbgAZ0O0fG9QnL6S0A==
X-Gm-Gg: AYBFou1L5HXObHch/rKf07LbNYt+m4GklKzNtfjO0Qx7Fgvn6X3M4LOQkEj+2GE69Be
	/hbDGka3jsesqAriJSq5ZoCDoDO7r+T7XyWtl0/H6nx8pQZCg1DMMuPmyervs8sb8IlBB2Qki9b
	2ZXs8OFPdH/RRtIXIC9t8cSdUVTcvC8SgVwMf6E/h4Kl+bKOL3hbNIeaEH7eVMfuftASWC5+cGy
	sl9wF1NJaPdkDn/ngl23A82kLZmDisiOO2AcASyBfv5XlXCEYiGS/L42Jl/c7NzlZ9UbLll3C0s
	Ttz7h6D7VwPF95SWSzi5k81mJ2DkJD+apdn02IKH5kmnkQacugwOMTs6PlJ7sc2bwMCTmvOixZj
	f8645kx3tiLPFn0f6X78T7HDfwcTg/nBHRKIoI+r2tgHBMrhFYIWKuL3qPZV1HbyyCvXPJtWvZ4
	Xj5Vh4sag6h3qNzelInIX/Hxk5ro3l2oDYWjD/B2kG/hlxvQ6a1xdxcA7m9Lm/FXqRuuXkl+eGI
	phWHC2UEfMfqzjRWR8FVPNeLYk647OTnOo=
X-Received: by 2002:a17:90b:5624:b0:39e:b7:cbef with SMTP id 98e67ed59e1d1-39e1e5612d3mr14829775a91.25.1789602475478;
        Wed, 16 Sep 2026 16:47:55 -0700 (PDT)
Received: from p1 (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d5d0f3sm9085370c88.12.2026.09.16.16.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:47:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:47:53 -0700
From: Xiang Mei <xmei5@asu.edu>
To: stable@vger.kernel.org
Cc: rafael@kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, bestswngs@gmail.com
Subject: [STABLE REQUEST] ACPICA: Fix NULL pointer dereference in
 acpi_ns_custom_package()
Message-ID: <ztqdpwmbpfusfens334indnsykgejamscwhv6dylk6xckr5uyg@scsb6egwneel>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable team,

Could you please consider backporting upstream commit

f8d14b7bb0063bbbd86c0e4d73edb8cea7b362bc
("ACPICA: Fix NULL pointer dereference in acpi_ns_custom_package()")

for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and 5.10.y.

It prevents a NULL pointer dereference when firmware supplies a _BIX
package containing an unresolvable first element.

The fix has been in mainline since May 27 but is still absent from the
longterm branches.

The upstream commit applies cleanly to all of these branches.

Thanks,
Xiang
