Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799245;
	b=nNdKZXHoE6WnFrKfAHtALe5iCLBjjinNDjO6G/eY2Bj2HqVswx3pcwqguQjIskmAA/yU
	 lCRmcHW5THfAvQvotaTGEiIfp1BWlVbUzjQxBj6NHGsHHPVJz+DMP/FBzpoIvFnDr1nTU
	 gB68Z3voMPgsRXsBWmcgkVmtQ8G/Fmy1JqYyu4CuVVwE1LMydRTnafsLvYPdpk/IXPnpS
	 SkCPqesXhw/wPOxx3qeWZgjotbv8C/4lou4F84MBx+r1LwyRsY2ZeO6m7/OSg1Mp/tXBa
	 x7adn55OfNSdQf9rx+Tm4Zshd3LQ5Mjne+MNhrsQ7MdRfpvsQH/QeQnReT0faThJT/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iIDdrX9Im0YtrcnZJ8KtkgD4n/tK93wVoTEyhvvYAHU=;
	b=qpWxWlQlp229YDtPWXl7w9NcvBKgUsEEEjFwESL2t/naXZILfJwGty3V7t03Tig22cWW
	 ZO/Q+gAnLlKZ7jnEuJRsf8Vsj4muzmpiXANjZ3TIMHbLyiQLDzDOxhCOBPo9tjJOIbYdf
	 DZD4ysqN/BrkZWf9ip/asQr4QFnlZRUQnFWUjhfL1+iFVXXg1dOByraAxxGbj+pNrxD+5
	 R51PRu59TyMMDHPDxoiyZGH+5LmA9T8i3r0bCUU8tfrcljSPQ8oUiNKU4gNMj8yZUanIH
	 alPv3xvCqG4BX/9Hs8eShaufG7bc/ofgFj6r64Qumvv5/Vvp9vGK/wEydCXgYfvLXHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QFkyAzjf;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407F606A32F
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 17:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B407F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QFkyAzjf
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55db674106fso33367791cf.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 09:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795799243; x=1796404043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iIDdrX9Im0YtrcnZJ8KtkgD4n/tK93wVoTEyhvvYAHU=;
        b=QFkyAzjfGTkujkaYy+JDa3LSyAfVjTh12u5C11SmWjH0HE945wYavEOgLQfAaHVC4J
         U0XeeI1KbknO8aUCOJoUDzQQxKxvvuUmvj7kjT8vq7EzmqZaFBS5clEcaHWrI5ZJB6Rw
         kD7MNTaQFLgSL1TOcZ+5fUGWCTAD2THyej9RaojqIEpOM80+oj9WRZ6KEQ6SYOL0EQ93
         Qic25BS5SoNXet+udcD1GcXsmdGfepiiN0uk63356vkoZ0snKTFc0EMP1tZOkES2Dpld
         reFIBvaWprmZl3ZS8TkCCUbKxcWk27JYUK9oWv8IQq06bow+029wYUueD5tKlHp7hy0p
         0hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795799243; x=1796404043;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIDdrX9Im0YtrcnZJ8KtkgD4n/tK93wVoTEyhvvYAHU=;
        b=zPFWzzg9haeL6i6G2pkp8XBHPP1393RAaPRGcyD0cp3BJcf5Ys+GxogJx8GPzCsak1
         V31vVCNQvQP2VP/r/RWIXIS8k9KAnC8TJUJp1vxlfQK3rn2osfia1V7Wc67z+IiIc/Kr
         2a5GLk49h1J5u0Ls2zLTEjtwOHzPaHMMkVRiMiks0dWi/qMBL0JFWJ996C6r3VzLBiVz
         yBL5RfSlO6YqpvOcgDOkb42WbHXtNXiLqYvxhapkKZEhyvi1tN52VOdOEX09SX2YCkyi
         2k4R20c9Z57epMwpG3gWYNmWCvF3DKZdtkwugty57sZUT1i+1qq1QOmBLX9/BdhQlZ4l
         hQmA==
X-Forwarded-Encrypted: i=1; AL+hErFXkAPrE/vamQyt7BuO0tkaGmjnOP0Pfab+4FSxp7dYV4KZHIdKOSwk7+ScWJgK7BwDwdKAqr6M4uk+@vger.kernel.org
X-Gm-Message-State: APuU4Z8zVWlUEth33najMvb+lx+RIHKz6PhUozQejv/ErnjvP8mrTsHs
	AJuOczcG3LdaxDdl2YAAUt5lTh5e/yzit4wySGnoDWIXGZX3n0gH9WEuWrV+TMO4FzI=
X-Gm-Gg: AZFdTZevcUYRcugtAPGvK8QS+Y0HIXD1QMazUMIomEyOI9Q6VEBS0ERy2H2vyvi/ioJ
	WlbGrdo6TNqD/ZD0e7mCvAgTzmu1MqJcxifuQYv0BD87p0Rg0WlzQNJrlV1b0ygDoGJXjUko5Ao
	QUnzXXl1MY99Y7wwd2yQyLgTuDHopoaK3Co+HSMCZ/Q1cuLsNl5pPVRKikDtJmeuQyEjy/40TqO
	5nExComBylOY7pp8i441x55oKBG1JPORi7h+gSl4faLWuLYEsGnJOh2T7TPGm0W9F8yIpNjxEqK
	jvpPuL5/KNMaB2KHCoaBuoXPPUkJMpjdeknb2ztnx8ySDzMvLNZIh3sEdpdsfmvlVd1QsRP5AfX
	v8OMHOXqxWOl0v4H9l1Gecn7+3ozGvFCC5UGZtGJU08SGqgr7tYhazQcAZSJM08hScOT81FYEv9
	5VyN18741PhI1C7UEV+I83Ld1IxSZbiSz+MRH2LrT9T8tN1caA6a5n7nfznh8J2kq0GZwMypyaV
	PWubQYkEeBv5/xwGpjCZJtymemqGaqKtVlUgCO7gCwccGjIv9q52PCIC6oCTHiVwWVpu/3Evpyt
	LLFTUA==
X-Received: by 2002:a05:622a:400d:b0:536:7f96:915c with SMTP id d75a77b69052e-55d6fbfc5f7mr441942441cf.5.1795799243423;
        Fri, 27 Nov 2026 09:07:23 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e32dsm214830511cf.13.2026.11.27.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:07:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWzPu-000000079Rg-05Sr;
	Fri, 27 Nov 2026 13:07:22 -0400
Date: Fri, 27 Nov 2026 13:07:22 -0400
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
Message-ID: <20261127170722.GT246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
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
In-Reply-To: <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>

On Fri, Nov 27, 2026 at 03:33:02PM +0000, Yeoreum Yun wrote:
> Introduce CCA Realm Guest attestation provider for retrieving:
> 
>   - RIM, REM0-REM3 measurement registers.
>   - CCA attestation token
>   - CCEL event log
> 
> used for CCA Realm Guest attestation.

This is great to see positive proof that the API fits CCA!

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/attestation/Kconfig               |  10 +
>  drivers/attestation/Makefile              |   5 +
>  drivers/attestation/providers/cca_guest.c | 582 ++++++++++++++++++++++++++++++
>  3 files changed, 597 insertions(+)

But we need to do alot more work on this to make the drivers slimmer.

First, we need to pull drivers/virt/coco/arm-cca-guest/main.c which is
the evidence part of this driver into drivers/attestation and build
the MR stuff on top of that.

Second, things like CCEL need to be handled by core code. The driver
should only indicate it "claims" the CCEL if the core code happens to
find one. TDX and ARM shouldn't have any direct CCEL stuff beyond
that.

Similarly the TCG log should work the same way.

I'm also wondering if too much code is leaking into to drivers to
implement the uAPI. We should take a look at this vs the TDX one and
make sure we have the right level of helpers and abstraction.

I also can't help but notice there isn't a single comment in any of
this, it should be a bit more descriptive why some of these things are
in here.

> +static enum hash_algo cca_guest_attestation_algorithms[] = {
> +	HASH_ALGO_SHA512,
> +};

static const

> +
> +static const struct attestation_mr_props cca_guest_attestation_mrs[] = {
> +	{
> +		.id = 0,
> +		.name = "rim",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +	},
> +	{
> +		.id = 1,
> +		.name = "rem0",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +		.has_register_index = true,
> +		.register_index = 0,
> +		.extendable = true,
> +	},
> +	{
> +		.id = 2,
> +		.name = "rem1",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +		.has_register_index = true,
> +		.register_index = 1,
> +		.extendable = true,
> +	},
> +	{
> +		.id = 3,
> +		.name = "rem2",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +		.has_register_index = true,
> +		.register_index = 2,
> +		.extendable = true,
> +	},
> +	{
> +		.id = 4,
> +		.name = "rem3",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +		.has_register_index = true,
> +		.register_index = 3,
> +		.extendable = true,
> +	},
> +};

Jiri this probably isn't going to scale when we get to 32 PCRs on a
TPM.

> +
> +static const struct attestation_evidence_format cca_attestation_token_formats[] = {
> +	{ .vendor = true, .value = CTLV_ATTESTATION_CCA_GUEST_EVIDENCE_VENDOR_FORMAT_CCA_ATTESTATION_TOKEN },
> +};

should be the generic EAT token type

> +
> +static const struct attestation_evidence_format cca_guest_attestation_log_formats[] = {
> +	{ .value = CTLV_ATTESTATION_EVIDENCE_FORMAT_CCEL },
> +};
> +
> +static const struct attestation_evidence_challenge_length
> +cca_guest_attestation_challenge_lengths[] = {
> +	{ .min = RSI_ATTEST_CHALLENGE_MIN_SIZE, .max = RSI_ATTEST_CHALLENGE_MAX_SIZE },
> +};
> +
> +static struct attestation_evidence_supported_object
> +cca_guest_attestation_evidence_objects[] = {
> +	{
> +		.evidence_class = ATTESTATION_EVIDENCE_SIGNED,
> +		.formats = cca_attestation_token_formats,
> +		.formats_count = ARRAY_SIZE(cca_attestation_token_formats),
> +		.challenge_lengths = cca_guest_attestation_challenge_lengths,
> +		.challenge_lengths_count =
> +			ARRAY_SIZE(cca_guest_attestation_challenge_lengths),
> +		.max_length = 0,
> +		.binds_mrs = true,
> +	},
> +#ifdef CONFIG_ACPI
> +	{
> +		.evidence_class = ATTESTATION_EVIDENCE_EVENT_LOG,
> +		.formats = cca_guest_attestation_log_formats,
> +		.formats_count = ARRAY_SIZE(cca_guest_attestation_log_formats),
> +		.max_length = 0,
> +	},
> +#endif

Jiri, same scaling issue, CCEL should be handled by core code so it
needs to be inserted dynamically into the evidence list.

> +static long cca_guest_get_max_token_size(void)
> +{
> +	u8 dummy[RSI_ATTEST_CHALLENGE_MAX_SIZE] = { 0x00, };
> +
> +	return rsi_attestation_token_init(dummy, RSI_ATTEST_CHALLENGE_MAX_SIZE);
> +}
> +
> +static int cca_guest_get_attest_tokens(const struct cca_guest_attestation *cca_guest_att,
> +				       const void *challenge, size_t challenge_size,
> +				       u8 *token, size_t *token_size)
> +{
> +	int ret;
> +	long max_token_size;
> +	void *buf;
> +	unsigned long granule, offset, len, rsi_ret;
> +
> +	guard(migrate)();
> +
> +	max_token_size = rsi_attestation_token_init(challenge, challenge_size);
> +	if (max_token_size <= 0)
> +		return -EINVAL;
> +
> +	if (max_token_size != cca_guest_att->max_token_size)
> +		return -ESTALE;

What is this and the related work? That isn't making sense to
me. If the token size is not absolutely fixed when the driver starts
then it should be fully dynamic and this just streams the variable
sized token.

Ideally directly into user memory so we don't need to allocate a kvmalloc.

> +static int
> +cca_guest_attestation_evidence_get(struct attestation_dev *att,
> +				   const struct attestation_evidence_request *request,
> +				   struct attestation_evidence_result *result)
> +{
> +	struct cca_guest_attestation *cca_guest_att = to_cca_guest_attestation(att);
> +	size_t i, length;
> +	void *buffer;
> +	int ret = 0, ccel_obj_idx;
> +
> +	ccel_obj_idx = cca_guest_att->ccel_obj_idx;
> +
> +	for (i = 0; !ret && i < request->objects_count; i++) {
> +		const struct attestation_evidence_object_request *object =
> +			&request->objects[i];
> +		struct attestation_evidence_object_result *produced =
> +			&result->objects[i];

I feel like the core code should be doing more of this for the
drivers... Drivers should have an op to return a single evidence, for
an ID that they control. ie the core code should be returning the CCEL
for its id, and when we get to SPDM other common code will handle ids
too.

Maybe the evidence itself needs an ops?

> +static const struct arm_smccc_device_id cca_guest_attest_id_table[] = {
> +	{ .func_id = SMC_RSI_ABI_VERSION, },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(arm_smccc, cca_guest_attest_id_table);

This isn't OK.. We only get one struct device per RSI and it gets to
bind to only one driver. Given there are other drivers that will need
to use the RSI, like the TSM and others, this needs some other
solution?

Jason
