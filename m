Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36B13E51D2
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jun 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993038; cv=pass; b=RjQaTpDl53MpGYDjO2pJxBWUyHGd8F6zh5JKidup5xWsmzYqJbQoAGwNM7LW4LKeFGKwLEcZoOww7mGDHzOZ+J08mTMtbgwaWpc5HGSW0k5ygR4t71DCEsK8Lm52Sbt2ZKUUb3nXqEIqfQvblxu+Sw0p2g0Gqd48dOcTJFtwCXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993038; c=relaxed/simple;
	bh=dWJx//JOEjj26wHu7ehYPbCtKxGVYW0K8EvQVYpijNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7SebFvIXq12R/MVWv4W2jZWTVzzWVOmyBWCovAVamA1jswxG9CrHIjgoLSRRLiBefgNoSVIgsUUuMYtpTPLWj2GeXcf0H0mRfqYzPGp/3D7DFeEuRUUwMtDufUn3BymWh4H4hTBFBDJgZG04jHunSbervFB+oQ5dZiftkq2TAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eQk5Xu9b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d9h6AFAo; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eQk5Xu9b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d9h6AFAo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65985UOt006903
	for <linux-acpi@vger.kernel.org>; Tue, 9 Jun 2026 08:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=jvupPNCldiQKAIDZ/DjgPDJckTZ6qUBUmQZPH8bK9Sg=; b=eQ
	k5Xu9bgZXNXJ4bQsWSdE0Q/hF3srxk9yTe3JRQkdC40uDEowSMrqS7QQqHTqZxVk
	eCGeFEusOg+w5sz7cCmeEO1aHxb2d3NamlhES9kf/HO2CDCbvfCjo2vAo9ww7EUB
	qr/0zdDRAgFFq2ypYQ28gc8ntwbaW+2G8MtoKN3iiteLwr3qDzMPGyi0kXSuOpay
	DrYLUpeGo41/qmgvY5kLPgIM+o7n+zoNoKMpXZUOMwx1w6psgTzgWXpXhSyQi2j/
	kpMrZ82TNStzxJqvdx+xZgnohrv2T+eGo/F5vXVaGUhCqXsDhaUJqx5NkU79XOzW
	kX0G8azJRS4o4VXLdPwQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0sr1n6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 08:17:16 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7e9369f8d35so11143167b3.2
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jun 2026 01:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780993035; cv=none;
        d=google.com; s=arc-20240605;
        b=f3Pb8VSUYDdjt2WUUtsBte6Tzy/zSsfm0PcqJQqnCgWlatAvdEL7zWJokNWKDGKc6y
         WkSuWKux7wVMKtSZ30vLcOb7Pfv4HvQLmenTpuK9y88EIvnLN+PIBUhhYT705dZLCT0F
         J6GPKNtiUneOIeS7JZUGy9pyhop2OIXRPMVRIcenJWSn9WQ56IEconY5DmwtOKcWxxZK
         bl7pU4iyuy3KfQ3L5U7UAVdOAjvLa97cz/K4y9G/Z+bx8IzTcpp7Ent0QXT3KlOl3QUW
         pAl8ftAA+O/afQppEoXD5yBCTTHhh0FsVtZylw+xjvkLKIgu4/8dHQR61ypLLI4wYIOe
         nJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=jvupPNCldiQKAIDZ/DjgPDJckTZ6qUBUmQZPH8bK9Sg=;
        fh=jy/KQJ0pmV9MMBirbKWOLxABoyFzEeQcYhTUk8Vt6x8=;
        b=ZknTiyXavd68mh8o82Cw3rmxPKotwKxND8iJi0emYJ+zJQD7SSQKuKoa7oid2e2L24
         6dnqSHW2aGmI7qkBZwHUVEAqhi7yOLybkB2brsWarnmiW5bZJpRuswvtXTPEuRR//FkL
         nCpQhM4tAlPvg49sotV+kZHlFBncdVdIlE98XVfYBZh5LcnvrApA61zjEU4EJDMm7aJS
         +cfsEjmzNnlp8aX3FcqzxoDof5cAVNZVp3q66Wk14h18I2s61n6XKqp/cqOLUgBRP0XN
         CZtHBXPF7PppWVUnea+45PuaJpsQYfuYwKb56YffyC1M5J91UYs/aR0IGOEEME7Dehgm
         cTSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780993035; x=1781597835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jvupPNCldiQKAIDZ/DjgPDJckTZ6qUBUmQZPH8bK9Sg=;
        b=d9h6AFAorcyam0RJ1HuJ8e8jYVJM82lm60dveTKDKSdImXLnTVxnxCqSzpnglo1Z1F
         qmrNuAKvd8dnymOU7WG/ZHOpLDpn3QSt04kOgtFAthJl2oZ9B0xrX2W27peFL54rdU2w
         ciHn4dSkeXPssbW3NlyKXnOC3MON1dy2Mu8L4Nuub+bp3RVvrijWWsUVGGR/rx0nl75l
         X13bLfrLx6ss8HgE69NWZiaYrSA0e8NTlYyLtIkbvx7sl8Qq94/M3tFhdGZWurTozhe0
         nDy+wHcHcobMQ0tFChgBVKgB69/0S007toKZQR9WYTv55NlyeB7madBUZOFUerfqZsld
         femg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993035; x=1781597835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvupPNCldiQKAIDZ/DjgPDJckTZ6qUBUmQZPH8bK9Sg=;
        b=p2wBrZFKaSh8muppiRezj/hk6HZ4D3GgQMy7gSmWlP01WAKtHdPvTPqCkCo40ctHp4
         m8TTo9zrW4P2wmRYnbq5Fa/KPtXQK+ZPeO42I2zaePsV8R7fQKHtV/3ZfuvVTMw+L+ya
         FFZOAqWiXiVa3i8rfKHT7O4bEsdH0hlz+rvc0WwR5OaPuHik/nOb9zvKVMwfrlddV+Xk
         VdtZfAWPGQXqPGzykp20HN9mdUq8A/aF8JYYjmlKwtuP/eu1OJSsM6AWWl3H6rbO1yo5
         jkfxhx2WIUof4aHEwSNFH8QtxCWKKf7dMW8wb2wtsZZ2usoaRGL1qQsiaOehGm1ZIPjN
         R0Ng==
X-Forwarded-Encrypted: i=1; AFNElJ8cBu2JLVWnxlVJ5M1RN0AxX4HXOAwN3P+QkNK5rV18l0DIosJoKfBQ1DPs6AR6qLTuqAUCOK+8sbCv@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTf0+Ez1TtAjVdYk/WPvBvVJL7XAv+dDwbblTGmTh/+gHnc50
	kjxa8H5RvlvtphcqB3/8IAMFKInG1441mDflxStyNH8KSnW2X3ug3cxirAekLGzN2czxC0RIvNx
	idBo7MkOxtL0/PBOyhgnFgPeOFIgV0K8FEplFlxHwhb7HZTd7D3RFh6HqW88nIKaIR+0yDUmY9I
	bdI4FvWluzr6VeWsbSM68E9Tp0nxn860kFEANfNxM=
X-Gm-Gg: Acq92OHlIT0Gq+XKYtDxURRp7bQZSTlaBe4N9baZI1XMgsWofC62gpRHsmh6sk427Ji
	5FmOTL6xfXRltzBYeACkbKEX/uA/s5MBWM0GEeCW5DJbBzh959JYraCkA6bdqzfpDmwyrL80ZQt
	KDohNHaGc4ER76MsZutjmDxSApIacJ+6hgahNbf2tDam+JX6RRap0Z6ASCBZD3A7zkh6lkp7kWK
	bvQFGsZTJ+FUStozQ==
X-Received: by 2002:a05:690e:4105:b0:660:2f29:9d9c with SMTP id 956f58d0204a3-6614f8195bfmr1177974d50.57.1780993035322;
        Tue, 09 Jun 2026 01:17:15 -0700 (PDT)
X-Received: by 2002:a05:690e:4105:b0:660:2f29:9d9c with SMTP id
 956f58d0204a3-6614f8195bfmr1177943d50.57.1780993034797; Tue, 09 Jun 2026
 01:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-6-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-6-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:47:03 +0530
X-Gm-Features: AVVi8CewdCgb0dSR_aOfcZlf5FZmhKTqxG1BVy6uKMuIOJaJR9mdub3hX1vwY7s
Message-ID: <CAB19ukEWxUTnouJLG9pVBkS9VcfdFP_nVdG9T6V_4dAVLDNKxQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] riscv: conditionally compile GHES NMI spool function
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NyBTYWx0ZWRfX3j2423vsG2uI
 LmVaBI3m7/chnJt4Gsl1bqtFA0Lqsx+b6AxDkQDRonofirDTR60paDMIZX340l2kW3nbhKcaZED
 qO3wASGBQJCnkfk/Hx+LjUvO6qwzJUKogAfkN2Mm6Y0yqY4b072EZh/b1Y86t9BnvdDJ/q9bMIL
 2zcEm4uY0k6a9BwWVFfCIAqJtzt0C9j0xTGZOhm+REyuKF9S4d6HWG0+HZbRKQZ7P5SvUl+r+0V
 VqSsEU42YGlLf54Hpng5oRyTDskRxiKw55EGCeSjv2aSZDVlJJjnWiNdIeLdJ4dAZ3XuzpKsvOV
 lvcYNUuAuMWfaHzdDODT7iZFPBjnaUzWwmJ5IQzd3JRGIicOssWTT2++op9q27dOxY8pnYyHCNy
 yL9fBHwI4bYwlDRiQSBgU6BTS8DE+ZqeSG3p4iWvW8EOVmgjC9vwr0I9Iajj24qTFO6/jRmJTIL
 dLkqTQse21uo0C+Gi7g==
X-Proofpoint-ORIG-GUID: d0semYV7nvZ2KTGtZkz_C6ujdPNyv1Or
X-Proofpoint-GUID: d0semYV7nvZ2KTGtZkz_C6ujdPNyv1Or
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a27cc0c cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=9L7PnyXcnU1f3mQPG5kA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090077

On Wed, May 13, 2026 at 2:14=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Compile ghes_in_nmi_spool_from_list only when NMI and SEA
> is enabled. Otherwise compilation fails with "defined but
> not used" error.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..8edc2c8db1bb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1397,6 +1397,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes =
*ghes,
>         return rc;
>  }
>
> +#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
>
>  static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
>                                        enum fixed_addresses fixmap_idx)
>  {
> @@ -1415,6 +1416,7 @@ static int ghes_in_nmi_spool_from_list(struct list_=
head *rcu_list,
>
>         return ret;
>  }
> +#endif
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
