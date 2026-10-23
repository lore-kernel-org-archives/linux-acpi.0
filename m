Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750461;
	b=P4PTcgGDEo8dCigu4xWvXJogS5VwjnTujWnhOy5k+lsJLFguUuKHnqSld0yKlQ8pccB5
	 F6KZCWzEAMrv2rlMMYf8d+Soajhns14p4o1geX50qd4/tZQZ4TjMvoi26lDk7VGkDtbJ1
	 d6LbJkVQiKjsTNOjN/1qLBu47cgwQ1ZPCzQkKvWSRWuWq8PQzW6Y0uo6taMJojPX1my8k
	 3neZkkn/gz5p4aZBZEhEwFt1KIB5M2TI7JNMzTSk8/JKM1vHkD8p0FHPXSGAIfwK7PHGi
	 ZqTMPw95C0dxoZvxmD+JqiaTAafagtgqb4VRZ9afEvZ3IMSqTsELpvFzXf1YM9p8x5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750461;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
	b=aiVsFWb61HZ030ZRrnhHfr24JMfDrA+2mMc2k8e+THVgPZdDIOPE6uMgcYQN42vllrb6
	 xMHi7tBrd1eBAaB4/HhVDywz1G1A/fp9UgS8OEHHp571Rs3aqoW4zoVTCGfrdthUW+mx+
	 OfyS8RwgJRGiTDM9Fbu+i9UePP9oagJDqnWIMC0Fe8woeyUvEMcP2aKr/d9PMSM7H4M3V
	 wYNW5G04Yec3uT5i4QpN5PtvC8BR/7a00CdiZqA795yIxvwRE7pt61RSmYMzF7V+mD2EL
	 FQ3ljrvbjhqYvERJZ3xCsoge2Da6LP4VDjXwgRmgkbqZXDHtCO501I02H4Kft9ni6RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJJ28prD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CT1EkLF2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60C606A329
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB60C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJJ28prD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CT1EkLF2
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAZGR3045390
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=; b=CJJ28prDtl1Sa2a2
	Bm9KbcDV8XmVJil6iNkbtv86iosZdXfqsdZ+stkSO6KR+IETA+iLycFpoMnwm3Vz
	OqS5uLpavCrXU0lN5w1wjhl01oFAN76/lndyTFDm3iniHjSzZj54x73+XUI7nFCI
	ssTrImomR2xQNPVNX8kQqlpynOjzFr8j7pIHf8w6ybfU2ylBjb5eKI8WwYB2DKm/
	CqoPoPmLKvCtiuT5lGgIDtVCG6VH9v1yBsmahCgAHsPugfOayUdmbR6AKvxecDca
	6Wm2JKIL0YYM0/md9Px1MhlZHaHZ8de7BkGXSsWpiqkJIH9im6ntUJGNOgaIAONk
	rp6Kmw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjb7en-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f37c94ceeso363056185a.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792750459; x=1793355259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
        b=CT1EkLF2/UdTRjxBUmVP4k0HdSNY9Dz2aAQkTuWazCuYdbB47gILHMFYCUlnH5tFIt
         5nqAfstaPrBdnn5rZVLGC9OZr/XLMFuYGnaWw3lvXJ2wyHKPO4TmG76CDguiCE0ABLEa
         vQWMAAq+M7wVyEIs0tK4bmGH3dZCXbeLTHru4HzuPgDIwN/QIwtQrcdF5qXWTSxC1sjp
         DNkiBLt+TzfpSdwlNAFW6YYFHFsOA3t4pVInCsgneUvUla0Iyms4/KpfPql4gORuJiLi
         Uq/NNuWcpTT9tL01PiKYAjPocV2VwtdB2Ip6JX9yJmqrN1+XEvAwW8y5DkA8q2iPpeeH
         WU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750459; x=1793355259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/BnLC9IlXI4LO5c2UlLKBTCYcBIOSWeobZN8MtWNZ8=;
        b=Jb3x4M9VjDqIsBLZ2GNF+R1t+rcunmA4scbQA2ZTaofhv+Bs/QB+aph+bR+jq5c1VX
         bQoMLK1qBI51wAgK1xlvjkurBPHCRqHRFIfQZcfQS5CK+6CU/9TPQ2qqcIR/reJ1hy/L
         oi5JGo8praYwAKmwHRLY9VXHC0naM2xWQsr/MPLeOhrF8e72NPyMl3OqqPQSgmQqeFoG
         oJ0AKEAt2gmBsjCA7z1yOtnVHlkgjTpmiyg+r5tkbXoknqbRcPHsvm04g1BZM41WHCpv
         mu8MdFD3UhA4LrKvBNHk5GI99KUqrCGQSjBb/23N/GYXNm+U/Lk8tyoEKqtH15bUE74k
         VMqw==
X-Forwarded-Encrypted: i=1; AKwUvBwbVK7iSiUfKuD+cdugIg34NIh0PMY3Xo/az3p4fzkDEb9g3C0N4xNllD7N+cTjtKBdUiCuftEBvPDk@vger.kernel.org
X-Gm-Message-State: AFq9FYJeD5rPjAERotPC6Gc4FqTlfKjyr2qiRAS4e2IGxQC/lZozVFIo
	gBMyXT+l8Ih9raWGV3FSVa+GN/z/gmWX/8dLrQcKGbi4+xo7wEIjwviBD1qy1bpLN6Aauqlm46F
	hwPgO7a5+OXYPzCAx4jsjuosS5MmiuskDRkFRITl0qgWfPm85H/mH939r9JIf0hd0
X-Gm-Gg: AYBFou0vT6afPSWFjJop1ilZ3ETW8PBqb6EpCJvCurG2sGvSqZ3PS1jCPKiYh5Wgy6s
	9ea7Ls/MP9TRn1LF/10jmXg4UehPNoO88BEju9hkcTMjot7wuq1dVSUbR7MBVVLBhk4q/3cBU4+
	tTWtt2pUmbSbaDud6y5V6o7AV3GrRiibslZi5dwloUfbVEQO+o2AGI7SVlISjL2Yi7WRqzptahJ
	13udwVEkm5hm7n3JF2yJT84AcwDD0fB5j3AZZhucbUy1NUVkFJxkKZ4TDGAZNyt5kcyeRWrIwq5
	/JmuslbgzPlzT7hJz4kExFc9A3ls1u5+CQ/BSwh9cbC+ZWIgPe/ApnBJtz2Onb7PWDZpkvJ6UXf
	JM/Flj2sb5B4jaSPz0dp3Exu8QAfm
X-Received: by 2002:a05:620a:2b4d:b0:93e:e111:2778 with SMTP id af79cd13be357-93f626db3bdmr810339585a.14.1792750458986;
        Fri, 23 Oct 2026 03:14:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4d:b0:93e:e111:2778 with SMTP id af79cd13be357-93f626db3bdmr810336085a.14.1792750458529;
        Fri, 23 Oct 2026 03:14:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025da3sm4397734f8f.19.2026.10.23.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:14:17 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:14:05 +0200
Subject: [PATCH v2 3/3] software node: fix unbalanced reference counting
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
Message-Id: <20261023-swnode-dev-notify-balance-v2-3-948d920a79f6@oss.qualcomm.com>
References: <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
In-Reply-To: <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Eduardo Ruiz Duarte <toorandom@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=b5psEhGu33J6XAeJBkiV8PWWEXQuiHu7lH/f7ufztzM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2zNz2YE92ESzC392G1x8G8Br63rp3N4Iy8wYl
 osTmT9ujOyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatszcwAKCRAFnS7L/zaE
 w+tjEACZmRinXVoCkP4Z22vT7HN+sZsXAZ3M6U2IGuy5XXzSQeIY6JlnV9m0mJCkFXDahSXeiWy
 D19YDdUAXI/uoG/dR4rb8pvKJF3W0GQj7Zz6wmrGKbF//kZuPAR9BryX4tSKkY/9l5v35G2w139
 znuZpjq6K5wdLUDxX8ovhJo1rpW64PM1NktFoJ+V6NkdeZcXPtXZQ0Dlkk0XbnDPbPFkFETL3Bl
 ZI5E1562GhXyu8zfv2JqD9bFyW+76A6h/bMIjq3AeAByGOvOFMF28gV9ZSp7aqOsCSokk+/vaHe
 FF6jf08LYBRFVyVXhVVQYR7s2qPFnKXlc5h39rZBPj30HEWWDX3s8Ykxyunc+Hzd/9C/SjmZODW
 RAeSSKpGwB1nxG32AbhUPw03xXLW8911/p3kQ0YZ4wApwrH6OGPvtA6TDp0ThmQanuEfFdSHf/8
 SLvLXf1yRqs9Z/mnLuIBD7KehvSUPNDYsBaIV76RHoo/Xfn8truO40GsqoMzIUZcF8q6Eu0KQMo
 yqoG0u6jUt8nKfQ/y0vEBOKJ5iw9X8NRQ80AiYXTzEGQwwrh1N4Ke74y1bqHoe1uxOTv9KXey2D
 IgpwLgtwd2xqUoW8/0hdxpjOy3FYlqC0AGX9m2MeonHD8agNn1u7VPFE+SUXkozISCQ2ghANq3+
 VA9wzGn7riXedQA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: qU6AUk9nzEmceKg0LWSs30S_v-OkdRdm
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb337b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HsDmPXzSDgUE5-xNsXYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX/0qSoY+sQu8d
 ThZgCv0+c2S7qPacsFthljBab7ZkMDWb81OLqOBVTW0KRt3vJtbuKg77SZqZ4fT3BIcNurGIbne
 SJj1Mid5BZd9wBSBvzQOAvRa8RqYP6o=
X-Proofpoint-ORIG-GUID: qU6AUk9nzEmceKg0LWSs30S_v-OkdRdm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX3O1WZouecPrZ
 YWFF60SoKs85IWqqVT4u5dsvIgaCWuqHAgEuCHvrnwnlA6siLJK5FoSUFy7I7m5+UUF309Avmyy
 sNKh4CJt9gM8YMJVoA6q72Q7zqzHjiu7UbEjpnwKSXlxKAb09FG8IlMj1jWfQPIK0KSV+aJDoSh
 mjHHEOrMr1nB1JBIn0HKIk9mAgTjcbqsgdtpGT1pSodUIucSP1CB73f1MvoiB81lsDsEQOCEwXd
 tBHaJ4WjcPeiiIEPwXM3fcgksjBgQsdWwrXqjpYrjillGcGlWM1ypDOZfDQv03X+L5yJ4dNtwin
 LZqE2dzVVxxv5iGWdHegvIk1l5shJJLddFUkR+tOB2qcGpZqtiVZcJ57jvTHIUYI/Prp91h9/7U
 Tvxk+VOMz0FcT9RwcNarIeJQYCW1O8EOKBd8seSUleFXc+9lG8oqI5xTNgVkoEEd0D0Zah52OEI
 6kBXD//r7leWOwdTQqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230039

software_node_notify() takes a reference to the device's software node.
software_node_notify_remove() drops it unconditionally. A software node
attached with set_secondary_fwnode() after the device was registered
never gets it reference count increased but it gets decreased in
software_node_notify_remove() all the same causing an underflow and a
use-after-free. Use the new device flag to mark a device that needs the
reference to its software node decreased on device_del() and do it
conditionally in software_node_notify_remove().

Cc: stable@vger.kernel.org
Fixes: 384f5a857bae ("software nodes: Split software_node_notify()")
Reported-by: Eduardo Ruiz Duarte <toorandom@gmail.com>
Closes: https://lore.kernel.org/all/20261011131518.48838-1-toorandom@gmail.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..9207d7f96f20f8cfaff2a4eb8915609c499cce24 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1176,6 +1176,8 @@ void software_node_notify(struct device *dev)
 		swnode->fwnode.dev = dev;
 
 	swnode_get(swnode);
+	dev_set_swnode_notified(dev);
+
 	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
 	if (ret)
 		return;
@@ -1206,7 +1208,8 @@ void software_node_notify_remove(struct device *dev)
 	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
 		swnode->fwnode.dev = NULL;
 
-	swnode_put(swnode);
+	if (dev_test_and_clear_swnode_notified(dev))
+		swnode_put(swnode);
 
 	if (swnode->managed) {
 		set_secondary_fwnode(dev, NULL);

-- 
2.47.3

