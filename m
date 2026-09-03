Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFAD1A682E
	for <linux-acpi@vger.kernel.org>; Thu,  3 Sep 2026 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410743; cv=pass; b=fcJ+ReN/OfKNmISHBr8hWoyqfERJjg7O4SnE93DGDPR9fyonMxdkhIrsmJxaOm5GnKgj0Ab1OINuEhCRxT/MRcgD1dt8qXbIYMI0l9S1PT6XFi8YA3zWDwzA1H2SxnlT3+HO+FFUUjPsyV4Dk5c06mpt+dowqlKuU5c3kiXM7v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410743; c=relaxed/simple;
	bh=zI+ifEyxByjM6Y9TrkSsIST3zFDRCsE93qCLJwvC3Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkU8/SPaDAD9KlnDqz2H4s8G2QO922gl+AK8YqF81FvuXQj9In42K0NYpKBHr6kDShK2WhPWJrJEAVmom1Xrk/+xFKiwRaenkAiJhsVUVzkyH6ceL36OT8DNC/8/zjzfnHWwxLzXtNOgLikLYP9BVZQ8OyIQ9vKzvr3xhY9Kujc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GT6WQFDv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TI42IqP/; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GT6WQFDv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TI42IqP/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68344qhC4050775
	for <linux-acpi@vger.kernel.org>; Thu, 3 Sep 2026 04:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=Sc3WkFAgGyNV3trhZQm/9QMD1pz+GBXUg/MNSusqdCk=; b=GT
	6WQFDv9pLArywxCmT3lPlnoXr2OAUvu7mqcefxYUUQuUunKAa5VlMOYVhi1XHofF
	wNp7i1KmIYwmZiVe735eI4cQHXKDmCFkr6yMJdPFaUc/NwzdHYyHYzUClpEYYgie
	yvQv0yMi4H5DAe8jPsq4Xb1aXKV4a4AH592GoLt4RMYMq86gHdsyJ2gaU4UQGByS
	b0gSWRpCIJPxNqaNqfgiDWP0Df9bwLAp4TI28lcvgSpD55UJxpE/3ynVVsLXxaJv
	k02kp6hfeHLbzushzd7gKW96sI6q7AiOPsWX1ak+MOq2YWPSgXTkCDWH4aKaFCvG
	hVD2/xRAwJBROlTjq2IQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4g405-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 03 Sep 2026 04:45:40 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-836c9f68dcbso32401517b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 02 Sep 2026 21:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788410740; cv=none;
        d=google.com; s=arc-20260327;
        b=rA1SSkYEPYtfU0ZBccj+VI7fr/wWGvNyakrSgdXbL4VbnLI6Tx/jM4h6M6naZcaeio
         Wz4TKMrA5/JqOr7dl6LhjMFcZFED0hJeg+bsIUymMIAP8i49lDpo22fN3iZcqEGpx18t
         w+ULBkvJxl7QEjWGCYWOMnaBZXS30TvUZSH+1nqv3DkAHmPIIja7ojEjfVly/JoR3k0s
         c77hW/rV7Um/Cxv1hlWSWXMvR4BUrFoKo0PA6bm+QA/C8qzxKTC63U1DxhOSMnl18EoE
         oNevqEqn0RXNOc0ByVv9igRW1aEjBffVHPUUy8n/IJxg6J43utynaChLiGBf9EF+sGnu
         alAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=Sc3WkFAgGyNV3trhZQm/9QMD1pz+GBXUg/MNSusqdCk=;
        fh=5YVQvixQwS2d9NEDwoHyZgKed0wpMCEkFguQx79TruM=;
        b=UO4UnVuK6qCPg9qcORpqM/jy4JenirxeQXXrfxemNOEcus3RisyUljnoFcA645KhaZ
         im9AxZcM5UezkFPKMS9S2cq2Rh39g8icdX3bAYXgWxekxysnEvqs4GFIdXXTgTmCBsNj
         2Xnk40GY34Ac3ciQZpjnEaPxQ52tQm0brUR7deovgbEAVm0IgTowHIcayx1qCi7UUnfT
         dirp3AhraCGFBUJYIoukFj++39XOEki2SpeObfGCKQ9yy/gKYTlFD9h6aLkdY+zLEpvv
         AZveiAHdL9DRCcFIz/PjUikurrexz+t8Qr7wodC9oEkaIqPGsQ+NEWU9YTC/jcJDL+HU
         Ihfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788410740; x=1789015540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sc3WkFAgGyNV3trhZQm/9QMD1pz+GBXUg/MNSusqdCk=;
        b=TI42IqP/CrwiugmsXM7s/OvbfKPScmXaABegJC7QmNE0c63t6LlPpL35Attg1D/4Gk
         9wkg3vli9mvm+f7e0J19/Q1DF5ar87e2BuYBxyD/FeuJ2HTVXieybS0ACLe4AdP3lxnT
         lORSlL7tVmL6pcKPfpuptC4q/9R30UR1kSi0lLGDSv54MJ3t1Gby+MkucN1I2H4Lt6Wh
         gTHCl+ZnkSV+4PHoFCKYIF1FUNHx+4Gk6LLB7t9xi7FzrOk186z253tiv7NOuF95AfGk
         VfoT92rv6DOTvDeLEZ3mRi6xBLHAfAzXcC6J63UrFqJSQxHCblm995w0MHqUX20bAhnp
         qxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788410740; x=1789015540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sc3WkFAgGyNV3trhZQm/9QMD1pz+GBXUg/MNSusqdCk=;
        b=F1vWNUQk01lLL0xFzHequr+rFprSBBtDXlK4RnNKvQJE1AiAJJPbeTx1xSlVn/ljcc
         sGlm3og5QjO36J6Od84TqvXv5cnqM94S09bWdzajUCWoavqVZa7csjBiL0IyhoZAi3jE
         OEhRB8Nu724lgFxa4CAS75kc4g7wPR/G7qu/uxji9Wt25eLtYneUmFMGrVm60WhlNno7
         5zunCu3shoXWaws6rfmycd+eaz44wvy8GzrQ77ERvwveD+ygaN6YpIShZVNW54h5xIDJ
         Mp3MHIG7e2I+WKKHynhVENnZ6Qq770rOcFSFksIvfsdqOCZcmQewRrn8R5crdPe0UBE5
         Awrg==
X-Forwarded-Encrypted: i=1; AKwUvBzq6Ur9uvAxm7KtH2OE8uXcNMIEhSdDxo5Sbzk8AbsLIPx6iZFZW/TuCGuKC7lsxSQbalr9GrrYlumE@vger.kernel.org
X-Gm-Message-State: AFuF++luyNhVUcpP6zMo53RiBp7rnFG4B/xSD8rPNCJ9TQ4IhEAfGFIf
	XH6Vw3LABt7EcNvFuOSCfx8Oz+JvXARSCfWNLUqoHaJKuKj2DGtX1Nz4Crtpg5ENdHD9Lobi5Vm
	xaRO1TEg5PjGq+EnmR87rf1DHz+VZgX9y2BWVCN87l8rGqSzj2LK98gSztvBjkfuXTW8LOe79Pm
	DY8AE5HwDy0bw8S44DjpOhOc6ytcV55mAnmHwEYyc=
X-Gm-Gg: AYBFou3Ya4ppHIO2M+8Z6+JwfcCfWirqa3PphS2DBL7qE+h1OxfDAaf5WqySUQSfkar
	g7yy2uJctNJBO0B5p5q3KiKfDbca/FADx/e4rUrpKM4yWX64eupEh1v1xnwoNSiz5uDH7fUompC
	PilS6ipPk4vGzWUVNSWdQPKZLfwJxD40qu4BSlL5Q7Vxeg8P6JeBKX97d/sw==
X-Received: by 2002:a53:ac93:0:b0:66c:85e3:7f28 with SMTP id 956f58d0204a3-66f9be6b625mr3646183d50.48.1788410735025;
        Wed, 02 Sep 2026 21:45:35 -0700 (PDT)
X-Received: by 2002:a53:ac93:0:b0:66c:85e3:7f28 with SMTP id
 956f58d0204a3-66f9be6b625mr3646094d50.48.1788410729854; Wed, 02 Sep 2026
 21:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902140145.42094-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260902140145.42094-1-fangyu.yu@linux.alibaba.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 10:15:18 +0530
X-Gm-Features: AcwNN1UQoEUyCiHFoU50MMSvS7TZQc6s0bZHcLqzyxXDTbBAI2PWHTUKR2JHNJY
Message-ID: <CAB19ukHwcDnApuWcn4MWm=bJZS2=UqbLT2=MnpfsJePG=qA_wA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: RIMT: Enable PCI ACS for root complexes mapped to
 an IOMMU
To: fangyu.yu@linux.alibaba.com
Cc: sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, guoren@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a98fb74 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=wQ6y6Ln1IUvFgne-YVsA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-GUID: ri5iNjnC54YDH27Ufsz7aO2VrVtQZ-cz
X-Proofpoint-ORIG-GUID: ri5iNjnC54YDH27Ufsz7aO2VrVtQZ-cz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAzOSBTYWx0ZWRfX946J/BRZwvaK
 b8I1ZLbG57M5INNFhh426FrTAAUHgBBQBxm+2Qjf8YODHCTXWbO+czSZYj0pakU8fR0CM05G6Ul
 KocK6n5BzXGHqUwrv+9fodSmHGX8Dew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzOSBTYWx0ZWRfX5h0pI46GKfTv
 RoATyHWl5E2AFsITzfj6MfT3h815q5eUJ3Qf/2LKaOvRj82QTlQt+2gaNMDQsAuY8SQ7XR5A9OB
 310mXG2Rkq8iGQEFvpGkmm05at0Q4cUlkiR7oTN7mbyrHhA70FJQE1xa45LqPGTWO6izpDPmlRl
 4T0X3tt3W9+mOo61Pi4WVuNUJh+09fBN6l9hdom+n8G/RTHquX5/yQCCRoch3/hWzHcS1HRWPh1
 p3diRPhR6QOn9xaINOp4TU8zcJXddsSNlGC2wCkcs3r/xXStl3Zsi0Rrfh9oqXZzWApfmBeRfQG
 Yj9i8lR4DEnnyXDtraut+47ayWMIcWzgQl9195zDLtCAqs20T8aTNweEIB94yi1e+WbxD8t/wcR
 3t6Fuy6nlObpQm/t2lsPuAbx9Vzk6gNLuicL6ADA0TvnqkmCW/2j8IiAQf6qZYfYrDMJNEgD7jS
 HzLLD3OAiLZQa9/z9kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030039

On Wed, Sep 2, 2026 at 7:31=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Mirror the ACPI IORT solution used on arm64 (see iort_enable_acs())
> by scanning the RIMT table for PCIe root complex nodes during
> riscv_acpi_rimt_init(), which runs before ACPI PCI enumeration. If a
> root complex node's ID mapping points at an IOMMU node, call
> pci_request_acs() immediately, so pci_acs_enable is already set by
> the time any PCI device is scanned and pci_enable_acs() runs.
>
> Only one call to pci_request_acs() is needed regardless of how many
> root complexes are found, so track that with a static acs_enabled
> flag, same as iort_enable_acs() does.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/acpi/riscv/rimt.c | 56 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
> index e4538fa6c2c8..f22e28c8211e 100644
> --- a/drivers/acpi/riscv/rimt.c
> +++ b/drivers/acpi/riscv/rimt.c
> @@ -179,6 +179,42 @@ static struct acpi_rimt_node *rimt_scan_node(enum ac=
pi_rimt_node_type type,
>         return NULL;
>  }
>
> +#ifdef CONFIG_PCI
> +static void __init rimt_enable_acs(struct acpi_rimt_node *rimt_node)
> +{
> +       static bool acs_enabled __initdata;
> +       struct acpi_rimt_pcie_rc *pci_rc;
> +       struct acpi_rimt_id_mapping *map;
> +       struct acpi_rimt_node *parent;
> +       int i;
> +
> +       if (acs_enabled || rimt_node->type !=3D ACPI_RIMT_NODE_TYPE_PCIE_=
ROOT_COMPLEX)
> +               return;
> +
> +       pci_rc =3D (struct acpi_rimt_pcie_rc *)rimt_node->node_data;
> +       if (!pci_rc->id_mapping_offset || !pci_rc->num_id_mappings)
> +               return;
> +
> +       map =3D ACPI_ADD_PTR(struct acpi_rimt_id_mapping, rimt_node,
> +                          pci_rc->id_mapping_offset);
> +
> +       for (i =3D 0; i < pci_rc->num_id_mappings; i++, map++) {
> +               if (!map->dest_offset)
> +                       continue;
> +
> +               parent =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table=
,
> +                                     map->dest_offset);
> +               if (parent->type =3D=3D ACPI_RIMT_NODE_TYPE_IOMMU) {
> +                       pci_request_acs();
> +                       acs_enabled =3D true;
> +                       return;
> +               }
> +       }
> +}
> +#else
> +static inline void rimt_enable_acs(struct acpi_rimt_node *rimt_node) { }
> +#endif
> +
>  /*
>   * RISC-V supports IOMMU as a PCI device or a platform device.
>   * When it is a platform device, there should be a namespace device as
> @@ -509,7 +545,10 @@ int rimt_iommu_configure_id(struct device *dev, cons=
t u32 *id_in)
>
>  void __init riscv_acpi_rimt_init(void)
>  {
> +       struct acpi_rimt_node *rimt_node, *rimt_end;
> +       struct acpi_table_rimt *rimt;
>         acpi_status status;
> +       int i;
>
>         /* rimt_table will be used at runtime after the rimt init,
>          * so we don't need to call acpi_put_table() to release
> @@ -525,4 +564,21 @@ void __init riscv_acpi_rimt_init(void)
>
>                 return;
>         }
> +
> +       rimt =3D (struct acpi_table_rimt *)rimt_table;
> +       rimt_node =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt,
> +                                rimt->node_offset);
> +       rimt_end =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
> +                               rimt_table->length);
> +
> +       for (i =3D 0; i < rimt->num_nodes; i++) {
> +               if (rimt_node >=3D rimt_end) {
> +                       pr_err("RIMT node pointer overflows, bad table\n"=
);
> +                       return;
> +               }
> +
> +               rimt_enable_acs(rimt_node);
>
NIT: Can we check here itself if it is a PCI RC node and then only
call enable_acs()?

> +               rimt_node =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_no=
de,
> +                                        rimt_node->length);
> +       }
>  }
> --
> 2.50.1
>
Otherwise, LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
