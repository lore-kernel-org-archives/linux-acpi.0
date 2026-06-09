Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBC3E92A9
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jun 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992128; cv=pass; b=ghJnNdgs+zDxQ950jlcswFzJ1jEceVfXJxfKThEpsk0UaXXbG6Q2KnRtKKN/dNdGTQ9JmdW+sifBP9F+3FJw55dH8f8LgiyrN2ZBNyU6lzylfh6BlB6J0VAwAqqRLP8NM7PB/bnFNkqa6hZnBkVhJ1+khrXDPuv6Aww7ceiqQ0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992128; c=relaxed/simple;
	bh=+1EOZR2wB1otcZ/6xEuFv8g9neuOi9MSaHh/ECdDfgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDe+BhJta8QGIMk9Ow0sOQziWNnga0sL5ghAKrNZiBSJzAsn9/9Hl7JOYWB7PDWavbQUyK5KJ9CNMmOIct0XX5GJCHvCQv/eJD61E1+maZt64+db7W36nnrUagBmhXyuFtewHO6VayoRUAtBALeIWw8O+lRtd9aWsCYpuPZP1PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L46jW91n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FQEeiAKN; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L46jW91n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FQEeiAKN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rb6J1923214
	for <linux-acpi@vger.kernel.org>; Tue, 9 Jun 2026 08:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=ppbxYWmUe+n14dBjJKXE7EunGdgOizVvORmJjhi9sIQ=; b=L4
	6jW91n3danqpMZpLno/pXbgGWSanIfmO9hon068Tpnm9qha7YtcdgtUzxQJoyeYg
	RWTBu5aL53Flz1LEpv5Rygv6Q2Ra30dpOwmmC2GHNZ1pb/hVJCVKGKbhKYN0RNra
	CUenh4IG4t2Fe+PdEeZ1oZZ3R1Ve2CtA/UVCtAYCrbsuuoI2FmP/S+7rdgETGz/j
	7KksS3/qVrZX8vSzYARaeFDUe3TgFThzKaUGNMWM2DJOCJUOD6PyC3W+h0x6cgPj
	hE9I05HmCv/r0kpqpEb9uvq81wreomdAmQZhnkgVanDQ3qc4qw6tGaLprPO7dZXB
	U6X/A5CsUnA3KoCQID7g==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4g508-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 08:02:06 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66044a47d6fso9301449d50.2
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 01:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780992126; cv=none;
        d=google.com; s=arc-20240605;
        b=G5mVMkA+cAEc5I/+nOCVEJ06QuTkYa+lqkiGw4qMrmcRaJl4Er6rp8eEcRU443ZD1w
         99pHPUg6CMl5xFc6r5fuLNfuBsvzrvJqNg2DO6ICIPqDk6ffr6iGKyM6Dt0mHG27NkRJ
         TXIZLU3X6gR/ck3MppyK3g/KgyDin80KL/0dE0J38zHr5s5f2d9Bjj1HdJQ3A9C8PNcE
         5bc9K9bxx9cHRkqO2Yg7DzObL5n0xGyYCP8jVc7PHB025HVYOXvKUG0WQINIRu8WlxK/
         l1A/Ygb7cFhZds/cNo6bRE+vxx045wRy5qP/I4AgdsQ3DfS3JeDnQ+oxTPFJ0UeB/Nbp
         TxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=ppbxYWmUe+n14dBjJKXE7EunGdgOizVvORmJjhi9sIQ=;
        fh=LTu5H5ZYBpnj3BGf64pr4T362Gtvr5aEuNg5QTW2U9s=;
        b=ji2R9YDCfz5FWuH3QbKkkbUzqUZ5E2qw9TW2JzYDTs+e5YQaBiCx56we+zG2Ectztz
         NawXKp2RI+8N2dGQtcikP7HFLEkqDEkMxJfUXJ49/0jQjapLEbqfp6eqgr5V4iaawDxB
         EVNKC2XDdjlZyp2/qMiL1pwjPKlD7uyrG/8lNvV/rbrj+9ioxeDMDd+q03aQMln3NpnU
         4KB78Y3TDYk+ngv9pPWfR9UbQjtwdtM+Tl/56OL8ipxzh2C/90z5XgOGz0PTDRU0N08P
         wWFJ/o7lRPehUd//N+Ri8WMVf+jo1Mt9cCiAdhcaPKaxkbvbD3CiPwZ0dWiXdLB3MXsZ
         yy1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780992126; x=1781596926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ppbxYWmUe+n14dBjJKXE7EunGdgOizVvORmJjhi9sIQ=;
        b=FQEeiAKNui0UwrJgGnMiUfl21t/I0wYLJ8jNW3v7/Tg4m4n7ZmXw4YG0/gMltvPTYn
         t4AeMdeVRwjxD850aA7MEI6XgzSxJaU8qvs1o+Tvz0u3XPP5iHJbIIttJOyzOZ7XkBy+
         RWK32vFimOJA0uiYqmc7z/XQ5pHZayTstKZgRyrE0M1pY2ZrET5iGF6se754rpE23cAE
         qckt5+ypAne3VKytbz9TWBQoV+lD60hjFRDT5Uj5USFrNWV9mWPUSeXWslt0xQH+3Atq
         DIemziy75jj2YH254fyxqf4yZytyJXK7K/7zJYO2VubhTQEVSEXjffcZlFRGJ0ann9I7
         JMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992126; x=1781596926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppbxYWmUe+n14dBjJKXE7EunGdgOizVvORmJjhi9sIQ=;
        b=nCU7pNs+wsnbbS+AKR+YXc+djJX9kLN4iZmiaZZibkXY1tpU0yXHgC+3CMt+QiMr+Y
         t1d7SiF4/Ay3HDWVyxnh8saqM4J5HiX2jIE/NNk6pjHImkJQ+6FweJdP9gmeyEeIMsRQ
         YpIc5DRcFsNoiQD+V3eUzpf6CXGmbJD0rad5oQR8BDWyTEWCkcfb0EBT2kA+hCmWOQex
         4EFsQ44fOHiNJpI8emJ1KKFHXBLtyOWQjsz7cOuS3Dxu4lQeSRPaAvyiIClS95k9fBQP
         Ja56dG5D3UAKIcEyP9aP6DPij0OvET/1z45EoGwrgIzxyTfzlVBFTA3uJvJiIOFPzNk2
         VOmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZcKf4nNG2XxXj/TPkwE4plhRNr2qUiF8aHTThMnUltxfhCRuB+0QGQCqGiruoRMYU0hQ21qcSLkEe@vger.kernel.org
X-Gm-Message-State: AOJu0YzXB0nK7LumSM+ndzR4O+58Snd6Ohnd63ZatzoGZcmyqzu4d7Py
	qFiZ4d87I+FU4jOhsLQ6XNQ6UkEr3SPyUC1Eip4YoZceHRXNZK2rRwvl5AltoBwhvC33Ip+gRvS
	WwZix5JQwV34wDEyx8n93k+olEZ9/dLYxWr7asp4FjW/l7yYsaiR74bEZkOcIfRRyMAXPxJH9WT
	MedlNTnmZ9w6Mvjw/JRsmi03+Fw9sm9lPRUHEzIAQ=
X-Gm-Gg: Acq92OFUdQlJG1gus+q2m8lBLNoWADoqw6FpHqRhfy7diSt/seNWIZGAUvodUWF2+1Z
	gNDefQv2Iw8w0gBfTktIOCPay65lXtVMw/3hpQsxOkmzTIsxayFIz2gdXoGVTuEO4UbCwOXonHq
	FBSYz6IRk2JxyY2hD68V413CJTrpxEs3BQwLRu3M7XRQG5pbKcj7kayQs4Uos9KNuxUQNbHbJ1o
	a5jgRTeB9BgLHhXqQ==
X-Received: by 2002:a05:690e:4144:b0:660:a653:4495 with SMTP id 956f58d0204a3-66106e01386mr16440747d50.4.1780992126066;
        Tue, 09 Jun 2026 01:02:06 -0700 (PDT)
X-Received: by 2002:a05:690e:4144:b0:660:a653:4495 with SMTP id
 956f58d0204a3-66106e01386mr16440721d50.4.1780992125662; Tue, 09 Jun 2026
 01:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-3-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-3-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:31:54 +0530
X-Gm-Features: AVVi8Cdab09nLFiWsiig7vANHBJNBVR0v6HSRzUvHph-SxzBxVhm2UenvmNafPY
Message-ID: <CAB19ukExADA6W1pXDqVdA13BGLrtbG1nkfNKVwKyCd4yrNtdMg@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a27c87e cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=lDU5pCILgqd7k7drH44A:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-GUID: R27gI-JCEoT4rXpOHvgflg2z6WUFH6cK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NSBTYWx0ZWRfX0azkMj2fxAaX
 KqKZO2z25Lz8u5SdUzct0X7L46PZAUvnZy81E+3Ie0eZts4JF+/KX9E4TcTBw+OyJsBR6ow9GXm
 C91qjkoQLx4gLKPRhn6jQR2NNmRY+OfE30GgZOEMINL2ACmN9zfN4hlPjrh3pQoTYakQbEIWbqL
 o5VytWS14SPCptdpe2MTQ4nysnUq9BQCG2ZF6IsqK4i5ppC0NmFOHOAgW5nP+9JRtUpnm2E5Hd9
 PERvi/Wh/8MS6uPIIKP1v5ATbREAXdCgFll/ehnF7lXe/+rtO3NyLSP+TFJnHuV2LbeU/5rrdJh
 1m+/1pyLgoZpcNDcQ7oa+n9F+nP8IrowCYEV3+U2kv8Omn1yfLeimJyV1lrJxBZGb4mbAPkFRzx
 hVWV/k7Tu2Lzd1K1Lhpk3knrtKfjsAiYUqkz56z3WZ64nXzA02Dq5vchlizxPjjxxj8W50ajqRu
 qE4WEEOWUunxCFScBSg==
X-Proofpoint-ORIG-GUID: R27gI-JCEoT4rXpOHvgflg2z6WUFH6cK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090075

On Wed, May 13, 2026 at 2:13=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> ghes_map function uses arch_apei_get_mem_attribute to get the
> protection bits for a given physical address. These protection
> bits are then used to map the physical address.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  arch/riscv/include/asm/acpi.h | 16 ++++++++++++++++
>  arch/riscv/kernel/acpi.c      | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 26ab37c171bc..c142db9f81a7 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -14,6 +14,7 @@
>
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>
>  typedef u64 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID INVALID_HARTID
> @@ -27,6 +28,21 @@ extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
>
> +#ifdef CONFIG_ACPI_APEI
> +/*
> + * acpi_disable_cmcff to disable IA-32 Corrected Machine Check (CMC)
> + * Firmware-First mode. It is not required in RISC-V architecture
> + * and is present for compatibility
> + */
> +#define acpi_disable_cmcff 1
> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +{
> +       return  __acpi_get_mem_attribute(addr);
> +}
> +#else /* CONFIG_ACPI_APEI */
> +#define acpi_disable_cmcff 0
> +#endif /* !CONFIG_ACPI_APEI */
> +
>  static inline void disable_acpi(void)
>  {
>         acpi_disabled =3D 1;
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 068e0b404b6f..7a6770697999 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -204,6 +204,18 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int =
cpu)
>         return &cpu_madt_rintc[cpu];
>  }
>
> +pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
> +{
> +       u64 attr;
> +
> +       attr =3D efi_mem_attributes(addr);
> +       if (attr & EFI_MEMORY_WB)
> +               return PAGE_KERNEL;
> +       if ((attr & EFI_MEMORY_WC) || (attr & EFI_MEMORY_WT))
> +               return pgprot_writecombine(PAGE_KERNEL);
> +       return PAGE_KERNEL;
> +}
> +
>  /*
>   * __acpi_map_table() will be called before paging_init(), so early_iore=
map()
>   * or early_memremap() should be called here to for ACPI table mapping.
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
