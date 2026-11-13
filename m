Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584829;
	b=M6pieeZSh215+cABn3SGlkk3GEm+sgkcR+49a+OsAZSibJO5juYTw2GHxctISxH2ZPN3
	 RLNctr3R+f1FWYJqoaOkUG9rWJpWqfgez155y5PFaw1xkZwZ9IBNE2sgGoreWvaPUPTSp
	 RDj8SE2m1xuHDjd2HRy3H5g/XrWL4tH04ypyFVLyGwk6Ksr6knQZk2NnbwikXDQWD221M
	 DFgo99u5JuWyKZ/YjXknGJTu++GQC/Q03Mtynfaa5Tl/4B/3qE9lQhQ97xwyjqvxciZL/
	 cV07TfAufU5pYBT4YBpEdae1+7RidEvMOd9EsZGQPY9PpTbYH64fZjpNQLtgR7FCJyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584829;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LhvoIjPwf8qgSokp0XPAMhIk3AI3O12ul9x+XjikETM=;
	b=Mfbxl3tkLw6XXDk1alYqe+uruh5w8rq0P0AgmJfMTGfUpIx/5J8YsbW3XpLgTWzDtXwD
	 bQ8BvXC30iOsa8K1BxogzDtXgBF8B5vtPeoJYkN6okREteWqIJP6i8zseNlkXK+lH4oHl
	 Kwjwfvc1M1RYzL4pu8KNO+njwo5npTGxag2eETrUEomCjyVerTBEhwe6VERjTabSpPVnD
	 ICgX1CTZoI+G7XM+27NsLAWaFFOoiXRpbJtUPJ/koizZpi1nPqDIq8CMYxCOdJfOm4TWf
	 7quq20/6Z/AetpUS8gQ4YuxhWoG/n3bfiIbFESt3A9I2CZd0fxKXRWH9JeBP97hxOjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXdqUjNd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uygw0GpC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B9606A33F
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 585B9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXdqUjNd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uygw0GpC
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFREiM1190178
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LhvoIjPwf8qgSokp0XPAMh
	Ik3AI3O12ul9x+XjikETM=; b=CXdqUjNdwxfkESc6nmWW9DKUrkFP4+VWDxMyIT
	5zzkDzxJlvdNGzHXqnGzmZ00HYGZit8pVYaM0vt741QDL2k70Tojlp72dbAANGqs
	wiy8BWIYlEoRmlzBTPoGDwizSxMEWU9tuHtAXkjNuKqkmTU+sjVWQPAoBptzXTyJ
	/5DNwvl4TO/BmJ8Ljd7MVy6JFGHypREnTuPgghIGuirod6Q2Whauhbae56WMq3Gv
	+HSYrZrsmBfXXAtmmDDb64gRmMO91Ermzbwlsq5op84HwqWYIQPME2Oo8SSwK93b
	zHTDm3LbTUtLXEt7vennFsueax088RWq2ATKTaAj2lwKlCqA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufk1ke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:47:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2373e9b4so123336585a.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794584827; x=1795189627; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LhvoIjPwf8qgSokp0XPAMhIk3AI3O12ul9x+XjikETM=;
        b=Uygw0GpCYYXyTg+C51cVM166KOnBOyByo4d9miMO8nK5amviyccPWpqfko32don7iF
         k2RE9Cq2+MTaY/BOWPOPqbB4CNEPi34wCj/MWuzRO0tTEXKwYhWhtrHNMGhho3p8sUbR
         QFiD4jBCPXUcBVn2zN0U8HNdUpIrTa2MLSe+lDdFsy5McWzbeXIJXyHC4oNM5El9OrTU
         TwRK7XX7CAm+/RDTHGZ6gICnXKKPYwPigw+2ewdzCStCwLfaZBq0rRVm6i+1yqMFvc8x
         LKQWKqn9tmK7XiIFTG7PRCT1tpKMRd54z979xDdjqLPjRsul7z6P3/ehE4ZVlgFIjCwr
         521A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584827; x=1795189627;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LhvoIjPwf8qgSokp0XPAMhIk3AI3O12ul9x+XjikETM=;
        b=OSN81ve21iiSJQfJD5g6i6ehFaSKTwc/YAwOo8DQ7ed/HzFjtmxknSrauTzEcyUslJ
         DV/GayYv1t4VzxqMDzbFFH25sbBqw38Q871/8rBrx0GYnWUayDJP/3Ed6W7xlHLr5CfW
         QUSHz5uQ/VQE9QcnHrvMzx4NJ/53aIQmiGPs6EWax/nwv7a4WMIE62qe5RSgaigNnLTQ
         qIT/a7tcXcVcHuPmqFW8F/wZcX+19SsEnahn6hoz5rdDB9EzcrirTDSiaYcqvw+CH8vH
         f60bqYabeDQFxDj1dc89cr7Cw4gcnVgbZKqlpM9C4JgIzI5+P4oXom5VLasi82mx8kyR
         VTZg==
X-Gm-Message-State: APuU4Z8891jaAxhUUkZA5TDutiRBpsVBtLvMY+T45CMk8c9fveBgP5nk
	q3o8tFQy9xSfw3A0YV+AXxJthSCx/9E5lCBnWHLfy7Zj6etJVm32hcLW7DSwmZdWCIzGZehusYB
	hJhlmkzMDGlDGP85bXXZ+9KZsQCPG/v+oP8oLkAtBhWDHSjCN4kmgw1KupHc3AcOK
X-Gm-Gg: AYBFou3JTf/fp3dLJCCGtpOUTzsQqYl/huD87ElJFFa1ybmEpEXGYnkiguoKLBvEuif
	8kN8aL0z0H7HTNdzkN6V1Z3opev3j6ScVxvbWH99fyVPA5Fs71o+BUvXIXKnqWCnBWro6dTysJZ
	F5cCEbwxR8FMqbMrCwHZNvLx9a3viMO5kZkd9DTv7NjWNpNl/Vnwro49Qg7hG95zsiMcwIkKP1W
	Fmn371/pXIS/Mk6PaaOoxBKJsywmat9eMQ90uRiTt4prTk1UlQyCsJBOg0BEDjaPj+W7HKZC+rv
	BjJMv60IK//gC4QCzUPQD0NZYZObgo5os7loEm2FIa7DRmVFLZzmm1lw7zkOkVWkF3nTNHArCmu
	LsSbfWZGCA7NnCMeQrWKYAx06Hq6IcBqYpOUwVDUjhdSHQlGGrLcetgTw7uecigHDBicx7DOLOH
	S1tQ==
X-Received: by 2002:a05:620a:4448:b0:949:3017:1f91 with SMTP id af79cd13be357-9494bc117f3mr479649985a.48.1794584827192;
        Fri, 13 Nov 2026 07:47:07 -0800 (PST)
X-Received: by 2002:a05:620a:4448:b0:949:3017:1f91 with SMTP id af79cd13be357-9494bc117f3mr479643985a.48.1794584826652;
        Fri, 13 Nov 2026 07:47:06 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm5636519f8f.21.2026.11.13.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:47:05 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 00/10] gpio: make gpiolib-shared more fwnode-centric
Date: Fri, 13 Nov 2026 16:47:00 +0100
Message-Id: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPUw92oC/22PwW7DIBBEf8XiXBAQimMrqvIfVQ4ULzaqDc5CX
 FdR/r3Yvvay0qxm580+SQL0kEhbPQnC4pOPoQj5VhE7mNAD9V3RRHKpeSM0dT8hdkBdRArGDnT
 GONOuNto1HOrT6UzK6Yzg/LrHft6KHnzKEX93yiK27R4oBFf/By6CcqpBnh0IW0urrjEldn+Y0
 cZpYmWQ2+sAIdwfpXY+aOTLJKCbyee2CrBmepCE3IpNkJLZn2qri40LIBN1o95rpRrNep+ZGdf
 rN2CAkUXsPwrm9QdzGO/QJQEAAA==
X-Change-ID: 20260916-fwnode-for-each-prop-d7a6f90e7338
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3990;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=pLIlI74EKk0YI7MaPzy0iJBswk4SNJ2VXVWpc/TRWOw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zD2JMfefMzgqf2gQI9HjEGkS03S9cU/+15NM
 rjVlFW/aLKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavcw9gAKCRAFnS7L/zaE
 wxq6D/4xjxqWZq/YBLoZmFR+/rPVSoOwX8rkCks6n/OX3Jp78z4FF2adFhLx8bJ85Oku2/BISm2
 m0RUgQdn75xNST+tnoX5HcmYJUf9nUSGKP3T+L8P3rrEs5OnL4TKmPZXyNVtEq061edragWxV2D
 vfxLRfqfi7lKeG/PbEZcXRjHi2UqY9D1mMiU8me0zhg0ImJaediNulfKFjUF1Y73AeuvZmR6i4w
 Gob+FXXfoBEnFp95jPNEvvHRYhXdIR8SHZpbFIeO/7mADCMgnvCQSMd8jWyGUh6RieF4V88REBA
 hHtGU63S6UYK2MkpWdLHPPnopb0XTokOHJilHGLzNiyAEgmpIrtDjBMEN7VzbYz62y0cB9P1+xR
 x7uTqVCf9uwwCd40S53BeI0oxF4V3QJzlN2E2+zZaIsogr8xdBTnJhJe0VGPqNAan07bORhfS1q
 VaiuWXjNCRTflQk8sZN1TTPvDbb+AdUFBQl2NRiZLmicOVRCTVQspSV9zguDKhOa5BP/cZan7Ix
 H41ArOd4d//xYhalyUpxpFArnnmtHBX5/+4QSfi61MxWo1vukSRKdmbH79qduBXtA5ICXeCG8th
 dCpmdUvPCMKmQd7XdDLog0WiuOIYXKYStd3asW/exPaOEffaSzlDW839ujQevrvVhUZgOELL53A
 0wFciXGXz9Avuxw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: ghx_nVBmFq9yjdXYr6YmCjC1_3C6vMUH
X-Proofpoint-ORIG-GUID: ghx_nVBmFq9yjdXYr6YmCjC1_3C6vMUH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfXw4jlaDpRnbDR
 WiCEBhO84Nyf23vckbw00OJrVttgoH6NbGQthlH3bTWiZp/rhU3x1Bj8YBCW4iGmh8OMZEB6tT+
 DabysCJKhvHJ29AHbtm/jkcYT5Y7W8zL6y9lX6U8kitGUl0BcAFstJ9Deh//2lKBshu//9Xri9z
 0/0Ij3bOb9bpUVdBLb2cWRrC93nVOx5BvMZ69v7R2YXkjipJA0x5uoEwnZVRHvH8LD9hzkDm4yf
 CUuLuSMxYSU4jaYVNsNaMpvRW5ZC+g3KENNjrJmMKtIRqAZt7TVTkUdsUF1ZRVnzaOJ5Oexrtgf
 qmFctunDisTmowFSMtG2jir4kKHzOBafVYU07Rd89O3ApesCgIOlLDmyxfYmWlsCqN4HqxwPVh0
 LgksBMHWR6O6ODylSCi+xkDW2/abhASD1PIgxZy93pgiTSo7A333HybMxVdvnmzEsiP/A0IbmwX
 J7p0TsaHVTLpfZhcCUg==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af730fc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=sw4_LmjLfTFoMrZgmVIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MiBTYWx0ZWRfX/jFczfRyuJz4
 dtb/tKNoZvzaSvLqUFY3x2LDA4VQ0RmD18m8puBhF4kpCdw2FzGDYmnoousgQ/oYgOJ3lePxctc
 i82FlOhqvsKfWfn803y/OG6UGWDweJc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130062

Currently the code in gpiolib-shared.c only supports OF nodes and uses a
lot of OF-specific APIs. This series attempts to make the code more
generic, ahead of extending support for sharing GPIOs to other types of
firmware nodes, by defining two new fwnode operations, implementing them
for OF nodes and using them in GPIOLIB in order to limit the OF-specific
API usage to only a few places guarded by ifdefs.

The new fwnode APIs are:
a) property_get_names() - this closes the gap between OF nodes and
   fwnodes: OF nodes allow users to iterate over all properties while
   fwnodes don't advertise all properties in any way at the moment
b) count_references() - there's currently no way of counting references
   in an fwnode reliably: using fwnode_property_get_reference_args()
   does not work for empty references (e.g.: phandle = <0>, <&foo 1 2>;)

The first patch adds a CLASS() for string arrays. The following 6 define
and implement new fwnode operations. The final patch generalizes the code
in gpiolib-shared.c.

Merging strategy: patches 1-8 should go through the driver core tree and
be provided on an immutable branch to me so that I can pull it and queue
the final 2 patches via the GPIO tree.

This series depends on the series from Alejandro Colomar adding
strprefix() as indicated in the b4 tracking.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Integrate the series from from Alejandro Colomar adding strprefix() into
  this series as a b4 dependency
- Reuse the existing struct strarray in the new CLASS() for string
  arrays
- Make sure that props != NULL in fwnode_property_get_names()
- Replace string.h with string_helpers.h instead of including both
- Tweak the kerneldocs (Andy)
- Use size_add() from overflow.h
- Mark gpio_shared_fwnode_traverse() as __maybe_unused for !CONFIG_OF
- Return early in the OF variant of fwnode_property_get_names() if no
  properties are defined
- Add commit removing unused leftover code
- Remove useless alias variables
- Link to v1: https://patch.msgid.link/20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com

---
Bartosz Golaszewski (10):
      lib: string_helpers: export and rename struct strarray
      lib: string_helpers: implement a CLASS() for string arrays
      fwnode: define the property_get_names() operation
      device property: provide fwnode_property_get_names()
      of: property: implement the .property_get_names() fwnode operation
      fwnode: define the count_references() fwnode operation
      device property: provide fwnode_property_count_references()
      of: property: implement the count_references() fwnode operation
      gpio: shared: removed unused field from struct gpio_shared_entry
      gpio: shared: generalize most code to firmware nodes

 drivers/base/property.c        | 115 +++++++++++++++++++-
 drivers/gpio/gpiolib-shared.c  | 242 ++++++++++++++++++++++-------------------
 drivers/of/property.c          |  41 ++++++-
 include/linux/fwnode.h         |  15 +++
 include/linux/property.h       |   4 +
 include/linux/string_helpers.h |  12 ++
 lib/string_helpers.c           |   9 +-
 7 files changed, 315 insertions(+), 123 deletions(-)
---
base-commit: 161837d37055642b03475137461d4438c65dbddf
change-id: 20260916-fwnode-for-each-prop-d7a6f90e7338
prerequisite-message-id: <cover.1794574496.git.alx@kernel.org>
prerequisite-patch-id: 6c8ea11afdfadea1c72457e460596f9140195f8a
prerequisite-patch-id: 81834766a605fc75e62501a8459944c87aa7848e
prerequisite-patch-id: 49110713d1b10ae2972ae738da383215d9be001b
prerequisite-patch-id: 97bf1ce8e594218715d5df30711d0523c7f07bc5
prerequisite-patch-id: c94cdf0377763fbdcb942add8a058161503f9024
prerequisite-patch-id: d0e6af689d680619ee07aabb50635328052bc9af
prerequisite-patch-id: 1006c25c87a8e46129fdba68822b9592c3f5e0e9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

