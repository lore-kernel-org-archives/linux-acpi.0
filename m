Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1793659F9
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226360; cv=none; b=AKzKvKOqeDytzGSPUy1iT+MRjyUe6mFPAhWC+4Nxz5dahTA0DZY4TXJXsjxi6f9oiOvP419ZR5I+61gxh774jpgSrT50ZQeTKwH22XybUWR7nuQ1inRtuJesWQrq1XaeHdGFDc9RdJROo3owUA+K4LfBN+apgSKntJBcLn/E7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226360; c=relaxed/simple;
	bh=gs/hzEwhAJ+r7pTjkeMeBtJvWM1dkzXQiQwCXPXmifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DA22ImX/E96NeojjDJDdMJDg4Zrfiaovh5sCWzN9p5e5o9SYfKOoDruyy+RYpxHdwq6WyULq6Brm6NsMpRhohwcr7M4V6i6CFMm+i2Lj3tGLMurKvAgwPgDPfG/Elywgb0RY92Rqg1s1bvlDFTQDcubziYc/0TPdMHL566BrL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SepkRtGD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZL+byM1J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SepkRtGD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZL+byM1J"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZ9KE030875
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KGi2wSuhgMr
	bNgIYWEFeuPYzY4mJULYGKSBHEKbMvdI=; b=SepkRtGDsmdMlBIxRFG+aBuiFna
	olP8tlOWHqeedM4SJohjMVZ8onn509o9SK0GVISm1xwkiS5+RkZOmB3LG5v4ie/1
	D5U0DPdUTFMpkm28EsfuU/rpl2moeHfJ7DDyLu97M35hPD0CNRkZjyHitupEXGDN
	pVUF2x1m4bsVYeHKJ8d76AOI8h1AxMGAwR0H6EURR7tWNbydMaaDP/wCmQPLd2yb
	FM22AG2H8aEOUvQ1yPTd/oc+ezMm2tXHufDMbcLwwbTBIhhy2m9sBO3t2HWmmLqk
	uzoMtuiByL5a5ljU1m0K3f12iHROOWRe865J8zo1CoHZDr+S/VmVhqehq8w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe69chj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:52:37 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-96388871d70so5802485241.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782226357; x=1782831157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGi2wSuhgMrbNgIYWEFeuPYzY4mJULYGKSBHEKbMvdI=;
        b=ZL+byM1JECDRM2AgtDD87pFTsJ6Z7EJVIlD8OF0gbHGD5Uoo2RprE4xvaeQ0tqp1J+
         vdFj6boW4UqWaauSZrA/xcaoTMOxrMuthGNyLYJhASGy4lT+v1/sZ9aEFVMfS04ABrbo
         asLLnmhNj5bgFesRyNsbyfO+hA6fp1gcnTsePoMlN9iFA0oSdDNIbFRyR5IvLNfAqG5t
         f6xeu4rSZtSQ4AzvML4k0kTwutuSv6tL1hhrGFW4zpwKYWLh+9JYfVIuWjrs5GhnimkX
         06IRZTOSl9HttSR4RF5rZfBS+yAQY+iDrPdIfzsKaHRf5bkQcly6wo8CTzrp0EXd+R2g
         lidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226357; x=1782831157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KGi2wSuhgMrbNgIYWEFeuPYzY4mJULYGKSBHEKbMvdI=;
        b=dvjEnrbECc2+nVi2kDFTJWJRZJFFwqInZpjwsInq8ai6jygFbiETWs4v+n70BM2uWr
         ztIjddPrzexl7Z0Wf68+HjEuhUW7mBXLedp7icWeULuzjUD7SfNP5ZP6Ezj9FkFINFoG
         MDK7RY+mZ6phFu0SRu9opLMoJzNFWZpy/Kk0UuD7IfGyucGuaFV+zPc/6sN8/Pt/jsw3
         1JmxjpJO1hONlljYUTYE29pRWm+7FKcOp94J1ypU4z7D7hFrb+okwdArHNEV7RpJmYdp
         UUZXEd20/MVpvTVVryDmVbo7PT1UvwJ19JJDFjD3dmP/L9tiRU3/8oSwq2S5x1Yv06jp
         iOtg==
X-Forwarded-Encrypted: i=1; AFNElJ/NhhudguO7iRrY+ulS77/9YpkhNpinE548Qs5WJcfWCuLxPF9bPhMyFoLzhQnUmO1GriA2b76Y8+j5@vger.kernel.org
X-Gm-Message-State: AOJu0YxxiHRfXCBleHFraUxfIGuH5stbUOas/FLr03MYV1LLOOQxl9Bd
	JtmNJxDJL8sOTCLYVBT2fAZxdatN6FUh2xsT6493dTmXInJEqBkZ1QQZTRTk2bIBFfElfLdlTkZ
	SPp9+VyhSs/GcbHhXaq9VPtNGigyv5iHOMfbMGYzxexfijVXQqFHOxeF4sTVUqf0v
X-Gm-Gg: AfdE7ck0G1diF+WRYwKQi/fSIqz7a3iRPfdl5S7YW5pg0YY+P+lWiG163W8gjstfUfF
	w8hcvezXPDas6YM5EFJHI6nvJNwovuZMuqRdbBcu0Wex2k0ak31/G42ryllsWE33vKuTjcDVeo1
	C338ozrwhtX1PGB0KqUPBllBZfN3bG2ofR+oLYMWycUrxBsAzHJ7AMoygvjNSB8Jg4wcp+A866s
	z3o0Tc3YohEnj7/6yeZSfwFmDIQWq09537WH9vX8Q94K7E7yWTnxnwmXl4DtKPArD40wjUdkpd4
	3nZyD2/VSg8Okrmlz50y+GlSBuMzElXy7WQNN+UP8PjSWEBDtN8nrV+MkIhdKfDmn9tFs5oEeQw
	9WDCf4e2+ZOAH7VsxsY9TB/2j/OtgL6CoCaLV/ohs6wlKh418jJA75YJ/MWI8t1tfqBFIC/kcK7
	M8U69mZrwGtYQMFyzRRuau9JacQA==
X-Received: by 2002:a05:6102:3710:b0:6f0:3999:b378 with SMTP id ada2fe7eead31-72a1f0bbe0fmr11192248137.13.1782226356884;
        Tue, 23 Jun 2026 07:52:36 -0700 (PDT)
X-Received: by 2002:a05:6102:3710:b0:6f0:3999:b378 with SMTP id ada2fe7eead31-72a1f0bbe0fmr11192215137.13.1782226356415;
        Tue, 23 Jun 2026 07:52:36 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm534042666b.36.2026.06.23.07.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:52:35 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC 05/12] ACPI: glue: Implement setting secondary-fwnode for DT-ACPI hybrid mode
Date: Tue, 23 Jun 2026 16:52:18 +0200
Message-ID: <20260623145225.143218-6-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G8AyTRXU1PFe5qA8PAg9Sq0Ent-j6NOb
X-Proofpoint-ORIG-GUID: G8AyTRXU1PFe5qA8PAg9Sq0Ent-j6NOb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX3sB+NxEyQQZA
 8OR3Pc3COGQWLFUVwWGd9fGxDH9uztBfvCvBu++q/XonCUz+xYUV2zMpyBVgJi3Y2t6LgLIYGNV
 P4Iqyg4gdOiJGAA04veNvuYNFgjLD+g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX4jk7Uu21yrH2
 hTToaHH0YMv3Dyi0AZZrKeWCDRczuPDwkOhJ5cto/JyKWRf0YRx3klgx+aOdz2K9xzDUXfOW25H
 KrahwCI1RkI272gw3RwsPHGBbNbtWRXk7fWd+PSckA7I5DlfKv/t0BAP7LBp6clC87JSWzuLo2+
 zYiSBPWhUZLHi92PM5+bX0R+C1QqAcqmYs8hvCnS7Rp+EQrfTZ1TcwZrzYleH/Vhd6l4zRL78EZ
 HltBc+EwuZi/zvlElQMAR6Daia+0uwYTresT4fpPKKJzROHRB7B5SgMFkVBXSVb2lm0o8QHkhp/
 L+AQxDgi5bixV5960gkFsIuFDkrLSFFR5jj8BePQxrt2S3C2tAZGXRxI0fx6Ik9IiFva5bmYsdA
 c7b2rXcrmHjJk/4Ve0jHu6LH8llG3go9RkKXslkv32yKSwO5EE22kWTesHWpO13BemaamI6S4w9
 vcFuhzGiYPDraLqNp/A==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3a9db5 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=SqAYOdU-xvaNvrLwBAEA:9
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230122

In DT-ACPI hybrid mode devices are instantiated from device tree and
a device's primary firmware-node will normally be an of fwnode.

Add support to the ACPI glue code to check the new "acpi-path" DT property
and when this is set lookup the handle for the specified path and set
the secondary-fwnode of the device to point to the handle's ACPI fwnode.

Also create a firmware_node and physical_node links/entries as normal.

When e.g. an "acpi-path" property is specified for e.g. an i2c-adapter
then the normal ACPI i2c-client enumeration will happen for any ACPI
fwnodes with an I2CSerialBus resource pointing to the i2c-adapter, these
ACPI instantiated i2c_clients will have an ACPI fwnode as primary fwnode.
The normal acpi_device_notify[_remove]() paths will be used for these.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/glue.c | 70 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index b1776809279d..fef450d5cb7d 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -225,6 +225,15 @@ static void acpi_physnode_link_name(char *buf, unsigned int node_id)
 		strcpy(buf, PHYSICAL_NODE_STRING);
 }
 
+/* Like ACPI_COMPANION_SET() but set secondary fwnode if primary is an of_node */
+static void acpi_companion_set_any(struct device *dev, struct acpi_device *adev)
+{
+	if (is_of_node(dev->fwnode))
+		set_secondary_fwnode(dev, adev ? acpi_fwnode_handle(adev) : NULL);
+	else
+		set_primary_fwnode(dev, adev ? acpi_fwnode_handle(adev) : NULL);
+}
+
 int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 {
 	struct acpi_device_physical_node *physical_node, *pn;
@@ -233,12 +242,12 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	unsigned int node_id;
 	int retval = -EINVAL;
 
-	if (has_acpi_companion(dev)) {
+	if (is_acpi_device_node_any(dev->fwnode)) {
 		if (acpi_dev) {
 			dev_warn(dev, "ACPI companion already set\n");
 			return -EINVAL;
 		} else {
-			acpi_dev = ACPI_COMPANION(dev);
+			acpi_dev = to_acpi_device_node_any(dev->fwnode);
 		}
 	}
 	if (!acpi_dev)
@@ -267,7 +276,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 
 			dev_warn(dev, "Already associated with ACPI node\n");
 			kfree(physical_node);
-			if (ACPI_COMPANION(dev) != acpi_dev)
+			if (to_acpi_device_node_any(dev->fwnode) != acpi_dev)
 				goto err;
 
 			put_device(dev);
@@ -285,8 +294,8 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	list_add(&physical_node->node, physnode_list);
 	acpi_dev->physical_node_count++;
 
-	if (!has_acpi_companion(dev))
-		ACPI_COMPANION_SET(dev, acpi_dev);
+	if (!is_acpi_device_node_any(dev->fwnode))
+		acpi_companion_set_any(dev, acpi_dev);
 
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
@@ -303,13 +312,14 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 
 	mutex_unlock(&acpi_dev->physical_node_lock);
 
-	if (acpi_dev->wakeup.flags.valid)
+	/* Don't set wakeup flag for devices where ACPI fwnode is secondary */
+	if (acpi_dev->wakeup.flags.valid && has_acpi_companion(dev))
 		device_set_wakeup_capable(dev, true);
 
 	return 0;
 
  err:
-	ACPI_COMPANION_SET(dev, NULL);
+	acpi_companion_set_any(dev, NULL);
 	put_device(dev);
 	acpi_dev_put(acpi_dev);
 	return retval;
@@ -318,7 +328,7 @@ EXPORT_SYMBOL_GPL(acpi_bind_one);
 
 int acpi_unbind_one(struct device *dev)
 {
-	struct acpi_device *acpi_dev = ACPI_COMPANION(dev);
+	struct acpi_device *acpi_dev = to_acpi_device_node_any(dev->fwnode);
 	struct acpi_device_physical_node *entry;
 
 	if (!acpi_dev)
@@ -336,7 +346,7 @@ int acpi_unbind_one(struct device *dev)
 			acpi_physnode_link_name(physnode_name, entry->node_id);
 			sysfs_remove_link(&acpi_dev->dev.kobj, physnode_name);
 			sysfs_remove_link(&dev->kobj, "firmware_node");
-			ACPI_COMPANION_SET(dev, NULL);
+			acpi_companion_set_any(dev, NULL);
 			/* Drop references taken by acpi_bind_one(). */
 			put_device(dev);
 			acpi_dev_put(acpi_dev);
@@ -354,6 +364,40 @@ void acpi_device_notify(struct device *dev)
 	struct acpi_device *adev;
 	int ret;
 
+	if (acpi_dt_hybrid && is_of_node(dev->fwnode)) {
+		const char *acpi_path;
+		acpi_status status;
+		acpi_handle handle;
+
+		ret = of_property_read_string(dev->of_node, "acpi-path", &acpi_path);
+		if (ret)
+			return;
+
+		status = acpi_get_handle(NULL, acpi_path, &handle);
+		if (ACPI_FAILURE(status))
+			goto err_hybrid;
+
+		adev = acpi_fetch_acpi_dev(handle);
+		if (!adev)
+			goto err_hybrid;
+
+		/*
+		 * set_secondary_fwnode() + pass NULL to make this work for
+		 * child devices which share the fwnode with their parent.
+		 */
+		set_secondary_fwnode(dev, acpi_fwnode_handle(adev));
+		ret = acpi_bind_one(dev, NULL);
+		if (ret)
+			goto err_hybrid;
+
+		/* TODO change to dev_dbg() when DT-ACPI hybrid support is stable */
+		dev_info(dev, "Set secondary fwnode to acpi-path '%s'\n", acpi_path);
+		return;
+err_hybrid:
+		dev_warn(dev, "Failed to set ACPI fwnode for acpi-path '%s'\n", acpi_path);
+		return;
+	}
+
 	ret = acpi_bind_one(dev, NULL);
 	if (ret) {
 		struct acpi_bus_type *type = acpi_get_bus_type(dev);
@@ -400,8 +444,14 @@ void acpi_device_notify(struct device *dev)
 
 void acpi_device_notify_remove(struct device *dev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev;
 
+	if (acpi_dt_hybrid && is_of_node(dev->fwnode)) {
+		acpi_unbind_one(dev);
+		return;
+	}
+
+	adev = ACPI_COMPANION(dev);
 	if (!adev)
 		return;
 
-- 
2.54.0

