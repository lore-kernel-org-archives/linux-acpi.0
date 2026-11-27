Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799343;
	b=YzL8LaD2Qgra5PNeLD/71teD0wbnUbF6T7LIdqdWvA2vbfFZo4zFNn/b0LPQlXQH1XGp
	 acuF3FE12l9AzxCYOB/tVXmNnJ0N0SJoZF1MpFZLl5IBta4pjiqSY5VfwVIA2xKbbzAl7
	 dl4Gr7GRYgQ641KKVZMzIRxX2RQZoWW4lW1DvT0/2+CeANFKbdSz+fCHAnywUTNwiUDkV
	 x516Cdt15tXquLbDB/+N/VPSBrYJhthD9CrnT311eGswvnBu5gF/fKi137lfvTxkv5nbu
	 BKQcyucuHkFSS2rk7we4LY6j+kzV+hz/wV6pJvRqp6TqIr6JcBqNgCcNBDhDPZb9qXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
	b=gbc8FGIVCVuy6U5TgQGZWsOrZVxSLGsGdevd4kFle0MVjFLcxZYdyFzzyM8lcZhWwq8C
	 vEZm1HTTRK/w0Knw4H4S4F8Q+HUL8M/SD9Msx58vufF47q5XrhMmM/hjbZVyoMhEMo5Z0
	 WUVX2xKIw9x09GUuqiyr7amlCkxvEF85iyWd8kOGVQiuFuqbUDqiBtwz9Jwe307rMxF78
	 Q+p6CYaVX/ydShsbi9t0C6p/3QpAIflZXzx/sq9zfZ13vnpfIqB9j2UbUfKvr5BPKqcFp
	 ZbPyRjVbzoyJFStHZuunQX7aHlws7RqmEhgGImt2ZcY8h32GuYzfbYGcGVCNvi7YiXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NpcMn18Z;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F23606A32C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 17:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F23606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NpcMn18Z
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-94961ed97bcso821423085a.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795799341; x=1796404141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
        b=NpcMn18ZOcBUH/K57xXEmosR6TjqGtaHb4iOQyIq0GgNDqO6dAa3ahAGzdoMm6DK/R
         3dkns94RmQsNEaf/27kIYiOKFNzoSKhIXNccUkBguWLK26AIyGo+A089UsFFPfbNz3JT
         fRNukHbF1g5uEH+w2aeet1LpRPQxG0BgLshkGNvKg+X6WFsNVdvtlTlH7jbh0mMU3AE+
         droQd+7Wzvs1ZZv0Bm+V2UKWtzqHa4QvPeJsxPzSnXUzGeAIakkUFw1mjKjdYkbgy2S8
         Y9PJhCrLM+XiW39othsK/ZS90eIpfnqQ3cGzLWFY0EcectQslbi4vHXfem+Makltaxhy
         GuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795799341; x=1796404141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HB0ZTSdDDmOkIsTidMqTBiLshJg4ThGdlzLSWF0DBNU=;
        b=dvstTRUYvLnUx/Pjtf5mOibFSzZSgJUza719XF8/jvSZzRtkeHu52YgpYn4g517osL
         UZi0Pq9GSO9Q8JA+W+EvA2SlWUYU/01CR4M+l66ObcZZekoWpjQ99oytbqiLr9K9YDJ4
         r4yFiu35lCmMNk5569TEbv0WYTZdxaTgJpGHTvuqI99VVX9ky20WyrDnubvpqtrXA7AB
         Z9PiPivhPai5pnfqCFaRvePvLeDY0jddRqqSCSXVJuhozgb9qXW4XR8ifu/B/vHbS30w
         Pdmkuc2606VBLIB4HcLeWy/6T3iRQJZQ5ZQn+L3Obq+nOkZdq26Gu6SeVoAB9DkMfveL
         /qDQ==
X-Forwarded-Encrypted: i=1; AL+hErGTHtRxWo73mM9isG2Lz0Is2rE1AXVYKEyNmNg+Kdy82eqo5vfyMgFzf3a1sfHV4f/NG5V3T/P8EdxF@vger.kernel.org
X-Gm-Message-State: APuU4Z/guLU2TXWBd7TGl7Zjfe8pe5JZAhUiCID4PV/wS7AuyFnuCRee
	JR1f2d2l0gVOxKT0wlo3rfBll/pNBxQ2M7Iz7j8G5CWDz0qxrf1+jh+L5U7zF+BzF2o=
X-Gm-Gg: AZFdTZf9S86opB344KHRFqiKdoF+sU80gRaJAOMg8rPKgnqjVSIESgeRHGEusajp3ZG
	W5Yq03awVPqkgbXljfhdUl82uapeBUjuP/LHdeuAcmz7HZIGDKNyOjXgPEsacv3LgtPvmq4hPEw
	f1nt4w3L0Br85sQZZD4u79GkoO/yUkdzI4mSxDSMg+GiNITF5pNe8UX1s+gvPDOWLmPZvmsDXPS
	+JQCJ4ozMlUPnAZDsjp49sd1JVKgJkc6MeMyM51Q3b5I1HQ0ifGDIgdNuNciWs98g+X84o81zAM
	zjSLQ1YxNuEZJhByTkIn+QC2YHKonwgmI595l51PGxTecbWbyt4xsdJUn13rcFsAS+dVYy3pWk+
	NLDvcsyrPy/1Oq5kfK7sonqn5cfHNzskdl3smxOQefdJWNiR5lGDG7SDy3bz4JvzomJEhlx2z/2
	tSz+C5Imm1cwm71KYjYkjXwj3pUh9amNf6VJqqGPZxyILEHtRO5YT46EWc6eSM2WlgrmPldn+tw
	o7q0an8JK+55b00jbEbERZZHI7Fii6udOtRmIci/sUHih4HESb2red2ujESns1eSw70nLMhk0my
	1VJ6yA==
X-Received: by 2002:a05:620a:7206:b0:94a:889:5a33 with SMTP id af79cd13be357-94a08896165mr1311739085a.30.1795799341642;
        Fri, 27 Nov 2026 09:09:01 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41a341sm1875035285a.37.2026.11.27.09.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:09:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWzRU-000000079ec-2Xcr;
	Fri, 27 Nov 2026 13:09:00 -0400
Date: Fri, 27 Nov 2026 13:09:00 -0400
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
Subject: Re: [PATCH RFC v3 8/8] selftest: attestation: add
 cca_guest_attestation_test selftest
Message-ID: <20261127170900.GU246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-8-df3230afce8f@arm.com>
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
In-Reply-To: <20261127-arm_cca_mr-v3-8-df3230afce8f@arm.com>

On Fri, Nov 27, 2026 at 03:33:03PM +0000, Yeoreum Yun wrote:
> Add CCA Realm Guest attestation selftest to test evidence-get, mr_read
> and mr_extend interfaces.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  tools/testing/selftests/attestation/.gitignore     |   1 +
>  tools/testing/selftests/attestation/Makefile       |   9 +-
>  .../attestation/cca_guest_attestation_test.c       | 517 +++++++++++++++++++++
>  3 files changed, 524 insertions(+), 3 deletions(-)

FWIW, I really want to have an attestation userspace project and there
is where stuff like this should end up living..

We haven't got to launching a github for it yet, but that's the plan
anyhow.

Jason
