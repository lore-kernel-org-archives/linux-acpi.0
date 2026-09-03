Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C71386C21
	for <linux-acpi@vger.kernel.org>; Thu,  3 Sep 2026 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788412337; cv=pass; b=uiNNmh6AHXprZoNP7Cj7HZQe9PeRy7sYlSbQ5Iq3lIBs3xkGXOV2cV6DeLabqtRUNJzshDW45cHCWngabT2KFZtR9YcVlVBiTnTpHAx0MgyqlCpuYLUI5atdy0lBsefypQcGsKVXluMzJahCc8M6iaMuy1oyLB/ZnytzluRYnNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788412337; c=relaxed/simple;
	bh=QOVXsbt6Y6xEtFsoDTi00B2mYOQj1gJHTB3VphGJEWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZ0oCfdStF9L/jrKyyGJ5VPxyGL1KXO449uoWFny0jUlxQfpYvNXmsuGTW/PiMzjlWPlrKClYvwtmThHkBS8RL7rhfujLajROUp8RBstg3XiCPFDk0jffrKbPkvAzfrAKkjIoRwExaCrWx/PsbCYXj0ROAy1ZFaj+/D/4fGqeV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOtT8K3I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OztZeO44; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOtT8K3I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OztZeO44"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6832xn1A2235603
	for <linux-acpi@vger.kernel.org>; Thu, 3 Sep 2026 05:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=LR9IzqRjALwvtfG5DGG1mPrwlxTakHLUnlY5jwSMpfg=; b=WO
	tT8K3Itnc0Ak+8I0BFgOGn9/g2FVvuu0T+dr8ALhNdfJKJGANHAOovCKLSe61eaK
	RmFMYR+ziIiCDeXJdVcvMBTm/ywhPktYEH6gD4YE7nX3E4+nsMW1o3vMuQdSw/XP
	6vzifS4X+ujg/lN1qiwnthspDZu6QOY0sQLXbu+2ljOE5B0HkgBcUBQLqUnkBLll
	/sO3HvdZVWZKRmYoY43EPr7slNLQCLodnkT1wTrV8NEQyaOfuhG3hAAv9eUzaagZ
	QLWPrtRZBQr6BAFsmHCu2y0bGmYE34PtPJT3gv/6BnvQ6DzfUnNR2u5099agYCY4
	KzKeWlN0FpCTuFTMNN8Q==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemja3krv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 03 Sep 2026 05:12:14 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66e509682ccso2587203d50.3
        for <linux-acpi@vger.kernel.org>; Wed, 02 Sep 2026 22:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788412334; cv=none;
        d=google.com; s=arc-20260327;
        b=j20mn7TwYVibzoAb5NQCZO5yFrg39jb5ObCIcWXRrKD5eZfk7vViItpkzVDu3mWSNV
         CcSER+HWbPFALX9K/DbYvbZ42w63ArhHhkZSmm20xFuSva9p3CdGCjfCsKYd42q2LSco
         p1Qnu+tRukhLmKLheGtSgNk0mGL45WGfqiC+Ra2p7u6l9545aJvYuWJJBaSgsUCAeCA5
         e0P7YWkZB4GL7MfopKJNK0cotykRIgjEhjjGC2YCYbChpiUmYFIeo/9uIg41V77VJ3vT
         dIc5fF6y5WKj8ywJ9JcuKm2ohXpvA05mxcybC1WZS/q0dQZ1hPIfHv0AuxMdDDrVaOlc
         fQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=LR9IzqRjALwvtfG5DGG1mPrwlxTakHLUnlY5jwSMpfg=;
        fh=eMomoF4Jehmd5mEqltUhnXzjha3G0Ea70Mu9+5U0SjY=;
        b=ISPstQ0uC2ggiiQurao7KBsDqxXj0AxXOA++ps9xOz5AHaGhy3/gwo9pFd6cpxBnF1
         nnrbyLvRV5tofG7YCBEjA2zRkAfiyWuvwI1BuggcwW3E2r2KZE0bmmBE3ob3JXwGZMEz
         OFjvqaEVBs7pzYeD4fxCxNq7GSPSttRuKEFYNLFQdxyUFJeS1eKJAqi0JIjePelS7Avy
         oCjRNtkCeOTupkN44TQUkqBgfiBHztXr7nYZP8lX75Ivt7IYeibt3VIldfSdGBT+eVOn
         bV0RZ+W0qys4SIjKOzYcy4Clb5MKxlQXHSWaekEYQYOBoVOoSUmGZMwjAVyhMcZCRI8y
         IOoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788412334; x=1789017134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LR9IzqRjALwvtfG5DGG1mPrwlxTakHLUnlY5jwSMpfg=;
        b=OztZeO44TkBaXIJeAe8iAOTx+24he1cGUnos8yTTMuVaw5of5f/M22D/7ZSCa3Sraq
         Fuct4ZTa3ULQzeiom28MHqW3us3NIrxaii+lW06+nte5Uu9p1R0dbUk+apH5JAJ8CWWY
         92AvNeXa6/6fjBHT34irm+Tc8QIbb+Ky5ueiaEewbNikSOqid+FXxRATGdcDf8o8MMKR
         5nPXsdwNKxKU4tVUDPx9qkiXAeqoUNvH2oe7QVL08iqxCNJochbhnSjrkKeHQzrsjxZ/
         Itdv7XBG3282ZaXOapQKrPuV3Q2ba561oGgfgOICwBJbih6C84dHwXc7+olXcCaLxHvj
         Q+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788412334; x=1789017134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LR9IzqRjALwvtfG5DGG1mPrwlxTakHLUnlY5jwSMpfg=;
        b=LBMf5UYHPyoFN978I6sOfvvP/Zh7R+ZqH6d7b+dCEJhro/xK9sfBM7zxNQYZqJRkyK
         P2j/H+m475OBM4pG1jKDMbHs9porOBbJWZM1AGKoelghMfbkNm6RDw0sqU1E7IVxluyd
         uDuTatFsH/dGgz89/4vnjjnvtuaTLNA6PFBo454pBI3qznU8h6d3757U7G0cNXo6Yp71
         JryD8Krfb8AlzJk/6wFTnhYCSE84+PwjzkFFjAHeohQazXOAgUfnNfXrVbvrzGd7iqtn
         Tz2Tse7nxjyRHPmUtK9GdJNIXTOY0An+C7Z7U3M7t9QGyfhEAcqM5h875Cfm4Mpzrfl3
         2tCw==
X-Forwarded-Encrypted: i=1; AKwUvBwnKDSD0qtfDQAVi3Y5vskJNN+q8a3wCZFoR9aSLLpQP7sedQyRrx3dFzHbv6b9BhEuWALU7456oxgR@vger.kernel.org
X-Gm-Message-State: AFuF++mBrqOzrkBFweHOw/tWOfACI0kVLtF0TU1mC4FEIbM43u3njcgg
	s6d0PIqPEkx0TO4G0QnDV8gipdW9lqhLUGonZVjZIeiVj/ztNGFmHONDtqeqTQuRopJKM+ud6Ho
	nTQUA8vEEHhuPklAc/yK7aTMzLiuxRwXfgkXxS/eQWiCeHUu8Vpbs7FJyGYZp22Casnuj1GfIyN
	5TpMEOj3xsg38zAkkguWzaOEoAKPecnzpPaaQyEAM=
X-Gm-Gg: AYBFou0QvIJliKNtqUyqjx4NiCT6IFEm4sC7Rtop/Jt03jUyyWOI7YB9ri/RCdlmQ6T
	fw1GmlOZ2uYL9QzjG6nB4sbU5h9fqTcVYOkWSg/+f6OllwiYzznM8vptvG5efmOxeynVL6iogfy
	I2OU5UA8mrN9v/w8mNGEIQqjJA7AQXeR6sR7xNqpHeg3HzxkyZ6E0KEPxp+w==
X-Received: by 2002:a05:690e:438d:b0:668:9d0f:ab70 with SMTP id 956f58d0204a3-66f9b93b27bmr2799461d50.18.1788412328988;
        Wed, 02 Sep 2026 22:12:08 -0700 (PDT)
X-Received: by 2002:a05:690e:438d:b0:668:9d0f:ab70 with SMTP id
 956f58d0204a3-66f9b93b27bmr2799438d50.18.1788412328517; Wed, 02 Sep 2026
 22:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902083450.2348-1-douyufan@picoheart.com>
In-Reply-To: <20260902083450.2348-1-douyufan@picoheart.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 10:41:57 +0530
X-Gm-Features: AcwNN1XjAPbxTpUY682euCheD5pZce4ONELDwflXG2pmom4yd0wIGrjfYXZSpf4
Message-ID: <CAB19ukHyZN6kFJ5W9dYLNANmuU=vnSC51D+2q+FhuspAbPg8RA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: RISC-V: CPPC: Implement cpc_read_ffh_fb_ctrs()
To: Yufan Dou <douyufan@picoheart.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuchao.46@picoheart.com,
        zhanjie9@hisilicon.com, yang.yicong@picoheart.com,
        geshijian@picoheart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Qwul3GFx5qf8Ut5VAqFcuSYif-IFP_I1
X-Authority-Analysis: v=2.4 cv=FeAHAp+6 c=1 sm=1 tr=0 ts=6a9901ae cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=TxhyHGSeAAAA:8 a=EUspDBNiAAAA:8
 a=R2scDWojlFBtPnKtwUAA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=VRTRSrWG77IPp_BSX07q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA0NCBTYWx0ZWRfXztxxAATKJWAU
 KfjOVAhDN+1IHR4cskIuqMsTOirSloy5hRpdVV1nkvLiqLmuRZFNTMAgcJdxaEOYNcA0gS1/X/N
 K/qATEnKqKRrRhFHILhz6LqK7BX3Xmw=
X-Proofpoint-ORIG-GUID: Qwul3GFx5qf8Ut5VAqFcuSYif-IFP_I1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA0NCBTYWx0ZWRfX4NJKV+ZsizhV
 L9EI5qpyMB6U0XjRBasNiWmqLMKyUwkycvto6UHb1M3BI36CaaaGyitpH0blUzv/JM1Ft2YXc/Z
 I6f5ZQScjheIE1V60nx5d7wXFr8VxvGhDa7JxpYikCf5BQNagmpdMtn2MXt3wPt7iageQ+AS/cv
 /hsIYEJQ7Kyncd3VsLJYMip28Gm1C4CZ4nR/r439WsukyJk30FF2Hs2mKicBxWVdu/TgWpDLIaq
 xKAw/MvR+RaNnwvqx1Ip5b22ywIcAroGWl9o8GXOihjmKlryP4GsVxQhoMitClcO7ErTgJczNhd
 wfTxm3SkluL5xKWG5pIHT5lV9YDt06O18zannotxxHgJYXi4I4IULL9SdWpb6/NOxrie9zX7mqA
 Osnqk5TOg7oynN+bLhMvUDU+jhyEK64tuNk4t/YVN/jFNeMaQoiDxAgm9AjvgBV7dR02zbQ50B5
 ooarxmJlJxkaXc1wdeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030044

On Wed, Sep 2, 2026 at 2:18=E2=80=AFPM Yufan Dou <douyufan@picoheart.com> w=
rote:
>
> On RISC-V, each cpc_read_ffh() for a CSR-type FFH register sends a
> separate IPI to the target hart via smp_call_function_single().
> cppc_get_perf_ctrs() therefore samples the delivered and reference
> counters in two separate IPIs, at two different instants. The skew
> between the two sampling points distorts the delivered/reference
> ratio and thus the frequency reported by cpufreq.
>
> Implement the cpc_read_ffh_fb_ctrs() hook to read both CSR counters
> back-to-back in a single IPI, which narrows the sampling window to a
> few instructions and halves the number of cross-CPU calls. This
> improves the accuracy of the reported frequency in the same way as
> the arm64 implementation of the hook, which reads both AMU counters
> in a single counters_read_on_cpu() call.
>
> SBI-type FFH registers still fall back to individual reads, since
> pairing them would not reduce the number of SBI calls on the target
> hart.
>
> Testing was performed while CPU1 was kept busy with:
>
>   # stress-ng --cpu 1 --taskset 1
>
> On a CPU with cpuinfo_max_freq of 3000000 kHz:
>
> Before:
>
>   Maximum observed cpuinfo_cur_freq: 3201369 kHz
>   Maximum observed error:            +201369 kHz (+6.71%)
>
> After:
>
>   Maximum observed cpuinfo_cur_freq: 3009646 kHz
>   Maximum observed error:              +9646 kHz (+0.32%)
>
> The maximum observed error is reduced by 95.2%.
>
> Signed-off-by: Yufan Dou <douyufan@picoheart.com>
> ---
>  drivers/acpi/riscv/cppc.c | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 42c1a9052470..2ca98fa69e9a 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -85,6 +85,20 @@ static void cppc_ffh_csr_write(void *write_data)
>         data->ret.error =3D -EINVAL;
>  }
>
> +struct sbi_cppc_fb_ctrs_data {
> +       struct sbi_cppc_data first;
> +       struct sbi_cppc_data second;
> +};
> +
> +static void cppc_ffh_csr_read_fb_ctrs(void *read_data)
> +{
> +       struct sbi_cppc_fb_ctrs_data *data =3D read_data;
> +
> +       cppc_ffh_csr_read(&data->first);
> +       if (!data->first.ret.error)
> +               cppc_ffh_csr_read(&data->second);
> +}
> +
>  /*
>   * Refer to drivers/acpi/cppc_acpi.c for the description of the function=
s
>   * below.
> @@ -125,6 +139,39 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *=
val)
>         return -EINVAL;
>  }
>
> +int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
> +                        struct cpc_reg *reg2, u64 *val2)
> +{
> +       struct sbi_cppc_fb_ctrs_data data;
> +       int ret;
> +
> +       if (WARN_ON_ONCE(irqs_disabled()))
> +               return -EPERM;
> +
> +       /* Only CSR counters can be paired within a single IPI. */
> +       if (FFH_CPPC_TYPE(reg1->address) !=3D FFH_CPPC_CSR ||
> +           FFH_CPPC_TYPE(reg2->address) !=3D FFH_CPPC_CSR)
> +               return -EOPNOTSUPP;
> +
>
 While I agree we can not reduce the SBI calls, can we reduce the IPI at le=
ast?

> +       data.first.reg =3D FFH_CPPC_CSR_NUM(reg1->address);
> +       data.second.reg =3D FFH_CPPC_CSR_NUM(reg2->address);
> +
> +       ret =3D smp_call_function_single(cpu, cppc_ffh_csr_read_fb_ctrs,
> +                                      &data, 1);
> +       if (ret)
> +               return ret;
> +
> +       if (data.first.ret.error)
> +               return data.first.ret.error;
> +       if (data.second.ret.error)
> +               return data.second.ret.error;
> +
> +       *val1 =3D data.first.ret.value;
> +       *val2 =3D data.second.ret.value;
> +
> +       return 0;
> +}
> +
>  int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
>  {
>         struct sbi_cppc_data data;
>
> base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
> --
> 2.34.1
>

Otherwise, LGTM. Thanks!

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
