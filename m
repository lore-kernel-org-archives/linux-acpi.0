Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800D367B92
	for <linux-acpi@vger.kernel.org>; Wed,  1 Jul 2026 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875685; cv=pass; b=JG2LnAwSgsvKd4EwNVJcWqBE2mI2ZVY5ttTr+9k0SGSD3A0sGAsF71SgArYh5A2dNyu5US0REy2iPlzU3aHAiDyF0StkV2Q34dp855soXWrXwtXiKymSp1YsjJI3Ke4Jl3HT5mdPxAcgwbcNO5omt4O+EOTb/BpWQ2X2Oe/K14g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875685; c=relaxed/simple;
	bh=0NlhND0JSDyrkw9kaOThnxDUJM5rl0wKX9vqrcqKVrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGgVGglR0M5zSVgYllTOBol9zYXSg1pKNIboIUCV+CzP3ULuqBykH4Sj3MHLgwMnLSYoYnRdOqAdKoHeBZyYmmnKp5v3ar+Y33JnH6k3purz3ir6atRnLr5sqYWOGqJQYHYdqNpj6NVH9RWucneLY1tW2G/oX98zqnRRaJ1wNC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSPx0p1T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=asumiEmx; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSPx0p1T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="asumiEmx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612tKNw3933520
	for <linux-acpi@vger.kernel.org>; Wed, 1 Jul 2026 03:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=VS5ekj4FCpEpJNmH/ZuA4QFE9m28JNhBKG92EL1tzpg=; b=NS
	Px0p1Tx8GIDPY2Bm9XKO8/dpBeu3EpgQNxCTsYCYXowA9Yv0zHToQyWCYv9o0dWT
	vVu/hcZUGfLcgVF+pIFJQfGj5nJ9LZmIF8d08T3IbAKaimGksNnjYnfJhr7eHu91
	Wc56KOJfK7RLECRtwaEvifl63vJOxUmK5KKaooLr+sVU+pCjUIMf7yiw+A4HKLcS
	1lOjgU0ydtNso1ADZW76gJ4pgNodBzOfpDTY1lisOvXptXFXwHGw92i1v0/NhWsp
	f4mHje8pUxFkC7v5O4kkiy4LDhQQ5+j9xxGveGQFjBquOTEGjAaOGHN17y1XPH5P
	7MF/pX0mvrhpLCRzL9oQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0b188-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 01 Jul 2026 03:14:41 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8003dfff682so3069337b3.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 20:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782875681; cv=none;
        d=google.com; s=arc-20260327;
        b=j4riLC+1NZQ0Y2sxeZSonHKqJ46KEHYxUVhOgDyE3ZKhD8E/hnzrp89c1d8siLbo1v
         T1/uCBC34idDtOV695IMRC8bd86oDsM5Z/tYznhXwgPY6Ly9p2XSOJMMBg/rZhXTuh5j
         ltKxvRkZc2CfY5vNes2rDGdsEz/c8Tyt4Cc0pDAnQBxcTinrbjpmQMH7divm4zctCOae
         E43EWK+p7Tzz2CUtAEniFrhj9Pg93njsRnQXipKyMt8pviX/WYFz2Nr+7imw3Hug/ZIK
         441DLRTSgvhBei5ftGDhN04edjvfiYmvnpBa90ZuV0dfspz9RiucGuVo5SrHtD6gVIir
         epOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=VS5ekj4FCpEpJNmH/ZuA4QFE9m28JNhBKG92EL1tzpg=;
        fh=uABTu/2hPEnFcDYICV1K36s1SKCDKMgPU/4NktWlwZg=;
        b=hIElFMxaQ0pHoiZ6BjwvTAhEPQnFTejSa6bYdWQqVrfn/chW8YLx4T4mIuEg61XPeq
         6uGILuxqbYe6o3ndFK7R8d1WFFDESia6QGVbOo6IvSA5ElQJbxfVHOvkqPNEr7wF7yos
         T1/nB341w9eKhD8zN0PjbFliSE3G5nIMSnOZJ5fAZN0hT5yjHXqU31w/aiZvpGGAnbQM
         cxzhTnamOeNWue5A4W9sQDkSJKj97a8I4BO4WDgF6QDzO9QI5Ca+F2mBaiYd/Kj9E01G
         9G8z7ktKJQ8bOXg/iUhAmjczpdyVjkhI/X21VH3p8edRE6NCXsqwsInv/dO7F4/86THp
         uQ0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782875681; x=1783480481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VS5ekj4FCpEpJNmH/ZuA4QFE9m28JNhBKG92EL1tzpg=;
        b=asumiEmxowbkxSe8J2qmyREoEAIKmJe83aylh4ZfO+ud47+MYuVHZBRwJjfflqxheg
         7jBEcch9sNEQkr/6yGG2Q0njdU9duOCh4oi5hYXckbWXajNfUTTnJuh+QYn+CQGHynNW
         YwlPF80X7N60Vmlha2g7WJmvuEGl9vsDv8kkcQRbcejpYySKUFYbcrgbmB7yGGwMRk+n
         2XRKgztCfpnzgpko+23IvL7sgSE7XY7dZahVJi8txaDXMrIWt9V4nwIZ0G1tmbxTE2vQ
         r0lwHajRHmOGmjpsBSYh2jhZ3dhe98+JSdW74zJ2nvX/K46Q+k4O4nqnXtGy1+7u9p9w
         qfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782875681; x=1783480481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VS5ekj4FCpEpJNmH/ZuA4QFE9m28JNhBKG92EL1tzpg=;
        b=rU4j5/4d7YDLBLr9HE6m7EN5qXOfU/5sWgs5ZXi27Qe5awwxVxpunoWc97fuga13g7
         1eM4BPvLvB9k4kZXB98UUrDcSHlWgiAQCD1BARgF6Z0IeHYNoOhFn0HDn7oyLJvlIzFw
         D5spfX+CNkwRu0zGjE2mkJUuS+P5QybzsKmG1VJeA/XwRp8BWpms5r6qVe603ldSvBhO
         1QMw915QFrPochWf5OnlokIbcIR5+/C5EBnZplLLGfcbf1tkDste8kHPuK+EHAryY6wk
         00Xd9aDK54U5Eli/8P1Ti0flQiWSyfLB/TqnHkvtIrQS/2rfkzyXB0fltTlvApjyg1l2
         JR3g==
X-Gm-Message-State: AOJu0Yze9tQxBNWAXjyjIiWFjuHQMVTpzwcw9weo7qehs4bqKNv831cQ
	6AphBmPR+mFREpHYtz2poGYZeLsqigJ5a2df+ZPgzlr1+WnLkbOdK7H4LKLYOOA13mbW3FcOVPb
	/qAg1sKfqqGffEn2MPSGVk1oKvA4ACKGCXQTYUhcXEyQhTWZqOW6bTgyPZMOMZr1pgGPcO2ozGU
	xmw2WZU37AGwRwUNUMi6ocUUHcc85IgA7IytiNRdE=
X-Gm-Gg: AfdE7clUQMcnYdpHc6IKKMzbwClraNNXK/37c6PBbGAnYjMk2ocsksZlgyc9OYMTWnr
	02vSdjDTQkpDcZCkfwh5QejLmYvhbeZbcuQWEQyoW0ESwJgf/9rlLuCZrgTNj4zsOnPaGCi6qbk
	1u1TUC3nlPFBXZ6ajjOtmxNky2fZFmKUn++H/jIZ/uyV5lxF4xt669cVR6Kl8+JL1L4X4D6Q==
X-Received: by 2002:a05:690c:22c2:b0:80c:85e5:8749 with SMTP id 00721157ae682-810db01e72emr70433377b3.71.1782875681044;
        Tue, 30 Jun 2026 20:14:41 -0700 (PDT)
X-Received: by 2002:a05:690c:22c2:b0:80c:85e5:8749 with SMTP id
 00721157ae682-810db01e72emr70433197b3.71.1782875680711; Tue, 30 Jun 2026
 20:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609192856874Y8AaPpKL5TnmbgiWI8DI3@zte.com.cn>
In-Reply-To: <20260609192856874Y8AaPpKL5TnmbgiWI8DI3@zte.com.cn>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:44:29 +0530
X-Gm-Features: AVVi8CdZv5JqJiLqPrWvRuGUGoTjuCetf9hU24TCu97qowjOVPb4FJ55ZLdiM28
Message-ID: <CAB19ukErZAJZjXwZFE6m3R8N8L3jTn=FUR-sKm0RgvyhXmkyWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: RISC-V: Fix false warning in cppc_read_ffh() for
 same-CPU reads
To: wang.yechao255@zte.com.cn
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sunilvl@ventanamicro.com,
        rafael@kernel.org, lenb@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, zhenglifeng1@huawei.com,
        pierre.gondois@arm.com, viresh.kumar@linaro.org,
        zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAzMSBTYWx0ZWRfX+DuH3YRQNWd4
 nsVncUxILCys7O7Zds0UTYIGMsUMreQbfGMWsBj+LahIcSoXa1/u7jX/8MQyXLpifq6/n519Awo
 8OHUPWkDiKl7eLU3pzqOMJdQkQI0LgB/+xVbDAxhj5yN0zKu5iURgD6ry22yzMsIG0QARlbuIt7
 yZGcD3fF9G5BGEmwRFJmq4jIU+OhPTv17GWaPRAH8x2yn4P7oma2SahcqE/hzWB2EiozmDMmqn6
 Y8Amqe6ePWv2s6NRQtyCkFAjMMk+DsfMwHWOsn0FrSZFbtzmGfAk9u4lxBLbMSCXHitmxyWZthe
 +/OtoThC8qLa00zxlx651LW0Sn88zNwws+EhQRKWje4RvR+hjJWV/3QJsXfBYNnWjoiYaV3UjVB
 HbihDbTIXBGmhAwvjvktEJuX1iLnOzzbq6OC5x5Oyi4WXOn+R2GImfZwB3HfBV9Jr1VAuXgj13Z
 XmSejD73sW8ITga0G3Q==
X-Proofpoint-GUID: mP_vwp7_0qbEddxP_uz9dy6QOe1EcaSw
X-Proofpoint-ORIG-GUID: mP_vwp7_0qbEddxP_uz9dy6QOe1EcaSw
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a448621 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8
 a=ChMDA8uULeNNkDMNihIA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAzMSBTYWx0ZWRfX92bnppD8MY4S
 qNVzkKYY2LzNp1RxZ4LfetBXeEe97xCG7iwuQSHr5wQ1at+/nojXHKnPREgdV9CPQnk62EsRubw
 zzPnE31gnNEvqRTcpqxISamMUrAxkr0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010031

On Tue, Jun 9, 2026 at 5:20=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> Commit 997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in
> ticks for non-PCC regs") changed the CPPC Frequency Invariance Engine
> to read AMU counters directly from the scheduler tick for non-PCC
> register spaces (like FFH), instead of deferring to a kthread. This
> means cppc_read_ffh() is now called with IRQs disabled from the tick
> handler, triggering the warning.
>
> This is the same fix as commit df6e4ab654dc ("arm64: topology: Fix
> false warning in counters_read_on_cpu() for same-CPU reads").
>
> Fixes: 997c021abc6e ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks =
for non-PCC regs")
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  drivers/acpi/riscv/cppc.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 42c1a9052470..5dce0377a8df 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -98,16 +98,19 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *v=
al)
>  {
>         struct sbi_cppc_data data;
>
> -       if (WARN_ON_ONCE(irqs_disabled()))
> -               return -EPERM;
> -
>         if (FFH_CPPC_TYPE(reg->address) =3D=3D FFH_CPPC_SBI) {
>                 if (!cppc_ext_present)
>                         return -EINVAL;
>
>                 data.reg =3D FFH_CPPC_SBI_REG(reg->address);
>
> -               smp_call_function_single(cpu, sbi_cppc_read, &data, 1);
> +               if (irqs_disabled()) {
> +                       if (WARN_ON_ONCE(cpu !=3D smp_processor_id()))
> +                               return -EPERM;
> +                       sbi_cppc_read(&data);
> +               } else {
> +                       smp_call_function_single(cpu, sbi_cppc_read, &dat=
a, 1);
> +               }
>
>                 *val =3D data.ret.value;
>
> @@ -115,7 +118,13 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *=
val)
>         } else if (FFH_CPPC_TYPE(reg->address) =3D=3D FFH_CPPC_CSR) {
>                 data.reg =3D FFH_CPPC_CSR_NUM(reg->address);
>
> -               smp_call_function_single(cpu, cppc_ffh_csr_read, &data, 1=
);
> +               if (irqs_disabled()) {
> +                       if (WARN_ON_ONCE(cpu !=3D smp_processor_id()))
> +                               return -EPERM;
> +                       cppc_ffh_csr_read(&data);
> +               } else {
> +                       smp_call_function_single(cpu, cppc_ffh_csr_read, =
&data, 1);
> +               }
>
LGTM.
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
