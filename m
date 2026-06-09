Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3C382395
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jun 2026 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993659; cv=pass; b=BTma5oNuQoDkeitSoafvKbdvtlJZJ3GmdbnOBU5/Ctab3QFghdCMl2dXZVuzfa/KcivaVkTd/dn+vamPkQrc3QZC37tSufbjRFHvLAiUlEGe6M5en/r4UGc2pvZj/Ca1oNeeP6NRNMvg8Kn+XQOtcb4kwn9stBOJxisd8PvIcCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993659; c=relaxed/simple;
	bh=1yq6NLeTXKn2qxQnfkuIZx97MltL8Uj5Dvhjzl5v+/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/1x+VzpVAKk6apjTkHvgisoEr1qrXPiDsH9V1T/iNYJMNJlNNGpu7MBMLJOhNAvzgD4oiYq03gpVar+EPZIbRYEe6cmKs+L58gO7jZMGQOmxnZCh1M+OjAHSxZMNdpIhFbRzkB5ZNp9Lx5NaiHJTEOScZvxXvGHG+QWwnm+Zww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9+ay0tN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pom7KRDd; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9+ay0tN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pom7KRDd"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rdDV1958629
	for <linux-acpi@vger.kernel.org>; Tue, 9 Jun 2026 08:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=TFkSAnnuzu4vpgPtCevU9biue3ziTEZcQbHKJrTFV8s=; b=a9
	+ay0tNlJqbfko3akJd6ZxVnaymemUIb0U4vMaEBJicsXy3mKJoGs4l9LMFjwToas
	Ojj+KBqwFXM0pWv2Z/iXLzdwRNb1/8tZv1AzHBofi5WkV0a9WQWg9u6oc5yAvspm
	S3Ie84Q1u7WKdC7oRtNE4tTvTabbfG3i3Kdxv1IH/KxuRbJSqQ5PPfOFmISACeVt
	Ro//6yjwkHHPgyWNQcJKzVSqGuX1CorJ82ERYhwgBJZtuycC7QT4QAPAJ5tiqjQY
	/BAW39z9JHJ8s+kZOnEy3P+UypuFrtR3/ZP/k5EDax/A4OXikUiXhFgI66oZJ4kb
	8pBNoBGn22Lb+NeK2OpA==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdds8hsc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 08:27:35 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66043ac620fso3845225d50.3
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 01:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780993655; cv=none;
        d=google.com; s=arc-20240605;
        b=YDSs8vIFvJWeFf2pEnalEl8wiRez1c+QBN9DBVEPBbyOgaOr9MStfI8MXl80yOF9V+
         kHlUEziwX8DBfJkpsIHT91RUDutjPR2zX80xeLhkxy8pITATOI2QHUJyVcNceqosATQQ
         Cg6nUbXA19BOcNyX+uUdtu64XGgC+xcIRSTomy8XNgb5kLYUFqYV8+ecq4hASePQlOD+
         2AJ/6Md2oXrPT+zOFmp17E4h2GDENnSXVDm0gZO95AAnftFHoL7e5oyTYyK3mFFL+s5g
         hVrch377zKYMyJO0K1qEc5qCBNKUM0TB5RGiBbTfwcMvGFBjki9KfWcwZ3DnygZAzg6p
         yZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=TFkSAnnuzu4vpgPtCevU9biue3ziTEZcQbHKJrTFV8s=;
        fh=54YAT+H9WMtPy6FMa35HbfjdSxWK1Bb1Yw3Q8oa9nfU=;
        b=ka8g/L9MUgcQ14Zlnsk3VDWWN+RAch8f00EZ006deHJW4bK2HiWrT9PbR7Br/n3qTf
         mlSJAsgusrvwmanwlU3dqUsfNDsSxxnLfYOGnzB45y4Gz92UVjBMvs7QnIyRzeQXVep/
         ZEZ8zxnXIWHqKal095JJ8/jAAJhwglka8vwUKe6FVaUkTfGob+9cm6aWLXKK1o2U+mTu
         rVK9N5uGH2+rzmvLHUl8XdtXJW5K2H8qH5DJ6H1gEmGrNKy+SPMC8dxF6WlsOsTnUxv/
         fkdTRvu86EWF9he0LFxL82RLhlAquR/PdcWz8cBteUIli7m+fmneYAQ8TIycfdTenB7o
         rLag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780993655; x=1781598455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TFkSAnnuzu4vpgPtCevU9biue3ziTEZcQbHKJrTFV8s=;
        b=Pom7KRDd5vPCamRtzxCwYb9y/ZLjnwxhcxOIDkdVjJ+OLadZ5ptbTUiN05a0rOYctu
         nIqzmujZHCX40Tgh6IfnXToRGJIPgKNF2Cjx8wKt1mCmyHoh3WaG76uCE/qHK/73gL3S
         iONgwVr7RZiT2z6ROsuFeAZXoLM1CSeWqRU6mWwiKESAjJz/EIItuei/ryZA94T4IDZw
         Lh8WOfR/vH7EklnXMi+4zLKPwip3rW5Cp5Vs8+qzr6MeduyYQMaIwgQBnZ3u9LcmT5TW
         gz4kjiV8CW6s43NvfxvCYvTF+3CzZjiKH2bE/nDcTXkEbx7ML2LDeOAX6WIkXvWkOMQB
         1Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993655; x=1781598455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFkSAnnuzu4vpgPtCevU9biue3ziTEZcQbHKJrTFV8s=;
        b=VJxKtOUk895YuL9n+MW7kINEQnrHwWSOyjs4eYuzpd2Q29qsC/dXqF9unQootV9wtr
         2UDKvnvo9fuUcSKa1cLg5NIDcRV+Zda3/BpjRNdf5R+flDh6DDapgCn05xu9g53MwBsR
         OXNphBJ1/Mu52YLJFJU+uw6yPghHzN5Zfnief8+REw81snKhVwrcoxpYq2nOlsMD1AJH
         dbMU9u/REL5pTrVK1rJD1LViIe3PJ3nYq47oBPOqeVNM24OvoVBnN06t/FVKLHprW4c+
         uRivyE/1QnpbbSVyEwSMTVQ07oz/i6Klj2Jcb4tFl9JRgXsfUgWNlzxGCxPZMj6nphhh
         bajA==
X-Forwarded-Encrypted: i=1; AFNElJ/X7PKzYuOgRZuoOSp9xP+pu3jxpEBjwpzKHPjqb989lMkgREpXLpPCGUYaxZsPP50wxOv3caGpbuFK@vger.kernel.org
X-Gm-Message-State: AOJu0YznEbZPF+8SiTasrokKcC5pf9t04fLf0wf0ILCQMe6rUNTbGQf7
	/v++xxJXFJoBg7OqMNiXbbiEXU5GGqefnuDScxIHY0JCW92UWm8gY5c/HIAJ2NrCcOzSZdDt9Dj
	pOL0FjamS5EK9GesSyQ62yYnjk+vdTGWmDBl6EIv6c8I7Hi58sRCciHCE3UagqWaSaviN9Q5vVI
	uqaOniWDpBKs0iZG2IfvMIuiXzj1iji48S+bgi3oY=
X-Gm-Gg: Acq92OE7AfDUQYDuCKBRLcRqtY5AKTpGb+3wo+lBxdojpLyebvY9S/o2Nub7fQs/TR8
	lJwF3r+MAPBgHvpLB2PETa7CGYXX93RPT1NyTB/J/o7otMtvNAsi2JDFGviBJXvBNbGMRrBc9EN
	hDB8CGpVSoommKkv8nLinAy4Jkk6qTcsDHSmlQDo0SNTs9ATRRVhumVpZ5BuIX94qTlgTHgo1Vf
	iOG4gwkzTX/u2amYg==
X-Received: by 2002:a05:690e:168f:b0:660:ea4a:153a with SMTP id 956f58d0204a3-66106f4d882mr16311100d50.22.1780993654664;
        Tue, 09 Jun 2026 01:27:34 -0700 (PDT)
X-Received: by 2002:a05:690e:168f:b0:660:ea4a:153a with SMTP id
 956f58d0204a3-66106f4d882mr16311086d50.22.1780993654159; Tue, 09 Jun 2026
 01:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-8-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-8-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:57:23 +0530
X-Gm-Features: AVVi8CfQL2ndPqpNPolnsL7-JCyoUBHFD0_-DueGPSQTd6Hneha3xqLb-1My64o
Message-ID: <CAB19ukHDB6viGCM7FURuqsR_4E=bb8nd-z-Y32+mgrdBT7JB-A@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] riscv: Add RISC-V entries in processor type and
 ISA strings
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
X-Proofpoint-ORIG-GUID: HayGc-YM0C24JCvZF-eV3YbZPlOncGrH
X-Authority-Analysis: v=2.4 cv=EI42FVZC c=1 sm=1 tr=0 ts=6a27ce77 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=_3BUxsq8Yho0MmvbAbQA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: HayGc-YM0C24JCvZF-eV3YbZPlOncGrH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OCBTYWx0ZWRfX0dGPkr4jvq/d
 N7OZtCff1jFcLOrRRLk7ptS4wgKfY6d+L3RZ1WHWL5FL2ZK9rbnMQMfEzOfropJEnh17ePhWDyV
 cmUCZu3AB76F5sxry4nARTmv9PjD8f4vv9K2aoBYrO+1Pfg21qHJ2BZ288hZN8HYqBYoiojJ9e+
 zLvFP2Gk1VM2FOwxLXu62pELDYnWL1SbMgZy53PVvb/tkNnY9Hk4Vxg6QYwApImF/e8fE0b3mZg
 7BRxuv1PkW3LXAuMgj4TTUiGn195nmQLylWtDNWqd+1CFP3TRdo4PdO62cbQa+CyHMd5zDGInZU
 yoqFQS0JIgitGy+LAZN2hYudCh4sIAYT1EpGEktmfhp2py80o42Ih/lGhK+Wl3yBKHyIOAuxjjJ
 KHWdI+dWruA6s6gOdF0oQ3Pf4gOkWmDdrem7l5AJleWlUHVKNAwXlretWvNh66Uh/pPl1UUWBH0
 hsV01p8WpkVlDfvBGmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090078

On Wed, May 13, 2026 at 2:14=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
> respectively. These are defined for cper records.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/cper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917..1b1ab2f1355b 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -170,6 +170,7 @@ static const char * const proc_type_strs[] =3D {
>         "IA32/X64",
>         "IA64",
>         "ARM",
> +       "RISC-V",
>  };
>
>  static const char * const proc_isa_strs[] =3D {
> @@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] =3D {
>         "X64",
>         "ARM A32/T32",
>         "ARM A64",
> +       "RV32/RV32E",
> +       "RV64",
>  };
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
