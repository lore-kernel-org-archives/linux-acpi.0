Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E714DA9B5
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672136; cv=none; b=HdwR8VYIqpb5NpggLWEJ+NhjJytbJHac0rEKVI/mo9WXbk65s9zwkRz8YpBxYu93+eOEGKlFb5vUbIIAOxjlC5zwRXP/SfAqEkJ2C2J3tbdMhoUgQAbeWSI6sqYcd4fenxaPt422q54Xg+oXUATksCL/Pc97M1Cjj6ZZXxuM84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672136; c=relaxed/simple;
	bh=WOxJ6Lo0wAfwLEa0W+6u790Sja0fGTF876sOU1ZE3OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aefhwrlq0eAn3kH+XqaeZHodaQtD4P5Di3rR5zZcE6G2ZmfZkP6eSG7sDZUGJBprRbcCiyG3F5KDn3QXojBbOFOO6Sc55eu0pxeS8imNlGmZHd3Bs06cXOIgkBNIXdoymVqS86Xq5XxEfAcoRK+MOlBj9zskn+aqn6v4WqfRr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SxwwWJdo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JljEdXED; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SxwwWJdo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JljEdXED"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7TqJF2570988
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:sender:subject:to; s=qcppdkim1; bh=YYysSFbntWirOw1STKVl4DrzLwzu
	CO73/HGQAWPAgJQ=; b=SxwwWJdo3tGTRs3AaiGf1j/VaAqnsgMbWZMSWtn74vsD
	zwqiDSxOpJaOws2+xJZzDHHuMqxvqlygctslhLdl5Xp3uTBgYmY0chpWOb8YChJB
	v1bE3R96lkI6MpgdMA9Z1yPJxzmsftMBnHaMUxem8TvkIMl8YmqVVxepIttO4Mm7
	y0kRTFv0TMRIuT73a9i+uQ/XPdLV9ooKR0BvqSZEIQRasmqyVnKuy5H92ZQNI4bj
	9RlqpcyokCzii6SaTNp6sVYYi14bXwDmyQJwqGVjvDqC6PJ2Fq4YpdwQHhAVSSiy
	6XT6EYyAueRsQqbgFbE/ViVOUWtuoKa9ndXGLEbZ2Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn9suj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 08:55:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so8109435eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790672133; x=1791276933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYysSFbntWirOw1STKVl4DrzLwzuCO73/HGQAWPAgJQ=;
        b=JljEdXED9Z7dgE76lY+Lna/3M+Jw7aAYZLRzpYffg/CBpHrV0N9vb1xB6FOnfg6lxv
         kNzCO/zv68vHol3S8uh04+K0ljZwkwrAjCvHinRkBHeJ1HSwkZ2f+G3xOwim1hsTa88J
         aw24wmCrX722YjwaH30r1tlWVKIjgBQerLX0ZkOtrtXf8sbPmj6gHl+We4DD6SxPIKrS
         PofEgQCrV7kLeYmLDaWEH65/rK7qAhTtAs9lZOhU4poe9jMOgO3/PSLcunJwBVCTlhsj
         ORuwecWG/w/XLmLP+ndyp/vzOuhcFMpGuvcGBDJw1E47hrPrisgLI8zGSKqKKGS98eLz
         JPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672133; x=1791276933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYysSFbntWirOw1STKVl4DrzLwzuCO73/HGQAWPAgJQ=;
        b=Qo9rVzNSucgTfpRt41RPihSYWPBZbe0X5BO19Ok+xeQkM7KVGVlEGakWRvEvHO1XnH
         WkIjD5NgydF5djw+vxSVGynrSqSFNPVwkav+4g6HglpfI9t+aRwRIFYcM27g7VkidJCM
         2xGyJbFbnovbx4pGX775XcCetu4u+jOgASRbZ9378VDp2VkOE9Se2YWlrSIMjVmY3LPB
         v4xmCFnafmmBz0shJ1Xelpxm95/aJWmVaq0iUG56u8Wet+j9aN9AkcQlB5bcMMta9kA6
         U4RMWslRqNIOSf0VHnpbfidbxMgNbVt57xkt8CepXta547culxP1aj875Z5JggJzxPPS
         Hg0w==
X-Gm-Message-State: AFuF++nOWUCZVj6hGBmjJZBIbu44E84TFplzV3MTxzM226daMaxy2N/5
	THIN41O1Dr8Ca+Up/ycOjTMYwdwahkvro4RO2dUH3i5yBR9ZTmiMAppsv8sfKrzLxwBaMM7wC9n
	bIVDiI6S47oeZU8+FFrglmAyVvFrNEwnVbWA2fXAsDOGtK3EAOZsr06RUAmMODpGPSnK9Zc1V
X-Gm-Gg: AYBFou0JL22K/m/a40/C/DUOsQe+xhZSMmoqTH16WyMmYCHCb6rMc2Vpmjt4kw7Uko9
	CiU9mWMwDBcM7dyBUduzRdQam9Q2GcWtkIDso8nTZa9P3w27xWuZKGwAf6RewuP+OQmPscpHqyB
	lI7aPl/HOVhUAjDbjr969WcnaASSirIZFMh9OMOBqv8+FY+pczPLwvQpXcBcS6ahGkAokovhjPH
	+HueaiyaLYyBoReyicyZgRaJB8YgaGvL/ZImYUVUsEPThgR6l99RsGJ7AoZ0XOwvxdyTug8PauQ
	FrfMuf17Qlj0+cbEtAML/zdP9AwwyD5Xos5tOaC6nUtzTtpUogmfUAqa3pEwHIF/xHSAUfIS+L6
	wBufr3yOcGSIhDqtpczUNc4NoD1MRFHp1JHrHFaBcSzPf6XKzQPHmk1yZ
X-Received: by 2002:a05:7301:b0f:b0:341:f87d:4bd4 with SMTP id 5a478bee46e88-342701c003bmr12253853eec.4.1790672133126;
        Tue, 29 Sep 2026 01:55:33 -0700 (PDT)
X-Received: by 2002:a05:7301:b0f:b0:341:f87d:4bd4 with SMTP id 5a478bee46e88-342701c003bmr12253819eec.4.1790672132479;
        Tue, 29 Sep 2026 01:55:32 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144f4eb9esm34294467eec.19.2026.09.29.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:55:32 -0700 (PDT)
Sender: Sunil V L <sunil.laxminarasimha@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
To: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Mayuresh Chitale <mchitale@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [RFC PATCH 0/5] hwtracing: rvtrace: Add ACPI support
Date: Tue, 29 Sep 2026 14:25:19 +0530
Message-ID: <20260929085524.1554507-1-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb7d05 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=vF7HM7XGAAAA:8
 a=EUspDBNiAAAA:8 a=V1jnuoLLAAAA:20 a=Zpogi3qlAAAA:20 a=NEAV23lmAAAA:8
 a=YG64nluAAAAA:20 a=wDIQ8p4OHAohPmJ-3qkA:9 a=PxkB5W3o20Ba91AHUih5:22
 a=bNn2QJc11pDkoTYzAKk6:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: BcdGCFsxclSxag-7jpMHz5kY4xNdu0h2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzNSBTYWx0ZWRfXxULn/XeVIo+D
 h4qcE07iMEkD6LbjKWiPo6nquy56DEOMD1P4nvatt5XLhp0K1XDx8M5TnwsUhPLxl+wnniNtbuH
 GWguTxI6FhkmXqsuu9tpmbSBZg7fgnY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzNSBTYWx0ZWRfX/FKVaEsHnCEM
 eSVKedhImBL2nKp310zqU2Hc/mCc8hCwj0Cqfgn7X1Wt37JTCt6uvB4tz6yf52xTisI6+LhogNX
 JLeyMBxsVLvXxgkspAGkL6JVrmB0Y/fzZtgeVLY2orq/+tkpB91EbYLNQeh7A8rky8sN5+jPcVs
 BDsQIKGOspSazAt7dB8jz12n/v0pZvsDV2Yb2+CMSC6hUnawg4/WXD4gbAsbhF1PzI/GXwJ0DPf
 ZJoaDjkJhy69lheOZi4XP8dcYTdW+fDDDF6kkODpTRvphzPS36TQiQCvFF5HYIQKiuCT53ImLgv
 EmD7iKvBxjZFlAQrU0xKTJWpUaKCNBLFxz/z9wd2uSt4jUDL526NMtZK9+/pfhnA5TP0BMv1zhZ
 kBcnTvi6iF9HOQM7YlEhEXpO5XZDiHK6ZalNMyjo1HdGgACpjAHVcTuyuda20GmGDqS5mWXqU9O
 nG4Xg5bVHoOspE1gtJw==
X-Proofpoint-ORIG-GUID: BcdGCFsxclSxag-7jpMHz5kY4xNdu0h2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290035

From: Sunil V L <sunilvl@oss.qualcomm.com>

This is an RFC series to add ACPI support for the RISC-V trace
framework. It is based on Mayuresh's v5 series, "Linux RISC-V trace
framework and drivers" [1].

The RISC-V trace specification is proposed in the RISC-V BRS v1.0.6
document [2], Section 6.5. It uses the Device Graph UUID defined in
Section 3.4 of the DSD Guide [3], similar to the approach used by
other architectures.

When I started looking at ACPI support for the trace graph, the obvious
design was to follow the approach used by other architectures, such as
CoreSight. However, that would mean duplicating the ACPI graph parsing
logic and maintaining separate DT and ACPI paths in the rvtrace driver.

Instead, this series proposes enhancing the existing fwnode_* graph APIs
so that the trace driver can use the same interfaces for both DT and
ACPI. The main idea is to parse the Device Graph UUID defined in _DSD
and create synthetic nodes that match the DT nodes. The ACPI-based
fwnode_* APIs are then enhanced to traverse these synthetic nodes in the
same way as DT. The ACPI fwnode_* APIs already support the
"Hierarchical Data Extension UUID" defined in Section 3.2 of the DSD
Guide [3]. Adding support for another GUID therefore seems natural to
me.

The series adds the ACPI device-graph parsing by creating
synthetic nodes matching the DT nodes, extends the graph parent handling
for in-ports and out-ports, converts the rvtrace platform driver to the
fwnode_* APIs, and adds ACPI matching and CPU binding support. In the
future, other drivers that use the Device Graph UUID, including
CoreSight drivers, can use the same interfaces and avoid duplicating
this logic.

One question that may come up is that the DT schema [5] has not
standardized the in-ports/out-ports. However, the existing OF
interfaces already support in-ports and out-ports. Therefore, I do not
see an issue with providing the same capability through the common
fwnode_* graph APIs.

This is an RFC series, and feedback on the overall design and the API
changes would be very helpful. We have a slot to discuss this in LPC
next week under RISC-V MC track. I hope this series gives better context
before the session and we can have a fruitful discussion next week to
converge on the right approach.

The series was tested on a QEMU virt machine with the required ACPI
namespace changes for the trace graph. These changes are available at
[4].

[1] - https://lore-kernel.gnuweeb.org/linux-riscv/20260810152223.3946743-13-mayuresh.chitale@oss.qualcomm.com/T/
[2] - https://github.com/riscv-non-isa/riscv-brs/releases/download/v1.0.6/brs-v1.0.6-20260928.pdf
[3] - https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.pdf
[4] - https://github.com/vlsunil/qemu/tree/acpi_trace_rfc_v1
[5] - https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml

Sunil V L (5):
  of: property: Add in-ports/out-ports support to
    of_fwnode_graph_get_port_parent()
  ACPI: property: Add ports/in-ports/out-ports support to
    acpi_fwnode_get_parent()
  ACPI: property: Add device graph support
  hwtracing: rvtrace: Move to fwnode_* APIs
  hwtracing: rvtrace: Add ACPI support

 drivers/acpi/property.c                     | 516 +++++++++++++++++++-
 drivers/hwtracing/gtrace/Kconfig            |   4 +-
 drivers/hwtracing/gtrace/rvtrace-platform.c | 191 ++++++--
 drivers/of/property.c                       |   4 +-
 4 files changed, 657 insertions(+), 58 deletions(-)

-- 
2.43.0

