Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132744839F
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247657; cv=none; b=FsFaxOzgD0d5FsdUmbmjVL14MxbJrr/e7X8LcmVXlupqoG+WTTGf7ysTXMP8sQkqdrXx0tYxXZVZqOQfvOX74yZJviqtEoVzAkfWQLrCAaOHk3jXrvoY1UVM3xNbHCHRB0QjZuVnMQWgbGn+5pXeLfYtCLFD3XSB6cMcNWNxXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247657; c=relaxed/simple;
	bh=9+NRNC7cz7+H2463EMV4gkEfG4tiBnjiHz4PwOIzpBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K269g3xEAAPexX4RIsnP2MYeiqAysQewvGB5kKWnzTL+sW74XJ/sLw/6VIRfwqqQ1cBB+rhC2+xE8oZGyZzrTR23l31h8D+hjEOoNTEwGVB2wVWaqk3rXyRTe9+N1pGNPV8GKIa/4wQ4S9YAz7FnUXpPGLiDyMGoOe7KIl2wsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ji3iKGes; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dh7gB6XD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ji3iKGes";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dh7gB6XD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SDP0P62881587
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KynMNtPTT3Ht/2TnXMaMSG+Rx/1syY4qqJ+wQXKDRcU=; b=Ji3iKGes+pnIqIC5
	2vwLwriQO/KVlU2l/zvC5ds1KgcAuhcG40FHSpJt+dAvZ85xExQXWxwO4/3m1qCI
	JrEyj388AnSacILUUDaNoomwzszlRQFqKZruzoQNoQPm5m8vYrcbtMDz3oZvu5W6
	jSbBTc75QTvy8ViXrqeUMDoU/PZOa/1LxgmcdbGGSIceIsFMiP+Bc7TylHPhUBrO
	DKrKw1zpEokjXBmRMdAkrNAeaEYJwLDI4rnUpj8W8yVhMnuLBUkiz20hKO1MLm+b
	9kYxHtQuj4fLbWbz+x8UYMmhF+acyKF7pLrpO6iq0CKnwsfUdx6CL6kLSK+583eJ
	xDjdDw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpuyg8k63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 14:07:35 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c2ae99c28cso238689e0c.3
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785247655; x=1785852455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KynMNtPTT3Ht/2TnXMaMSG+Rx/1syY4qqJ+wQXKDRcU=;
        b=dh7gB6XD3vV97uC4qNlCXoqtyWDC0zANs3PjLXno6Zx2SDTuUl2kUW28yP6aaImsyd
         c7nnxU12zbF3/0iOZ6KBzJLS1miJsou53OJ3hYEkrxVLj7l4r4PopdDzTuw/+1VLWSQN
         H5bt15pBx88aGhKvcsOIed1miFgpTpu6EOE9EjEVDFxx87XIx6DM8egJzr/5lQRpWz4f
         0VjpikLZXms7F/PzE9vTkXCYr3etj5Ub/8VtHYtgZoFedw9E0tuqhlYC+clPLLwn6OTL
         APYeJSY4IvZoPuMlICbim2juDGdJWr4QaD4Mm0+mCkvCZhqOsKvk7zS9QtuVa08qMZq/
         JxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247655; x=1785852455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KynMNtPTT3Ht/2TnXMaMSG+Rx/1syY4qqJ+wQXKDRcU=;
        b=tU+bfpEmOedG94cssL7T/SpRKaMVJE9L7lluB8qPMR5GAQLOtfNvOnxZEvr1IqZ1fM
         fjH47b5FNR/ghT0tJTkLZw56PPlJFSEfgjeZMDhY9Z068xLoj+4ej89BIeVY8jPMmDoK
         iJDGKjYY3Fn3ouG4N48S6q+bJL3XNhX6qfk2jeQLOYK9k5al2AfOU/eFLMhVlTJA/ioj
         KwDJ8ZKEiEWuFivLYQSBELVHRkc9NWyAqAO+BMKxilqUmiRH9JysSp69yDixj4MKXR3i
         cWR5Nc9Unhq974wsSIuI/OzQ12xgnm6upu955jIJhxjRjVYS3y86/nneGx6FKZON4Wfi
         itHg==
X-Forwarded-Encrypted: i=1; AHgh+Rp27kmT8hjHassgAtXsr8DoRy+RZa/N47cSsw3TWc0fa6BXhQt/tAoiLe7UA3N+UlJ8OAu0Y+kGz8Tx@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHeyo6uYPTtXfYqINpKBrWqiHsd6s6h8TeN65aK8PKeUPl0hj
	qyko+kDRxGP5Vnz+L1sDFSUzxbZfkvOE66Bfa6uG8GYQtD0hK/x+bJLoKtuTEgS6umFg3AFbmDS
	vtMkR0b0XcPy313T21RjftLmOUWG0jRXD5bbjtY3A+DHz2NR7k9owusmJNbRB5bO6odsgXYGW
X-Gm-Gg: AR+sD137a2hjpf2lIngS6OLu7Jug0lw+/W/qe+eBAtFJIIaX8EYZ+U7AhlcdJ0VAnBP
	HLB3sfQ+HUXoIKTJ5VogmaIup2t92BKceZ9nTB+onJriZOUUGHt3fEmK++L6RXgaDQBQvw2Emje
	PIUoOVCM2zLKMCOCRMe1mXfcYVVdpBEIOJlKR8VbRYqUfHZTADgU1EnVUXQryzbZk1LYPa/X1Z2
	ik6PjmsoDB6mwAOxdd+HbtQz3tSJ1jyMGIcKyqB0mp+GYXZHm1u2q6ZWBUmAdIKm8x0BxXsvxyH
	IZGQXZZVVX3LgfCLAjF9QUbaSFoAFMtrG4oJ635IAyUFNSgjrIO09zApXvPvvs4QLNtjv/ZmnX0
	0nfFe81RlOPgH2NwqjzucQhDCJTidaQ==
X-Received: by 2002:a05:6122:d06:b0:5bf:a6dc:e631 with SMTP id 71dfb90a1353d-5c33fab4edcmr1025963e0c.14.1785247654841;
        Tue, 28 Jul 2026 07:07:34 -0700 (PDT)
X-Received: by 2002:a05:6122:d06:b0:5bf:a6dc:e631 with SMTP id 71dfb90a1353d-5c33fab4edcmr1025908e0c.14.1785247654328;
        Tue, 28 Jul 2026 07:07:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d2e3:b407:476e:c977])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44a9451sm91612285e9.1.2026.07.28.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:07:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 16:07:16 +0200
Subject: [PATCH 1/2] ACPI/APMT: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-acpi-arm64-pdev-set-fwnode-v1-1-b5aff9b2235a@oss.qualcomm.com>
References: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
In-Reply-To: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: brgl@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9+NRNC7cz7+H2463EMV4gkEfG4tiBnjiHz4PwOIzpBI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqaLegYDEZQ/sUueBDm+sOifDJjJLZO+lm/xUdk
 Vs4COMdrj+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCami3oAAKCRAFnS7L/zaE
 wyxHD/41fquWwn5r2rp/8s74FTTjwav08U4/iEn9J43mZUvktNRAiGXaSvony+AW8DYrGcJP1eF
 Xo4Rb2G8iOBtC5Irex1dDi5+4lxX3Tc1eHR72M+M9I87POlDKeB9rlrgy3KsIZOsHJxAGBUrmpI
 6/quYhPmvs+v7xH7AXinSjKfD9VYkaInBX+nJn+6Q6tm19QDYHEc14cDL6NCL84tRd5hgSWt46v
 s2niSH+O9nQmiejtCp1oo0CytSaIeD9l+e9hDr7oIEDv2LMn7w8ElUBYZI85AtI73tnnHtdjltq
 3zOynxa23pHWxEWBGlrqaDRdltK6oQfkl/oZbbNniOtISIk1DCifmZNYGNAxWjg3zVoPmH3N8oV
 YRTiNuA+QzgumK94GC9VNG1DL7lbC4+jsyH3d6QGBv3XaI8Bb9yar6hFi79C5No4sigXeq246Vp
 J5PxSIu6DkWoNPLme1S9olYoBp9CGs3ghS9uF0YrP19qMYFNsKc0NdD0utrxk/SsHXSgQedixSE
 jOh8xy4B35D1AZzhaSvDKRczaVNIVDqAPJd48hZWIt6NcOUvkXSpVbuscOQsQmjCv6Y67shvD7X
 gPhwAf+rOHNYF1gBNIiHWs4UUrCQXA4JOQDYbQbG1ENWPDid7aigd5K0JMPtli+QKjsIhGloJiI
 +B+z88k3SUdMKKw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: PwiegLeh4tuJDmPz63PTICLJsrIxAaaS
X-Proofpoint-ORIG-GUID: PwiegLeh4tuJDmPz63PTICLJsrIxAaaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNSBTYWx0ZWRfX1jXXa9EEJswy
 Y0hO7Urd5pIbH2FukmbqMRkuiojdtA+MKhQhBtOo3mFBrcoRFqBLjIdbU2c71Cv5HvgYeuPcmvZ
 VF9WxweM04/aqh98wbADrqmIzJ14smUM1AzFmcEuO27rfc+ITql8qO7LPbdB1BKc36Okpevbf4M
 ivL8lv2H29G2oCZ4pfRJ1BBR0DvK4EctPI7awfN5XGK5HAhHnYsB70jCXGcLrJpJD6QCCW13gy8
 DtGtHqs04Vwnk2a8g/6SxK3xZGHbfDWy1nDquiIxBAti7IoUIa1UItoE1QuiBPGDnhnpNdsYloY
 58SMCnJBZ4ZJFCOKAN4O+kQss4wfGEnJFub4JvpmHUAmC9mt/v7C1uneVx8i19k5owQ1Y1RSUVt
 lFfJMyi5MAyXdg3fNzdRW7g5Rdb7Ap0WTa4gsEwpPW6TBvkEApIfiJl8nnBeZGBDavRT5ns0V3I
 CYbVQkFM8NuAMt52Abg==
X-Authority-Analysis: v=2.4 cv=aoWCzyZV c=1 sm=1 tr=0 ts=6a68b7a7 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=fqL1emIZdJcgNPYfUqkA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNSBTYWx0ZWRfX56q0J3K8LIu2
 B5KvAmW/W/Gn0EQLtltjgYLAKE02HEnTzGPLI5ChKA2EJW50+1ouRxBT+bXW0GlNjIecVVF2Oo+
 VEboHObnw8xGVCXB2DPGTcTIKGdWFac=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280125

Platform devices using the split approach of calling
platform_device_alloc() and platform_device_add() must not assign the
firmware nodes manually but use the provided
platform_device_set_fwnode() function which additionally makes sure we
track the reference count of the firmware node correctly.

Replace the manual assignment of the firmware node with a call to
platform_device_set_fwnode().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/acpi/arm64/apmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
index bb010f6164e528acd802f65afd80d65a57f5844f..c927e4f08ec2c98137d4e3c64ec1709d672ad9a2 100644
--- a/drivers/acpi/arm64/apmt.c
+++ b/drivers/acpi/arm64/apmt.c
@@ -99,7 +99,7 @@ static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
 	if (ret)
 		goto dev_put;
 
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 
 	ret = platform_device_add(pdev);
 

-- 
2.47.3

