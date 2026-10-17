Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7238B12D
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252787; cv=none; b=HDuilWz95AP9dM/xDtJiWT7fZJitbSGGVvoAbz/IMvMcVUbR6bOTv9FNu6hjBCxtieTB6HLjTFFLlwpXncSVJqQkylACttVM6f5yYgOuaDRBc7Y9vGHcMCimD7dxCe1ZtE4u57X4cvUxx9wjPOiUEoyBtQO8+OcfpZ26nf4ePRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252787; c=relaxed/simple;
	bh=byVAvNqvsjwPdeh+FO9RKveJ6t3iuSgMa1R3KK8A1ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdP4leo13Sgbor4TYcO6LFkEzeGe3pJNh/WgSBnoiyr6rwr2HkRE7AtGXAE7Lq/c86UnYMQyuUc5NIhV/Fn9aJGnWDTgDxVhix4+jDC/U5rqtv2QfvOfJsQ2UyLAoMI5qHTPFRSizJThUhMRLodmXgf4zRNfMqPNeKKfVmYoCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F0mOmyo6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fGJNVGXF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F0mOmyo6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fGJNVGXF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HDEq3f1127092
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 15:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmad
	BeZlL4Xw=; b=F0mOmyo655CgrUXGsmDERF3TGJi766eAHyw9RMqF+ZR5vKQvPbZ
	mLAt6AbTMNIupW8ezj/fEuvKIg1aE3aqrduSyg7WmCKEb4Q8+4A79l3f23OOko8A
	x2GyfwdYHXJOwoNtlU6kEc9/BcXBHzOgHNT9qIsHMbx01t+b+g0R2+RINLwi05pP
	v7S0qE6gk35GqYwNvbPkbWnToFOJPrLVQZ5gXRjRMsz6tn6tocHkc9g3B369DMhN
	PKxEJdtC0/LF7mh8hbyA00i8NmEwGxbDTiIY1HsQbo/JTjm+QVTrDKoUZOz5fdUf
	WjPFMYaXyGExChIqcUb3E9isDQ5Gkvfk2tg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc13us8by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 15:59:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a082c014aso221560285a.0
        for <linux-acpi@vger.kernel.org>; Sat, 17 Oct 2026 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792252784; x=1792857584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmadBeZlL4Xw=;
        b=fGJNVGXFcxcJViuLHnaTpxfsGq7YouewcWVZf9WqkPCWysBylWzLKAKK3wLiOIRRqb
         P7gtWhWTqP8i2Ssvwev+kqZ2KfigHRW5MWtKz1gD9OR0vlkL/1op/MzWs/Flf9yOK/dQ
         KYZQDBi8hs39eJXOWhVuUkOdzWRU1EId4vCPzaS241nB8oBu9aNPDFOgNpAXttZLZXP8
         0l+934pq98bYG49wNbLSWMIYeRrhBBDNuEPuF4REhhdQm/K/EDM946kW0FkMHUOdp78c
         K9dPqQ5crHzRX/3Vdm4aNEityoebz5bhg8qPFnAaIb1ix0ONS+bwVUuUXDN5yxWsy+4y
         X7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792252784; x=1792857584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmadBeZlL4Xw=;
        b=1R/8Y/dBpYkOmtUm5EYSdFbZklcUZb1odLFKo1sVg+osqedHo1dvtMh0cCfzLNK8cS
         VRk0gB72tZse0R97JyMoHuQ0+o+lvpGyYVbxJnseHU6gERAabkhpM0P2de3z1bCBYdG3
         EW8kF6PINPMA/XsFnP4V4KHnHEUFGco+d/urkK+C24CNJWqBh6IMI2aPQx2v7s0u5SEQ
         Fip2xKkDvN7mo0/JkEvsuPHn2Kf3xsKHvhx0ZQ0C7Yn5hZG/BAd+0zTcFlG/B54o6ytg
         oYIsvUM4UVHeZrn+0xIwO/a5zrX9xnAI7V60/slc/iK96IYzf3pKToLgtm7nF9Fk7kP9
         BzhQ==
X-Forwarded-Encrypted: i=1; AKwUvBweMHrGjPbZQ8J+LQ7Xeml9VmHdvMO6ZE448y2GMitp8n+OfZ2AcIh/7gRqthq2Vz5E2NBZBgTRq2z+@vger.kernel.org
X-Gm-Message-State: AFq9FYIlGIk4EVuLepUXXv8D+EePBHS0EgUqD2CXQd1uiFyt98yq8203
	S31rsN8f/bb3hwWjvBNTxxa3WKciPStD1kfH3zN+IvzdnMnO57IgsezZI/aSyYrj2ttmp3WfLSt
	5fMwxt9W4R9ipMpMFeKF5rtK8IWb4aj42d+iFC0m3Ao5gBW9cS0QdKhdHj+rI8vnVVG4Xrz+R
X-Gm-Gg: AYBFou0UE5BJ7DnB/7FOK/zPhyw5Osz4rcehfhyGn0pfx18E2A/GulPIj7Jk/eKOQj6
	gItw52+I2EclRs2/UXtju5PoH5NUfxvivjK2YlWQIEP6Qe1kMNeiKLKvtN05ilDCeh196z0//dC
	ls7+cFcfE1oPmoWhmIk1JCpOpDP7ZJoMzjpC4O4KmC1mivtUxjGpRtWI+FDIT/R6nmZK7LgYKFk
	O/Mkl9Vm6IdLhhtTrEmzwKOulwCoif8CJGsineGbNjSFAOkkhztTRLen05qele2oogpvCcE7IjV
	IncQePuyMjdTuC6dci+5bUtR9eTux+RoBDCK7rcZ80nkvT64p2kxFCKS20kPZ8vnplaufrVQJSi
	d9GPi/n3PvJppsOrFjmKOTZeijee/FOmIHAsLxXuCoVMT1cZlQsbjtM6W1BFizf3SpYbqE03zfn
	nZ3IOCsjoT1w20ZLQ=
X-Received: by 2002:a05:620a:46a0:b0:93c:290e:9e9c with SMTP id af79cd13be357-93f17ef320dmr1099205885a.16.1792252783846;
        Sat, 17 Oct 2026 08:59:43 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:93c:290e:9e9c with SMTP id af79cd13be357-93f17ef320dmr1099201685a.16.1792252783230;
        Sat, 17 Oct 2026 08:59:43 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40913c4c5dsm185868766b.39.2026.10.17.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:59:41 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Sat, 17 Oct 2026 17:59:39 +0200
Message-ID: <20261017155939.75677-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8WVfkKf_ydc2hKbEoh10WzwQYL4xhFmi
X-Proofpoint-ORIG-GUID: 8WVfkKf_ydc2hKbEoh10WzwQYL4xhFmi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2MyBTYWx0ZWRfX48pVMuS7yX9E
 32iXCXmoN+EZGdtTG0t8eQNJmz+7At3niNCitIewXWSQJ27pwi0PSs8VqVNgMLzfaWJbu8ogLu/
 /WgnRHxL888Zco+6Z/W4vavDM6cvv8E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2MyBTYWx0ZWRfX0Q1yipljziXr
 6LDAiyFTuhMUvsc24okd8Yr1dKQkpr6XBmjlpdq6+/yzLv5G6eyzYlr50G/oFKeLD0JhuLxKwDs
 A3JAqDPaSk4sJCk1ZCSzfq3iWkxrp2miyMtZLoxauNxvJ7cIiC+r+KzBEgbieNqyC4+Cec9SR3U
 vsQqoyoDZr6AfDj1EemofRFDEjUIyX42FwliW8a/HmUDkp4wK5PcS+e3NMkzpDTpzZzgzdy1rKY
 TkL/KFhxLEFfS6uwp0QQCgFW7E62sPU/SqyU7MpsRVEJhphhLeY3tYuqoHWZfBH+rccKhN4dP5G
 BwhaOlJY0e/epLryODwq3jeFTAWQrGN+RzkP/STFXFZvrhDFq7DdEyCvTN/UsWO66Wx93UcWnWg
 6U28ADarpitX61ijwcWpeDi45Uy11qtFW0AjY4wbUF7vOeS7zkPQZq1ADjHtLPnS0U7f/G0xfMV
 XbK8Jz4xoLPiYfLkNbg==
X-Authority-Analysis: v=2.4 cv=SKzXx+vH c=1 sm=1 tr=0 ts=6ad39b70 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=aOoE8zyrkuWKOWMt7W0A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170063

Many MMC host drivers call pm_suspend_ignore_children() which allows
to keep MMC cards and SDIO-functions on while the host is suspended.

For SDIO functions which are in the ACPI power-domain this causes a race
where the host may end up runtime-suspended before the driver for a SDIO
function loads and probes it. When the probe() looses this race this causes
the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-domain
code with e.g. the following error:

 ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot

Busses using pm_suspend_ignore_children() for their children should set
acpi_device.power.flags.ignore_parent on the ACPI companion device of
their children to avoid this.

This is safe todo because drivers for sdio_func devices should always
call sdio_claim_host() before doing any IO and that runtime-resumes
the host.

Add the missing setting of the acpi_device.power.flags.ignore_parent flag
to fix probing of SDIO functions sometimes failing on ACPI systems with
the error mentioned above.

Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
companion device wills stay around after removing the sdio_func device. To
make sdio_acpi_clear_handle() the proper inverse of sdio_acpi_set_handle()
also make it actually clear the companion pointer on the sdio_func device.
Technically this clearing is not really necessary since the sdio_func
device will go away shortly afterwards anyways.

Closes: https://github.com/MocLG/rtw/issues/2/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/mmc/core/sdio_bus.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4b07098c33c3..fa1d300211d3 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -373,11 +373,27 @@ static void sdio_acpi_set_handle(struct sdio_func *func)
 {
 	struct mmc_host *host = func->card->host;
 	u64 addr = ((u64)host->slotno << 16) | func->num;
+	struct acpi_device *adev;
 
 	acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), addr);
+	adev = ACPI_COMPANION(&func->dev);
+	if (adev)
+		adev->power.flags.ignore_parent = true;
+}
+
+static void sdio_acpi_clear_handle(struct sdio_func *func)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&func->dev);
+	if (adev) {
+		adev->power.flags.ignore_parent = false;
+		ACPI_COMPANION_SET(&func->dev, NULL);
+	}
 }
 #else
 static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
+static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
 #endif
 
 static void sdio_set_of_node(struct sdio_func *func)
@@ -402,6 +418,8 @@ int sdio_add_func(struct sdio_func *func)
 	ret = device_add(&func->dev);
 	if (ret == 0)
 		sdio_func_set_present(func);
+	else
+		sdio_acpi_clear_handle(func);
 
 	return ret;
 }
@@ -414,6 +432,8 @@ int sdio_add_func(struct sdio_func *func)
  */
 void sdio_remove_func(struct sdio_func *func)
 {
+	sdio_acpi_clear_handle(func);
+
 	if (sdio_func_present(func))
 		device_del(&func->dev);
 
-- 
2.55.0

