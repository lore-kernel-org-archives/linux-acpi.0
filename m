Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487474;
	b=H2bHkgQZpOYQ1HM6HWIqaXQUiDLa+vCilSCWklPnWG8zDM276zKd0ozJ/klkcX3Wmn6X
	 LUZyPN0jM20gxGkhaJ94FqIEFYb2zj6LmhB15U81H4WJQQWhGAKoeefaXGNrijyme+ZeM
	 Q3RrRcn/4IHZvj/XqCNesJssRn+YkvospXmgDIYERT8KdfafObcauYyCwrt4pAVlMMPr/
	 MIHY506fHTqxrK2/FrZK5+TpZ0yjrQbL9XxuXdIIokcqOkoXfsRTpyOWCmH/5a2hU0n5P
	 De8hG4rzspD8617+vADeHxqVxMxL8KueD1Mx7PlPZQzUxEubAKsS5e51SE+a1E06aFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=49ZpNrKwE8TqZiyrTrpVNbWlzThPfD/h8h0uFniqkMA=;
	b=Zn/feqpzVc5khnncBCS8RZYHQX0tpPWfyZsqCBIPhsEXJZtR6hk4/q09wFIDhP1akKxr
	 tKuySKjO8wc7NbgNbx/mM2E80azQClosO7vJ2i+ZlSxgkRcQ14a97eTLSoZLwD/8m4CHD
	 rDiuXeeop57GwzWeYzuGCyvYm6RI1xkMTGkQtT6qNdrBweKc9EExFSs3KKEs+PsOGMsgQ
	 b8aLY6ZDVrOOrImBVVB8NPt7xjqD6Km3BakL1uOuOJ/IFV4xjw6wNVtjCHG44Ixf3tw8s
	 SEXK1p8DsBnvMGWr6jL/Wbx+c6ZX/tjufK5tOSn1pnBs0u9JUdCkhMrd3caMr2/2Bng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xu63Bjmc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XLnwTPyA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF299606A327
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF299606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xu63Bjmc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XLnwTPyA
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8qliw4149469
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=49ZpNrKwE8TqZiyrTrpVNbWlzThPfD/h8h0
	uFniqkMA=; b=Xu63BjmcDkpILW3Uw1b/6dHUZkGm34fSN2nYRTGQi80RbkJT+GJ
	7bubcECXLBjIqBbLBI5sXkiQdvft5O9gwGXIJKxajLO7ExMu/+6SdvRB2BTknVX0
	EgOdDjuwsKnpOyWqF5dlqYwU1rCCq5UspOI9SoKrXRWH1dkHJj82FJ8HJXiwzcaJ
	ZwD92P7u8OB0m9Qn74jPrmU40IGu9zhTmy6cHlhsPIw92/gkblabek0LbZCkU1hg
	6xutXcHBxIsj3EkuU86r9GFiBNFXY1rRxipsfXFh3sfZRa3K7l/VAIxZkY1ClTZb
	Cx0UNCZIQQ1GQnzYIWmQbmIimLXLXgrox2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc63ef4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 12:44:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-945c60b470dso641627385a.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 04:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794487472; x=1795092272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=49ZpNrKwE8TqZiyrTrpVNbWlzThPfD/h8h0uFniqkMA=;
        b=XLnwTPyAwvOQ5EUMVlpPjIrw698sy+C0BXlEvBrwlqKHy5TtUEPyPf7NE5HCxABPLu
         WcTiVQAlhHJp9YszZdSn/VUV4/TmoidFp/+YseuZbiTEyjHutpGUCUU/qoHbUGWRhCSC
         9OscumCwi9Ulaxl3DS8OdQt2MhpN1THxQTXsmD6QejTse9BWFE+BYH7PKgZkitvwjo8q
         30x9RlULI0rvkY8LIzLSJffOMmecDrZ/472I25Y7rNnge8fH8M4ABG29ppluYd7phzI1
         qfs37Pik3KAHaMvEljpc/dQ79ZTjAOrmuAW3LWPVQl4QWchIZQ/2/+CfUhmCChTs0qk9
         cYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487472; x=1795092272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49ZpNrKwE8TqZiyrTrpVNbWlzThPfD/h8h0uFniqkMA=;
        b=1PyoPg/PtSSy50qD6v1IZ3Iz7pwpS4kLbTdGPUCkRgqSr3FGL+ybCW2qQ9tGgvIPpv
         X1gHd4WpGDDuzALbSz2r+TfoTuTRBiTziyF3fAhYaIBRIpqC2O97Fs5qBpyMwQGV6OOl
         3VW3ZaBDHfqJwGCD4uY7ChZGw3LmTHasbw4I7IGWQeozr3/zpP4jh63nl42ljdUP22LA
         GfMNB4nsHLq5jYb+PMF4+GU1LE5IkhvWArTgXDdp/YzAnWXfJ9hDpUsW03QD1sGZuvXk
         l+qIlInmoSaX61kXF+XnJSY3DNJNuHmStUg8NMWWh4EUkXE8iLRSFGE4AyycjzjrFxaX
         ryAg==
X-Forwarded-Encrypted: i=1; AL+hErE9BsdmDG+kaq3+Nr4ZcNuqI6gW5jHi9IuuThyPlbY2dTo7GrXBOzQq+sAe2s07Cnmsc5B7Im0dws4r@vger.kernel.org
X-Gm-Message-State: APuU4Z/QPiFeElBMIihrufFNsNIrIv7xj/CzWJdROTyMnYMoUzM6EX31
	OHaWttSZYOT4X7A8w5zSGyU8z8srSZb2N/n9ET2hh7SflfybYCQy/kRYdo3bFgPEQnVa9sLQXeI
	v53VNobSNWq/Hbz2yEzwdigPsDFhJHRMXS2IDB5C2dyLO+GR++MjDl8cq62fLyWYd
X-Gm-Gg: AYBFou3NjY5qUtn7gX4/ymRKt8OvoLnX9YF0NUQFXom18ZVRrqpA1uEuGWbul7kTOEU
	pLZ+zJF5ftnZeEkzXfQ66kq42qMB4pDwiTDYVWpHl1Qn87p6WeBlq5WbCPXwUpVqfcgz0fKM2Lk
	c+hg+7jj73yBqJbe88SG4d9CBC3JEfpPtETGT1SFGAPiFcEDUTlmy74+8P9jDhaxr8bVhV15O5i
	sj/IiXqhk4rspiINCsrt62Hrl4IOrrJ1Rv6CuE/aso2nAMx1S0AXq5uzD3ti3g2hcEs6gR4l0F5
	eyjeve03rSP+7Z4NXfaperB4tERcaKB4LS040oHPVqbsOUUStByA7tnCLCYw60Kjaoscq6yQ2tv
	HpWHoB7mbB7R3ZSvqdmRPuz4qLsVC8/wJ/mcCWOydlHsi5oL1Mj1bLG8WJG+mgZZKGzpOZdwmSL
	H+y/E+BiR4gDZYG7gJf3BNCcN8ctblBQxh/B4JFJpFY5+rCAqAlrZwPmy1HsDGhmXo
X-Received: by 2002:a05:620a:a188:10b0:947:b201:fabb with SMTP id af79cd13be357-947b2022ed5mr619972085a.58.1794487472260;
        Thu, 12 Nov 2026 04:44:32 -0800 (PST)
X-Received: by 2002:a05:620a:a188:10b0:947:b201:fabb with SMTP id af79cd13be357-947b2022ed5mr619969585a.58.1794487471766;
        Thu, 12 Nov 2026 04:44:31 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757823caasm3289147a12.1.2026.11.12.04.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:44:30 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/1] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Thu, 12 Nov 2026 13:44:29 +0100
Message-ID: <20261112124430.110629-1-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: G-RNWH0mmX29YdS7NIVfExE-RIbbRMTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX99+nvwRGsnbY
 OToI7EWAAudfclEvCeLtakwt1RE0ZR4gKrCgoZ9qNYHupn1VI9Ap7RtbY9RYfTLpjEOxBPDI162
 gB/YJS0AD3XFofMMpoiSgNVulgJIs4BijGhQzgn/QG22ySZz/+Z2CsEeWf7B0FhDk2/CA7fHhYB
 rZQJfg4NpfHgVkVusjsYXnkS9WTBMLzDRzKzkZNZypukiszQB7D8pj3z1TBjKzHMf+XUBsIfhSA
 YFMphihEKEMSdn8UbzAKVjvpqxdARl+ppgWLjQ9BjjgpeOfnT3zHSJN1ek6r0Q1YTgEWpETBzWd
 2QNQxLpynpo/nyuIIjM1Wqs+K/+wW9kRXUFa2mj7QBXEcXg+/mDZxPFpb6VkgWr7CPKlyD11HZW
 j7v0AKPYSy8uHS6YKLZkOhHWJfRdqliB9xl3t+5ErBcePGiGCUDtrAGx/RZzbSTLIxaj8LlR/qq
 xTcHKJxVZ3zJDTkDoRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX5MyXrRdCSOAu
 ck8CKKh8WUQI5pUjjSnSGO6IRQi+6ADPODEFJxKdniAeM1TLsLkSJugX0qOzmzQxFhw/kHVE3j8
 P5RzL+y/TL6/WHAHi+JEm5iO8EkeSLM=
X-Proofpoint-GUID: G-RNWH0mmX29YdS7NIVfExE-RIbbRMTc
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af5b4b0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=P1vjxsRChtBFIuO1higA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120050

Hi All,

Here is v3 of my fix to fix a runtime-pm race for SDIO functions with
an ACPI-companion fwnode.

The race this fixes has become much more likely to get triggered by the new
rtw88-8723bs support replacing the rtl8723bs staging driver in the 7.4-rc#
kernels (by somewhat changing the timing). This old wifi chip is still in
use a lot on (somewhat older) cheap x86 devices. Which now often end up
with non working wifi due to this race.

Assuming there are no further remarks on this version, please queue this
up as a fix for 7.4-rc$ to avoid users getting hit by a regression when
they update to 7.4.

Changes in v3:
- Drop unnecessary clear on error in sdio_add_func(), sdio_remove_func()
  will get called on errors and do the clear
- Some spelling fixes for the commit message

Changes in v2:
- Do not clear func->dev's (ACPI) fwnode pointer before calling
  device_del() so that acpi_device_notify_remove() properly removes
  the physical-device links from the ACPI fwnode.

Regards,

Hans


Hans de Goede (1):
  mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func
    companion

 drivers/mmc/core/sdio_bus.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.56.0

