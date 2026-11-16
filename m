Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824275;
	b=ZmETISTvYPdxSNp+T8nYRpGhrZIMMpwSxvyVy3m67f9XXN70xCUWTwfpQ30YwhoisYbn
	 HsHrPW4v9QlLqOwyGTFz/HWsXmA1QEDmb/5G6wKM+jvhzgQ7Wdoks6kPFNGZICJrr43ab
	 n1DKWv0/MLn3ukf8kkUihWtSFTegyMkU8ySNRIfS/K3Ot/y97q5wjVQVr+MGZtP8d5c+i
	 SuYErA/Zg/ALDACAhAZNyFuXM4UOrrOIMeToQ00w97xVXUHvd9ScmgSrxTsKwktBdUn1x
	 hGprxF7f8g72BbF/MFuzgwzddMkxitcLvqRLg2kdUc0933RnA5OGRDpFLXxF8JcPfyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824275;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=oauvhr3FkqRcOWLArtQY4R4N6vrfRI2WZdnIjmuIxeU=;
	b=bklgm9ZMMxGSZVK7F0rnuxNXoSHDe7U0yNmoWBZZX8jn+BYPJlS8QVbVCq7sonwWROqi
	 Wt8cY1wq3Z2gCl4kCzI2ztKTXQ9OhKcF3DvtC9RETTKXaZCjnJcHEuOSl8UJl0fWoWVYk
	 lisypPaIjfv6TNeBRO6ayLmN4AGpnSNZh59r1u8gNEs6gqQY9cUrjZuZ/bZ4i25Lgbpnt
	 Tpy+VngFfjVcGawGdJEy9alEHCWk71KHWjw3j8S85vT6Wf7Z2ozButZkjRrh5fbUvsCwx
	 e0aabMhQIA/ZymkdIKiT8d5P1l/p1iHUDiMoD5CZyhaigj7A7yupb/icSzNfrDP0CDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hTdAytkr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LnyH88yv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14F606A32C
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F14F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hTdAytkr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LnyH88yv
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGA1lH4273533
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=oauvhr3FkqR
	cOWLArtQY4R4N6vrfRI2WZdnIjmuIxeU=; b=hTdAytkrZXuL2w5o2D7b9i+zngj
	fNHwlcRbqfsA2slFjjGBK7QTHoeLTIG70SulHnvNBhxZrIjOnF7uo9Y62a9lMiX9
	0W+TQVfy99zJnq13qrs0jCF3c54oeFamHNW6//+wpzkJjDfkwjcQRNjRTBBCfwKb
	qMcIVBHp7zrkHubwBSKbuAR0NE9aUT3EZT6FG7a1SVVeAR87h8q+O/2uOSlYRGWY
	9bts/Yntk/Miwi72Fx/MxQo65hIIvG7guhbbYMCPlUCeGbSwGZm1ml2qcY4WUUeO
	yjVWeJ6PC5NIyG4WS5xW6MvH35OWcSP6N7a52SEezdBMqDpKgt33TphCpZw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgg1u4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:17:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f5844cb60so615335785a.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794824272; x=1795429072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oauvhr3FkqRcOWLArtQY4R4N6vrfRI2WZdnIjmuIxeU=;
        b=LnyH88yvF3zBUUYJs5uc3e+/m1ltdxcWNlkeHQ/zqKifHC/W2sBUHc1z1NiZloNdKW
         vTKDJxioHHDjs/II1xxYYtVlQxx+itpTR/Jru9trU/pit+46pHMbeFOl+CYwFbENlfxz
         Q3X3tREEFeghqWBJX9GmvOADLz+USOhLPHJZ/MA8tcyzjI/IzUT0jtUC7niLJ3qBj6wD
         7hwofgPil+0MKM17IU5vVlajWx+Y+OvZcYtgh7bDO2R/fW+B1A31/9L/1sUhkL71QrJo
         87F6LoByHArnGc7fzecvBD5LK+4LTNJt3OMXtpELDwGZzrCafSJ1uzFcOCJ3ymdN7+0X
         eF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824272; x=1795429072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oauvhr3FkqRcOWLArtQY4R4N6vrfRI2WZdnIjmuIxeU=;
        b=RxvFn0Z0Q5AmAiKtPq1jJObMRsedRKVP5e+tGJXg+/c1t1JMCW9SKBCwzXDWZtZyfx
         6TtaK9B7hWyDulbES6mvQbJKIUU7ZnUXhKmnOKGhptiphW6CTXvnS4HDZcoguFogwDMP
         CkPj1wfn8ryqFo5nNeGQMErIgFdxkaPvl8/YVDsCcqyKLmru5PO0dfkosQ6AtpVttKlf
         f4oW+cJbTlaaqw+HsnlOKFgvsin++xpNVtaNCtOVZV5ZBrMFA0EeS7B7wSqr5o5ZhJ4z
         py+c2SXy1McvgaBLzEntEc3futim5dcB+mJk/RrtfF5jpGZvDOnnWmckyPSVw6pnre3j
         7pQg==
X-Forwarded-Encrypted: i=1; AL+hErFHZGwFbhpmHx1a4icbgek2gxpQ/qOGfxN7qSuFvBtqkY4oeSYBlMLqo3ZwGBma7GG3bsM6WeeZJIRf@vger.kernel.org
X-Gm-Message-State: APuU4Z9CI/FLexKrY+fpdCRh/t/NXfb2AxrPZHInCinQ1he8rtMjYq4F
	D5LLgZfwP8FfHIXQvfnHN/pHu9fdVQNNXvKvX4rL4MnzjZReQtT5vjYquw8WD3xTwquPy2O0reW
	yPIceqxAxJnLVonTVLr0gjuQPmmX3sxrigeSPPRsKxphYQZ8AtBUxkqrpfLAn4eX8behynA0ug7
	o=
X-Gm-Gg: AYBFou3QF7CKlOjqV8jJUByL2Rbuzus7Eundcw5/bUDnmHS9RLuBM38xTjIyinl/7rc
	smVsdNu9ANd5q6jApJE2RPc6tHLZX+6YZWDK6y7sL50ELaB+vNhKlYjXnI2vMQ14eGUVMS4dWw3
	uU+ytDabBS1oPXEdFyMRfNY2zRp2Fq3WQ2SIb414iY7if68AWMNpuOSnz8G6oRzNfmSbuSaEOEE
	k5GRy2b57VA9oVosAzocznCS/zRvG2G4403bPzYZ+NAU29WcJGxeEANfDbCbO5WO6bd8MeCnTzI
	3Oq3kjCJujoZ/M2x/t3AarQmMS5aVNF/pv32n5HHBQXAFNY99eOLAaEhQdDKroDDN4stv+VOqzZ
	WcD4eOcVzWx0QXSFVGMoCfWVmsZMCJHBCk098fnkQ931acqB94tCcKsqmK97FKjGnzoqHbVw46n
	llM3uUlRtFq3ZPvjJ2xizSfw==
X-Received: by 2002:a05:620a:3187:b0:949:7058:dbcb with SMTP id af79cd13be357-9497058e11emr763739185a.14.1794824272253;
        Mon, 16 Nov 2026 02:17:52 -0800 (PST)
X-Received: by 2002:a05:620a:3187:b0:949:7058:dbcb with SMTP id af79cd13be357-9497058e11emr763736685a.14.1794824271733;
        Mon, 16 Nov 2026 02:17:51 -0800 (PST)
Received: from t14s (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55acdccfsm290351955e9.8.2026.11.16.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:17:50 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/3] ACPI: GED: Handle -EPROBE_DEFER return from request_threaded_irq()
Date: Mon, 16 Nov 2026 11:17:40 +0100
Message-ID: <20261116101742.13702-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116101742.13702-1-johannes.goede@oss.qualcomm.com>
References: <20261116101742.13702-1-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MCBTYWx0ZWRfX9kajWNVkHuGP
 ekeexcr4ajmRSSlQTAGR3xANYFeLjfNzre6AB253xlEk01TiSwnezxnHFwlBhQonw0uJz0z4Umf
 WAPjxWiCeCRhDHnRMNEnuKZpxGf4MnY=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afad851 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1DJkMYjW_GnEe9Y-2uYA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: hZDQn8vpI0Nnc-Gsj7d6Hcf9UCvnZhEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MCBTYWx0ZWRfXzqfk9PgqJYME
 pJ3ZwlxMlUuoFkAbOdXGg9sbnyRH96JLGv4f0DB+J73YxUnAGVyEoVBxbraFZGzzHODeztxweib
 btU7jJvq4j+P5LMvCtk9zrLPUqXamOHOGeaDqU9Y3zz9FfrKVU/x8pmMx4GrZ78x2Av4fbuxyk6
 f2Qv/KL05+pbdZOkdhrQsQU4Bg4CW6OFk4tas4zb4wfiQnOv/vV8tGq/w8Il6hs9NQfAvxCGPjj
 2NCozn/W8fV40wflIAgM2bTzoaG4xlmUMQPC5W/xkS7NJhcsTvhgfIO8OrPe+2jrBptnWkK6eXH
 tDUTK/7FoDQ8r9nEYbFuOf7BMhfUnORn3uJtmdgMQsK3s8sYOfRxT7EVJ3c2D2+5eQraAhDQBcg
 473Z/z/FdYepS0UuR5IJAF0coDGvn5wK+Z0hTgiUsg3VAvT3P3pmCBZBnD8EholGSnAFxiSr7Lf
 tZkeriWxadThBeH9g6A==
X-Proofpoint-GUID: hZDQn8vpI0Nnc-Gsj7d6Hcf9UCvnZhEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160040

If the IRQ controller is not probed yet then request_threaded_irq() may
return -EPROBE_DEFER. Pass acpi_ged_request_interrupt() a context struct
which passes in the acpi_ged_device pointer and also holds an "int error"
for acpi_ged_request_interrupt() to optionally return an error value on
failures.

Note that context error field is only used for errors which are not parse
errors. For parse errors an AE_ERROR without setting the error field is
used as before. ged_probe() needs to handle this case anyway since
acpi_walk_resources() also indicates parse errors outside the callback
this way.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/acpi/evged.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index b79ee3f5c1c3..de0db6782afe 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -65,15 +65,20 @@ static irqreturn_t acpi_ged_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+struct acpi_ged_request_interrupt_context {
+	struct acpi_ged_device *geddev;
+	int error;
+};
+
 static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
-					      void *context)
+					      void *_context)
 {
 	struct acpi_ged_event *event;
 	unsigned int irq;
 	unsigned int gsi;
 	unsigned int irqflags = IRQF_ONESHOT;
-	struct acpi_ged_device *geddev = context;
-	struct device *dev = geddev->dev;
+	struct acpi_ged_request_interrupt_context *context = _context;
+	struct device *dev = context->geddev->dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
 	acpi_handle evt_handle;
 	struct resource r;
@@ -81,6 +86,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	struct acpi_resource_extended_irq *pext = &ares->data.extended_irq;
 	char ev_name[5];
 	u8 trigger;
+	int ret;
 
 	if (ares->type == ACPI_RESOURCE_TYPE_END_TAG)
 		return AE_OK;
@@ -116,8 +122,10 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	}
 
 	event = devm_kzalloc_obj(dev, *event);
-	if (!event)
+	if (!event) {
+		context->error = -ENOMEM;
 		return AE_ERROR;
+	}
 
 	event->gsi = gsi;
 	event->dev = dev;
@@ -127,19 +135,22 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 	if (r.flags & IORESOURCE_IRQ_SHAREABLE)
 		irqflags |= IRQF_SHARED;
 
-	if (request_threaded_irq(irq, NULL, acpi_ged_irq_handler,
-				 irqflags, "ACPI:Ged", event)) {
-		dev_err(dev, "failed to setup event handler for irq %u\n", irq);
+	ret = request_threaded_irq(irq, NULL, acpi_ged_irq_handler,
+				   irqflags, "ACPI:Ged", event);
+	if (ret) {
+		dev_err_probe(dev, ret, "requesting irq %u\n", irq);
+		context->error = ret;
 		return AE_ERROR;
 	}
 
 	dev_dbg(dev, "GED listening GSI %u @ IRQ %u\n", gsi, irq);
-	list_add_tail(&event->node, &geddev->event_list);
+	list_add_tail(&event->node, &context->geddev->event_list);
 	return AE_OK;
 }
 
 static int ged_probe(struct platform_device *pdev)
 {
+	struct acpi_ged_request_interrupt_context context;
 	struct acpi_ged_device *geddev;
 	acpi_status acpi_ret;
 
@@ -149,12 +160,14 @@ static int ged_probe(struct platform_device *pdev)
 
 	geddev->dev = &pdev->dev;
 	INIT_LIST_HEAD(&geddev->event_list);
+	context.geddev = geddev;
+	context.error = 0;
 	acpi_ret = acpi_walk_resources(ACPI_HANDLE(&pdev->dev), "_CRS",
-				       acpi_ged_request_interrupt, geddev);
-	if (ACPI_FAILURE(acpi_ret)) {
-		dev_err(&pdev->dev, "unable to parse the _CRS record\n");
-		return -EINVAL;
-	}
+				       acpi_ged_request_interrupt, &context);
+	if (ACPI_FAILURE(acpi_ret))
+		return dev_err_probe(&pdev->dev, context.error ? : -EINVAL,
+				     "parsing _CRS records\n");
+
 	platform_set_drvdata(pdev, geddev);
 
 	return 0;
-- 
2.56.0

