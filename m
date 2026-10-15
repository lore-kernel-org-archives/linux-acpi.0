Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A165852941C
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075611; cv=none; b=k/+6xcxF1AhWp35ppjjxjvJzCVEpFq0JPRFGC/MtcV/hlL0b14xU8sogtd/qEFaGhXQk5x/c81H2Rl+v60eY8JXK1RmdEm2ZjBWNqHjenK6ON2KRBiQxEodi79fNd7CrJ27TX1abSiANIo9ROhTU0zSlBHaZvcLm3y7fLY2o9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075611; c=relaxed/simple;
	bh=PNdJgOWRrdyzTTYx+0b8LRvlWIDUWkxVpHQl9VF4oqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNY1Vq79C+rrYOlUDXunFZGtvCFocsWQuF/66qQ6rMc6U0d+8INfXZELa8sG67BX1pY4y/GV7DgsQ7xmFSig/yKKO3h5A2nHqifrV4+v5dkFIvLh7fy2c0GzS9hSivYGgeEHI0zpOqIJ4Y+eBx0JzUh35yqkvO08jRNjvdFZ9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JqQqY3f3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dBqqfE12; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JqQqY3f3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dBqqfE12"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jR5m2662617
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HWO6GDyq3PQxTwNf8mQmtUFqkh6kAi1lfM6v6Oehdq8=; b=JqQqY3f38CmrCrM5
	4b9gCEVeZZRUcv4Uebfp/Vnzx5/RmNtJuBlM3rCieG/JrlwE1BrWs7yphZsJGNlR
	PMPnhOn6UEX5bOLd7UckkW8Ob80wDaTK06pogBtztOcu4YtSnUgwrPpz3Yf7vJ+z
	xFvRkBWXopsPYBaZ0wDYiU/UcWiz7bSS93Ltn+xPopJ0iGfowH2x+unHG09r33x5
	Gg3yg42eMTk5KvXXaqmAumbhSBYQcUZDLnRWc2ydzaQFEIju03shaihJv2fRkiPk
	c2MRTRa+05Qv8d5D3VmSaQLEeojQuaUoVxYSoJ8UdZHV86/PNDNVJRAjB6/JUeFy
	GiN51w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda2km9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 14:46:49 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5d6105ab658so1360733e0c.0
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792075609; x=1792680409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWO6GDyq3PQxTwNf8mQmtUFqkh6kAi1lfM6v6Oehdq8=;
        b=dBqqfE122OUtutjIHNdtX7gMWmk1xFMrgfExDuFxu/mq0yQhJ7jFxo+7Qr8oR6um4G
         73hsUR8pSaiQRmk2cets2zr3jg30AaxUaGD6fWYXadORW2VywQeLZnYMQz7oDacthtkb
         Yk5hndN78OZlGg77Ii4HQx5nl2d1xDis5xMQvh9PNYUPRHs5VTpoRDPee0Xzj9KfH3wQ
         GFn8s/Vr39OFhUjdYfPFi1RNoiwZH8oPAQQxl6eMVEV6c4SEIhsmeouqKwWwDgVh45KE
         STFdu1TcvIDXT/ukFgFPJSIjdS4jHxXYHJBL1gfNf4YJ8J9Vysujy8XBjunLEhju3hIJ
         rxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075609; x=1792680409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWO6GDyq3PQxTwNf8mQmtUFqkh6kAi1lfM6v6Oehdq8=;
        b=LstnInaQfp2locus65p/g5WwvxgCgz5mkXgqDsCq6zHYHIJxGWzktXsHaik3LJR3r1
         OeiB9Dj+f7IFWQs8lvKd6/zdOVEPMJotVAJOx4QJrvQLHJMHmFoHSdGehRisVPJlvTQ7
         x0RQa3jqT9C/e5ChSCQmDdaI4zNssS2vv3ax88S8z860R/MWxCfoAluzKacpcExOGO5F
         97wu2SJ0lFTdkk/ZrOWKNjNYPXOZp1KabI87m0lraOsqdgxYM8za26bkNGGE+f8dUsz4
         mgbylR1ec42N+2yHCrsMDmc859P4dkZeLPCJAcED67SuJ9Yugg6pRB4GX4/gO/RW7hZU
         28Rg==
X-Forwarded-Encrypted: i=1; AKwUvBzqpp4pBnicw8iYFkAzhyahti5xyxfKg0LM7vJQZu5WZL5I81Gvkec/usQAodTeQsRUTmIkpYkEm3M/@vger.kernel.org
X-Gm-Message-State: AFq9FYIzJ6oXXihq4bH1kGcpftUYyRnYO8NDs49RrstleHRoNLmONvIM
	kwrFvWYrRNprM1TqD2NO/Byf48RM/GFwqxFhGGkyP9oyLKr1Knf2hoZ8uMIqnXCqBUtUhKVMx7N
	XwkV8QE2Ajj/mK/vcgmY3cUWOn/xWxdsWQFj/51s4B1f9+rwQ7IZJObNQDTngzAot
X-Gm-Gg: AYBFou1WYxGsxam+S41MwEiibx+pmBr+NfTjniq9Yhd2Q3BCRfGETHCQVI4jb/+94dU
	tTP23n863jsBavBbsEf+wOfBKHrK5Qc7oaPi23osJPQv/7B14nsUvmhYbBBRQEvDIJBpQw/GDtm
	RNZTVlxboLTDY47RHO82eYGKpMLO0SB8XYh9dGQu1P9GMuaZwWx3VReFzJs6gn/kZXmz2oyNND8
	px96kJRxDJ4Y6/3tDqH3uQbbKaxbMJQmTZzabvnMVTzs1on47EyhcGEoLm5VcfWKBMKczRT74WW
	/iBPGjkQ8Bc1uwKzVnLqj139Brnad8pFc9I7sRfTcSVMBKlIFV/nEUaIzfm9jrZSw3tQaaHp7JB
	OMOSHLxFXp9AfMytqfBKvNUgnH88N
X-Received: by 2002:a05:6122:4892:b0:5c9:c60a:e9b4 with SMTP id 71dfb90a1353d-5e91f55a9fcmr6144193e0c.20.1792075608907;
        Thu, 15 Oct 2026 07:46:48 -0700 (PDT)
X-Received: by 2002:a05:6122:4892:b0:5c9:c60a:e9b4 with SMTP id 71dfb90a1353d-5e91f55a9fcmr6144135e0c.20.1792075608133;
        Thu, 15 Oct 2026 07:46:48 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8ebdsm86840625e9.10.2026.10.15.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:46:47 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:46:23 +0200
Subject: [PATCH 2/3] driver core: provide new device flag -
 DEV_FLAG_SWNODE_NOTIFIER
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-swnode-dev-notify-balance-v1-2-9e7537bd2869@oss.qualcomm.com>
References: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
In-Reply-To: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=PNdJgOWRrdyzTTYx+0b8LRvlWIDUWkxVpHQl9VF4oqE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0OdPiZQqXyRVvBIXUPuGwAoU4udtCy7kp+VfM
 mzL4ByYlWqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatDnTwAKCRAFnS7L/zaE
 wxfEEACyGUZXdcCq5oDMV891HI/JOAHeiDbSgTxeyANCyvf/CDKa14YMhixX7AUZieI/gXZXCVL
 H1pCDnbkKcTT/Ju9Xz3u+Sit/5/0XXiU91xKraUo0Sw3IwnnygHIwnGEjO5dbbXq3hyAitx5ZTJ
 Dgqkeq71E81ostCiKxh8ED8NfM5ha2J5ODHR9cO7/zy97/Eb3Z1rfWVK+RF/JNQX1rpGzXeNZQL
 I8xLhTiSu4Y9U8iiWZZNaVWPhQazdsrCx6CmGyg0blD0VpmEvPnvZr+8qr/CsWr3DVHnVzDB27z
 /MdSZcTRtMw/SGWAtRZ59Ty2Zdm9paBgc6hIpXB7ymiesYy1AT+G8mCEuogQPpZGYQyC/P45Pqt
 R2GFlOFsJ5Uk64zZzLt/pg7pEOfKQ4wUK/6EFtLOY2P76MQPXFSnpvjNUHz/1Nzoq9T2tsXv3Pr
 +ea/2kf4R3ZcxVudDIr+KRibFjFai51dQ7w4fQO0UHgYEpOPX3xOgKHqiOultUukHRXlJt0bZ5R
 Ds6nvzT+2Tb+/yLPB6FXTJAa5xGqBdfVWBdqtc9geCgSb5m5cCEFAClVbAt9Sw4YzhykVnMQ0qi
 4VyZT3945smX72q/BNuz5QQeYF69JhIfSorf8ctQq8WVWC0W8EjtgJwVYQ6B9FtMPKPdJEuWwf9
 DKqaPYgZ1G51kUg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX+ZQRMcv81ZBc
 Pv0k0MYOT0Wi80CxCvA46sdB4F+31FM1imB9DujpyUqEoxo/Lu9JM79V8PMIsKZzx4PaTdIUtcy
 UOEkzHEBGfcwtoCMY8KtPwfbyynZ8D8=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad0e759 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pFYeoU0bCXH7zDU5Pl4A:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: loSplKx8lK_gV0EFqeZ0BkAJVuAw9PDg
X-Proofpoint-ORIG-GUID: loSplKx8lK_gV0EFqeZ0BkAJVuAw9PDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX2CPWNcEaOfBA
 jrmXllJUJP1bVzVfJ+F6ZN+Jce9qImwBWcM9DChKXT63MDYPSa879AjGFoAI2qwlzljVbKq/z4w
 JKOpnHMQx7uYVksLLcLTPT+UkIplqonOQzKD+NXmiPJNuZWA8Qqs50i+jDtXkz4bGux8T2PVor/
 EhHY9kiMNYX2jRNMqXHuh2Omkejku6th/lXX0AmMryTTSRmSJfvXKl6JI92iW3VtTDOa2FFWIIT
 HUz1di8MgkVGfcIv9EQJfy5QmmP9yp4w12yKiSLTgZBkDCO1cABe9Vc2GVBlsmPAilmAnGFYz0J
 lIGPyi29eAs6l/WwkYzxuqfJApmfWo2IvK7RIJbqg0mO/Io5ktMLoJlKqrh9ADYSoitmp2SQiFc
 0E/SHmJ+UmxuNg2FwRL+1TMn8TjJL/ZKRJ5JomX6XwbX1NFgNosGJuxLUb6U164R1T1nAhid0hX
 OC48Wq388FRKzCXFBTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150058

Extend the set of device flags with one that indicates to driver core
that this device was passed as argument to software_node_notify() and
took a reference to this device's software node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index c8de370d877f978dd4a160f0094812a1d8441078..b8f12d053cd704b12febc41035aaa44afe286351 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -599,6 +599,10 @@ struct device_physical_location {
  *		ancestor device.
  * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
  * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
+ * @DEV_FLAG_SWNODE_NOTIFIER: Set if software_node_notify() was called for this
+ *		device and took a reference to the device's software node.
+ *		Indicates to software_node_notify_remove() that it should drop
+ *		the reference.
  * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
  */
 enum struct_device_flags {
@@ -612,6 +616,7 @@ enum struct_device_flags {
 	DEV_FLAG_OF_NODE_REUSED = 7,
 	DEV_FLAG_OFFLINE_DISABLED = 8,
 	DEV_FLAG_OFFLINE = 9,
+	DEV_FLAG_SWNODE_NOTIFIED = 10,
 
 	DEV_FLAG_COUNT
 };
@@ -833,6 +838,7 @@ __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
 __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
 __create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
 __create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
+__create_dev_flag_accessors(swnode_notified, DEV_FLAG_SWNODE_NOTIFIED);
 
 #undef __create_dev_flag_accessors
 

-- 
2.47.3

