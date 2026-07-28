Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7C3B47F9
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243262; cv=pass; b=SA9y7AJ4TaBDMZ/Jiu1xIxVt0zWDEA6aCQP90knlv9IsFSkCWyTRemlu+25gQAI1ES/wG73BrwD+l6kP0x0WyUDzRoyrvo2NphGWdMdV4INr6Uyj/2JmkraaekGGtT3fonGM12K2kKX567rUp6mGmrkD7RS8yJg4Zw6/fpCB1r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243262; c=relaxed/simple;
	bh=b0sx0plN/+brXM6H07t6I9Q3Pcn6MIVpSqkOawHATLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3A853xTYKgCgxwHYj3PIEeIOu8ZClLaE1y1I0vzwsXCYO7s/9+Zu8ZffgqWtQ7znWi7Vltkfz42gqOEXC9kf6POMYtNh4kmiQNNvIGl6HSHjDufIT6Fn+z80JrG1axSzTxfzo0QnnGNPqZ0BrfvrT0YhSM/oCSZqQZfLH7nPAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GuoFVeyr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzPKfZAE; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GuoFVeyr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzPKfZAE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBH8M12121159
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 12:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=2cawBiWQxfIarR0xDzJpp07gga51kPcOc4W3XKmecSg=; b=Gu
	oFVeyrj5q7qEfmAq9Ld9pF3nypwgyzdkuGSuoVTrliv1yNCHhZMtRTyw6zyxUXed
	t8JZrp7fZ4Usyenfy/Xmmfzzcauy0t9EvBjpfHflJsAUruSJ7i3Yd3Lwu6iJ87VT
	J8cUeEMAQv0iItVbW8kkoq58V8clS1/cXeexBCbcq/+hWo0xY4a9cMyRUEeUVADz
	aRRJaTgeyTHySUXMG5/VCYg4YbkxpYiN4HK+RNjr7WNgJg5k3t+iy0hEulHTBk2S
	/vgmHalkhe65yZjvFnEgTpanqwYpMzinT/iEHkpm32sdEqV9LrAzUDjMnujYjQHQ
	KeLaP8g/8L9ak2VswBtQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fppttsnr6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 12:54:19 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-667d6c4384dso9456492d50.3
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 05:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785243259; cv=none;
        d=google.com; s=arc-20260327;
        b=gJIHrLyeoH+X/S6Fg5MTq+6o3boAzJKHiZFF9s5n5TICuuNLeqnYjSpIU7BSZz7zcY
         E/ECKnEzYWPk0gPGb6bmf57nKwuBZoUGGTf2043UhJPlfJ4J3mZqFyIwhctM/1q+FxK2
         efHgezSWA4rE8huN9kw1HoQWDZBpbYWlp2o8S4SvBw1uWV5nPvxbqV+EZUSkfDwIjVkR
         XIPAfwJH5VekNr//8SMxeNPL6BTLluecZQXSy9cAx35Vvn5Az9+WioqsFM7PEUXSuNmU
         chxxgLxLfJFjDdXvF4/SdF/fVWMMJUck6G7KzpzcGyvODqPogVJClMEcy6E4oGPMczjI
         tYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=2cawBiWQxfIarR0xDzJpp07gga51kPcOc4W3XKmecSg=;
        fh=IJ18SkoTT0JkMcuhdhKFKHIysAETfXYJUBtOqjUN8Bs=;
        b=rPDIejpixhF7Ne4ktNVFverbA9Z0dhfvoniKSukbZYUmbrmpiswuU8QTf3AF653q4o
         D/JIH6vbK+c8iZba0H900prKdkgb2enxchJfP2j0H0BHFSllVyhVrPnxw880DvEzE7mJ
         UHW9cr8ogjVEMRT9Iu3uHaWVomnjRy0kMCAn7XVhC5eHXRCPqHBYxwKlM0PTmGOmHnY2
         ajNLq1LgAPDmAsNFFHmjqRbgNY3HBNvRXNLiSaJgN5FVk171SfKgjqpMbJ62uz+kORR7
         +/puEQRdX/veKqssv2YT+oR6OtbI2CLO0gX/Cmd3654HDqhL4aJwsqz7CUo4hQSRnBNV
         rnQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785243259; x=1785848059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2cawBiWQxfIarR0xDzJpp07gga51kPcOc4W3XKmecSg=;
        b=CzPKfZAEIS6S3G+O2OgCX4rMqU3JG1WHfeWlw3LlhhTntQr7udjjmvX5jUtoSXydAN
         6OiOu5EgcY2GTQ5AcI4Rdby9aL/+xrpK6ni782oZ4rZQl/raAByVWUPH6vDzYxAyV/MU
         TdFaL6c/LamYcbSR20HSGcj54X9xaw6+h82XxzfKuZHwnZODpYDv6bEznz7PbMepteJe
         3S00/cTlqxAI/p+1nCfAh4Q5/sd6QjUNVaK0qq1ioPkIOlrolhBZjBF4ZlnrqQutqjqE
         IZoIR1k5gEToA/iJP5k6B0cMM8XheHI9hj6c9BEzGQ44mHFkRnpduNt2PcY0FaM5+TR5
         2LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243259; x=1785848059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cawBiWQxfIarR0xDzJpp07gga51kPcOc4W3XKmecSg=;
        b=hJq86Grnl7nqV/fzdp5gI92QrFhFBMg4X6L7F6a4630pp7rZUFYBWqIvvkl6+DZecb
         /nZUtsLD/XnofTMEdk5amWfi4QQN2GzAji94xkiMP5uTFFb1kVWJGGNehj7jkSVmOXaz
         +0lfLPvwZiPJRd9x7SrWN3q085kgptl4V7pJ7EjCn3DcPaiCOsVBvwPjWig1XqzZU5N9
         QmlACqEJsLsAzT6gkgMxxq7ncOrDNfKg42LHGqbv4rvgBlNOxmkmMgbVEqSQ1kAuXEwi
         rCpq+AaUE5uXV2Xrm/t7SCc6ib+5Ld2pjnRuHJKLvhDE60k7ludquuN9KasbLyfgvLAu
         BvFA==
X-Forwarded-Encrypted: i=1; AHgh+RoVHNs2rKiGVEu8TqHgrT0L+KRjo+/SuVaSgOazZKhIfDMlYTc98Z2Mgs8Tq+iq5pjWzBOjXu4CFzPD@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6RV8baDK1svR0NXnuUtyd90LfhWIuk8vMuY+XP0CvmUtozXu
	BpFGxpF9z/oHoQ3icKxKmVSaVB3TF03Cf5Ol4aR1RdwGsB+RnxjHVDpTt3zf3AVnZSoFP/SnIlo
	AUFaZ4QLErYa0wJjgICdQSnsRfPzIVlpbTvSj3zj4JHt2Lkqxj8kgGNazIq2aGBixqj+warkH2k
	VuMEShbSrKt8qMEU114zTbg1jrLLGW2mjCaSM6t3Q=
X-Gm-Gg: AR+sD13wbIqXYJYWU8+npXqswSn//zCFsQqzg1gAt6Erg5xPBm6VV/L5U5o337VmvlO
	uF+igCOz7khjYflycpgoj7hTng9kXkr1Kev++F8gCTjBPyIYIeGoz77spfSfag3/ypOkJgc7Rjd
	fja9SEltG0Mhh1GkIEDfsdxr3yfOaDMKqJWKfAvMLPVnAIGlvInOdyXixCyQ==
X-Received: by 2002:a05:690e:4395:b0:668:1c09:aef1 with SMTP id 956f58d0204a3-669054c30c9mr601978d50.6.1785243258988;
        Tue, 28 Jul 2026 05:54:18 -0700 (PDT)
X-Received: by 2002:a05:690e:4395:b0:668:1c09:aef1 with SMTP id
 956f58d0204a3-669054c30c9mr601973d50.6.1785243258645; Tue, 28 Jul 2026
 05:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-riscv-acpi-lpi-timer-v2-1-5a30e0021ec9@linux.spacemit.com>
In-Reply-To: <20260728-riscv-acpi-lpi-timer-v2-1-5a30e0021ec9@linux.spacemit.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:24:06 +0530
X-Gm-Features: AUfX_mwIyP8SKtHFksxOpexuAlrA0_ifqJrmlt19_-9C5OcL2egVfaB2UDApqMo
Message-ID: <CAB19ukH1Srbw+Yko_-21DiV7Wc0ysJX9cmE7xDTwtrmUm_5rMw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: acpi: Handle LPI architectural context loss flags
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Yixun Lan <dlan@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>,
        Oza Pawandeep <quic_poza@quicinc.com>, Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfXy51VSXuNJlrm
 YS0VoYnpOlq+/Gji1TIyDpQoJbvlTEpZKL+1dNapNX94DJrEJ2/heULvkbJf1XqLS5BIDRQWG7Y
 pXaEhMZF7ikQ7Y/JYE/2wy2/NL6PT5M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfX2CDxgP16bp8d
 vtjJeDodOxs6mrQdfITKDGH5e54ZuHqckF/EsjREXsXHs6sRl3A9fpekLDP8XmZPqkd8iskA8vy
 je4AdN8D4qDzhxqIb+37aP7NeY+Y9cIC3CZ7T9+g0TkoTKS7/i5moCtGyVGhfMsr89+zx+mCFXf
 3IVOZtoLHtm+xGkaG2A/DNntPfs3RGEbYVqVuiJIye5NSeI6TW+u5Gvl8W3vJVQbC3wdIhl4m8p
 xqgKrq2xBZaV57hjZGTIgsxtkC44URoF+U1d6IGCgG15wOE35cBOAC1KeviM5kMmoq4YBZ0xk0l
 mveieGTDlkTwTrIeA4iCYb8EWDfiPgyAE3mQPGFuhc1px9gr0v68YRahievAtLh9tBabXCWGAjw
 4HzjT31JUN6qbkvjeXZNiqEIQJiaMSCutTfKOJjm0JFyGIEBrGMPnsp4JTz7TtCC+Tcb4dttjV7
 Nv5i6i1OyyPQUXSEsYA==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a68a67b cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8 a=lv0vYI88AAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=YoT47lCsnKj-Z75T7f8A:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=FO4_E8m0qiDe52t0p3_H:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-GUID: Cb4ednDc_zi03VEodPMVmqJ7sztH2QiL
X-Proofpoint-ORIG-GUID: Cb4ednDc_zi03VEodPMVmqJ7sztH2QiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280114

On Tue, Jul 28, 2026 at 5:24=E2=80=AFPM Peixin Xie
<peixin.xie@linux.spacemit.com> wrote:
>
> Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
> broadcast timer") replaced the generic nonzero check for LPI
> architectural context loss flags with arch_get_idle_state_flags().
> RISC-V does not implement the helper, so it falls back to the stub
> that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
> an LPI state loses the hart timer context, preventing cpuidle from
> using a broadcast timer for that state.
>
> Implement the RISC-V helper and map the hart timer context loss flag
> to CPUIDLE_FLAG_TIMER_STOP.
>
> Fixes: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcas=
t timer")
> Cc: stable@vger.kernel.org
> Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
> ---
> Changes in v2:
> - Correct the FFH specification reference to Chapter 2.1.1.2,
>   Table 3, as suggested by Yixun.
> - Link to v1: https://patch.msgid.link/20260728-riscv-acpi-lpi-timer-v1-1=
-c722bce01e48@linux.spacemit.com
> ---
>  arch/riscv/include/asm/acpi.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 26ab37c171bc..2643e28fc08c 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -12,6 +12,8 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>
> +#include <linux/cpuidle.h>
> +
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
>
> @@ -67,6 +69,23 @@ int acpi_get_riscv_isa(struct acpi_table_header *table=
,
>
>  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_=
size,
>                              u32 *cboz_size, u32 *cbop_size);
> +
> +/*
> + * RISC-V Functional Fixed Hardware Specification Version v1.0.1,
> + * Chapter 2.1.1.2. Arch. Context Lost Flags, Table 3
>
Isn't it Chapter 3.1.2, Table 4?

> + */
> +#define RISCV_LPI_HART_TIMER_CTXT_LOST         BIT(0)
> +
> +static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
> +{
> +       if (arch_flags & RISCV_LPI_HART_TIMER_CTXT_LOST)
> +               return CPUIDLE_FLAG_TIMER_STOP;
> +
> +       return 0;
> +}
> +
> +#define arch_get_idle_state_flags arch_get_idle_state_flags
> +
Otherwise, LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
