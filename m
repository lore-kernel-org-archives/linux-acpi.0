Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807105;
	b=vVokkQvdX0ejIjDzdwUVjk1YQuL7VLk9ZD8+wXBbYmqKHfvMZkBM4xerOH5Z4uoCIwL6
	 dkvMJenaxOnaHdvqo9hHEhOhEjYEAEZrjzOiUJVZGAEbW65BS3y/UD7/Zg0Y7hK0p+M1Z
	 jJvQGtabaMN6Q8hrGGkIFs7pGgGVC6kpfyPxQYFwrWxZ6WXACNe0F77wLBsDpQkIc8hVw
	 j1uti4GfhkJiJ6SDR20ebHTn8og7mOxDQytHYf51UY3lsWjEZi1xoOf0LkYOs1RMdQm5f
	 V1FwfzdsKLu/jcQTH2L/8rSqITrN5dPJ8A8UpeJC+OfENtLGz8cz9+1vWRJe4gNXmKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
	b=c/o1tfO1Ar/wKlBIO/JfqsVAZvx/03wCjHxx69VOhEpemYoGJph0TpZQfMW7KMSL7wtM
	 RVOxzc1ZQJBzhsvYRLlnt5Y9ViOjgqeXySv/o/vUvIsM9VDoZls3da85tUKwFHbbxmag/
	 eJfr9gvP9kN7a3gSzPh2YwYdK1s8zcyYdKQEAWfrmwAoEei2RucvFG65W7al46FOwBtos
	 mm9TuKJuRSBGnV+SAEXvzoxMi8bZzsVM56qDNDgl5QTdnJqbvwNSfUO5DkAupoJkkH6j3
	 js6Tz6a5aLZlUefmtd4E4zEaCigGBuW3dXC0vSyBXeUP4bd6/TExQvMJjovhoRPhSjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Au2hPQjf;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B8606A323
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 19:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC5B8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Au2hPQjf
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-94961d90b79so851100485a.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795807104; x=1796411904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
        b=Au2hPQjfRRLKqpzLdUlS4qTuMZfutWDMs3nxeZ6kBFtz5N2Xk2LtgNA1S5U0oOtM1F
         pUH04r+cU6kZ0kDgUOxrstM7z2Im5gAyxPSe4aD83cFjmAwAj+Fkxac12C/8nN6ofeLR
         MFElkoYfleQYMRT7phF4+sDQ9A/GDPgp08AagWSlO9SiwrCyijC940FqmwCDAQns8SPF
         vr8fSP2KNc3B6d+8S0JwcH7uT18lonZeGkS87z1MJOqJgxKlovDuQgZgrTINI217fher
         UuRXmrGlqd2cTXfhETi+BHgGNRW6PAqgPj4iVvWnFYjeFdjgAOpMLRYBPKKqoDP1GfuD
         ymIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795807104; x=1796411904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
        b=f9FDqE+ryyTFGEaTAiFy6xVIdA/Cp+hpafGJzrP9gEGk7k/lLD3BphuUgfYvYHmqkc
         W7Uzet3o6m18/MDa42fujKSzTDQJ+v1hfEqkEswuDtARlsxKKkzqpYsA15BGEK3P3iP4
         NxvHsCKneuKuoa9/UyoAXKGkRz6u9ILXWKAQg5ZpQ58WXeZucjcQlOpbOCVqQHRYIqYo
         PCzDfkcyNwjrh2pG2rThMKjUdp6YJJIHga8cs5jUbR8BMLS24XVrjtz+fKqm3i9T8BlO
         AixGE45oSx/bzvNUa0X9wNXo/bsoGK80vDgxXR+vBS4kbfT8odON+WAGDZ3fnnwe+cMQ
         MJng==
X-Forwarded-Encrypted: i=1; AL+hErEDcmlQ2LaqVeQIqz+xSJbC4jtpVpC4ZTjV2gLLem7WUxbpZTgkgIpRzbBwp1nT+sPrJ8MXZXI5C5R8@vger.kernel.org
X-Gm-Message-State: APuU4Z/9iivA8E1VeSSI9CzrlxcG9n5UVBimtcDcqaemVcwltcZ/VpKc
	qYewN9iub5rraSeMWXwbY9Wf0Z4bsKfI+HzuPD/T8fcfvAeTlwwgbgJXQ2HlX1fKJUc=
X-Gm-Gg: AZFdTZfuKC+YU82cb3O8NZ8jKEE4vuxpdcyaT+TI4tnCN016iSI6Fe54qLMPsj5RMRC
	7JgEAnexWZB1RlZuVs3wXvAnFwAcrnY6a2C4MxvA3CCWhZGApeDSdFBUNw4GQOp8INFsm+4Six3
	fLkrD7H3v32GAAsx3U/QxzwIWeBOSlX4JSQLk4s8H0SMUgh3sOfL6BjTJqu5S+BiNEPxQrYeGGj
	pSiDXaK4OlJW+gWU3SH86aXCWvNxq7cCK9XLEsuRGBzKC9AeOaboMr+W0MSoVQKnBFbT7zdjnDf
	JrK4NUBwd/Waqik+uiROWrunQ4X/CpcejFO/AZJHdF57k2ZM6gon2X9HnE8zwsA+X3RstGqQKFQ
	hqjZQv2taLWxHXu5tM1DSvQ9x9adpnZpYo4H6kDN9ejJ1+RMsZ1hlm8HDufzG1n1ACIUUz4Dx/I
	juktMQvnpnmcJyJWRdFx9bJj8BMPT7sDOGJQ+f3CLvUmeeBVlYuJUrLElOzWDvivGZ2G1SxAGzc
	qwDEPPchvxEliimpHUAHZ4U1S38hAsFI3vZgbFzIDzD2ewtc9QQkqRJ1Jl83sojs0Z6Zei0bCMO
	tdHDoQ==
X-Received: by 2002:a05:620a:6f0d:b0:939:6dea:374d with SMTP id af79cd13be357-949ba9d1fa6mr4395559985a.49.1795807103939;
        Fri, 27 Nov 2026 11:18:23 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb418241sm1867466985a.38.2026.11.27.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:18:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xX1Sg-00000007nGK-3YSV;
	Fri, 27 Nov 2026 15:18:22 -0400
Date: Fri, 27 Nov 2026 15:18:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <20261127191822.GA1856591@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnK2c3kMq8p2a_7@e129823.arm.com>
 <20261127183550.GV246011@ziepe.ca>
 <awnV5S703Rgf5sh5@e129823.arm.com>
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
In-Reply-To: <awnV5S703Rgf5sh5@e129823.arm.com>

On Fri, Nov 27, 2026 at 07:11:33PM +0000, Yeoreum Yun wrote:
> I think the problem is the *max-token-size* could be changed.
> once the LFA updates the Realm definitely the contents of hash of
> firmware binary can be changed. this means the token's content could be
> change including the *max-token-size*.

I think that is broken, there is no good way to make that work in a
sane manner.

LFA must stay under the hard wired max-token-size limit, not try to
change it while a realm is running. Take this to your spec team.

> For this, the RSI host call interface has the way to get LFA eventlog.
> IOW, after LFA, there will be LFA log is genreated and then for the
> time of re-attestation, it should deliver the LFA logs together.

The detached event log is even more reason the token should not ever
be changed by a LFA.

> > I saw in your FIRME series a solution to this problem, I think that
> > would be good to get out on its own and apply it first to RSI as
> > well. We will have the core RSI stuff, the realm attestation and TSM
> > driver at a minimum..
> 
> Hm,, Does this mean do we need to create two device one for TSM and
> one for attestation even the functionality same?

They won't have the same functionality. It will be the same as you had
with FIRME where there is a driver doing CPU attestation and another
one (the TSM driver actually) doing link IDE.

Jason
