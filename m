Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746520;
	b=Ulwxv2lPtedGw7qqpSZubuWCTjrretoiIX+a6nqD5x8oOVQgVcmDMJ6jGECb9x4QIzcc
	 mPfpZ2oUCFgy6gbbux4XyXCs7iilBfhsJsdeFjVz2aDL+J4kLsmVxQBJcuiod5LpkdBWv
	 LJoarabjYfjjoMgg8cU5L/WYMCihxyd50rupvFiyUt5Jb5ceh75AxqfBpwzzBDqyGlAaS
	 aqHPI5urJGYpTLkKyX7Szy4PLtQAIzv4Dcj8VL82y/f+DpDsHxUQKs5i45bv1U1CRwFW1
	 LqEjrXUn0X8jxLwJ23E7/0u0iFKrH4n24Cy5oGaKslorEb/DmoOsQC3mrD7dGIMCFaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746520;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5vu540DCAHNR7Dg2bFFUUYAP8YFFyB1ksBLxdAK3dqI=;
	b=jpH+JBOoEfxRnXjfqP4Atgo3gXlvpDTOkHn+UoEMTDvhCs+YRzDHaYd4HYnPYgrzXW+j
	 zkJ+m06IJGVqCMCtPWisTc8RrJVUr0GARugAh5oYMYbN72mbhN/Qy2UMT4eswX7ScwQlh
	 TQgqWFP3OzJZC2gK18igHkxl4uKkMgvNqVMlYrQcMypR1fnbQ8vNQNgtyHW/wC19FPJ4H
	 SRLUMzBopdGdry4abcfzX05t4XR55OqQg38oyjd7KHjj7mFT1xHrbcj1vj45d1NSl1yFn
	 GcwjSymfA5kdg9hl1jzxwcJ6qks+Qb1NnniFfYlaT1UnVVH0Xp2ZqoRauKMWoM5wbhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jLp0siYs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RxnLeXki;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50735606A31B
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 22:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50735606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jLp0siYs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RxnLeXki
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LKsZ2415299
	for <linux-acpi@vger.kernel.org>; Tue, 3 Nov 2026 22:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5vu540DCAHNR7Dg2bFFUUYAP8YFFyB1ksBLxdAK3dqI=; b=jLp0siYs24jiykur
	zxQzv9pTq9ogkUhtCM8SbZyUdidoHRVVOVuj+RwHCteLXOlAd5VrWyRVPCCnfziZ
	XwchQce1ZXTKtV8FwllfjLfoPYdNQAKEXqR4PdSN4tk6rmDJlm5fvzA21hDB8Z0B
	gvXVeviawB108z+4JG4gPvvBNF/bUD/xKvnvlpWkgADPlmQk9zZWyUE3inaf04TF
	S6pnnxJqwk7Jy1rQpYegPXHt+SSUFYi32vaHCunSIkoYG1J6PhvDMuY1IGuAK8xo
	egMBeVlWtnfbZpT4Y2UCyYl3hhMVEOeZUKmOkZQ+WjmuU8parznvB9+SygC4jP3y
	PzCnYQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqkgp9e85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 03 Nov 2026 22:55:18 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-82274137201so146107a34.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Nov 2026 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793746518; x=1794351318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5vu540DCAHNR7Dg2bFFUUYAP8YFFyB1ksBLxdAK3dqI=;
        b=RxnLeXkiJoql7E08VjYf+Zy2RgZCdX5a4xNt4vp4ItVAkkZfFbQTJu6VW8i4K+1rFf
         vF8HXiMudLwRyjB8wuBNpg46wwEUgQmk/kz3PcwjWf1odLafSIneLsmdtlYgCKFKnPki
         tslHs+OOvaLP+YrRgQ4klMk+8RGykidRVgMWRZVYuJEyykDrjwrzmxxj0mWyCMnyh38j
         7K+LkzZQHR6PxvTKC9dQvVYctM3YohFxmQD3kZ2SsvqK5hTVFLKt7jQJ9BLD6k+Ww2E2
         fgbAdGzUeW06mYDWHChzsrglDDCoKmDhsARKqQ/qXm8DGE78CX32n1dUVzIIUumizeOm
         aHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746518; x=1794351318;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vu540DCAHNR7Dg2bFFUUYAP8YFFyB1ksBLxdAK3dqI=;
        b=SScd7KiShaeIcd7LLn4d/YZsP5tXuC69ROoNh3d8pxGy0PZPlvQdt46SPfJC9/tNnY
         wIe6wP7rGZ0//870TVEgQJJFqAdcJZzs9akqfYZvxxV/IlaKUYSCu0YwUFLkUcDBqqLs
         RRiSTUwO4+a7LvqCzmBhEq587TlAMhaIm/Fl5IeYLkdhlLFMFXCitJ1/X8mbiOrn3mfa
         97pCeZrJqdEREG5f6cQPUFW0chZGSBU7XCllyPxqgW2TEHnHKCWgR+AeMzGCZedQATuR
         7o4mX9lSCbg4wKMWm4MnP7thyVOaS5XMtQk369dnBynXj0hPHFzyJ6JNhpFNJ3hzjD6P
         /4OA==
X-Gm-Message-State: APuU4Z83t5AnrFIzyFS/7+nJIctV6dtpNMEK/qKdmnIzIKdSy6GrM/oo
	g5H96ucmzzhjexrx7JdzLE6FqgbmGBZ6J/BKy8rhemLF3ddAya9bXutZKhvSBY5Ip3Jgrbud5rc
	xVNUA387yOaJ/lmID0RGWsmLDOxvDR6p80cxmW4nT4RYeF439sMc/RkahCygJjGv6
X-Gm-Gg: AYBFou0oD1m7ut1lhQ6sz0PZxal0YfliswTw98Ev6VK1U29oArmRcOhUgo8uTRLKVu1
	RhzQ1obwDeoN+7YCS4visi4oZYsQ1hEHNNml+yARk7lzKaf/Met1u8k9zpUN9JPy8gAogCDdjxU
	+GUPCGaBXtMGJoVHFOFbmczJjIj2HgBBY7ON2u8mPHzWQcImFQxdPvh6wd3bFyGOGuObLbBwX4D
	zVWwg3x6BmIerQ4+9g5osVGKUNaERqBKz3TkmdornKId2Hao+/8AiI0j/IM6J1oQcctnGQTAkSW
	1NMAs54WgHlHcrZD0SM9D3QGpFdTPF2T5VzgU/vWFwVSoLL0ztmtm2FU0Q7kfq7CrNuX0Z0792m
	8oQ6FhHSXA9UpF5O7PkUdJrPJfwOtL9fDPynVQTlmn8hAP8pwcmFKK8ktZ82XpW3HZCeXDmpvKM
	zG9FDOVzi8A+jN63BWhHLfUtJ3ZQ==
X-Received: by 2002:a05:6830:680b:b0:822:e9bf:6445 with SMTP id 46e09a7af769-85d364b9a22mr11312086a34.9.1793746518253;
        Tue, 03 Nov 2026 14:55:18 -0800 (PST)
X-Received: by 2002:a05:6830:680b:b0:822:e9bf:6445 with SMTP id 46e09a7af769-85d364b9a22mr11312074a34.9.1793746517810;
        Tue, 03 Nov 2026 14:55:17 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e170absm449988a34.15.2026.11.03.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:55:16 -0800 (PST)
Date: Tue, 3 Nov 2026 14:53:35 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jamie
 Nguyen <jamien@nvidia.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dat Mach
 <dmach@nvidia.com>
Subject: Re: [PATCH 2/2] ACPI: FFH: Support FF-A direct request 2 calls
Message-ID: <20261103145335.000026ea@oss.qualcomm.com>
In-Reply-To: <20261103173907.1996118-3-sudeep.holla@kernel.org>
References: <20261103173907.1996118-1-sudeep.holla@kernel.org>
	<20261103173907.1996118-3-sudeep.holla@kernel.org>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MSBTYWx0ZWRfX9dcB4vlJTK+/
 Xh7MuCKBQO6HSl8XuqzpuY2mlLWM8d2iYQ5Fid2zySZlL4jQjJT/1RPJD8LsUrqsLFvqNqQv0zg
 wHdzLuEbq4ynFd62w23DFSLklEU2ET51SK42ytcSLijUt2l8Z+8XOw8cyILEnNzlhIPB8oGEKRM
 wJSPNtHzvJknv3tTqp7ESIVmd+p4k1GdhEsC0gfuNtSwbM6rSdWeOPk4ssb175h8rbB1BUtSMJR
 3LXJFn0MKrajOsvqIBk9qn4/KN5SkbrIpC8+m4VHoqA/z1nid8aTcbXPmeEwCETlkUyFhyIV7SU
 5P8lpemMt9vF8kxgVuaQDnqZdQ0Br/iaekd4D7WZ9pj0hMFQeHwutjn36AezPVz0D3qXgM9oCOM
 UvknFNuvj4Q7h7KxF9msNxVwvr/KdUrQLJuVAkpbUjVNSL+5zoxYD2ZnIju5sKryqFS8H3kDPhp
 je9cRoYITShixgZ/QgQ==
X-Proofpoint-GUID: MHTNvsWgx-Gxwp8Elc-SkO7KBvOaMTUa
X-Authority-Analysis: v=2.4 cv=Yoya1IYX c=1 sm=1 tr=0 ts=6aea6656 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=-0h4ovkggksBOsavXOYA:9 a=CjuIK1q_8ugA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MSBTYWx0ZWRfX0M2zc1FnjVve
 2BeD/y953DhYaOwLIzm8nli+7dEWCZifjgow7g1NxhzGkKUbDXkQfDit0xSYZ2NVoHX/tKC8sUG
 FOPdjLoYK1pETYHOyD4Ticv7QBk3wdM=
X-Proofpoint-ORIG-GUID: MHTNvsWgx-Gxwp8Elc-SkO7KBvOaMTUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030091

On Tue,  3 Nov 2026 17:39:07 +0000
Sudeep Holla <sudeep.holla@kernel.org> wrote:

> Arm Functional Fixed Hardware specification v1.3 defines FFH
> OperationRegion offset 2 for issuing FFA_MSG_SEND_DIRECT_REQ2 calls.
> The arm64 FFH handler currently supports only generic 32-bit and 64-bit
> SMCCC calls, so it cannot implement this standardized interface.
> 
> Add a standalone FF-A path using the existing SMCCC conduit. Negotiate
> FF-A v1.2, discover the sender endpoint with FFA_ID_GET, and use either
> the receiver supplied by firmware or resolve a unique receiver from the
> service UUID with FFA_PARTITION_INFO_GET_REGS.
> 
> Convert the ACPI ToUUID representation to the FF-A register encoding,
> construct the direct request, resume interrupted or yielded calls with
> FFA_RUN, and return the defined FFH status codes to AML.
> 
> Register-based partition discovery avoids RX/TX buffer ownership and
> keeps the FFH implementation independent of the Arm FF-A transport
> driver.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Hi Sudeep,

I was curious so took a quick look. Some drive by comments inline.

thanks,

Jonathan

> +static int acpi_ffh_ffa_features(struct acpi_ffh_data *ffh_ctxt, u32 fid)
> +{
> +	struct arm_smccc_1_2_regs args = {
> +		.a0 = FFA_FEATURES,
> +		.a1 = fid,
> +	};
> +	struct arm_smccc_1_2_regs res;
> +
> +	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
> +	if (res.a0 == FFA_ERROR) {
> +		if ((s32)res.a2 == FFA_RET_NOT_SUPPORTED)
> +			return -EOPNOTSUPP;
> +		return -EINVAL;
> +	}
> +
> +	return res.a0 == FFA_SUCCESS ? 0 : -EIO;
> +}
> +
> +static int acpi_ffh_ffa_init(struct acpi_ffh_data *ffh_ctxt)
> +{
> +	struct arm_smccc_1_2_regs args = { }, res;
> +	u32 version;
> +	int ret = 0;
> +
> +	mutex_lock(&acpi_ffh_ffa_lock);

Use a guard() here given it will allow direct returns
in all the error paths. Seems like a nice easy code
flow simplification particularly as the good vs bad
paths will be more obvious.


> +	if (acpi_ffh_ffa_initialized)
> +		goto out;

With guard this becomes
		return 0;
and is obviously a good path.

> +
> +	if (!acpi_ffh_ffa_version_negotiated) {
Maybe combine this flag and acpi_ffh_ffa_initialized into
states in a state machine rather than separate bool.

Passing this one just becomes moving to the partly configured
state.

> +		args.a0 = FFA_VERSION;
> +		args.a1 = FFA_VERSION_1_2;

I'd do similar to have below and initialize the whole thing here.
That way no need to look back to see if the rest is correctly
zeroed.

> +		acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
> +		version = res.a0;
> +		if ((s32)version == SMCCC_RET_NOT_SUPPORTED ||
> +		    FFA_MAJOR_VERSION(version) != 1 ||
> +		    version < FFA_VERSION_1_2) {
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +		acpi_ffh_ffa_version_negotiated = true;
> +	}
> +
> +	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_MSG_SEND_DIRECT_REQ2);
> +	if (ret)
> +		goto out;
> +
> +	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_MSG_SEND_DIRECT_RESP2);
> +	if (ret)
> +		goto out;
> +
> +	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_PARTITION_INFO_GET_REGS);
> +	if (ret)
> +		goto out;
> +
> +	args = (struct arm_smccc_1_2_regs) { .a0 = FFA_ID_GET };
> +	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
> +	if (res.a0 == FFA_ERROR) {
> +		ret = (s32)res.a2 == FFA_RET_NOT_SUPPORTED ?
> +		      -EOPNOTSUPP : -EIO;
> +		goto out;
> +	}
> +	if (res.a0 != FFA_SUCCESS) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	acpi_ffh_ffa_sender_id = (u16)res.a2;
> +	acpi_ffh_ffa_initialized = true;
> +out:
> +	mutex_unlock(&acpi_ffh_ffa_lock);
> +	return ret;
> +}
