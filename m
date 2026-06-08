Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2A241686
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939906; cv=pass; b=aWDIBwdb0z7+FShT8CHnM8zCSatK5HSJ1GAfFFJztpBMt6M7RQ5kO6Vs8qgLf+O1FRKFvpT1/me2x91us6/yzvDtUPlAL2XT/JNG27ay4y7fip0LYVEwLGda5RScudndFuvtXnL4XmCH9CFk9aJIGNuJwsrrBmugQdkNU1wya2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939906; c=relaxed/simple;
	bh=VwOSg9+5twE+GIOhv0AO1lGOfnn4XsIbGFrCePaepw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaBk5r5Vd20CfqwzTjdM0JX1Z5wBLN0ZnGE2Hcb4zCILmWacgkYKR1VrNtQcmMpDgNgkS/QM/DGvv8Aw9QAPyRDTnHp0n9UnL1jO3r6rGK5jsEAwEXvQdhNk8F3KGMjPqxXCvvwa6WEj33PT4F0hJ94kjUhe/ikd/Np+JEytiBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MZ7ZYieT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=buuIbjoY; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MZ7ZYieT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="buuIbjoY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FKLV74045083
	for <linux-acpi@vger.kernel.org>; Mon, 8 Jun 2026 17:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=NboUCLZhVdamDjmk3+ro5FUR3e/MaMLfVXZD7CFCBmQ=; b=MZ
	7ZYieTiWl84GjiRgdXz4awP4cGqtTjVwzl/xLPeYpoNddIilxXmopDu0EZ9hXgoy
	tjX5j1OxwrTKB1dBVuxebTr0lTC0xuqeZZD7lDIU5/EUMDRteROE5tm4lRd3ZTR+
	iPpC+2mmbuj5RHGe4x5PmbB+NQSfszPtVKuE6fwKYb5LBeBcP3jwaRboBSiPNEIo
	ewBdPmzvWzXH4cCOvc5ZjPjmGI4V1tCoEKBMpnET89X3zrIZzw2Te1xv37nAEM89
	GLFtuOTlvqGxVjU8R8mFIHCmnngJRFkPYWac7WJHpO2GjWOsSv8C7MnUy1Vi1eAm
	P/MsW+GQgqwfkQSlZJKg==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxee1bf0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 17:31:42 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66030c38630so4749840d50.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 10:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939902; cv=none;
        d=google.com; s=arc-20240605;
        b=lSBWWShT2ZCzmAjNSdDpPkh6+8M8Rn5g20lu7JXuKeXT6wbtnDk3riscKFTAFfwGdl
         wFIs8geR40cL9UfiGuzZj7mIkAFXNIwV4IcpLhMsVPb0++DQOmcNjLcCDaI2qewaZqI1
         LN43CgEv5qinSdKNVbKYi82mKDGlfo5EwmA+OICB1kWXRxzBX7HsNCFJoIoFIhevGhC0
         TzEa/Lxib1y8xJr94i95qF8F694c9fonUi7nRVdDw45pN5MDgPjzyOSGxnPVtOwnHpq+
         edAGTxT+56Y749wdAO3sLYIUy5vwhy2xD32q0JGfny/h5juOOP0sx6mCS0EGEa9NupHA
         S1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=NboUCLZhVdamDjmk3+ro5FUR3e/MaMLfVXZD7CFCBmQ=;
        fh=wRZp6DIA19Y3cCcpfNtoHKuNeNb7XSZ9AxhVIA5FKJw=;
        b=D7RpylF+K42qpDG8uAL/1Tn6K+A5HUZG13mQPI8mxW3Pfw8LDwVQL+pYXQdS8MLxHv
         SGPcBZoQ+OIH6NuusqLTBo/gb3ZjySYfH/u4uaEXe7p1e/rSbR+uHA/TF81w3sWWiajl
         wZhSdIBWe0SKz2Oh3R/8x7YtdL0R5XWHl8N0nJPDfcEk5Zq7OLzorup7r+GnlZvef6US
         R9EOI95KsXw3yXAN9rWyx968d4lVWCgZJkHGF+GjnftgSe/X8T1AIdoK/sSKvG77ImkD
         /Spy+/MjeD0kB/tPBnZ2zQFWD4YfnWjGRJqs4jnnuzYHTN8Ygo+11glpiWymLlwzZKDB
         8c+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780939902; x=1781544702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NboUCLZhVdamDjmk3+ro5FUR3e/MaMLfVXZD7CFCBmQ=;
        b=buuIbjoYmVoN5ArRYxSvLn/Bjn+4MhElBt8ruLo/iLEJqeMlGzd/kfIFVQTpXi7fu0
         D84pWR+urQA3H6J5hH63ThFNXwPcgZVtC6zUHNTMgv3I7iH6f8qrFXyqqAhmlmbcBQnm
         c8qbQvrHZFrubaPqg7yezLLiDrH1I/ixduaKrQBK9qkZBwFPe3z4WNTfJZsaq279+AuJ
         jTyr0+G04HLIzKBu2gdLSDTGc8ggIyPwChud+I44Ji3qAb3rkhl7Zsgu8SjL35LoKZjB
         81knxvWCaBhrvzq1Ja/ZbaeF9N4EWdibzEfZLnkqJHBA4JHZ7vQB3kN2jFjmK9OgzaS0
         EPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939902; x=1781544702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NboUCLZhVdamDjmk3+ro5FUR3e/MaMLfVXZD7CFCBmQ=;
        b=qaAH4TFLXRlcsvY7qMFBEas5AlxSwNZxiZo+mqguqZ9DMpilTsbXlfga8/IHvtXORx
         UnU4aBjDzdK6szqGf2FBgQcyH9ctk8Gv2GvLF+pk2u128iEM5/UsCmO/ytxT3H57VDfp
         j6xFXDqCG1fRerPS5OA3sobScts45IhqOrO7j4m6cSRp3KftHM+mE+kXtC+YV6e8sabc
         PCf6g43jkU36F7l28fbLiev4Trzm/PcmyM5+De2qZ1AJHvuyxR8b6sXTBKL2WAxOW6+Z
         l+P2Hni+9GCIjPKPObZ6L16px+VwLTTbuPK14plG79vYZNvLwZwNS6ejXphBzfFIrlTF
         yXAA==
X-Forwarded-Encrypted: i=1; AFNElJ9CuobL+AhPUHJmUXuaJLlHEm4PVYodEFvXNAzfrQ02p2fy6J+ZQtAh2t8l++nUEC+dHpgX+7zz0nE8@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKyuqVueS6Bi5sOanCFHYX83JPIFi2m4ARSJLDgFDQOzvcFbu
	aP7RkVUFSXi0WZjmAm+RY/h5Faj0i4445yszftLAfsr3sVJ+S9o70zNc9049e6Q3P9aWX8VsKNw
	tEU5RCTf4AVGeCtFP25N4wSkUTgHwcepXnQglVeQXqzY1jZu+XEktSuQpHyNof2+BXnTzt8GXOa
	4xoIBQBNIDwJFwN5qVmerNgwNGh1N2Ujr5MN9Rerk=
X-Gm-Gg: Acq92OEeUsUQS7LtzSWcQMdBhlN6riE224ScKpnFkxwtYOyl85jKbJOyNHO2HujvGZs
	byVYoiSZ5ZuSGwUs4eM9KRZlXsU3gciQGoCja8ZZTdPoXjPNm6jSZewX4JDFJxqsYFf4kDj4mY3
	YI0SjZ0P0Io7NtW14bZsZPGODSnhqYhaPf7bCKUIu+AZvsEUTrAGas8eHWF1jsAgLHmQQvqxNxI
	UQdiZHJ30O5JtPDQA==
X-Received: by 2002:a05:690e:2ca:b0:660:32d9:22c1 with SMTP id 956f58d0204a3-66106f55bb0mr11340924d50.33.1780939902276;
        Mon, 08 Jun 2026 10:31:42 -0700 (PDT)
X-Received: by 2002:a05:690e:2ca:b0:660:32d9:22c1 with SMTP id
 956f58d0204a3-66106f55bb0mr11340866d50.33.1780939901792; Mon, 08 Jun 2026
 10:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525074415.1533884-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260525074415.1533884-1-maoyixie.tju@gmail.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 23:01:29 +0530
X-Gm-Features: AVVi8Cf8ngzVdvK9FKMj-xLN5UeSAS7tWWFrcGhG8O0eDmb0hUhF-uRq5getBFw
Message-ID: <CAB19ukFFpsc2eOmkXo9UzSieF-PrMb_BqHw1gdH8_MvwHJTw+g@mail.gmail.com>
Subject: Re: [PATCH] acpi/riscv: use a dedicated insertion point in riscv_acpi_register_ext_intc()
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2NSBTYWx0ZWRfX9FWjvKjO/RLm
 7uFA5e0P3LVoU6oLlpJX/M3nXj6krUUOUGuu+J2J2y9v6g6u4GrZ68tOvEM7HBKrRY8oO0FEnIr
 u68KftpcPagJpl09lF23avHgzDBsrhe4FHAsbkDPjtEZlo5M1cYZjijdCTpCD6NfMfvtiC/HQ62
 YFxNObZzmqQIQXxPhEPXB+iSf5mzeqLPzJ585rsBtxPRR7v6Z1PHJhYTPn6r0O7jbTFNvAnNGwR
 U6xMmq8tH7YCyPB2E8LIc/s28mW6pXN/EyQeohiMOrf6bCmA6hvh+wkOic9/Daue5zku94qXBOG
 SXxxR+a16ALKXrBdHrDrEYzoD2qtkR0caSMG2oXF8X9mCHlLrK1EiZrKF4yaVYrZsq9S4zW8fhy
 wNdgo0P0SqKdCdKBa/awARaw5OR3QvkSIixj5PBywl66xtMtAWbncet+z4yFCJLm/Dc1wruDWV2
 o3Rg0Oo8b/hciQiZYRQ==
X-Authority-Analysis: v=2.4 cv=V6BNF+ni c=1 sm=1 tr=0 ts=6a26fc7e cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=Saupl1bv0fQYsKODqNUA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: v8U4El_sqhR5pm835Zb9lBmyYe74oNjz
X-Proofpoint-ORIG-GUID: v8U4El_sqhR5pm835Zb9lBmyYe74oNjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080165

On Mon, May 25, 2026 at 1:14=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> riscv_acpi_register_ext_intc() inserts into ext_intc_list, which
> is sorted with the largest gsi_base first. It walks the list
> until it finds the first entry with a smaller gsi_base, then
> inserts the new entry before that entry. After the loop it also
> caps the predecessor's nr_irqs if that predecessor was registered
> as PENDING.
>
> The current code uses the loop cursor for both jobs:
>
>     list_for_each_entry(node, &ext_intc_list, list) {
>             if (node->gsi_base < ext_intc_element->gsi_base)
>                     break;
>     }
>
>     prev =3D list_prev_entry(node, list);
>     if (!list_entry_is_head(prev, &ext_intc_list, list)) {
>             ...
>     }
>
>     list_add_tail(&ext_intc_element->list, &node->list);
>
> If the loop falls through (no entry has a smaller gsi_base),
> node ends up past the end of the list. `&node->list` resolves
> to `&ext_intc_list` via container_of() offset cancellation. So
> list_prev_entry() lands on the last real entry, and
> list_add_tail() inserts at the tail. The code works today.
>
> It is fragile though. Any future change that reads another field
> of node will hit memory before the ext_intc_list global.
>
> Track the insertion point with a dedicated list_head pointer.
> Initialise pos to `&ext_intc_list`. Set it to `&node->list` on
> early break. Use pos->prev for the PENDING adjustment, and pos
> for list_add_tail(). The cursor is no longer touched after the
> loop. Behaviour is unchanged.
>
> Same shape as the Koschel cleanups from 2022 (e.g. 99d8ae4ec8a
> tracing, 2966a9918df clockevents, dc1acd5c946 dlm).
>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/acpi/riscv/irq.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> index 9b88d0993e88..49582cf4f4e2 100644
> --- a/drivers/acpi/riscv/irq.c
> +++ b/drivers/acpi/riscv/irq.c
> @@ -134,7 +134,8 @@ struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u3=
2 gsi)
>  static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs=
, u32 nr_idcs,
>                                                u32 id, u32 type)
>  {
> -       struct riscv_ext_intc_list *ext_intc_element, *node, *prev;
> +       struct riscv_ext_intc_list *ext_intc_element, *node;
> +       struct list_head *pos =3D &ext_intc_list;
>
>         ext_intc_element =3D kzalloc_obj(*ext_intc_element);
>         if (!ext_intc_element)
> @@ -153,18 +154,22 @@ static int __init riscv_acpi_register_ext_intc(u32 =
gsi_base, u32 nr_irqs, u32 nr
>         ext_intc_element->nr_idcs =3D nr_idcs;
>         ext_intc_element->id =3D id;
>         list_for_each_entry(node, &ext_intc_list, list) {
> -               if (node->gsi_base < ext_intc_element->gsi_base)
> +               if (node->gsi_base < ext_intc_element->gsi_base) {
> +                       pos =3D &node->list;
>                         break;
> +               }
>         }
>
>         /* Adjust the previous node's GSI range if that has pending regis=
tration */
> -       prev =3D list_prev_entry(node, list);
> -       if (!list_entry_is_head(prev, &ext_intc_list, list)) {
> +       if (pos->prev !=3D &ext_intc_list) {
> +               struct riscv_ext_intc_list *prev =3D
> +                       list_entry(pos->prev, struct riscv_ext_intc_list,=
 list);
> +
>                 if (prev->flag & RISCV_ACPI_INTC_FLAG_PENDING)
>                         prev->nr_irqs =3D ext_intc_element->gsi_base - pr=
ev->gsi_base;
>         }
>
> -       list_add_tail(&ext_intc_element->list, &node->list);
> +       list_add_tail(&ext_intc_element->list, pos);
>         return 0;
>  }
>
LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
