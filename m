Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F792FDC57
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936292; cv=pass; b=HdM8d5it+A5i2WSEoRCMyIODmeec44lNRbP5XxUfUnpkq6caPfjbb0jYeC7o5xPXMkFstRMpnEshjVF3+uKLwrv5EyzYkKBtQyPGVo1Yd+veEwLu7aKTmJ8HVs5n2hIGa4FZIOhObAi/GKA+IMtl/a4H9azCGq9VYQnuHE2+Owk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936292; c=relaxed/simple;
	bh=D8vFpN0hJqf9d/gKvHxzQEYWamJuG065TsHkAT3J59s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4Sbs9rPO3Ww8Np3MvYGPO5u18R0XU8GTBAxp/VHC2FPkGI1lhQKQas6xxFZoko9VBAm91XaTAPz9j7MOv/LhXXy2+agbzlIjC5uzJ3HCNiCc8EYPdGQjKMECcQn2OK8BV8efcpvGs/Ds93YFPZWKa7NP6sD0jYZWpz0TSng540=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bKUroUnh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BlLVkqYN; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bKUroUnh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BlLVkqYN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFTYC3934215
	for <linux-acpi@vger.kernel.org>; Mon, 8 Jun 2026 16:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=Dh0My5XPTw0EtAcYMuaP9DIqaOn+MAp7VRpz58CInTM=; b=bK
	UroUnhkz4pKQ36Eqx2OGDhGkz7J6Re/8ZFD82X0RehI7Y0MGj8NHovKB/97jYISn
	fudrob/coutlI9v+msh9ROiWhUMQ8PO/M+dKlF0civ+oQsu85Ade9En7qOvTf8ka
	Kb+aY7g3PrKtluAcX6wpYzIzOLTDqPDc9qgZKUlxWZEXfNJ2CU85gD/6FWG5IWUF
	bo0oN1oSSu5ihMosfyOpGFYaVVXxWPRbQDBfVYtWCirjdLKRLAFxMPbnEHWfJRm2
	GvSPIoVqBJKrLAJ6igEQPSCeJZarVZUJQbOkkhXfmbau/+2UV8zwUObFZ71lIRTA
	dKV2VrrDJz5GcxOhOv4g==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rs5j2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 16:31:28 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-660575c74f1so8674845d50.3
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 09:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936288; cv=none;
        d=google.com; s=arc-20240605;
        b=dLqQzV965JnFKrKPVUewMBDMyyxLRbdn/uKl1st/ugSJW8K7MGNVXpKYK0qgG/kZHL
         QzIPH880o+1LyL8TzjchhciLCrR6HLxH34A9/QgTKUsQNuTle+rjGtjHJfeVN78tPO3f
         OlHK6lnpb1IOV9vcx305O8tpctvvheikS3B66b8pg85t8ZYRurHa94ERLeIsssHMVna7
         ZScq5obQIs9+cNyQUKQAism2MI4AuiBHJe+hWsdsv6vAVNnMg6jXQz9QAzAV6rURv92J
         QJYy7IouexmtJTeD5glvOv8OLhLknyGJkTnHlIu1fp5dANKFQx2VRdKmLfUQ6OqpIDbQ
         TQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=Dh0My5XPTw0EtAcYMuaP9DIqaOn+MAp7VRpz58CInTM=;
        fh=O52G/lWssxiWZqa3gOr3/gmxqPAtRiD5Q+57mcNh424=;
        b=codG1lZk6woDUop12nVEZbUN6xk+VS9R+cHMuYKa5zsBVFnHIr8DKxj3YLN3R/LsSZ
         YnIpTrgtDRfn6pgnybqZPmq0mHWshRyFOKuYZrDK9ZsIP219Epq/iWo4skz4ZRdXLw1q
         U1lndwcn+Bn0p6MVxWAA6LYavV0MCsJMHo4KVkNeBLRY6QTXwu+ngAmO4LAw3HFVktS6
         Y3Vp13eiSyIANkd+0MrXYFlz5/Zznk4N6G0zj0elYZwGSKxYpTrs1m23hVWzS5++YNS3
         67MUd9H2EtvM1AQka+ZvUQay6U/n6n34X3nTjIQ73DvjuPaxoqWA6NEp45S4AHRwfYh4
         48Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780936288; x=1781541088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dh0My5XPTw0EtAcYMuaP9DIqaOn+MAp7VRpz58CInTM=;
        b=BlLVkqYNTspNeW1jq0F6KaOcDQaUyZPtfZp/sLlIJ38ugnmCHOD0uajj8buW/JWOLc
         87/y8l1Q0Zrb+QMIn+QbBGhMdZ/Sh35ZMyBYTFJZqJyxxjLWeoe9qywKLgE+DlD1SK+j
         7zkKl0D3UZW2OVCAZecvKbnFoD2daj402CAorykQvJP2WmyVM0v8370u4CtIHRlkIdnV
         h6JtH3bR4s9YaF3od4gSbeN9vdPqtLB/HbeCiKkHeiZw91pRZamWYEO3V3QFHjxKu+dw
         gL1RXyxRuEbaQU7oQUo+vCu72+xxykGg3XmsPsmoa4Q+Ek9orgrQWjIPXofO+boHhTxf
         uTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936288; x=1781541088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh0My5XPTw0EtAcYMuaP9DIqaOn+MAp7VRpz58CInTM=;
        b=DByRzHg0lnMuKK4D4DDH2cKm1AJxp9zsrWLOixWd1ar14sFLC98qnD7tR4thvHQwjX
         pMXtu3+39A8LOD8VgTAlysdTFFiE4rtB99yiPBucPpPB9ErzaDadYiXP5wTCjdPUF0ze
         ksrzKE1lFmmCubVQbALMRe1qBW815kMaMgRVL635Vse+Hxsth20LMNXcJAMaK6KzsljN
         1oV76brKAFEz1pVgRhaYi17ZTHMyyxpLu7HoYpWavf3LGxsTi0fY3xd+Km7EB3u4RVyU
         bXed9bBO88Wge6uLhkUW+MUXH9+wPAFFaG7OVn6aBr0Mfe+57HRLrtFbKuEqDVMWQZG1
         P6QQ==
X-Forwarded-Encrypted: i=1; AFNElJ82pZZYsHgr82bMG6Nch5rB9KxxgmwQfJiBEj8Oe67jb6bjDnrGtrLJVXvRsrLps/gbOeMasRiKFgGC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54a4Z8fYlr+KSZ9p67KspeXIf0+XiAFWZzM88dzVewXjvcCSE
	nrb9/Nsk5dhXXRWAu5jDT1PISti3o22fhNTiWj8oWAocPrvpnXJSwkCgKI6XeYHmFIPY1f2G42z
	HLI3eGm3ONIhJc7B6XwBgRcjo398qbHYcJ/I4hrJBgz6yK+1HZ34C9GwWa42YzG6WUeJ9hlG2ou
	Ai440XDbJsDkFPsP4UZP7Aab7M2n9iIZFJGWucfC0=
X-Gm-Gg: Acq92OHWVLyBChrQI5JxDRH0tOm2gdykEX2OdUFAa734JaZ7lpCu8WLmvCgJs37xRkt
	KtibLqf7eh0R6A23d5WI9/TeoDb+nbfnzp9R58xQlne5J6LVwzSzEcZYn85QztqgFmkDIIVOt9O
	9vAZLE03Ys7JjP5nWYlmSBFnlIw9fp2yAneJmnU9zfS0nFEq0Px3DYNyl/cx+/B9wQ+5balHfru
	YztcCEdzg/XI90f8g==
X-Received: by 2002:a05:690e:1919:b0:65c:1011:8a8 with SMTP id 956f58d0204a3-66106f38d32mr13567121d50.34.1780936288340;
        Mon, 08 Jun 2026 09:31:28 -0700 (PDT)
X-Received: by 2002:a05:690e:1919:b0:65c:1011:8a8 with SMTP id
 956f58d0204a3-66106f38d32mr13567038d50.34.1780936287720; Mon, 08 Jun 2026
 09:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-2-23ffa16b6ebb@kernel.org>
In-Reply-To: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-2-23ffa16b6ebb@kernel.org>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 22:01:16 +0530
X-Gm-Features: AVVi8Ce85oHpnPDkl3loJMYesa9hqOwx4u4ydQ5fzIl78S7nrYXEW2Qks7w8mXs
Message-ID: <CAB19ukFVPnWhgvb9icFU44L5qre8ViNTEHg_uvK5232PnCEE5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: RISC-V: Check acpi_get_handle() status in riscv_acpi_add_prt_dep()
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
X-Proofpoint-GUID: 8GkVHACD-Y4pLPnc7flBlTkq6yg-prEB
X-Proofpoint-ORIG-GUID: 8GkVHACD-Y4pLPnc7flBlTkq6yg-prEB
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26ee60 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=EUspDBNiAAAA:8
 a=S6Q6xKXrEcqShMHWKZgA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE1NyBTYWx0ZWRfX7x+yCfD8jywQ
 iErWyIDfFV2sRyzk3DNAMgkYsMM5nzVbqos0mZ8zytU/ielV2+AGnGNs55I4hml0cfImBB8LP6p
 7qCsjvlHDaJI1Qj4rqaQ1VrPktz20Fu6OJWEEEEanDuEzC6h5lwceROODOp3AG1uZ0dLic5YkWF
 2RD4q4pS37NWzWvtLvwbf5mNMTRo9e76s5kyHd0CDr87kWeOJOHB1xWpLP86ESkeAh1vnJGd904
 +VCz/CASJfxe0GBqVjJYN08uNd4TRV6IwO+oZOoJ94poVw9MPfIt6NV+W6nUCvZfe7dqh4zh59b
 NtgI3iiJGdamaJPe+uYNyXyq9jIiOTyGf6xbG3OesWfKGoXweW8SCTz9H2Z+6VoxFpQkQhDNZ0l
 8Xwy8/JkKqDZwOMf9CB9Y62aA3sa4H8lPoUOK8ymy+XhPEuy2r3nk1/MdaU87g2so/oENpRlP/J
 M2/B2odS42FelEKDD5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080157

On Wed, Jun 3, 2026 at 1:52=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kernel=
.org> wrote:
>
> In riscv_acpi_add_prt_dep(), the acpi_get_handle() call can fail which
> would leave link_handle uninitialized.
>
> Fix it by checking the acpi_get_handle() return status and skip the entry
> if it fails.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/riscv/irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> index cd83c3035cf6..75170151c614 100644
> --- a/drivers/acpi/riscv/irq.c
> +++ b/drivers/acpi/riscv/irq.c
> @@ -339,7 +339,9 @@ static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
>         entry =3D buffer.pointer;
>         while (entry && (entry->length > 0)) {
>                 if (entry->source[0]) {
> -                       acpi_get_handle(handle, entry->source, &link_hand=
le);
> +                       status =3D acpi_get_handle(handle, entry->source,=
 &link_handle);
> +                       if (ACPI_FAILURE(status))
> +                               continue;
>                         dep_devices.count =3D 1;
>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
