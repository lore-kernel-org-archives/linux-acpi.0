Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333155;
	b=n/7hxH+YwEsQMdunNf6+toqw7LzT4N4GwTVIb3FjYjqNWRIptgWLuNMYQ1bt8kipBmli
	 DR3f65SLHXRhhYTX4MbuYn1aub82Yw5cwBMB2TJWi4NHNQbjph9SaVLb+jnqV7JeeaB/A
	 aPtne6/7iU5EvsZQA8SylixHAiyVXk74oLw5TCpfjzus1jSvm2Ew7edpuoe8LIm4jhHDf
	 jqDhqkElUXOxmOnxvg3d3VC2raMY2FSXqR7KmwRBIJ0iSD1ArSD8bYn6/lQln8x51yqPy
	 k4rP1RGp8Q2ubS3Z23KUsj/Znh/HymbBd83MkhLQMvcKFjdOcAg98GXyCpZprt6BhKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
	b=YLGMxJb6Hssb9HXaW+mAVSw+d3zbSURnEDgNjUaQalBc6dXP/NwUaRfeEMZe1k4HmCHO
	 wk5ZqtF1t44gRceeXgDXnq1O7F1Bq78z5fDkm2+E7ydUrYVYowBwxc6X5DDqgPYy3Xu7a
	 NoK7//f4u5w1BR4X+4mZqsKOHnnBpO/dN+BrUHxeqPnS/7g/cYulhhJke7i2IBxGS5ADp
	 C5oje0wVjVzAmXaiCKjCojCQdqNlE5CnV6JeXxRDGkIrz0z9PeEZrYS6nHY6dby/486Fs
	 6/9PI8e2dM9FwL2HPAZlMIzJ8C5wxNLGhRRj44CGB4Ro7SLJ7mcNpnqp/5uoFFdJVYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="cZUI88/L";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D067606A31C
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 04:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D067606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cZUI88/L
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3514b90bb89so632134eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333154; x=1793937954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=cZUI88/L9F1F6vaHkoJiPubaFvpBx9ZOZoFIH4WzYEl9uT8+1501kBXRQ+iQnW1rG/
         4Fw7u6pK2bhGr83aiABmILWeko3myUezgpD4yxFu1q8ofu7DAw3nd3xwaeMW+dOR7WjW
         fF2I6XSi4uBYslctXHDwkVQCwzAYXH2+VEB4ld4ijUFXCUVYiKPoDWGSOArpmY2b6MgQ
         9ZvnqUJjjMcJdZxPtAbFTkDp6O48lwLVb7JSCvyQcehPpzJbJ6jeHUnZCR3iOiOfxhs1
         cwBXgsfbLoMorO9ZFOLAr33BI+k9rnycgZilL+r2ECnd+fRbSczk3whlomOJkp24wZFS
         GQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333154; x=1793937954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CvywPHpjrCT0zo2JhnH11M0JaZbySgNZTi9n8+NQFc=;
        b=cRUNi+QWG365gkGVQyFXRSFGV8OztaSemTL9A5zQiNoZn8VBcLc3vL8uGbexIkTpQS
         wyV0oD9moo0bon8oIqCNeZxGEk/DZOSN3WtyFRkkmkyGHzwa2aW8yFHLQPwNt5fxiS4W
         S4hHWHquNZQOdm9+9iGldmwPJUbk7tyxHJoKpzdrgMf9o/vH6HV/PJsjXxrG0KtAPCO6
         n5Jy94a8YoN7x6+exyXKktB0QrQgrjH0dZsHtWYwvyPX7hjUXExH1inwXKkvX0xaKZ8K
         eMjIj69rDrddO8bhsN2X7c9qn7NsenM6XZmqTwr1UnHnz/IFYoWgj6gYEl7BCOElBmQD
         p2kQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4PwA7RcDPYsL6eFQI8bs3YEu2lCUMQbgSLq+8TabmIcrdHbxagqmcjHaOCT/sjQrCgijMkhxLWBPW@vger.kernel.org
X-Gm-Message-State: AFq9FYJKISi10ssq1019gsQPF9mNtKoU0hcWxik7LfEQk+K1/NRQ/CyW
	0uEiIz4KKkRpW5hHpqehqCgdsV3tG+pYYgnyUnzWBNU8ndfe3dh4B/FVTesihls1A3w=
X-Gm-Gg: AYBFou0GY8UxEbCbObNDVjlOsE2AnCWANLqQPqWis5G0fxerSLikN8JI7OmGtrR8u4c
	D/BwWoKrKYT3vvGX+RIirIO7vBtxt1rQ3sAjhT9+aIa54MNwtIcu1BPBksxXIZST2Zjm9MqV30l
	o4Sksb2pI3bsvyY2HcS6NudD2Bnxo2+iRkQ2V6CYrtXVjOjrYhVtKsYCNQw7HP3zAw6PhIW+RD+
	LnpSElfGDa0E84tEjw9k9X0TaPeigB73DQvzqwdPNIpc4BgVgFPLnJlC4lOa+loPjKxEzcw3IKe
	C7+DIRf+IVcX2TtQ31Ref5vcb6IE3Ub4eM9hy3McqgN05AS+cPMUqBYfAtwH858GwYeX3ok7yz3
	jj23tB7JzxVQHaoAxpZiy8KqJEC4X7vB5IaqO3mTFaXIklfOjMH+tqlyCSJFH58br+bqUUq0Bc5
	lFCeuh9OQVUsjjQndbJF64DoflGeO1zapzwcIIsP879bgWD+4/f7fGjvxLVAgW+5UI7VBw35JGO
	M6npBFDOeegwWZTcYSyNmO0wrEOCoHwaxdAZGYQWNYM3sWqNFG0ewwh0zeYU0d1Lm/A+2KgVKPn
	yn6RHFiV6U6mtJ5kU8ReMbtJp7703r8=
X-Received: by 2002:a05:7301:53cb:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-36a423ea99dmr1772736eec.24.1793333153319;
        Thu, 29 Oct 2026 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm3512579eec.15.2026.10.29.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:05:52 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:35:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
Message-ID: <auQXnep2xKpuNJOF@vireshk-B250M-D3H>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
 <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
 <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>

On 28-10-26, 16:39, Rafael J. Wysocki (Intel) wrote:
> I'd expect the driver core to pick up the series as a whole then, so
> please feel free to add
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
