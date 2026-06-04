Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC830C371
	for <linux-acpi@vger.kernel.org>; Thu,  4 Jun 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585077; cv=none; b=WZRdmENlTrFAW6oZJZLxBLi2P8VXt1pvs29fMblLgZ5xb05EbzSD9pLsJEYsXRSF1ekzj+Ah0pSwWlzRXleoyMyvxTAkkJ3wQuvBmGS8qPuTY/WGB4X8o3VpMr9Nq9nB1Yx0CeOWTDJXPJ01Ysl6lJldOrLy41e3m52EA2/2/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585077; c=relaxed/simple;
	bh=gSXiSTZoEY3Lzy1lJp2zbSnXS1wilIQZZ1I/UN/VClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p93FrVMk/fk3MFtQFR8vxzRk1H1SC5mTd/ZHyI8Ud2b5oTeqd4ncizZFOLjjbGsXtVsSAzNfo+hi6eNdgu0G+foOVfbo+yf8iHqhGaE2kF4jF6H3i8pcDmYudJpNzj7N01qK7h8gGcZ7NotBLP9PMc8Zgqrr0k9/yOwmAuCqQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RfHL8/6p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWl28bwL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RfHL8/6p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWl28bwL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654ClVJ83241567
	for <linux-acpi@vger.kernel.org>; Thu, 4 Jun 2026 14:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f0qHDXKGno5xDqSISjONfodnvIlqKVUfyGUcnQBWhrw=; b=RfHL8/6pui2Gwc5G
	DFD5Xh6WzA2bj12rseOzXhlDbI4i1d7St0nTHJyQlvbJrJ6qLJ3JTvK4aZMB4pb9
	vuoXp2pNfmINrxhImUzfMk+73YmXdXrUeelQfrTNtBlLzbHHTM41zN3fcN666+5b
	3/qQnpw3X0OnbZSOgN2o6jBKMLFLqI7x+4YzvQm1X1EENF0HWejT0OklQsXvVFzk
	sO37yHSRZ2fzzIZYpWxD/OVKzn0m3QDNkt5kyyMJOQhqUV/4utQYqv9o8QZAFE2M
	Sh1/HSBt2Txy0kqARS2qcbfvTdBxQRwhUJJwL2C4P7seuCC8eAEH/ZK9aAcanYMP
	XGIKKA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejvd0bjsx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 04 Jun 2026 14:57:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517878a92c5so20555321cf.3
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jun 2026 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780585075; x=1781189875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0qHDXKGno5xDqSISjONfodnvIlqKVUfyGUcnQBWhrw=;
        b=BWl28bwLVoHHqJ7YGZkC+hta5lnPKdZ6EtSckLjsYSigd5iExBFzwViCipjUGw/laA
         YQioayXMhRQPjq+AKYwHLVFzR3BRUwnmWMB4xoyxFoJTXaZE+pz9xI9oGgxUO7kVT/u1
         xWbqaRMJ1N6Hi+Ki+5YMbEJPIew50f6/mWeqBBwaBP9ARBrXj/E9kVnaWc/FdpJUuojm
         ZdJiWMaj+UQ7V1JA4FBdVPFN0W9PLNS/oj8tqOplwlSzqdKvarWJHut9/UzFHV//riKl
         jQV0Sf5DMWO7Z5EgATfE6IvX/PWhcRAmo0sMv3iw6QbRzM3zXw/SnvDrPu+DO/uep+Tq
         Xyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585075; x=1781189875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0qHDXKGno5xDqSISjONfodnvIlqKVUfyGUcnQBWhrw=;
        b=AjoVZlXWh5Gd6W7u0GVLSQqB8mo8H1DW5zsj4PmMpve2yFovBfujf7/z/3YZPppGVD
         IE2TWkTkv90V427v3JSyQ/Buk52WqJIQbSdyNmnYy+ZxxuHKHwphlTxoMOz2CiyJmRq6
         HQWE8JpoT7RIYgT9+R2+Y7NbOQv+mjeFIHXk0AZQRgPnyRAdp7E2hdoF47HG2LLl8Xcm
         RTfLCok9+v7s9dXJKLxRnqbPiwzL5cr/95tpXzcRBvTkHiEmOBymDHe45YEcMH/WOqz0
         bbvm+c1n+dqA6ePbYkB+Mj2rHnwDY656JFFHLE8rj8izZYzJ444Bbs77mgC8oQIWblAR
         3DIA==
X-Forwarded-Encrypted: i=1; AFNElJ8jq1hqPIWMCO9qIKxyaTp/lCe4gGS+G5nLVt5/th2DfwFpu5k7d+LQLllWbl9bI85PYrEAk3zUv0lW@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwRN8cGXvK1D5b/pYusjP8a9HILSE/Kc5zbhYXdkyHj8fGa9J
	VCWVrbxTVaedJhrh8CDEXhnz76kBu5WuC5JQ1wz21ipuvaDlhH5QsJWP8lwxwGxr8LybWQC3KiR
	+sbZLOBssTKzcJPKuhdkyOknhN23ljS9N+yef1N3wlv+K0x/JQ7nYVD88mbVfSgpR/8/gvlwmJw
	s=
X-Gm-Gg: Acq92OFS/mls+jWer1JkO5vcEydCEB4vSuexW/8ZqyjGL7dd81XbdoQohyorwaDqOxL
	fKraVQTzLAIeGk3+/ngJgQ+dE173a3a1FCuhDu7A/wSeeSyKRshiCmJEVOG0vypSFD0stqbi+k6
	en2GrkPT5Q0f1J7BUUTwbW5dieowTLbmMVtziXF/NPNbX2mo6jp+SqKl7QuJ0Jxw50l/spNtzcy
	l/xdL8ZeF+sNI7g6c8XExsonJdAkC3tVZgiCezhBRVxlwzPKKX1zOqCJqCu5CKFuxJ5nB7lqUn1
	9zzUtFuGGASjeU2tGSx4tXkdoDI1zT/NHxIN4UyaBvdfVPGg6ZL5uEsv9kvsJXoObVfXJ3Zakk4
	cXyHar0J4OhYLMLxVNAGbLdgO5pY37lzgtP5K6jpjnLOz1Mt05jRECQ0oKQrUa/E/BQ7YvdWczo
	K1luDK/JaCXakH/g==
X-Received: by 2002:a05:622a:848b:b0:517:75d8:b956 with SMTP id d75a77b69052e-5177871f8ebmr96526971cf.40.1780585074720;
        Thu, 04 Jun 2026 07:57:54 -0700 (PDT)
X-Received: by 2002:a05:622a:848b:b0:517:75d8:b956 with SMTP id d75a77b69052e-5177871f8ebmr96526581cf.40.1780585074266;
        Thu, 04 Jun 2026 07:57:54 -0700 (PDT)
Received: from brgl-qcom.local (2-228-54-83.ip190.fastwebnet.it. [2.228.54.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm75037855e9.11.2026.06.04.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:57:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        "Marco Scardovi (scardracs)" <scardracs@disroot.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gpio: core: fix const-correctness and remove UAF FIXMEs
Date: Thu,  4 Jun 2026 16:57:50 +0200
Message-ID: <178058506651.3858.6240644872632687153.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524162708.62949-1-scardracs@disroot.org>
References: <20260524162708.62949-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dTeKswPu9A3qCqyJRHe9KCrBXWc2SLNg
X-Authority-Analysis: v=2.4 cv=M8h97Sws c=1 sm=1 tr=0 ts=6a219273 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=F4J0OHcPalsv3C1teIDEwQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OnkKZ1vEyO2iae7U7wMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: dTeKswPu9A3qCqyJRHe9KCrBXWc2SLNg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0NiBTYWx0ZWRfX2GqLGIg2y0tC
 mjuTYuVOxVaQ/3R5QR+InInHfY64Fh6UVtL2kYIoTJwzQ461UYVoAsOyX+YfQKqm0xwpwEuZzIS
 wVq6+BdChFx1vDlkNcapA2fJqywQKOGdBYI0kPXm8pqD5veBFRUrkV4RqZFEUaz5LhBZ2YMKbNv
 hOwqimrt5XD0r29lyIVYhK7oSevqNigSUXFMa3+CKNG45cXtYK3Ppnw/D7Y+Tm0tW0NJpCSbMse
 yUoiBbT8C4UmkRwfXYJmJ51Ep5rnU+e7CncThfvqT2U1ZsVgxpoeX3ms0myG4rRUkrDLvaqesbL
 69EdVygG4Q5WU5xZWQgs5SKgyih64Qo7tEnG98g6Pdx92CQlr5ernEPKSsxE2I0qb9K/Yj1cVyc
 AX9nPkbEMT4GZLtUpEfRDIxdlNnSnemCubPFnl7hLVhfTU975Mbs/advkqMM4Rqy5YJdQvt/Rf8
 bEzhxQjP7+nNjFyEtfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040146


On Sun, 24 May 2026 18:27:06 +0200, Marco Scardovi (scardracs) wrote:
> This series addresses legacy "FIXME Cannot use gpio_chip_guard due to
> const desc" comments and open-coded SRCU locks scattered throughout the
> gpiolib core and backend lookup paths.
> 
> I am aware of the ongoing work to replace the gpio_chip_guard architecture
> entirely (see the "revocable objects" patchset discussion at
> https://lore.kernel.org/linux-gpio/20260513091043.6766-1-tzungbi@kernel.org/).
> While that broader refactoring is being iterated upon, this patch series
> provides a simple, completely type-safe fix utilizing the existing SRCU
> guard infrastructure. It can be merged today to eliminate the FIXMEs
> without conflicting conceptually with future revocable objects.
> 
> [...]

Applied, thanks!

[1/2] gpio: core: fix const-correctness of gpio_chip_guard
      https://git.kernel.org/brgl/c/aa7e8b7ef03151305a387654280306684687ade9
[2/2] gpio: remove obsolete UAF FIXMEs from lookup paths
      https://git.kernel.org/brgl/c/07c44ee9fdf196dcec14675c793e3139ec8a15b5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
