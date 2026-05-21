Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EE38331D
	for <linux-acpi@vger.kernel.org>; Thu, 21 May 2026 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384433; cv=none; b=gVjK4/p4dW5PXZMMpkBNgkZUot8oUHR2YXStKllJ3GxfHFPrq8lK2cXeUT3Fj5jE2SjG6V7TooLpBZ7+IJ4LrQtBDvN8VA5XeH2Zs3aNcW0L5PgdNMSpdMuXzpiLPhLWRqEZlEVmeWcGqwitAtE+fWdaQnutZKEReXEbhKpbOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384433; c=relaxed/simple;
	bh=nUlLDXLr7tfwRxGNF7TRb9ZxBG1MttqUauLdbkr/FxM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vq1DNkBS0KueJYsak7a++k5Qzf/BkFnDCEp5wkuxOfIVHzIj2UedOgrnOvqGUJVhXNVzDFg/53Sb8LJnpzxsGNiwX8cur3/8i8lYK7hV2YXpdcoHYfFSf6xPSgc+m7LoaRYLhtiUVytI97xJNPNyMs3BqdzgL0hw6hW5d3svy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSxreC+z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QfMyKU99; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSxreC+z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QfMyKU99"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGk2f73673883
	for <linux-acpi@vger.kernel.org>; Thu, 21 May 2026 17:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+FmAzQvTXDL4Pj4tgiqa+GkBPY2ik/1LnnIYJZAA6wU=; b=WSxreC+zI2Cjwhrd
	kQSl4+KqS2iyhyW758hXoX/WTxrBMQa7Y2ZZNSV2G9ecCLwnJTdbOXYKi0uHsWUH
	5CSjSHTZqlA/MquVk/3k7NSsuSbq9kPn89xcAj9506uWle4Tj0BPf8rirACtJPEp
	AVEeBTZt7BbxFua3EngfyQYQBNHmTrgAeIkUAvjXv57fbGuJohUFEYrCXzTZFhQQ
	oShFmIj201Nio+qUCOoSaFRn8/ex61LhRKlxYtHaa1pLYVMYCh7XZD0+sgb4fjHy
	iOAFOTzxmvqIBLRoMrVxYOq+5E1H48oTjd29WaWrnOv3Kpcq56W6jWBa4qiWUsks
	xzgtqw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea4dc0kcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 21 May 2026 17:27:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f525565b33so7816175eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 May 2026 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779384430; x=1779989230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+FmAzQvTXDL4Pj4tgiqa+GkBPY2ik/1LnnIYJZAA6wU=;
        b=QfMyKU99Zty020hKcOYuqD2PbncVXgP8Hv1jAcN6dbhaTaGbYbvV0DejLJqJgXMlEz
         zAkrmfogn1IVoS4ZmGPzru0UHIhCktcDcA9950gyuMtC8tdrUrbU0Ys0FVkAoYveAzlH
         C7kx1c/afMmNs5QkOn4r7jGZgmggqRCLpNg9x8YIyKwyE/MYwIoV48XeiwG4QhqXKmY0
         JaY+IRsK6rUT9NspH/ACsEHRvAqjOXz/P9dK0bSxB/31bDTRT/1EiNy6CGhMIcWajJRr
         OAlBK9SodmTAdoelrQC9xXn0RJSxi5GIi9NkZOeJIvktFdv9/sPLwxieP1Gk+RhIT1BX
         ZOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779384430; x=1779989230;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FmAzQvTXDL4Pj4tgiqa+GkBPY2ik/1LnnIYJZAA6wU=;
        b=Wu6ufyxYSz0HNCTh1zwOM4+ECHrW8BRKPdQreoAIX+zzzQHaU4mKAknLgh9N8qoZTY
         bcQ9ICCxftgLRn2p/3bnV/R1Sp+3iXKxlC6tcENlSoN58KfXm+ZLbeYYpVBmdnMU1NZV
         FYHqrBG39xtXwfXSJjEg6Jh3fAPJGFRwW6fBIs0Pldoo+KeKDW+OCVcAC28IEL6ZzFeR
         N5cFU/5xeYXHMSQWWk3D5YZD2F+fxlzF758rDt1XiDy6tPRb2BFaEuA6gYthkMw/O3SS
         P7TiIOqLbz2JehCRmgKy0Z/546Ys4sCgsPQJttlDXYKrOvaBZbeFcZ9n21epag0lJgcV
         VM/w==
X-Forwarded-Encrypted: i=1; AFNElJ/vm2k15DCxWgZ11KFqlDCTnTqz540y8zcAcuX/QV/HoOFIxM7Cbpaksk8dki7a1dffur8vjqZi/yaK@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPvFEUaWLvzMSTv2BhlwTRkD3Kjwwlo58eSy2D8QME/0GMR6c
	uZfIrDA3NtVHQd8/xvdiQU0vu9kOthYjf3YtuFaqtoIkCP86L4E5avQ2C+A53LBPPqU0KH7Bw5m
	ILkVdhGL75V+vdvS0G7WqSUVAP3fswHNe9RA+FqPhVLkbnCs6EhPNOYDoNwfewEcr
X-Gm-Gg: Acq92OFYsJ96vYRDbJvuN2a+U4jjcB/KDe0vPzaw/U7S7/TcbYv2k6soT4eKmRqr5LZ
	U2u2I//RtIX7qv1Od0OpQYjPKTG6zFXdjxO7axnEbCrIYMvFlX7GFJbfO0aphwWfylm1OLPPfsp
	FKRTKOYIrbYfR+XFG3y2pG9GvQN8evcszl9PBBIUE2wWl2Y5IG12SrMN2Xzyl28qulQ9+bD06pZ
	NbJomBaxpzNyiFfEKj9nppr3Y8Ko02y83ZMHTux1EZXpkZ6IIcKh6F0DjwaTmMxqeUg43amSnUa
	fxo/SJJr7+AGMwctwCfOznUbwUrM055t2vnlDkEcAWIipKVWmiW/qPxIVqfBqRAmPvJP5+C34rj
	aLM7sFwbCYvelKBXbjAB5WGZL6BxanW0sOD1EJERwKf3yZZIwSYy3/Ag=
X-Received: by 2002:a05:7301:608e:b0:2f2:b544:2fca with SMTP id 5a478bee46e88-304490e65femr33137eec.33.1779384429989;
        Thu, 21 May 2026 10:27:09 -0700 (PDT)
X-Received: by 2002:a05:7301:608e:b0:2f2:b544:2fca with SMTP id 5a478bee46e88-304490e65femr33100eec.33.1779384429350;
        Thu, 21 May 2026 10:27:09 -0700 (PDT)
Received: from [192.168.1.106] ([106.51.193.136])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044359ecaesm941567eec.25.2026.05.21.10.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 10:27:08 -0700 (PDT)
Message-ID: <fdaf3bf7-378b-4384-90a1-b64a2389a00b@oss.qualcomm.com>
Date: Thu, 21 May 2026 22:57:02 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
Subject: Re: [PATCH 1/5] arm_mpam: Parse the rest of the ACPI table
To: Andre Przywara <andre.przywara@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo
 <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>
References: <20260429141339.3171205-1-andre.przywara@arm.com>
 <20260429141339.3171205-2-andre.przywara@arm.com>
Content-Language: en-US
In-Reply-To: <20260429141339.3171205-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VefH+lp9 c=1 sm=1 tr=0 ts=6a0f406e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=7w7G2qr1pZSYnhmQ0Jjmug==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7CQSdrXTAAAA:8 a=DsZDJ7UI_9TAX8a9LM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: QL7CgAFiYVLBChGEeeGHhfqu58QtJvmP
X-Proofpoint-ORIG-GUID: QL7CgAFiYVLBChGEeeGHhfqu58QtJvmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE3NSBTYWx0ZWRfX9Tqxc/RtptMl
 yRGOga283n1yLCX9Jee5NK114dcyGIgp8qZYhhoiNPwwSxbntybAOukc10JCThab/mQQi2quxbr
 TCzgh0d7dO3+OglGnaev/wv4NxMjpAE+wNTiLKjz3y2m/k2vurSCd5jtaYhhWo8cGD3obKFn7os
 UhxEvPvLvyBQhysOiCEQf9Za0BZMEevmlEgyoxGck4dvD/i3NXxxxhs5mFzZQemTbc/GjHUgQIc
 MhJdxC8qSmKE0Snqovylm7n7FUYlvCou+TIu2pdR4zycKCisI0N04jJYhPchERRp/ud1ZqIkqIS
 9Yuva9woMb6M+DZqtn5cZHdhJmpjXj0Tr4eORnYD9lCT+XszqttVCWqb1HWYpAif6RtAd0gcBtj
 Np32T/Z5ppuCWEcscpcKvSnsjn8t4adJDG9sEZV4E2yeoHnzK47NViPXefna5NTdJBLz5EBG9i4
 ooncv2VbXL9epYWVs1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210175


Hi Andre,

On 4/29/2026 7:43 PM, Andre Przywara wrote:
> From: James Morse<james.morse@arm.com>
>
> The MPAM ACPI table lists the MPAM MSCs and indicates which resources
> in the system they control. Not everything this table can describe is
> supported by resctrl, e.g. memory-side-caches.
>
> Add the additional table parsing to avoid reporting these as 'unknown'
> to the MPAM driver. This allows class+component hierarchys to be built.
>
> Until resctrl has support for any of these resources, users would be
> in-kernel managers of a resource/PARTID or perf to query bandwidth
> counters on a resource resctrl is unaware of.
>
> Signed-off-by: James Morse<james.morse@arm.com>
> Signed-off-by: Andre Przywara<andre.przywara@arm.com>
> ---
>   drivers/acpi/arm64/mpam.c | 91 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 88 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> index 84963a20c3e7..99c2bdbb3314 100644
> --- a/drivers/acpi/arm64/mpam.c
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -95,17 +95,51 @@ static void acpi_mpam_parse_irqs(struct platform_device *pdev,
>   		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
>   }
>   
> -static int acpi_mpam_parse_resource(struct mpam_msc *msc,
> +#define UUID_MPAM_INTERCONNECT_TABLE		"fe2bd645-033b-49e6-9479-2e0b8b21d1cd"
> +
> +struct acpi_mpam_interconnect_descriptor_table {
> +	u8	type_uuid[16];
> +	u32	num_descriptors;
> +};
> +
> +struct acpi_mpam_interconnect_descriptor {
> +	u32	source_id;
> +	u32	destination_id;
> +	u8	link_type;
> +	u8	reserved[3];
> +};
> +
> +static int acpi_mpam_parse_resource(struct acpi_mpam_msc_node *tbl_msc,
> +				    struct mpam_msc *msc,
>   				    struct acpi_mpam_resource_node *res)
>   {
> +	struct acpi_mpam_interconnect_descriptor_table *tbl_int_tbl;
> +	struct acpi_mpam_interconnect_descriptor *tbl_int;
> +	guid_t int_tbl_uuid, spec_uuid;
>   	int level, nid;
>   	u32 cache_id;
> +	off_t offset;
>   
> +	/*
> +	 * Class IDs are somewhat arbitrary, but need to be co-ordinated.
> +	 * 0-N are caches,
> +	 * 64, 65: Interconnect, but ideally these would appear between the
> +	 *     classes the controls are adjacent to.
> +	 * 128: SMMU,
> +	 * 192-192+level: Memory Side Caches, nothing checks that N is a
> +	 *                small number.
> +	 * 255: Memory Controllers
> +	 *
> +	 * ACPI devices would need a class id allocated based on the _HID.
> +	 *
> +	 * Classes that the mpam driver can't currently plumb into resctrl
> +	 * are registered as UNKNOWN.
> +	 */
>   	switch (res->locator_type) {
>   	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
>   		cache_id = res->locator.cache_locator.cache_reference;
>   		level = find_acpi_cache_level_from_id(cache_id);
> -		if (level <= 0) {
> +		if (level <= 0 || level >= 64) {
>   			pr_err_once("Bad level (%d) for cache with id %u\n", level, cache_id);
>   			return -EINVAL;
>   		}
> @@ -120,6 +154,57 @@ static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>   		}
>   		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
>   				       MPAM_CLASS_ID_DEFAULT, nid);
> +	case ACPI_MPAM_LOCATION_TYPE_SMMU:
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_UNKNOWN,
> +				       128, res->locator.smmu_locator.smmu_interface);
> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY_CACHE:
> +		cache_id = res->locator.mem_cache_locator.reference;
> +		level = res->locator.mem_cache_locator.level;
> +		if (192 + level >= 255) {
> +			pr_err_once("Bad level for memory side cache with reference %u\n",
> +				    cache_id);
> +			return -EINVAL;
> +		}
> +
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
> +				       192 + level, cache_id);
> +
> +	case ACPI_MPAM_LOCATION_TYPE_INTERCONNECT:
> +		/* Find the descriptor table, and check it lands in the parent msc */
> +		offset = res->locator.interconnect_ifc_locator.inter_connect_desc_tbl_off;
> +		if (offset >= tbl_msc->length) {
> +			pr_err_once("Bad offset for interconnect descriptor on msc %u\n",
> +				    tbl_msc->identifier);
> +			return -EINVAL;
> +		}
> +		tbl_int_tbl = ACPI_ADD_PTR(struct acpi_mpam_interconnect_descriptor_table,
> +					   tbl_msc, offset);
> +		guid_parse(UUID_MPAM_INTERCONNECT_TABLE, &spec_uuid);
> +		import_guid(&int_tbl_uuid, tbl_int_tbl->type_uuid);
> +		if (guid_equal(&spec_uuid, &int_tbl_uuid)) {
> +			pr_err_once("Bad UUID for interconnect descriptor on msc %u\n",
> +				    tbl_msc->identifier);
> +			return -EINVAL;
> +		
>
> Looks like the condition seems to be inverted. This currently returns -EINVAL when the UUID matches the expected spec UUID, and accepts mismatched UUIDs.It probably should be:
>    if (!guid_equal(&spec_uuid, &int_tbl_uuid)) {
>
>
> +		offset += sizeof(*tbl_int_tbl);
> +		offset += tbl_int_tbl->num_descriptors * sizeof(*tbl_int);
> +		if (offset >= tbl_msc->length) {
> +			pr_err_once("Bad num_descriptors for interconnect descriptor on msc %u\n",
> +				    tbl_msc->identifier);
> +			return -EINVAL;
> +		}
> +
> +		tbl_int = ACPI_ADD_PTR(struct acpi_mpam_interconnect_descriptor,
> +				       tbl_int_tbl, sizeof(*tbl_int_tbl));
> +		cache_id = tbl_int->source_id;
> +
> +		/* Unknown link type? */
> +		if (tbl_int->link_type != 0 && tbl_int->link_type == 1)
> +			return 0;
>
> And here I think != 0 && == 1 simplifies to just == 1, so this drops the valid PROC link type (0x01) while letting any unknown value (≥ 2) fall through to mpam_ris_create with an arbitrary class ID. Per DEN0065B, only 0x00 (NUMA) and 0x01 (PROC) are defined. So it probably should be:
>
>    if (tbl_int->link_type != 0 && tbl_int->link_type != 1)
>        return 0;
>
> +
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_UNKNOWN,
> +				       64 + tbl_int->link_type, cache_id);
>   	default:
>   		/* These get discovered later and are treated as unknown */
>   		return 0;
> @@ -150,7 +235,7 @@ int acpi_mpam_parse_resources(struct mpam_msc *msc,
>   			return -EINVAL;
>   		}
>   
> -		err = acpi_mpam_parse_resource(msc, resource);
> +		err = acpi_mpam_parse_resource(tbl_msc, msc, resource);
>   		if (err)
>   			return err;
>   
> Best Regards,
> Srivathsa
