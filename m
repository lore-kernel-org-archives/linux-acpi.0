Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878655;
	b=v11coyvoIFGoW2VisLxs504AjnL2URhzlALtOefxypqH0EPezvkTTUr0Sc4dOX5+EuSD
	 SEcZZHhMIaOxu9mxWlcYPVsaLMlL+KEBMrrXCU80qzTVv1KTHo9C2ritinT1R6KXFaVL7
	 a1UadZElfMQKnESJ0zotSS+pmfwbrFMFeXnf0ChK2FJ0fghSd4/ieDn8WFKopEJkYoxoF
	 FiOm678rAoga8p6eWr9meTQQxvhlr/lBcuxv07m1oKpJg5sRBgXVSVFlZ9kNEQFHOKHnO
	 I6y04Cl294biWL5kYcB6oNpdn38pCYMEC6+ZHPLaseCZp+IG5j4DX3lPISRc//rs9yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BrGoEFHtqBmKXcb+UUckvq2KsUQ5PsLAHRWOdAWZVZY=;
	b=UFyIfz7+mLBvoonWteJ/MGpFRFyRMUcjOYykliitX+OD2BrgJPUpbba0dXAPm4kbo4hO
	 w8NfPsn1cpLlUJdpIpA63BRRPvBQRQ6NsJeBfYIAw4YQVwzwaq2aLc9QMpWDqZfwKuMp+
	 hOaTlcnjRwbLVG06bUfMmyVMjfpBHmj/Aelo7ZrjkLs2lqU7JmaXlt/t31GmMYLeGZZUI
	 2rXngFYr2C2aW2jG88l6n/tXUIfFfsj1kL6cAlSpl7p0WB5zFFN8oRa5YEdM4ZStngXQA
	 q3VU64RcLKy3u0y6jloqHSybuw1OQSba3cS7amHaxM0Evo7nyItMN1AQgpXwhIJSC2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF5tMPeK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eBn49Umn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E26606A31E
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 21:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88E26606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF5tMPeK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eBn49Umn
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLbMQG3758248
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 21:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BrGoEFHtqBmKXcb+UUckvq2K
	sUQ5PsLAHRWOdAWZVZY=; b=bF5tMPeKlBMtr38JagLlRF0GW+2Glwt87ZjNrMnh
	F5Sb6vnT+dP/VBXFjdEchNoDnzT1Sm6ssiOSbJ64BXBzFWzoGFoweWNRvQwXyy8P
	PDzkJLpeIcamWSQPmK08XOApNAQE5QiCH9Q3pzLHd49XFjPuv2t5lUnCNvt3avtS
	aNq5dXakjDg6KiukX/pkBrMzxSfLfYtbin+JA2uJGDRyFg2TYg0sAxbVFLx0dRMD
	ddrV6HLFIU9S8PGnDLxpluQAVOIgXEF7V8rA0Mx7lXGe6/9eMH2UA9qfEr97BTMF
	4aHyr9lB3WnowrVEoSZhg1I/KLdI5TfsbOVBPP480lR+Hw==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgt6g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 21:50:53 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4943ed99826so1856366fac.3
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792878653; x=1793483453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrGoEFHtqBmKXcb+UUckvq2KsUQ5PsLAHRWOdAWZVZY=;
        b=eBn49UmnXmQZs1LdRsd0+j95m7DXPVkZrjrSaTfLowFCsfCBhK97YjyL+uhiT195Xj
         nXbyoeNwGyokEDaqoDp9tN41in2VbKoCBtYMMp4M6+OUWm5/fLYXRY1M3LTKR/Zqwbad
         4f5zkqpwEOGrh9UrRhRn0fY27BtRJWroCFHfVx9LQLqZ0bclkFjEYPK5NkgZIFGEQQUx
         upd3DelHybPTCEKOpNIdHINyTL5k3W/rAd+KsOFzL0kPxMm43LTDoYN8KcOeIuHcENsH
         s/g7A9PxqyvyXB0ovpLARY4NrRVXvUQiUJ8Y309CJTe1TpOyaE/Xa0MaU213vYg49/t5
         0bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792878653; x=1793483453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrGoEFHtqBmKXcb+UUckvq2KsUQ5PsLAHRWOdAWZVZY=;
        b=A00jC8z+sCSB7XzoYiFCLGMVCczwZ/PnGqeLRsLeb1EEfL6IHFD/Z1pM5IiB7kwj+3
         qbrFVKcdTYIq6Wohw8Qbf3zghpa3fbRJ0SQwb82qiAX836tWkk9WNR4U0WPjeAaM2dze
         m615v5bWXINwbD/Jju+ZMLPg2zsbR4Sa7m8Ij8DohB5GRp+dQBk/KIaE8g87oNTxMN0N
         iIO9tMhClsODl4DcAim/TnG9psaVLJJ1SUmBZxjnbCbv/ty+jjQ0AkDHh9j3G4XEhLq1
         3RFvvzm9RHkYrKAWRf2SMHWEn8oZzl7rbk3c6vhv4fQ5XlagDBKvaNhAQl2af+WZV1qw
         JE2A==
X-Forwarded-Encrypted: i=1; AKwUvBxxtfwjxdyG2x/6+0bzsyF0wNUWkzysKuyIpmC/laf4lM4qCQDq3kHIYbMyOpvqEf68gE4qIj8KCQ5I@vger.kernel.org
X-Gm-Message-State: AFq9FYLK2vfSuqXkBMbSOqX2Pi+iVHAyyPJlesSZrYizv3qraTiQREBy
	QnOBN8j2vXcka5bebGlJvGqw7ziteaFQ6aJvx45SGYx1oOdnm1vMre+tPJEqpkEDosZX1sC2ZRp
	h06xHZm52zSA7b4EMVwqb3tXoIyt4TT506UGNkOGQMdAqxjAtBFm2obmljiqtcMQO
X-Gm-Gg: AYBFou1dDGnNRPKwmsYHj/c+LVz4XOGrK/7GVZpJYxzsojRMvCOnWcz5xkQ3qVjOqXn
	cimFsT2FpJJq32wdHEW6BfE5n2yqVGVjwVhMDHZIzqDe35KfNmpHvDWtW6NoAANXvXGOVVD1AT8
	yVg5k+CrxN2pFNBvbm1Ghg+9nM+fjLHowyNkIBjw/4pwR8s4MqPeJjVBw8nKM2qjsxbEpXzt1An
	TJ5kssWZxdgDxV7OBglufWuQDsPZFtNAsI8BKEY9HVKmBvU0ZTpeZCOnLXE6MY+esoqkVF09XNK
	zPsku92SxLCnmHvyoMRiVOmQV2NVTZIivy9ZN09+f86bpBhkrUMEJM3b1JhE9Qp/KlBQSVj1J9m
	O+bYlgiUcV1PRyFv+5Hmlkm6cwq5R6Wc1QTBNtLFusPlwLpB7iA==
X-Received: by 2002:a05:6870:a2cc:b0:48f:e107:317b with SMTP id 586e51a60fabf-4a83f5bda63mr1957124fac.46.1792878652705;
        Sat, 24 Oct 2026 14:50:52 -0700 (PDT)
X-Received: by 2002:a05:6870:a2cc:b0:48f:e107:317b with SMTP id 586e51a60fabf-4a83f5bda63mr1957110fac.46.1792878652228;
        Sat, 24 Oct 2026 14:50:52 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a84315c274sm1783227fac.9.2026.10.24.14.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 14:50:51 -0700 (PDT)
Date: Sat, 24 Oct 2026 14:50:48 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
        Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
        Ashok Raj <ashok.raj@oss.qualcomm.com>,
        Ashok Raj <ashoraj@qti.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <at0oOH1Pma1MvFlU@hu-ashoraj-lv.qualcomm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-6-pierre.gondois@arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019203915.2019037-6-pierre.gondois@arm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA4NyBTYWx0ZWRfX2aaJ+eLrJkpc
 iJwgVRXzxdd2KxLwoChdBdR7TYOcpL4iitEpYs2V89p3azAYqr0jEYPQYhg8f1AeCH1a+owKV+x
 LoVyMsSBZ90kw3AZsQ32Y4sPYptY4/8=
X-Proofpoint-GUID: eKnU9GFjZUHNBam-3iylo-n4RP4KOQc8
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6add283d cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=xNf9USuDAAAA:8 a=7CQSdrXTAAAA:8 a=SBTCx-jMH1C4PCkex7IA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA4NyBTYWx0ZWRfXyNbCHUwmPcmG
 fnEuMm9hNNKVgBHK6Y1SMpFaZhtqc0pE7+dexjnWYFA1C22rKjSvlmy7kZafYZ7rk/6CX2p8TWr
 YdouDMEr/p7cWXQIReDWJO8XLgAdgIMzjxuJb+yrJjID3iIjSvTMnuqcFaMJOKExI8JRFa66xuI
 Xhtyg7yqUhA13G7sJYoLoxvfs0m6296zP72KyX/iPpZEGsUfZB8WQhmR5zdtbqPQFfNoBq06PVj
 gxxQouS5+uYxcJdfHw+Es+3ls3guAaWbTEeXB66PUj+ic/K+kDrlIB4kwJpInQlvlGe1OO2F9aP
 vHDi4dMulajzwuM5ykBoEo/hieLagD7ES7mg+Izc1wI7OrJKs/XFDdWmSOC3JZAgUJIyx4jnyEO
 wRArBbTbOodyQP66sfrDJ3HxdA5sW6Ch/67TX0Nguygmf7+91pwlzLA+hqSDqc/4r++ByESEpk5
 nj1DoFThgmVjrxQlonA==
X-Proofpoint-ORIG-GUID: eKnU9GFjZUHNBam-3iylo-n4RP4KOQc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240087

Hi Pierre,


On Mon, Oct 19, 2026 at 10:38:44PM +0200, Pierre Gondois wrote:
> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
> records. Use a separate GHES notifier chain so existing consumers
> continue to receive legacy memory error sections.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/apei/ghes.c |  49 +++++++++++++++-
>  drivers/edac/ghes_edac.c | 118 +++++++++++++++++++++++++++++++++++++++
>  include/acpi/ghes.h      |   2 +
>  3 files changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fe10ab0e02f6..c7fb15543b56 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -101,6 +101,7 @@
>  #endif
>

[snip]

> @@ -952,6 +977,16 @@ static void ghes_do_proc(struct ghes *ghes,
>  
>  			arch_apei_report_mem_error(sev, mem_err);
>  			queued = ghes_handle_memory_failure(gdata, sev, sync);
One issue here.

> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length < sizeof(*mem_err)) {
> +				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");
> +				continue;
> +			}
> +
> +			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
> +			queued = ghes_handle_memory_failure2(gdata, sev, sync);

could this accumulate queued with |= ? 

queued describes whether any section in this GHES status record queued
memory-failure work. The synchronous GHES path sends SIGBUS after the
section loop when `!queued`.

For example, a synchronous record can contain an eligible legacy memory
section followed by a Memory Error Section 2 record without a valid
physical address. The legacy section queues memory-failure work and sets
queued, but the Section 2 handler returns false and this assignment clears
the previous result. ghes_do_proc() then reaches the `sync && !queued`
path and sends SIGBUS despite having queued recovery work for the earlier
section.

This series appears to be based before the queued accumulation fix [1].
Could the new Memory Error Section 2 branch follow the same pattern?

> +                     queued = ghes_handle_memory_failure2(gdata, sev, sync);

should be:

        queued |= ghes_handle_memory_failure2(gdata, sev, sync);

Otherwise, an earlier section can queue memory-failure work, while a later
Section 2 record for which no work is queued clears `queued`. For a
synchronous GHES record, ghes_do_proc() will then reach `sync && !queued`
and send SIGBUS despite recovery work having been queued for the earlier
section.

Thoughts? 

[1] https://lore.kernel.org/r/20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org/

Thanks,
Ashok
