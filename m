Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824273;
	b=p669OmvJ0c8KhFMP6qNMA+nxytvH6Ck6yXaZ1csy3boqmDy4xaACwIpgz6aQAkxP/RA6
	 HM7XjLsnjLMmA3u75XUw2bKDNYSWrBmIgBFdqvbQEqnfatLVZqXii6whipd4F4KHR4qpd
	 YRm6ObjHuCt5sR88ipQwlKPEZ3mC9A8xP7vBDErngrAohs8eLWZEJcp12TSagZSt+rO4K
	 Japnln/xl/bctYbdeWYAcOqRV0LvM9Sk5NVr6HzVMkoThQmlkL/m8yASAKNe5iDBPLcD+
	 fbcPzRXhXB6Gbovwt63D1MyQJPs3vPK5biU3S03ig/Gw3FlmC29dzR2U0u18snzNZRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824273;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OIR0NP/HU5QJCeDiG02hcmcnoOwyERbt6L/KhDTqiLY=;
	b=y4OVGzUEllRRmeWyiDUcY0z7jOBtInQCI/X5fM+1iniuoc0xHXx1rHiguE0ddHQolJDU
	 Zw7iU/8rT9X0Bp43+eRnh3W8XvC2yz15ICyjRLz4jnZg3YJ+GeuE+uCY0G0Y/LwwFaQOU
	 pUCJhRAiVvbJ72ENU4lw8y9yEu7ao5TghL9iCrXFz/D4fuC2WGDpPXY8+oacw8Acxm/lH
	 W4VLFaWJx4yT/L3J24V5I1T214jOJV8Eh76UWElO4H10fdAd3q5PHSSJXfQz1KI/Yd8Y9
	 weeZd18F6QYKmVuUOtuwSLfPjm06hOUCayLUcJtrVfXFHlIitWUgQtLCP5jGCui9Jkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JFFu1wV5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YoXw66Z8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A1606A8AD
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 896A1606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JFFu1wV5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YoXw66Z8
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7evwu1895557
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=OIR0NP/HU5QJCeDiG02hcmcnoOwyERbt6L/
	KhDTqiLY=; b=JFFu1wV590kXLGpqgOR3XZXKPTH5crPNKETsCaEflwfN+BNeYxu
	jnc5GnwzM0x6nbphvP+Tf75uSJzLgx1ZmOkFMd4pQUpUkBTlGWLlVQYZnwSDbFNY
	EBUQuXJvuitn02IZitnfllGlNEan9MaUW3ziFu8LVkgF13+5jZREDiA+fZXzS0sj
	eEE80A2bG/YO4Poip9Datt+8GVQnF/kNuhtYLpCScCHzEcLCl1U/k8ne/aeAAeBD
	Iq6IC4uXz6ECogyLiJcBbDrsKGwhb4gTkCBPwYP2lgBOUmGyHOK+fRa8962kVlhn
	Ns1xNoovXi95BFN6KIPmfgL3NehWT1OrVlg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdwwq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934963b2bc0so643144685a.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 02:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824271; x=1795429071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OIR0NP/HU5QJCeDiG02hcmcnoOwyERbt6L/KhDTqiLY=;
        b=YoXw66Z8CzTmRQhJPPr9HidGytEzXWW71/shHc+DtKKkdZ29sq+m/6DhvV51SHTvRe
         OeLiCokpL8k0xdWkZ+9lh6BPz2Lh6hDDSheyLje8q8jL12lsw6tHmzVXO3IQvhLx+SqL
         3EIKpwMXYVjlTU/TXyBDmbq4OaXBQqOP9ClEoBnfsdW+0HKJ94/k1MuPljPWU0MtTHR5
         N1yBL1NzfAVrQQLvpX9ZgNaN0Ia1Z7ZmDcJGYpBhCLmLl1qSroVpXDbqfWmAXYic8TkE
         aGkMYTCBuO3O5B1ZKLgDRK70TBpPdi8lM2XWJv9SpoWQrELJ7vD7OMjXnE1fNCe5suTC
         dVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824271; x=1795429071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OIR0NP/HU5QJCeDiG02hcmcnoOwyERbt6L/KhDTqiLY=;
        b=UqULN0VbWB04WW+XRzPUR4NjBmWo89inPcs+B524uokIp0yNonxbbSOg3Nq80CkFd/
         m2BUBZK6z8r/uT30c5k08XV0ls7R3NUr7jNsXVH3d9GLqVw+hlD6zxJSnN9hzG3b+8I6
         cD0fll9dJSNFdwsuS7GXgR0bVl09aIYDi8BY8+X7ocPozOSqisYhWY/Lz6cvOnT5V4Hk
         EBS8CeSKe/NJzr2TSNfYyFwtdxKQJjDhAM4arKZ8nPFzTSrZ8s/mhVwByNdNSqg0KFv9
         hMv1S9bL7+Hf7rKKm4W1NvVRLWQy83dahYgM568OyuuXLhSorBhkNfE1/Ra9mUfYvTZz
         aEXw==
X-Forwarded-Encrypted: i=1; AL+hErHpBcZeuHAYlJtAtZ1iHw9XoA6JiXCx7OI4h9t8fMM8C8wWxHgLGoFjBuqOi+TcoxgkM8LDctoYpXG0@vger.kernel.org
X-Gm-Message-State: APuU4Z8u6LGm2GXaVmDVcupmewAOXaHaKjc7SvrWzPzIw39f5dSGXnm9
	CUClczEtEVKjXLmbA+go9m7XGjul/cDez79gNkWHyCWMtwJJF4InVaRjv+pfpkdOoSKGwT2vmzP
	w28FzEQKlMSDkkDYXFum8tdtHtrwKSrpD/8udA7CtRQukmmXr6hwu2jzwVkibAICFUnRrOxthdn
	U=
X-Gm-Gg: AYBFou24RlAn2dbc7RbdmgkzxBz9eY5Guld0AGO1Ps+GlhOT/nWmsoxsv+THU8c0AjH
	uZ71p8xxTcOv7XiBNb6c22E0uu4ZHWUJYopbARG1o4Ej01huW0kmFUr5l9EnMgIhTvCdTYjjt1C
	82owu8lmZVQoFn4acBIODjqfZaP28tI0Z4A3iHZo5b5QWGYrokDZQUPhM90cSYovzst2GhnavOR
	RAmcn5olbSkqsMOl8hRGI+L03UGGiTqMo9Hw881WLX6SvNzhdf/qEnu0kNIDhQV+4H03MQGOTUL
	JBW2aV+EmziN6Aet3siD1/IXaXhjELdRtlEfa/gpTCWpRgnEkLFSZu5H68S3zT+KHr1rXAGFKnO
	88udOKbhBj5GLPgRuJpVWebb0mSw01vf/j3mh4pMRJbkoYC8YemaaWUSQzyC3sDbCDsr0UphVhR
	hQeoKcFQL9SMUuwQbT4lRuEw==
X-Received: by 2002:a05:620a:4048:b0:93e:592d:f5a2 with SMTP id af79cd13be357-9494ba4af44mr1581939785a.11.1794824270745;
        Mon, 16 Nov 2026 02:17:50 -0800 (PST)
X-Received: by 2002:a05:620a:4048:b0:93e:592d:f5a2 with SMTP id af79cd13be357-9494ba4af44mr1581936485a.11.1794824270119;
        Mon, 16 Nov 2026 02:17:50 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55acdccfsm290351955e9.8.2026.11.16.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:17:49 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] ACPI: GED: Add support for GpioInt() resources
Date: Mon, 16 Nov 2026 11:17:39 +0100
Message-ID: <20261116101742.13702-1-johannes.goede@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afad84f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=6DB-NaMTRXNXOPa9GykA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MCBTYWx0ZWRfX8gOjqQedsARv
 8vsisJ09ORAjlBZHJBcy0Pfw797bgkncXWbgntA4oW+TgT+fJMdvNLvvU0OaCp6TgpTa2MdLgp2
 p5wzpOFGh4554QdhuEwVrayDJfn5qec=
X-Proofpoint-ORIG-GUID: ipbFmUiJDDle2MD0trKczuO-mWh1bYLj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MCBTYWx0ZWRfX50ethI5y7eXw
 ZV+984k8d9/G8QBi6Das9yQ1KW8/vaHsQzbpg6WjwJBkb4IXaPCQKFaJ5S1au2MqmFxrPyzLfCH
 RbPpqCeWpV+gHqKQglm+ByYJ4Hc1QhlvVbsukCXJ9ve5CjTgyNs3ciQY5j7fINSc8CyKXUVLbmW
 zuvi5kCwIHgu1F+B6WGSnMk0SIdMJemF13mb6LN343dbYy/Ny5CjWma9B6Xl6c6lVPLoyRWWbGR
 downxHybDk2jPNkj0jjqys8AdvtEwtFWosHlA0SPHZOKm+6H44AY/dd1apeyEmEe/zFA0f5CA3S
 E8q2DhGKm1TQjanKb/s3KjAX5ByPF44D+nj9W81dU3IsKAoKKfCNFSTutHXXSAp4qADr6Dkxpop
 HhaT1qpPjr/IpKEQ7VaBpdHQMgkSfLVEmVfn1fSGjgHe++zVpnymN1YkkoIUtoKZhitQYrocvqy
 4J/PE+TAJgfxdzBCZ9A==
X-Proofpoint-GUID: ipbFmUiJDDle2MD0trKczuO-mWh1bYLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160040

Hi All,

Some arm64 devices use an ACPI-GED (HID: ACPI0013) ACPI device with
GpioInt() resources in their _CRS resource-list to handle GPIO events.

This is done instead of the more standard way of using a _AEI resource-list
with GpioInt() resources inside the ACPI device describing the GPIO chip.

This seroes adds support for GpioInt() resources to the evged driver to
handle this case.

The first patch adds makes acpi_ged_request_interrupt() properly
propagate EPROBE_DEFER errors, the second patch is a small refactor
and the third patch actually adds the GpioInt() resource support.

Regards,

Hans



Hans de Goede (3):
  ACPI: GED: Handle -EPROBE_DEFER return from request_threaded_irq()
  ACPI: GED: Refactor acpi_ged_request_interrupt()
  ACPI: GED: Add support for GpioInt() resources

 drivers/acpi/evged.c | 85 +++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 25 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.0

