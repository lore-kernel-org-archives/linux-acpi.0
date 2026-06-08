Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9293C457F
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936709; cv=pass; b=QtgdUJz716VsrI11aCvkhV7+etkVtqwxdl5ea92udJd7otwRumoovkJXP+6bb55wl5nd2VfCf26f9bFSo3xGh5eih0qA+Y8Xnyph65fUtxIVE/yu8DS8B0z54pvs3KTff351QBS8AoNxm/KVJID9jg0l2m8Qvj0cdn7DmBORD5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936709; c=relaxed/simple;
	bh=Vm3wQtaCS6UNXPo6wK2kH7vneATSo7Rhq6i2ABg2hBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMBpk6dDLsOIb1Jq0CSygb5mPHxDxFqD2incrEoLogaKWmC72gdIaac676QSWh9XHeO2zm3q9tKeOflNQn69+cyYzefdhgr5MACSH39pYZm71gVNdnOAHUnH9jLFWP+yRYSD2xLTk04/X1bWr8xFQRK4YWX9VK5ulY37leL8O8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aLVN1rGk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kPW530wS; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aLVN1rGk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kPW530wS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFYsB3588465
	for <linux-acpi@vger.kernel.org>; Mon, 8 Jun 2026 16:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=c+auThQZxPAjxDc0fMSepBAYMkGW6rfzA+iCSa7438U=; b=aL
	VN1rGk2GnCSWpr/C5mhI7V/5mo7au+DRCD5bCtE/56VkmF3zZDD5S4QGK7eSdi5N
	UDkPQvz/UwKEQ20ogLUtz1AcvotEMA2huV18YXdRP65okCDNEJ6s1EDD3/5TwpDE
	4uwuNiz1cEICsvSq5yq0VanLSarRqXHJ5Z/nihGen/hbOw+rv0BrlL6ic+AjCYVB
	sC3pDYPM5qOzS5R4T2Oa4Mft44f38yL7Ok/A+AK4478fvwXX47e5FexQBHRoHG9G
	JUvnodwGcFbbiUaiSjH374OIWgz7p5hfDSJLtjjr8OF4szDFHS7ga8B9VfPqNUN+
	Cbh3tK++gPAtQHfjYzqg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun41tvm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 16:38:27 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7f010ade153so24560967b3.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 09:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936707; cv=none;
        d=google.com; s=arc-20240605;
        b=E6mwNwi+p0WykaPEk+Sf2vCb6JKjMX9YSNYDj20lfrwmbHXhqv8R0EByLcTNFtmxUs
         E9qGVcN/QnlRbmhAdD6Ha9Zg0/Lb/MczIPIGf0Q1MrwqWppUOK8eAUh6Targ2ZYw7LQM
         DnZi+nGHPLpoc09KN8RQ3Pw8hJwIkIDPZIVgYlQVy2WR0qHHJtSn8or2uISSRfBv6BDS
         dQBUA2I8KcLs/4RB95pD3RGhnKFZmxrD01/bd3Ta+9tA/pIqBYji7b+kNRPkHijAmE36
         Ahotghyb988EnmLg5h4rAmwaUEzagphgToglVSWCHn0mWY93BLAnTccEm73QQI6vwr3U
         IzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=c+auThQZxPAjxDc0fMSepBAYMkGW6rfzA+iCSa7438U=;
        fh=4dh/dgnngmPtneE0aTpMp+n/rqLNl7SkcuBT0JpEsxc=;
        b=dukDuPD/iJMYIxK/Qvv4GeWFSgWqgOspXE7P0O2Ig2NjzVVxIGHsgwaBFoonkPjsWJ
         BKnK9sVfpe+0k571xhT7vkbyToq6J50DAF3w5IrebFIilPDC+p7MkVUA2B5iMreSxJPn
         kxlGe5qqGqvr0KpYE9OOhhcCuTbG5vCgWrV29JuE5lvNttHmaGBsBQHrywaWOud7TwP7
         ySMbXuRownheIIyDJtDdinBZUqDEJ2J2BxPSnEGr1ZQa9cwHu8XdIuSasE3fmneKtEvj
         xexyPZ4WXo8ezdEx01CISfIVHXRXwha/e/SrtD3sC4FBNDo8p+TKyw3PW+oBBL0QX3HA
         kKUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780936707; x=1781541507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+auThQZxPAjxDc0fMSepBAYMkGW6rfzA+iCSa7438U=;
        b=kPW530wSx9LZGBR/2zdCDYQev+YHHJX6qkW/f1/zU08BrmBkWh1XzZkLxUUMcLLbDY
         avsWa6SEl04Hw27b518guqRu/dfWNHC1H6fRIMTKzsZzINBZE4W1O34ANR/krT369sL5
         Gy1K8RVSVirc4Tltet7G40YkZmHFh34i/wGZud0dOJaBOZBjlTXjfi6HBVXI0CSdprxj
         5d0Of44I+5m3HSd4v7WZvikXb7pKw5netffncqVqdn2piazR4ThRd/sWpaTNCGwCEbJU
         mcSuKPLWhEPGhzF7UHOw86gdIH/X6WLCUW+QamJ9zkqntZx9k1P4rAiD2tZDrvjNVBm7
         wy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936707; x=1781541507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+auThQZxPAjxDc0fMSepBAYMkGW6rfzA+iCSa7438U=;
        b=cLaCyDHSY1eVYFrg8d/JJYlBZrwecX0nAGYZvBOBiaa5AtKkGu/LywHbrmZia0Kt8z
         8oEymhkcoA73xoirhXpXlxi2v3ADek4zY7manwYZGmuL6KcemrbJzvPPJVjQXJN8Qyic
         /KmWsDkXhes88QpoEP4FGiEcNmJtARyIcevnhK0Tuq2LDprUNwkNEPLqGaMrA1ruD/6V
         J3aO35Pqg6TeqfBuUy1h5riyRuKqEFV0VZT1zuKl0HaIjU42tftIFebU1uTJ7w8YKWfN
         aRwgYHvP9SvaDMf853cslDD7XztNcaXznXEFv1K5fFT8cq7Z12AZEf7x7OK5hyI3OqBB
         wPPA==
X-Forwarded-Encrypted: i=1; AFNElJ8mEStfem+g5CaW6aVd4lqW9Y/iaKMBhalHGq3dnpUa7HFgjiULNpMqIcq0zPTquUGqxdFgBf7DwSnA@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpRzwo1BZWRVJlpCIlIdskDf54nnNXCd8yARw5tOCKbs9qcgH
	qrjfzc9+kap5I13hTDjz3bLzHqAxWi8DF6PVjT/UE7PxuUwd1QE09/ZV6ygazubXwWO1TcxybgZ
	OqgW4HM+GrvGJqSHln5XxyvQmVuYAnUckwICZ4Ltn9uixK+02cYLl17lF7YD98Ctul/0RImnurR
	lBg/NLsZXnAy7gMMiNOgO0kwHgjMRG0b/ClNvWUns=
X-Gm-Gg: Acq92OH6RRgC9OkJKmjSOt8cnCvvtGwARj3De+t4r/SUiel9nOWA90DX4O/lA7GNxlR
	z5mUJLBdg7c5s3vPjn83rRqercFql9BDMgV97tPtxKsc+sAw5mt46lDQP90BxDLAfWY6HlOwUDc
	H/9Q2++Loh3nEOrXyF/McSCjUi8UWMA33ABfW0GNvsqAHRuDI4327KGdBwuWC5u2hUtSWgP2pE3
	PmbQ+qOO+X7Ji6aJA==
X-Received: by 2002:a05:690c:e3d1:b0:79a:60f6:c5ed with SMTP id 00721157ae682-7ed0d3cbcc4mr155717437b3.6.1780936706573;
        Mon, 08 Jun 2026 09:38:26 -0700 (PDT)
X-Received: by 2002:a05:690c:e3d1:b0:79a:60f6:c5ed with SMTP id
 00721157ae682-7ed0d3cbcc4mr155716897b3.6.1780936706088; Mon, 08 Jun 2026
 09:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-4-23ffa16b6ebb@kernel.org>
In-Reply-To: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-4-23ffa16b6ebb@kernel.org>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 22:08:15 +0530
X-Gm-Features: AVVi8CdP_PRc1DJjUVOc0gMS_HHZf1oDGc6wp_gUILbiw5JbF5QWPmOsllQtoVM
Message-ID: <CAB19ukH5hx_kfpfcRiuPFrUmvFxMk3B08RNjcaxx3C6fDBS0dw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ACPI: irq: Move RISC-V interrupt controllers
 autodep to ACPI IRQ code
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1OSBTYWx0ZWRfX0dqMQo3X8V9v
 PIrNNEVHHXVcx/AO+1/ucQNCSeeVVeY4wXdOWoTS1VNT1QwOpdGSKFNfbkeOwJL3i4ijiFLUUWo
 UoD1DZPLqqrw+TJP3XXOayfJxXlG29r2+jzPnS4udXf2MKLUqPBruJqNUCSeiVoivKG5FwoUfTj
 lhmCEAsV2ypF9vI2/8rqPYYHqsMj8dBBl1kEyDw1pYwMhT35bq5dTjIMSsMIgiVeGTeSWWi/ue+
 2mJPjf6fFFeEKcsXAEd4ttsW4AkcJ2ORoVLJV0H1lpqko3gaZRXS9kUPe2TXpc8bBq+55HuYK5H
 AHLd2/i9lk7Q/9tb2eP4xn9TXbuM4nyBH9nbHZGXHAN9EjC/YUl5Sy9TgkLKVR7LL/t2sl6sH7q
 TnRy5xt1cxAXWpKmE/PbcYiMPvPc2VBCEHDY3JlsmfFLAe7s7up5I8f/rGD5JEqxH7L49L1qSoo
 rzKg4G2Bi5rwhJPmXgA==
X-Proofpoint-ORIG-GUID: Nntj4G66XCnfcEonqKgFGF82MSl_W-4U
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26f003 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=W-_n0kkjAAAA:8 a=bDdBU3oEAAAA:8
 a=EUspDBNiAAAA:8 a=bDd8DhsF2Ke-o0a1jUUA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=qeNa2pbTr82C0GpJEZFS:22 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-GUID: Nntj4G66XCnfcEonqKgFGF82MSl_W-4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080159

On Wed, Jun 3, 2026 at 1:54=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kernel=
.org> wrote:
>
> RISC-V implements arch code to detect probe dependencies for devices and
> the interrupt controller the devices GSIs are routed to.
>
> The code itself is arch agnostic apart from an arch specific helper
> function required to retrieve the acpi_handle of the interrupt controller
> that manages the device GSI interrupt.
>
> In order to enable IRQ probe dependencies detection on other architecture=
s,
> move RISC-V IRQ probe dependency detection code to generic ACPI IRQ code.
>
> Allow interrupt controller drivers to register an arch specific function =
to
> determine the acpi_handle for a specific GSI number to use the mechanism =
if
> needed by the respective interrupt controller drivers.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sunil V L <sunilvl@ventanamicro.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  arch/riscv/include/asm/acpi.h       |   1 +
>  drivers/acpi/irq.c                  | 172 ++++++++++++++++++++++++++++++=
+++++-
>  drivers/acpi/riscv/irq.c            | 156 +-----------------------------=
--
>  drivers/irqchip/irq-gic-v3.c        |   2 +-
>  drivers/irqchip/irq-gic-v5.c        |   2 +-
>  drivers/irqchip/irq-gic.c           |   2 +-
>  drivers/irqchip/irq-loongarch-cpu.c |   2 +-
>  drivers/irqchip/irq-riscv-intc.c    |   3 +-
>  include/linux/acpi.h                |   5 +-
>  9 files changed, 181 insertions(+), 164 deletions(-)
>
LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
