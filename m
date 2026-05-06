Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8D425CE0
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068634; cv=none; b=HqHxLJVuCi/pCQOPc/k4zipwdKl+pwb5HrF9YluV7FyTj75A4NQRAl0qwfcNVia9eOBIV4cHQK1+usQApuOcpHH6KaUIeeSAAtP68VNrycx5uepWCTpqOI9jVBVGHXpB6gtRv8rYHbIfGbRUGiJyn/DFDA8fyMD0D26CTMnWs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068634; c=relaxed/simple;
	bh=87NP7XwywOn9x/iXWB+eXS5eWuDkx8j+CF4L7FZPusM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSfllhdeU3ksB+D4MvyMccokySVaLkmSRmNXhh8iSiTMp3qL0HphT3+t5m8HbAMZucm8lApWDgScePaw1gfGRQUvQ6+tjOIG4LCRnJpiqSJt9QYszufWDjtZBEe7zzf1+/YN6a9Fl1V+R14cv1OZVFiIQkFv5H9Jm+Y1EJTbVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=es7gRqPv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LAaJQpp5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="es7gRqPv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LAaJQpp5"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465qw6m2581370
	for <linux-acpi@vger.kernel.org>; Wed, 6 May 2026 11:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Odr8obAqI6YzuQA1Xf0eZUfZcXB+THZa+6j
	Hl6jpP9g=; b=es7gRqPvfcWjkrWR2L584axIUuruZrtV6MWjOIfz7Lh1qSod49p
	Oy8XigTxcm9eNpkWcayHLBAGl0VvVqQhYUX+SAh5f6n1w6RBEaEAo83Xz/Hv7Du9
	6VYjwznv6cbl85IlV5FtzNpAORbLU2D5fShggV9A7NJSBQG78P/4evOrheeLY16/
	zXNVzW1+4+M90DyGoFSd5J6MZJFsKQq+Arruncd7eXWyloeYem9HlCXF9iXelcZs
	w/eEXlA7LzMN1Gh02d605dI+kI1YO4/cQ2Fhpn7o6dRaV2qyU4zWmPdQI/XppJX7
	zekoMJJwlhQya9WcC2w3j4dbsIiuETzuaOg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw1bys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 11:57:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51009190feeso147016611cf.2
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778068631; x=1778673431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Odr8obAqI6YzuQA1Xf0eZUfZcXB+THZa+6jHl6jpP9g=;
        b=LAaJQpp5SExFXdKFbSqZlBYkrRZ00hUU2Ua5ZpcHT3TWlKkeeqTd8MANgnsm/WU2/f
         jeSgCWn4jN4C+Zfjlxhfpc7cxRh78OZjHlZKB5bDq11YQy1q3ill4AUpDvnrkx1S237s
         4NLrlZmR2qDdUl/Z3vCxdF0u6JxnN6j7tsqjelf+jOlw+/6p2SsVeU4NCy2O9uAKKnci
         J5OPmezin6uT/L7xyDKlF0090aTWOTWVgXKo4fg1i9VYZ4pMttiPTHz+qPIDnyABIUH2
         PPmsyljpn+KURkpbm/MIjwzpT/BVHQBNr9xc2YBLdDz1o7H54b3eP9aSEBk+W4pYRQtN
         I+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778068631; x=1778673431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odr8obAqI6YzuQA1Xf0eZUfZcXB+THZa+6jHl6jpP9g=;
        b=FjITWN7q7actDcCAPAILJcJ9hzmluKKfcAZ8gAvL79aU6WG0SV0UO6ASfywxMiN9pL
         +1cWIKu32T9Pjaks8vTU0Yx57nLl2q4azaOlvgQrk/CmVFfuGdQk2Y8foJyKEIXAUug+
         iyM0uOvgj3ngPpMV8xswzQEzSU77WDPPs+EjpFwVlJEzNHAj0PMQklFh83gA5aNaWGLz
         r0wKOcbEekqF509hah+TawjPp8qsF5G8gl9jXy3uVRJ7WwxAhfg/COQRjyfzSmlYdgfn
         npGQsh53yhCGlUiZ0o2tNkjcMzgonf91ONh7viz5r3gRnGKyshu9sNhVSLl+ragu9GD+
         pMmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8J4jsM7LgmSKMU6ljWjb5MQhwmOfIirRZfaNe5CtbWDv+LY88F038Z8TT4seikFDxnpBgUpW03cyMk@vger.kernel.org
X-Gm-Message-State: AOJu0YyXswdabos9sebWvO/IAx9pG+8xl/I/0r2tiwW07JMQbEtSn+Gy
	FwCvPiKC/kXs8R7jpW/cVCT0F94ahUJYgjhDEaDN3UN48lJsxkTMLYJoWacWeY9WOAPvGqjRRbl
	B9vOMFd9TXdOHrRXY0pda16IZNYqWWNd7Mn26Jindo/995HTDEHQs0oH1/ajrWQqj
X-Gm-Gg: AeBDieuzIPSsuIwuRWGKW7K11iYQqFJ19PoLHLCUz/e5XGs1zvQJ8i234VLh6Yv3K6A
	old81nFxdHZ90Mpmy55a5R85aVpQcxleUDT2JlKewioc7P+tkU5yoFqt2+T1ecyi0n4TDT33TBs
	F+Ulfd6UUsgUWsANOf6Sr2nWF3M1Nj7l1yCKUEj2A1lreRHjk106+Rq7SnfcbYnPsrwmsgw/A+9
	H3JhIVpMdCzlq6zSYqqPieHUve1QBBr2zG9L2kHZTQLDQz31ul1uetCfKQM+RDVQ0QMhwTsaHKx
	b5n/sybIGYB9U6GKsOrZ1UBNSOzUwlBqskj5xpZG5FM+bjX0CZLg/EiIlqcu0Tt0lnAYBoLxvBe
	gl6d+YFI0FxcMRIEbLMW++ixoSje8oW0xcjnfKyzyA4cYeyAUT5TQsJGCNsVP
X-Received: by 2002:a05:622a:608c:b0:50e:60b7:bb40 with SMTP id d75a77b69052e-51461157e8emr44080191cf.0.1778068631061;
        Wed, 06 May 2026 04:57:11 -0700 (PDT)
X-Received: by 2002:a05:622a:608c:b0:50e:60b7:bb40 with SMTP id d75a77b69052e-51461157e8emr44079861cf.0.1778068630631;
        Wed, 06 May 2026 04:57:10 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:ebfc:d4d5:c415:532a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm11651522f8f.0.2026.05.06.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:57:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>
Cc: driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] device property: set fwnode->secondary to NULL in fwnode_init()
Date: Wed,  6 May 2026 13:57:00 +0200
Message-ID: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fb2c98 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=oySY2n27BtFPXPS6EewA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExNSBTYWx0ZWRfX7cXyQAyzXNwj
 yIG1v63QwonvL75kOcqDGqeHOAAMU5l/A/IkhlvtIV4ewP7UbFwL8gnlkkLNgNxB7nl6hdMKGjf
 o7Vx4Z4QYH+e3QS8sWMlv3BDs80QJ0nhIeIMVDwXWKCuO52ZrCD7XdFeyc3xbJTaCBFcg/r0XkQ
 9WmwZE4AKb+i5zE6cyuG9Gmwm/rGOLaoFKtRljUg0gRWheNXuoK6VfvSptiOL7jn71ZbTGS8x0l
 x3kgZA2HHDQYvSLonShaV24e4m4TgTqOodb/Ag+DVx29qZRs+bBvqNq2MFk9DKTECS1evfqzNDJ
 BZanrz8rqcOZGAP1G/ej5P8J5mPg+0P6p9ZwmQMSCZN36+IelTCh+7FKBbk/l+tT5iWGZ6pnlDm
 yJWo/glPZTVfaf/UQKilkvOGZMEz7htWEpEY/BCBp+h8Gm0x/UjEvKPLUK0CaaH7uEyBSLorNhc
 NJ8E55EIVKGP5meTroQ==
X-Proofpoint-ORIG-GUID: Ql7OR9lWpk9AnbTAiYjiRkgkd6zRMSXp
X-Proofpoint-GUID: Ql7OR9lWpk9AnbTAiYjiRkgkd6zRMSXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060115

If a firmware node is allocated on the stack (for instance: temporary
software node whose life-time we control) or on the heap - but using a
non-zeroing allocation function - and initialized using fwnode_init(),
its secondary pointer will contain uninitalized memory which likely will
be neither NULL nor IS_ERR() and so may end up being dereferenced (for
example: in dev_to_swnode()). Set fwnode->secondary to NULL on
initialization.

Cc: stable@vger.kernel.org
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/fwnode.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 80b38fbf2121..31df7608737e 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -208,6 +208,7 @@ struct fwnode_operations {
 static inline void fwnode_init(struct fwnode_handle *fwnode,
 			       const struct fwnode_operations *ops)
 {
+	fwnode->secondary = NULL;
 	fwnode->ops = ops;
 	INIT_LIST_HEAD(&fwnode->consumers);
 	INIT_LIST_HEAD(&fwnode->suppliers);
-- 
2.47.3

