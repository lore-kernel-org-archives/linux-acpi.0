Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750457;
	b=hEY2o9SGFMcMiYdBxV3OXwlXWZZmpqUDg5VL3hegS5NIIMkCzX6joPrINC+CZ5i0EsW6
	 8ggRcG9Sl7gqQITWwidnZJ4nvueMj9yEdgscak68ecBG5IOh3NW/I5THmXllZdzALuwqA
	 qZeWggPaXnLJcX0fC/BFZIUOlGFPBe4cQjUHyJ/TwBYFzEVKBZ3+b0kKi8Zwv/mdinl2E
	 jEd7PTs0X8uVEh4m631EA0RPJeXm2u9Z8vSDkmVIyOLBef/HgEEH2y4GkImvWD5Bnakx5
	 gR7YbooAtHEGvy04bo56rcgysQ9tpF9E1e56M1JUHsL2kFCFEQ2t1xKPIBrZX2/6fWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750457;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3/lDJvjhBQBuyuaReRi3SarttfTu3Q6e0rLJWgeouyE=;
	b=4nEdR2Jubu9G17Cq49KH1qmCNXy31HwSJ1cJkdHkW3lvavPLYOCjaYlEhCc6u/uEYXYr
	 OWlgwcmw5MrmcIuChhbD6MBIKYJQwidfgwewBpi/XGyFS8/DFKtpZhGH/Z9QiWTR4xux9
	 8I2jTc4aZgsBAU8OuR1oh3phUvC4uOdjyx57PpzRlHtIKxo7Fk8G8BWMKsane9xU1zxiX
	 1bqCmdcWzjujEWfN5mmYyTpduWpfi0dKhMhkFlAHbQrJmFOSgMQlDWQ80du2nYCJ/7r2w
	 elj891rluaiy8sxzUwNrx60gnwhVsxZYZc1yN2cdoXCyXPRI9lcc3XSwEQyouiZwzXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Lgyycgo/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZllWJTJC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB03606A31F
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB03606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lgyycgo/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZllWJTJC
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAX222489807
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3/lDJvjhBQBuyuaReRi3SarttfTu3Q6e0rLJWgeouyE=; b=Lgyycgo/B0FC7eH6
	xRgd/soN/MISMo6rhLKsyFgoHPx0Qdw7MmzO0WVhH7ZKOetRsjqoh0B2OQlT6np5
	8xesbdxgElxQRwTCaFfyGBCoy2VIqnGs7pdEh7cr1HfvY5IFlylbAMFMOdZ5dpJc
	kb/Vr48Owld/N1u85HGcJSO4Xq20B9pehzsWjQ37Ggg5xn8bwmtf4O4DWEkqlpOp
	YQe+a9Eo4Pi6us6nxDW7LQRvryRf+X9PQjcTwOx2iWdIYe0l4dK9sQGS7zXLXodD
	PzWvb8BiB8bhh3d6cEkVJ9We8ZvNzAuDgkg5OH0znpsbJL4th4zdTUnS2IkOPZ6k
	qxPAow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftygact8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 10:14:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844e383so133287885a.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792750455; x=1793355255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3/lDJvjhBQBuyuaReRi3SarttfTu3Q6e0rLJWgeouyE=;
        b=ZllWJTJC5YUv6+TRX/RhzonfKdLJ0ka93/zg+S5+dLhlWamdrO33o3UkJglrPxqpV7
         Uk7XjeVcEF00se24k9VtvUcpJUyDCLMPsw/iKkACEPq59fN87uQrx3X9iQErd4CcwjVl
         a7yN3z8O04epCdRRax+jlbHBIMKVaaLXitPcqNJYX0rb7S1Py5NT3bo8N1E2Kla8LOLr
         Cn2Mk4unOKh4YR6Ljyv/Bp54+bOAivK/xG7QiCdDGPun10sIVrvBEqCD0345FXC0q3Gn
         WM/WCDJb49axGXnngvw3k3tQfMH1EjwXLcAfnr4voTGv6THNnIh807EZVlsVDs3XBfjt
         BBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750455; x=1793355255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/lDJvjhBQBuyuaReRi3SarttfTu3Q6e0rLJWgeouyE=;
        b=AMrSJYGE/JuMhKDFvRHVw8FAiajAV5YeV9WWnjMkpswCVa15R1wP2O82Dh50b1UXvz
         8W5LKJ13uoDV7ui0bd532fs82sCFw9Yq2Cy7gtncS2PI7CSAabxCtGAJIqnF1Ox6D4vg
         0bNfmjbPoi68AH//QIdRuo+wtd+4EFTPRJ69D8c8h8uJgBH1X694fqDmvBl8qcDaAF7e
         UbTZgzKvCptKrYE3mhp0vPfHn74GEyMOLlucWEvBfRucdteSbNtOCuRk8m6hqF+JW4kx
         2Ji25WessA23Q8AjghDz2JeJcivGtdUYuFmJEwIfHtvcsi9VBA49b3t89cyMMmUn+q5t
         ruLA==
X-Forwarded-Encrypted: i=1; AKwUvBwPlJUUmurD0ktyWF/IwNHY4h9lyETwZeH7RWXAc8T+2SUGmF5ZzvFeXEAwFWGtgFnZh1Fz7oon4E2G@vger.kernel.org
X-Gm-Message-State: AFq9FYIienLfFGmxOCwY2NczmLRFC/n0efmpDma0Z9tdEHuymYnytWqq
	Kp5/2tjNzLFBLsWyUzMPHHvkMZb24O9e7fdT7obRrOCbq+xiELjPHbqXbGfmMuQuZZr+S5icQk8
	jpR92pfIy9Kw/d0qxpBXnmyGET+kfeB/P5reUwrypsDKY5/RyCVcKZ8H8ZPROeSf3
X-Gm-Gg: AYBFou1Qb9Hn9+u2u/hwLwr6HgH2Cwj5XODjaUsXBX44zf68AOSk6sx5MqFLZzTBESg
	WiK3MPw5mz+AweoJlDnNhOy18RE6KKX7J6Dwat2p4Tk/YQabMNAeGfcKe9iUXXJ1Kdb9a5uVG7p
	Q5UroJvDq3SecktxkwYJhej0JedKbAAEg+HiEVAuf04LDB3yWKScyyCIRA2n31hP3G4siXoU6rU
	ZuFlx6/7iw6+akXXwAdrr/tFltcwl9tjp5p72v2ODq/kIwZiyIYgnTt/Q/TfM22sd5cTvyFE1Pm
	gHSq/nj7EkgMBKo4rBPZ/qNgIEkwKsyPt29Uz9AxjODoYSjAxeUs7MXbAf8nWbtDn2lQ3o1qZSu
	ReOdFe9zQyiHJLQEc5FHUD7zMGLnx
X-Received: by 2002:a05:620a:284a:b0:939:6de6:9518 with SMTP id af79cd13be357-93f6f972914mr327955985a.47.1792750455203;
        Fri, 23 Oct 2026 03:14:15 -0700 (PDT)
X-Received: by 2002:a05:620a:284a:b0:939:6de6:9518 with SMTP id af79cd13be357-93f6f972914mr327952585a.47.1792750454685;
        Fri, 23 Oct 2026 03:14:14 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025da3sm4397734f8f.19.2026.10.23.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:14:13 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:14:03 +0200
Subject: [PATCH v2 1/3] driver core: provide a test-and-clear device flag
 accessor
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
Message-Id: <20261023-swnode-dev-notify-balance-v2-1-948d920a79f6@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=z4Jc1b12fs1aifGCYeI0BXhsdZ7Li/X0waRYIl2iCrc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2zNyS0nR6r/NdXwiQFTkQHidfD6CLufh/QrMX
 B2eqAWLpr6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatszcgAKCRAFnS7L/zaE
 w2HSD/9Ovh2uv/UTJT8dwylA1DdD/J+L+gyMRIpMw5NbEgVO1ppcv47lZ85VJPS11yB21GSYUru
 MAC33BJT7VZSOWBkkgbQi55NNrev9csl5CXDD3CBowBx9d59FfGhHGmwOxoDVEnxZ43NMjW7mz+
 6irUMK7glppjTS+AJiIiAyhDGsVAKGMHAL1lWldTrO4qd/IyHZMHnnNIKQcMRahlf+ra7EyBVBh
 /77PWAmTEyzql+re9iW6iRu9aVKAgSQFT1n47B9bXS3dMxDn5iN3C8KKw05Gf+K0/z4OVG2KX5v
 d3RHLAVYnGoXnteqaUy3AXmevJ8HPpO97Qp/xRAvRJs6hP4J3krTWRaK0y7JJVhTKlDf4gWhiry
 EtvJn9Lvv5EyFb6Vqg/i7wooIL9hs6q05mMh8hy7WbCa+H0hQLRnyZ4bAONQnObQKVryL0SB0Id
 mmq0vFUDbfHgjtpLRMbTYAThU9Ihh5NNDjypsbCjI/KJaFBK5tpc1/JLKnuYCjz+UFkPfD3baKU
 /6qZSEhe9sWDvYOrCApN2E8oyivZQolcli2oYKSkKCFR+hdXIz6TVvUEz7rqYOQUQTHt5vNusye
 dtIU+VCzGWETt+YmozzMCrpERZlPwgUDFJbiovfp3kISVcOabdw7hTPt6LhhLcDqA48R2rNzJNI
 iTNur4J6kJ+8Fng==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb3377 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=0Wdk4a6BYWEShyIiZzoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX7iX+FCvQJjAn
 jw9Uk2gC596oBjT4q7lboATeSn3iyJhC5KXeTMeAVfuXPKhXl8V0NnucIlfTUM7ovC+9Wuj4MPy
 b+QzvF5IEgP+26rIthF2CZDreYdxt/M=
X-Proofpoint-GUID: fQi69KuqW_f-3gXQ2nPxQxpaj17Cybf_
X-Proofpoint-ORIG-GUID: fQi69KuqW_f-3gXQ2nPxQxpaj17Cybf_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX/M1zlCaV7bYd
 fII7ZhX4gSVLc/nA+b+MoZOPkXuKmc0ouPIyA/YhbYhNb2wQ8LP1qi02Qo9T0eisMe02Dr5Mz29
 pzBenhVvL2urW+vovOD4N8QMiPBPMwTu89Ja0XouItbhWvjAlmtkUzqovJvnfUTMTmltLuOrMs3
 fN4cIGHVdWwFZWFZzlUhU0rcr8IEBGQIeTs6gcC7WDKFX+k2wAlQPWGrmgOzoHW+uWihlrQVbDd
 +fYaNN3obD+FJ1NIxDqFCoN07R+EoAgGevy811Vr2a8xqP61+PtqlWZRw/l3p+IFcp1zJ0B0obw
 UPzIN5YGCymGF8JrmRxNAdCudmvtEJahVJCSGLhUrhfvsg7orOrFA4gVDjPxM7yLL8pI5aJgdhJ
 vzXehf/Fd64BtimkB/2wt1WvfDmhGKNBH/5BNz4AaMNZXh7427lzR3MLcfNqJl7wPtfqmDDl4A7
 7BHbfIY1M8t88OEqgfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230039

Extend the device flag accessors with a test-and-clear operation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/device.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 429e39f647cf907d2a9868878d1f89526345c3cd..f31fd62dca9a89c1c9ad565b1cd673b71b740faf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -822,6 +822,10 @@ static inline void dev_assign_##accessor_name(struct device *dev, bool value) \
 static inline bool dev_test_and_set_##accessor_name(struct device *dev) \
 { \
 	return test_and_set_bit(flag_name, dev->flags); \
+} \
+static inline bool dev_test_and_clear_##accessor_name(struct device *dev) \
+{ \
+	return test_and_clear_bit(flag_name, dev->flags); \
 }
 
 __create_dev_flag_accessors(ready_to_probe, DEV_FLAG_READY_TO_PROBE);

-- 
2.47.3

