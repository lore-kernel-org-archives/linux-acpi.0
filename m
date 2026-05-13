Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265733E0240
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661848; cv=none; b=L7zO7nca+YZbUvSN7IM0dQIGeTn06xuiFXdvFecoXiBuWwf3IEoatwquP2kQIS6gmXyQjHPo+a0vhukUqKjn6B/oA7H5thAjmCS815RDSUPtK97UFalsSyWwYPcmCpsWlO5K1sG36ACLGnawQwn/sCTMVtuEw0UiGw+dbRnhmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661848; c=relaxed/simple;
	bh=OM3puXfkqZmLNZrfom/EqiK3YzhGX1pHmbG85tQySaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZYGWsTDYxgmPRL6dLsS5u4RHHLT2kryYPv7qRIIXy+J0L2hFMJXpPNcVVEZCZuJ6WD5B5zBiKsi6UfhyFf2rIl0vcSHh+SmUfBzpNSzULZNOHwoyJQi2wRp09CStbFGgoQbqJmiDDtcHcYiF/DYcAcyL7KuibX/1xFu4OfoO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FiV9PcTO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kg5hMPmf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FiV9PcTO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kg5hMPmf"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4p95W2652377
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	10e/P1TFZBwN9btyQIYXv7eFhzP3u0CEgDuiofULBYw=; b=FiV9PcTOqUDEUrUB
	wi0As6qHPrmE1gK7uhvqXC2uVxa9J1dv7ySRSEbDJLDcDSaRwakuHud2jdMnNIwK
	Q0hNZ6dBU9a3s/Z0SfKkRwsydypn6S9OxbyfClQ0AH2illUtBPY0lOL+EBmocGs/
	pi6ioYi75L7WwnsGMhylhE3v+dWyYG3LPDDSoMF3YV/CKXBOiSCOyqzbDO4uPYqO
	gGs/hNOmOPNo8l9XQpt3K7iUwXJ5Je/tFiOSNvW4UlEjZBHYJkLO+pEUD1lNo/kj
	J+7Cfdr/7xYTwi72vawVCnv3U4srs/SJjVvCDmIO5j+nPL1VGlMVJrrIwy/Q9qmI
	hjYInw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avku5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 08:44:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b4678c6171so68670185ad.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 May 2026 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778661841; x=1779266641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10e/P1TFZBwN9btyQIYXv7eFhzP3u0CEgDuiofULBYw=;
        b=Kg5hMPmflBA3i8Ht8B/KXdInLhycQqmXoQb1Ht37LwinpgShpYI9/pFMv4yaelmKyi
         Hze73/1eK/i6VkOx1VcCtwvATDSe1DdiidZ1AR5MpYLt4gjiMMZ0jgg4hIxdKusIqPR1
         QQfuxzCjnnmSpNG/pmjVA4Jl2Ys9tf6pdzJnZkYFbGHGA4gkJEeqiJJ9op4xsrzqE2bf
         0j7INU5BPb0+4keqONQnCawcclxNVqi3OKehTfZMZXg7h5biwVn/UUfGv6t5NqbjwqgP
         NCZPsZoDZqfTikWwnrLhaCC8oykDZe3v9jZhU7l2eI2IeGsOazPIUksjvFw+ovb9rBxR
         /XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661841; x=1779266641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10e/P1TFZBwN9btyQIYXv7eFhzP3u0CEgDuiofULBYw=;
        b=FEzEEzATX/02OwFSpizJu+u+diSF9qTD0NZkbL3RJXlCwPZPFRAuSIpcXd2Y3xkkLB
         TKn+mUrOyc6k/wBF1NHYVTXGg2+4lJkdWOcJA3Hj7mtBqjpVTxGuQ11BGQe8ojoqX7YY
         LoEKVK2LM6bi4yFu+dOJB0GEIPybgMtXfgWcLI91H2rXhGiAHC2Rijh5asRDmBzLRVg9
         OMhOhfs1xWuHyvlrRRlnC08LFRac47B9UnbZBAUyrMqYt9WP7Dn8msXEVsoVoPtNH9wb
         RMAPe7lUbPlYfDWQpak+ArQ15C0I7a2tcoFmQ0VUvz5LFsQjEjdutN0OHdJ1TI/2Ctlo
         spVA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZyppOZYU05YT1NWIayh03BcTJmmTjWIC7Mk3UouhiCN3VcfKrPUR0frSXAbDdJtb10qahCBJ1VIpX@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9Lyi7JzAO1+o/TiS+N9CYRu3wioUP6pTVWkKt8u5+duy8WGZ
	zEAwT7YEkX2BdQblmZkoCA4C+52+2+2o2MQKOfY7bmk5I+vVTMAWTmQSQMoRAJmqLITmChJULNg
	wtjhYH5QFu54ndp7cpeiRGx/6UGsQZe5HAMQw/sTyD1HDreM9Pa2Ya+fdVNmfs5cW
X-Gm-Gg: Acq92OF9/gWP1J4igHKXug2RbXEB8xho6iTPOKW/jm3iPiOvBy54nnz3UUQekvCK7Ih
	3KiETX36x/NgbNwi7qbhfxiXm7lmtcfFkUmJ7JTe399boKUnQ5ytf0YbzHduba6pIm4EO1SfafA
	AMILz9UO55xIJK0Wp3PbAes8FtrMYi3X9mUL9+03XtotkMElXbMvf2zfM2QHrfo+T2CWRJ4D6AB
	WHmH+O20WiWKiG6JoJcsjr7+sH3BaaNIMrOGeikTn1BkgJ9Y9YeI058XydTCqB/aLFdTeo2jaC+
	LmRWGq1MPRMS+ltWNnOaApxqWrOF78ziJjFfTRqnqYxVTHZl/yUzUYnIZ8u7xbvVlPhky7SIowv
	jfzqmGC2Nttt4r0wktgvYC4GoePBkj5JdyQkHIJsX9+nBHYoubqVTSRkdC92yKJoPV5CjyXUWsK
	cPE9nmaQQKad3WVIVv4ZEIIs2pdsx1rtEDwJ08GjnVwu2Pmg==
X-Received: by 2002:a17:902:db01:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2bd2716dbd0mr27138515ad.10.1778661840814;
        Wed, 13 May 2026 01:44:00 -0700 (PDT)
X-Received: by 2002:a17:902:db01:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2bd2716dbd0mr27137965ad.10.1778661840293;
        Wed, 13 May 2026 01:44:00 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm169158725ad.5.2026.05.13.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:43:59 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v4 03/10] acpi: Introduce SSE in HEST notification types
Date: Wed, 13 May 2026 14:13:18 +0530
Message-ID: <20260513084325.2176952-4-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BzsMxsvDB7QlH2i6UEd-kVC50d67hGU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OSBTYWx0ZWRfX0bIIN3CHU2rD
 6BqLC2FC0R+lR/o/V1Nkqu5C5oSPa8BWKry8rVhRAYM4ou51Z/+YghPycEoo5dVR2KhQRT1LakL
 KKDLIt+DYeSM23wgZsB6ldfKw1kniM55lAiuNjuqu8D0lqQNxKDT/YiIcDkMkQyAgyQJXcVwHTN
 970VyRgLWqzX36srzPyz9L6ETsHZ9hcPtccfWkVFzgHW8M+UwbqJP0MPLiBCUT80kMED736yDVd
 wXy9Tp/8qvJUy194QKiHR1jH/NHN8mkAsgvIdgtyiMm/wbogtPBUivwVOeesBG/tLji6AAFCgi2
 EWpa/QPgOfgYcGPg8EyMF4mb/hKa/uYs61AD0PY5SLfi1wIu30RKmvLtjS4uQePPbzFYjNENQTM
 +WKRK0W7f5hlNw6bBNKqrUJBEXgS1kjxMNvk1DIVCKeKOTGMevBEfXeVh231TEboEnYLk3Z5RUC
 KlC80id5+ZqdXbDHLxQ==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a0439d3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8 a=6zSMeUNXk5_XeOI1LAoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: BzsMxsvDB7QlH2i6UEd-kVC50d67hGU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130089

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index f72e00517eb3..2a8167979458 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1798,7 +1798,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0

