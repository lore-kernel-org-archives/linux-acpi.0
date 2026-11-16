Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835054;
	b=IR+5Nosr4+CSeC2jPxLA6UPO7wVLnNs3K8iabXPjD+suU8SPJ3Vic/DPjVjTceyW06ZZ
	 6CDZ4/OyKCmkFPAZHqI+heRIpAzdCbQMW6M0W3Q454UB9vY2qJlaqXZeKQ8ms6lcvuug7
	 8b6dh4saVga0JlaXFLwIL6iI7GoyYccWy9PgRFK1nfvSjUDa1YCqBkWQrpnXnf1JXYhTg
	 L4Zy3osiW0tm1q6etwBk8BLxYrxvCETqtRNmjRrthh3yRtjD3POz8wqxs71pZpBtEAE66
	 N/mwPx42hhx6kAQghR3w3SrbQlhjlqWstoQw0SXXAvhzvFnRJfOqOLSgtSGeHYqtuLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835054;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DPgzSife+0fN3cYNF4exo/t+D88hj6Kyh9t5FaVY7H4=;
	b=NvsBzdsw5qMwuoxL70qyLI+YWr5OawUWfI+EN4XhDx10orp0mQvHC0/vmSbBEdYnDj8M
	 nzKeB8bp06Hu6ycaq23SyNNMybSmSFT9Ktl3COKauW6JHFptrNBmB0Jc85aTkjyYKAm5B
	 MTI/EDsB6NTqugYV1THTMirr4pmyja4eFpfVi9OKXIBxx4+5kUAFRkmXx+RQWNwHF2GQ/
	 5U8Dp77HClfTMNuEq6EmTlJQJrL4qHbM8RSEWTUAm0GRlvnuT+mhW0jM2VSx6mLaZJTTF
	 +RJ3KrAJT3K5Op/IBG6paXhQtTcexWYaMma7KCZdNF2E96Eo11y6QPBR2P9NdI46ekQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OzUBbxY9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bNQJtYPU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE59606A31C
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 13:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE59606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OzUBbxY9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bNQJtYPU
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC15Do1483045
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 13:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DPgzSife+0fN3cYNF4exo/t+D88hj6Kyh9t
	5FaVY7H4=; b=OzUBbxY9455L0kqJw+6OIBDy1w1W3FHAYOFUO3dop4sBnlj56vn
	wAqBDfdy6KFRtSk5EDOJLr/q6gkMWEYkBWn+PAhNWUYwuDJSifF78yf9ylUKwulF
	+Y7T2Kl+oLTqthi/stro6yYVXxiiPYloTqs2+sfsnq84TJXks5Y/J0jSJ+mwV9kU
	4CGhNxF95FAhb8XxYAnde27J24LezWqemOXD7PfpiQkBnpROBD6NtiyRutb9bi9V
	k4xxcMnlS36xxHH7Jx5FJ4TmHG9G78XQlqkOm+Eao2LkPWWCjC3RApTZ08aXGtNX
	xPbyjJNlfZ/Lf9eauncuf18Zz8PwVzOVdmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqgnjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 13:17:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f26dd2165so1067961785a.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 05:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794835052; x=1795439852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DPgzSife+0fN3cYNF4exo/t+D88hj6Kyh9t5FaVY7H4=;
        b=bNQJtYPUpkb9YYL2WJRJkH9OuESwlPZf1giibvWT7pfvQUYF17XhfWFoWhsgMbIy7O
         45nMSNRGQ8cEwEXMz1RCLVYXuQFPUYr7xEfkETGLKqPja+9vBVjl4rP7eOii3JETrzJc
         aHQ30uJTabEcPD0h4ezfyZ9hbDoFFQlhLrJhbqZfzI3lT628YelFbvgVsQ0FsaFWG6kk
         P8GNN+hur+fQXuHkHhbIp/1npHgh8GhquNCcjjBnOoErLOm4PE8PP93brLhJOEXuQp52
         uGNoxk6vPcf7YPUwn/BtG0htzsBzxZe3cFiqluNUXcit8aQ7LEqRoR5cQ6vaJMRpdfQj
         Hl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835052; x=1795439852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPgzSife+0fN3cYNF4exo/t+D88hj6Kyh9t5FaVY7H4=;
        b=lDWDosu5McYAej9xZO8VN91wDEdFjIIv+3Am0u2dM9qdgCS4gl8uR0lIIfEDSJLtVT
         6T7ysDPotzDAwlSBtm/LdEC7n1lCA5V4sqVw3vkt/uIa7ItOdzsHoPpIXDsqCLgkOfmd
         RTxJvN1WCF3V445jNEfRV9UIuVv9uLyExv/HMpZcg40yLNTa3HQtm9+Mun6hUI17nA2v
         XGecV+R8GfMu3TIMqYkpppsDcAl3EVoEEnX1ng4rComSP1kcPnf6oK5putwLq136lpw+
         F+v+9v4eVnJel1g9R42jgAfa0A5QUZWLStZazvENdW38Cr1Bg15ekGqXjzYZekQrZW6m
         NbuQ==
X-Forwarded-Encrypted: i=1; AL+hErF9o9F3CMA/gc56x9/KQURI2SxNN1/SSbYsZisbnSKfz9wWUc2yknFfgtzt7IPpKdOQos+y+blcg3MA@vger.kernel.org
X-Gm-Message-State: APuU4Z/G+e/UdZMRD2pKrTxdD+6NgwJJfKOdoBTHLytyMo7nCpPJ2hHP
	AXu5GnQEwnKqSOotzTk3RGh2ZJN7svbKPqsDtb2Vqu1xL6CaWaioeCLdeP/WgRpxnQnBNgbvlkY
	tGKOQIUZdaJeJOlLWpJdb+ntWffOcwsl9Nnnj6+Z2FbDVtZAQuoUx3MQgxCfIT8d4
X-Gm-Gg: AYBFou2wa3PoK6fHnluUxY5Kj5k59agbMRyqWMCdIGhoIZUWr0ZqfQMd9dvne0EGQGL
	xEq6gvN6OdN4DOI5SPYzfDumZGIiEVE7vMBObdsXzTx60p6m9RCgQlpSz95J4O0eVNGUXWILYz2
	6SNGTmLuZ33kKRR+1lT/bJLYYjSg95dRW2DvV9SdN+H/JwQ8TAInTjQ7fbyAe1I8q4e+BZ4UHuT
	L0wOslum/JnLAkYXomAgYd0mp7X6ztvqYM6dEkQfdbu5xUvtrehVUY4wZjVdNGSBu2oMgQMjuvB
	Ib60r+vGsg3euPlgzw9VmIM8xwQC//sOoYftZiafcINt+5dYkoUzOsEY2hsLUKTF4YonNWdmmQW
	hl3oPdNOKFMe6JHrPkP0DR+z+xSXhZrpYDR8x/9Z/UFOkOIt8ak/FeiBxSeSV52c42QmJYXAh2l
	aCVk4WTKKbmMyvBqkqgNleQw==
X-Received: by 2002:a05:620a:29d1:b0:949:723d:f7ce with SMTP id af79cd13be357-949723e1190mr783586985a.30.1794835051860;
        Mon, 16 Nov 2026 05:17:31 -0800 (PST)
X-Received: by 2002:a05:620a:29d1:b0:949:723d:f7ce with SMTP id af79cd13be357-949723e1190mr783580785a.30.1794835051206;
        Mon, 16 Nov 2026 05:17:31 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm24878915f8f.1.2026.11.16.05.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:17:30 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: scan: Skip acpi_scan_dep_init() for processor devices
Date: Mon, 16 Nov 2026 14:17:20 +0100
Message-ID: <20261116131720.75103-1-johannes.goede@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb026d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=vHvZn-9Z5xfy6IYPFUwA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: _RBpablwHUt3YWE2B4FPl7dw7Dm67BqW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX0NKLerCb6GKr
 2ylS25L8Fizau++IQcnILQQmsgClXk/1o61PhAIMQHb6umpGGhKw3ebnFNTtSQcpimqm5/K3FZT
 JtfViwdphzoiDhcFyWPOp2nRrgYdu0tknolGCI505tN60KKSA9I3Dzm9bkhrEcIOUF5iEVOtLuo
 vsdAAuXBrsywp0GOnH07mAF221jD07ilVqIImJRq8unrjkftPU3DAH1Ym1UUAaQg9wSx/26mr1Y
 p5gi71ZWPsZcLze0bBRCQUvWxYV085TTLCW/hfd35xErfWaBhWkIkkfUHjNgk8fwT8hhbx3V3yq
 U4XbD2cNCNBdTX0d8M6t+MBgeyd2l20Q+C1qYMEAh7CJX4HnA4aHO7KJmhPLaG8YeVB8TFI6H9q
 xHR6XIiOLeVv8Zl5RdGzT62s12GpkTzJb2hIviNB+gjKffSQYOuiVmMCy4YKLhqEbFBEm4vwE/y
 52lsRXrV6Ex2k59idzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX/r+LD9HHQylE
 vqYbDtuYDZOTUsJAmuxpG4mL/ghDkWEEhaXY1e6r89NoTSiLiZXw4G+HE4JSnCGb39ahcmlXKuU
 MEYkWgya/BFRTkJkD7kMo3vUQDvjmHg=
X-Proofpoint-GUID: _RBpablwHUt3YWE2B4FPl7dw7Dm67BqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052

acpi_bus_check_add() only calls acpi_scan_add_dep() for devices of
the ACPI_TYPE_DEVICE type. So the dep list of processor devices will
never contain any deps for that device, making the acpi_scan_dep_init()
call a no-op.

Make acpi_add_single_object() only call acpi_scan_dep_init() for devices
with the ACPI_TYPE_DEVICE type matching acpi_bus_check_add().

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Turn this into a oneline change instead of adding separate top-level
  if statements for the device and processor cases.
---
 drivers/acpi/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 96b8b0dfe339..28563becfadd 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1881,7 +1881,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 	 * this must be done before the get power-/wakeup_dev-flags calls.
 	 */
 	if (type == ACPI_BUS_TYPE_DEVICE || type == ACPI_BUS_TYPE_PROCESSOR) {
-		if (dep_init) {
+		if (type == ACPI_BUS_TYPE_DEVICE && dep_init) {
 			mutex_lock(&acpi_dep_list_lock);
 			/*
 			 * Hold the lock until the acpi_tie_acpi_dev() call
-- 
2.56.0

