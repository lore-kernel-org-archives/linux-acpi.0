Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963618;
	b=sQd7QY8yWlwKm6TvLchGiJViHg83BK+U9PU0sos5Rm0OIMGNeWnvAxfXA4wJL5lIo41t
	 3kx/Xod6zDlgi8i+VtOEMgZd2jrSF2q+rUa9jC7QcUCDLrF6KR/jGiLM9swRKMaLVZtSX
	 u4o/sV2klbuwqDkVEukH5/6egidheC7PY2n1GTr2XDbHfSHMXv5u++dPIVjzsO9kdbe/L
	 dNDT1JnsoIPdvENcXyrc5uj1r2aCZPMwy/JzMcgS7wWOwM1X9pJh2irJ0b54pW3SPLFcS
	 eAdgTbgaVsLKKBHdUdICpjKYMYQRR2u2sZAXrHG1ocrnAK/JNxm+w0NfcbK7/Un/yyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963618;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XW52UdCrmkSU2CFHGJcm0I6RcRFb9njYbyKT3jvjP+k=;
	b=cDm3opdyRFRIQ6vbcxuDKRFaQbpIxSaM+fIhQZpwkgeNym0x72Bj7UCNBhx7udyTWv7b
	 Q3MAqt9X4Hqeboa752+uEh7Tkue3ZDpQEwaBEK9zGzX3XYC0Ul2w1jW/tsTniuW4RUgIH
	 gA/K4XEPGo4srkmBtE74IXG9lQ6Bvn2EWVpFOnY+3Up/+xWrmyRwOpIlUZF3jero1gL4L
	 ELAgdyIaXTvCuw7RVYeudgHhFPDj/WIQjZU+n3Y2ulB2ZXfy3hZXjEuByialYBu3vmI+N
	 KEPIth6bvWPsqB/LRi2vN41T0yoXsxErKmXiv/UUqLU3m8/BEz1IqxocEb9d/1vMAIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jPeFjlND;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FUTDjyft;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4E606A32D
	for <linux-acpi@vger.kernel.org>; Fri,  6 Nov 2026 11:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C4E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jPeFjlND;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FUTDjyft
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AP7xw3335296
	for <linux-acpi@vger.kernel.org>; Fri, 6 Nov 2026 11:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XW52UdCrmkSU2CFHGJcm0I
	6RcRFb9njYbyKT3jvjP+k=; b=jPeFjlNDRAk41JmbgZciWPHgR3+DwR8XKFx/kt
	NHUj7NwJ6Q3h87H1/Yf8Q0W5YuO0rBlD57t6SjlBydmh17WkCVg6o+h+4XBJ5ozt
	ye4fcl8OEO/kg2GaQvTOjkwVGRfyeJufoljilK7bJDNUrXKirmrA+QfAEu7OfpyB
	3Hn2DwpE0DF66iDHgKc4t/N2FupwYNJnxMkdT8ZErhYXT+hzG900ALKieHW2UbTe
	iOAxWp2cEjQTLiffgeJoWQevf77WgJoAurK8H5f9bMy/RHySNybuP1GxOLIqxi/a
	RsU64j9YdzXqNvpo4O8wRUAE4hwntSiHCywNylgin0gUTDAg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa2hns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2026 11:13:36 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9806e283b0eso290324241.3
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2026 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793963616; x=1794568416; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XW52UdCrmkSU2CFHGJcm0I6RcRFb9njYbyKT3jvjP+k=;
        b=FUTDjyft0iLd4uwL2P5wvXBbUSnZttUA+bPvryV6OcPlfR/igitrZVyOPWKZ7iKFIu
         DddNP38qDzbdCwSQJoPc0pa3UiJ0SzfU4cUTFddzXJ0z9KC6P9NMe9mXpradApdT/RXF
         uRop1mTXysySszHJ4sbT+z0ooLc4pupQDpVURzlS0ccCkYEWQnMtVsGDi6xBZ/mf2epI
         h5TFMpjgCgjxyEn5RkWtSv/Aw9ZhBh8NEFhqyjJREAZDRckzraum/vG6drD3j+poPzFm
         vXdW6sLqgCQTAJLpvBpE12PaOj63CFC7/dBgKkQlZs0/ga2q5uUZ1VZ7RXws0gxLDeZT
         Yg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793963616; x=1794568416;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XW52UdCrmkSU2CFHGJcm0I6RcRFb9njYbyKT3jvjP+k=;
        b=WCgLzWJ8sb07GxALPoEx/2wy4gZJT50zCaGMaWayUochtPGPzSutdOyQZv8NcbUCKO
         PxAlUT2qfX5/NVZ6x4WCXNZW47eeqSulv5MaGUVeFaMSEby0nGEWKjiwuZb4GzuV3HKv
         0sMfzCk9GXSD6yRfGAK0xlBILV/Lp4HSRhaaQ6osO5NilwnmbJ9i3JkUEchKRCYpQTse
         aZNWUDWTzm4/TZtemKfeLZsggb249uZXy06mCnSz/jDwENH5ADs6k1LqfL8BNyJz1XI5
         vfzcyM8IAg1bpWd7DYgKbiJ7HF4pjarMlwoKBlo6oAqKuR70P7yc9IcslViDEzSZRvz8
         SEfQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4zTPTGvIytB3h+pINCc2+h3Hhh5Lj8T0J3Dy0NkXDAk35meG6Oy2Z7lQKrtH1Iho6klg5+ArBa+t1@vger.kernel.org
X-Gm-Message-State: APuU4Z+PCNeL4OoT+9jvkza8TwwgXHlHbz4+Ijjf0K8LIgUoWtbISZb+
	OUhh7fqkhTbsWFyw+WXDxNFvglbDXyauZv/bqAVRxz3fe33hJPqQEwZ3r9qgPaz/bRNdsxajaVm
	H8V/gjgjlwE8CwqxFlRo2PSnIi8gh91s/hrB1hQx5ycntE/GXYfxF0zMoU57c+vhk
X-Gm-Gg: AYBFou2rwnBHyqpRSiNcXW3ty22NI4IP/QP3+lL9DaEvQ3IsMP9LUBrclOTPH6b5cqf
	nAGu2X+YmppO3ZSZ48DXYgGHGWRQ2RgDbnkMnqjyRK65TVkDO1ejwRDMualq2Amb4qlTxLqtYa2
	d2w9A04CyaxsGWc45Gzfjgcz5w6epsWzIw0YNTaKKrN0mjUG3EIaNXr3dGE1B5A3Dq9aOoOY3RY
	k1x6rWJjq+/3R7TiAe6EOr4yzpFeuBQxKx38Zzw7icS+MccluQTm8H7ojzPjAWknVh4LnXHvj0d
	PyzsuuzEy9JWA4fqaomZo1ph/R50ui9rWDWPYsIxB08dojXZdrttRRy1vURkp/1vzQb76WZivDL
	dd6LxPy6dktc7g9Co7ISp/9Vk+idvN8ufzXipw8YHOGFygkb7XbBsZoT8Ij6cJ51da+i85qJknO
	pvZA==
X-Received: by 2002:a05:6102:4485:b0:7cc:16e2:c1a8 with SMTP id ada2fe7eead31-7d2a15427d5mr1236246137.8.1793963615635;
        Fri, 06 Nov 2026 03:13:35 -0800 (PST)
X-Received: by 2002:a05:6102:4485:b0:7cc:16e2:c1a8 with SMTP id ada2fe7eead31-7d2a15427d5mr1236227137.8.1793963615130;
        Fri, 06 Nov 2026 03:13:35 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63b79sm3183154f8f.20.2026.11.06.03.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:13:34 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 12:13:28 +0100
Subject: [PATCH] software node: make swnodes hold their own references on
 parents
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
Message-Id: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFe27WoC/x2MwQqDMBAFf0X27IJRatFfEQ9Z89puC4kkQQXx3
 w09zsDMSQlRkWisTorYNGnwBUxd0fKx/g1WV5japu2NaXpOuw8O/AvyxZJ5tRE+c8SLO3GDDPJ
 8WAiVfi1Sj/97mq/rBnbpwBhrAAAA
X-Change-ID: 20261106-swnode-kobject-parent-ref-3bd9b9b75aeb
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DgGmt26jdiGxwAImE7adK1jqciOsosJz/aF/TrpLB/M=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7bZddfcbboI5xx8Dq0fYn9wm1w6F0bhJ4f2/m
 JrO6JnrpDiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCau22XQAKCRAFnS7L/zaE
 w7ExD/450rySapmcw3fHkBw0K+oJ+u4K6ueGWCBEvXXacPV8DfV/CRsPh0/Pa2+h0EOzqj24Yst
 gohwb1WCCO8jICdehQPDrWPFTAoQvjHLiJSHucLL0+uBv11+LJWrsYETVaWSubOFB3IdVvvjibo
 gHPuIB4NcBhFvNVNjzMa1XsOHGkRc7+KGnaBaAYEupV5xkxwQzfHnTjMdCwRgkmNb5X70SNRHCe
 Mpgq4vZHcGWy7BgTySRfnzCxhQ5HON1EKvdt29CIFaL11Epn3p2TjRyOxn2+mfdJCFftOudH4gq
 8fZ9Ig7/MTfqsoHjgnhAvigafOahtC2ifpEEp1wqU4xrAIO0JN5jTsSlm9cFHJzNL35kp2tc9Gi
 zCc8USU/ClhIKjScsBGqNBEqicEsME3M11o9si9EkpV/vk8VQL6Hjt34kwzgewZhipMkXPAe/bu
 Kgw1D7/ZttH9u7pGaX9E4lxmaymhCX8SkRCtGU2cGZzwTXLlAe1qBGhnXMstDMBaexDQ8489cvJ
 8dJ+3IimaWBLGSAuU21qgeW1CcL+H//JJlWfz+YC0dzgoKrKv8PT0iKmLiEeceBKpE6Od2+dwJX
 NbmzFRLozA1pWS7z2m4svnafXoGFF3KZSc/s7SRgxp7eWDf79DVfF1ywckfILDVzpiIgMCjMB3Z
 vo2GWcI/DKTHegA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: KkMb2FOi8uKyYB1qVgYrCClZNeOG8MIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NCBTYWx0ZWRfX8pyXGyqIL2fI
 zsVkrtiaSyHXvzbU4UQsrVT4soHY61wNEWS7Pgjs+d8hPdAXFw0qLUBQS1lPpGnrau/hQiQ//mF
 uYyIMYWih2ndBs2Rs7dAg6mLm9Y4xtk4CZvFOTjUx/rjqXI/X8C4UZSREcBtGzfcuSlGgMHmyEr
 S3KcPSMim24iCg9Y9dC3InDOMS70nLTigjxfK68COrkpasbjOe8crEH0/Y2XKuW3Ugh1lp0O1sO
 XeYWKe7/L58VMgeVLrdBroQXiAOLMpT+XOxdtPbNttZNapwMNX2XZwglkxa92ARdGBaWu/cO27c
 6TLo4fisNQqh/Mz9JHrx4M7k3LT0kBRvvyJFZ6axgUxSaDbtU49ehsg9nKMaqUfkFxQdMa768lc
 XFX8FY43gXTpzoYOcWUyviu9w4GKpnvC+ryLqDJV9kmgpd2BQ2Uzr3gJ2Kp3uFtmfKgoPUCdxG5
 pi9N0bw/Hd6UQ6xix/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NCBTYWx0ZWRfX3TA8Z5wSjzPC
 jYYtuqiVPk3q7jqJIDGldODYXteOXMaAdel3WRawpygA7lfU7vGbagjYXEx4/lIBoczToRGYodY
 J3ZrRlNSl0hMVlDYOwJBxIvQ+VVI+Y8=
X-Proofpoint-ORIG-GUID: KkMb2FOi8uKyYB1qVgYrCClZNeOG8MIG
X-Authority-Analysis: v=2.4 cv=CaKdd7rl c=1 sm=1 tr=0 ts=6aedb660 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gm3xcvSgROcOYQEXUbwA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060044

In swnode_register(), swnode->parent is assigned before calling
kobject_init_and_add(), which normally acquires a reference on
parent->kobj via kobject_add_internal() that is held until after
software_node_release() completes. However, if kobject_init_and_add()
fails before acquiring the parent reference or drops it on error in
kobject_add_internal(), swnode->kobj holds no reference on parent->kobj
while swnode->parent remains set.

With CONFIG_DEBUG_KOBJECT_RELEASE enabled, the random delay in
kobject_delayed_cleanup() may create a situation where - when
unregistering the child node and then the parent - the parent object
gets released before the child who's left with a dangling pointer.

Acquire a refernce to the parent swnode when registering the child and
drop it on child's release.

Cc: stable@vger.kernel.org
Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
Closes: https://sashiko.dev/#/bug/linux-82933c14-d212-49f1-bd2f-d4ab1e16fed7
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..986dcb933d2c9274e9000968f115d7fccc2d103f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -843,11 +843,12 @@ static void software_node_free(const struct software_node *node)
 static void software_node_release(struct kobject *kobj)
 {
 	struct swnode *swnode = kobj_to_swnode(kobj);
+	struct swnode *parent = swnode->parent;
 
 	fwnode_links_purge(&swnode->fwnode);
 
-	if (swnode->parent) {
-		ida_free(&swnode->parent->child_ids, swnode->id);
+	if (parent) {
+		ida_free(&parent->child_ids, swnode->id);
 		list_del(&swnode->entry);
 	} else {
 		ida_free(&swnode_root_ids, swnode->id);
@@ -858,6 +859,9 @@ static void software_node_release(struct kobject *kobj)
 
 	ida_destroy(&swnode->child_ids);
 	kfree(swnode);
+
+	if (parent)
+		swnode_put(parent);
 }
 
 static const struct kobj_type software_node_type = {
@@ -885,7 +889,7 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 
 	swnode->id = ret;
 	swnode->node = node;
-	swnode->parent = parent;
+	swnode->parent = parent ? swnode_get(parent) : NULL;
 	swnode->kobj.kset = swnode_kset;
 	fwnode_init(&swnode->fwnode, &software_node_ops);
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261106-swnode-kobject-parent-ref-3bd9b9b75aeb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

