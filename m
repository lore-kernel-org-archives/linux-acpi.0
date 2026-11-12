Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484929;
	b=BRO+VGt4W5cAFJxi1r7iaE/hL1NxIoffimTs9zj7u2T4HuwIXTuIz1wwkwh/AeaLl5DX
	 SbI79c0p7fku73hID6s0Euf7JlMEH5T8qv17O5FrvgV4J0u4U3ctTjTQaMEOcFh1/0jCp
	 DzV3ON5KYiRhaqgYv/P+MvBInipGiDemgQbTJ4MwxaDpRKFWrg5ijN1U/bBEIeDSxWC3M
	 xRjTRZjL+F+4WnV7Wb5cjt2eaglU/ilMnloP/DaLWbwAlGsXKzKoI9Yn1FQjXlMBbLlzz
	 lZNh+5Z8rk4DkPBBsr0IVNAl7eI0FOgfXJxvhWXkLc+wHB4tTdO6kQsXSjTuL5FXBig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484929;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AuDYEcEDJUR1UK2uaeMHs+3RuDU+1g1i2caaN7EZPtM=;
	b=P0edmFEJahkVtlhzT+Kxsf/fd8GXfynRugPmo3HnSSy9nODMEiy8NxZBlZOqxXbHkJ/L
	 nQfZz4qPPEQjvQdL3DWEZBu86P+zx5oLCrBRiMBxf8Tno4SRmYpV8XvsJcYE/mZzyZN3n
	 F0S29L9qYKThp+fVDe8klZq8e3ky8V7hOAEAIU7xL4Re5hNX0xgW5WsaFPtZ7PHSimChR
	 Z+MZ0bnNWKk1/ZLoXhROB7kJwN6amF9iw0E2AiTguPuRZb95edX1jpuYXk9AGCm3psvoc
	 E+mAuKpHkk4JsEI4Hq83g980NKRsfKFudnlt1IonvHnGbsMi0CsejuhYnur0lFrI4Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fAvN8QWs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="d/Vm8QDn";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75F606A323
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D75F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fAvN8QWs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d/Vm8QDn
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAUn881629431
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AuDYEcEDJUR1UK2uaeMHs+3RuDU+1g1i2ca
	aN7EZPtM=; b=fAvN8QWsmuU63JrxdCgL0qfveB+M6RlA4jwH8ZLIRqOa2zWe2v8
	u8ja870wKN0nbFSKms4No9qzIwO0NQ4Elk+mJlDPRVmc38f0RazxKDxsMUN9fXZE
	yZqH0kTZkJnFMd9l+k6hWZwwG9ro1NDxcRdEzW6hlyf9ChvUxEsJj87iSAkxsJtS
	/eNdgKFGEVp2wRXvQTECYKr961yHNfF/jzcnrPDzINJaLoFEC3s5d8X5dTS0WMtA
	t3tLQp8kWzejHOodWzwFx2eyduZn+IzP0MnTN8Pe/OQ3mgSmNp29GZHCJo4j3Lcr
	KXuu36RRXYiLlldnhb5naaH17MaBNo8A1UQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs009hf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:02:08 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eae356241fso1072771e0c.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794484927; x=1795089727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AuDYEcEDJUR1UK2uaeMHs+3RuDU+1g1i2caaN7EZPtM=;
        b=d/Vm8QDnZ+t4OJIB8H9UGHjJRI2SoF0pprMESo5cztFhTVH7KHU5IDNcAmU3i9GH2K
         8tR+gWWt8b8RZfWSn2TVS7iOyC3B4TpE7rkO2Z1Qx9U87sQX7OLOxbK5Mc5rHmgzRGzU
         5zzdqlaiO/IfwfV54RsAde6Arj81y7BO+iyTJEoXHNAURCetm85ajHUv7rJNTirBlyfy
         9tgrR3sw6BRHpKHZeiPsgGRmLioWthR7esrhvNiP3//zguMKIG8g01h/WY2xJgSACrsu
         VXOSkV7CUatSOW1m6VgP+iisbqIUueSclCIyQonjwreYpucGoHwHg8JIAxgqwRFvYQ6k
         g9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484927; x=1795089727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuDYEcEDJUR1UK2uaeMHs+3RuDU+1g1i2caaN7EZPtM=;
        b=iG5SwpamTf44XbZcePJn2cRQPPzqygQf+G8GT+SqjSaY/HP09KLJlriqM2b4tIVK1w
         GpfbrhEUVvy7RfwvThiu1l3fbbTKBENXM/UZ99TgRY1DTScXyCiuehnAg6i7czO+P3W3
         3QfUHZeTqSSSrWfSG9cju0CFLV9dI4pWiewsuQdVoNgViSlkMLP1dYqyEN0m8kYvANu9
         shZHjtjBqDUOPTL5O61nhiRc/sz24A1ZUyOcu58fH4J/FeT11vZipco/SOMofHwqlz/K
         zNqXckeDMI70GteVGLVCsJ5lzlqEBb6IMcwPCJKOZgh1a5Xn5fWs/YdNtUOrckcaCLcs
         9zbQ==
X-Forwarded-Encrypted: i=1; AL+hErFVh/nvQEbmENqWjB55549euDjv8Sap63IuFs57hyCWoE7ojzc53NhzsiO3E0KMKuz3JxaSJ1Rpnyon@vger.kernel.org
X-Gm-Message-State: APuU4Z/wfNmvDilrpPC4o51TighvQyTbPbSFv3BxRIATB2qGChipxS6g
	z/ODb87IzulJyAKmE3b4Unq3DfX59/z1qPDPJvebNjXhurmGjW72Qyob6epgPdtBUcn0SYUk2fq
	1sdjJdpfRu7prBUI7w+SmRcJpGD+VQkLzY+jUZNstQWjVh1oHPHsc5VHwPD+kPBp67xa7+8CV
X-Gm-Gg: AYBFou0e7w3l4fAb5S9o/0Q45cocPVUJkJ2NBpgieQWx0Gik27vsZ0v6XT3E81tACux
	Wmjskq7WB5GLClFpP/HZzRqbm0+X+D/tfGXZLy/O3f/JSOEPCcyyVv3WXraBX+y7GctSHSvmfIb
	A6p8IKzr0537nZMdbiuxMor5BQTArkCT5joRQo1xhWzecg6zS8VyDXgb2VjA0AD16pzJ15Ra3Ej
	MDCM2wXS/U6t6JBew3vrQPiOh2p6hCWd/TuWf6MvCCAle3Pmo3CmbQ6fI/VXB02Ny/CeXzIDqJI
	2ffZxSiL41Q0nAFkmfXeDY8BSKAIj9lxKYX5WyJRHx5B+V+uXXO0eAfsPxVc/mueCMJo4u5AqtE
	7n5Au20Lhrf4vizr0t5giAl8O1sc85I/OPJnvJsR5SRbRQ8HblOqpAY7jNdafMTZK4sJga754n6
	ji17MBo/pSEx0v8p67ZBWVZZ84fELJtDjspeuz/1xnxpAB65dWcYphBwlB4bSrX665
X-Received: by 2002:a05:6122:1d12:b0:5ea:bfba:f540 with SMTP id 71dfb90a1353d-5ee1c2a6763mr1925865e0c.1.1794484926958;
        Thu, 12 Nov 2026 04:02:06 -0800 (PST)
X-Received: by 2002:a05:6122:1d12:b0:5ea:bfba:f540 with SMTP id 71dfb90a1353d-5ee1c2a6763mr1925756e0c.1.1794484926192;
        Thu, 12 Nov 2026 04:02:06 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a602b70sm325553366b.49.2026.11.12.04.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:02:05 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/1] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Thu, 12 Nov 2026 13:02:03 +0100
Message-ID: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfX0k0a2zwJIvJ2
 Yuyg+CEy1z7h2604VUIpTdKmgisthJh5Wn8ey/SXnaQ7RpZI625X1BZBNZ1qFL7/zst8pXM+qk1
 tfMLDfhXwRDkcp/4fnunAA+ViyhhlK9vstqAjmE+eSsHUsap081aI3zNAi0Ja5XS5RIyu9NIN55
 r/k9pG5P9/NzeKo2RDkVm0pQ8B2LcGzcZDP/XlBtsGlWZEYkO4IcTUNePTBZusJKEX2D9NWdw1z
 E1aGrvNi2N7pKXr8rba8+NAfKBG7H2XFzWWQFXEiNvEqoM0Du7lCkUb42pG0SfxBWpDLjQzSOYQ
 uMO0BgmvrT6zsEpnEBnnT1eMKaYWpJKB7SYhCgACbeG5W5PLrej2hOr5M7cMZjTCMaigqnxngok
 jy5s7YjyKE0dSYatL7eqGr9foTPn5t+OqaiK4eGaLHVL39VubizUvfLTuA+DNQLV9T46cIwRqz4
 A+UiV4xymSKScDkpf5Q==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5aac0 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=XvLEI6pVna3Y4YLx6BYA:9 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfX+uRNOu1YYw+B
 081xHIRaoc5GQHCWopYRa6tumMB8FFwjBJUJMAOGfpIH9huWQWoF1LznRuCcjeeVKVTivyqM+gV
 7G0uf6ZV9i/NFFYVAn6QdGEAP8wNYCo=
X-Proofpoint-GUID: RMJXLY-_dA5eB26JTIRGB8HFlIZQZ8o5
X-Proofpoint-ORIG-GUID: RMJXLY-_dA5eB26JTIRGB8HFlIZQZ8o5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120047

Hi All,

Here is v2 of my fix to fix a runtime-pm race for SDIO functions with
an ACPI-companion fwnode. Sorry for taking so long to get v2 out the door.

The race this fixes has become much more likely to get triggered by the new
rtw88-8723bs support replacing the rtl8723bs staging driver in the 7.4-rc#
kernels (by somewhat changing the timing). This old wifi chip is still in
use a lot on (somewhat older) cheap x86 devices. Which now often end up
with non working wifi due to this race.

Assuming there are no further remarks on this version, please queue this
up as a fix for 7.4-rc$ to avois users getting hit by a regression when
they update to 7.4.

Changes in v2:
- Do not clear func->dev's (ACPI) fwnode pointer before calling
  device_del() so that acpi_device_notify_remove() properly removes
  the physical-device links from the ACPI fwnode.

Regards,

Hans


Hans de Goede (1):
  mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func
    companion

 drivers/mmc/core/sdio_bus.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
2.56.0

