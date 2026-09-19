Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B204392803
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846614; cv=none; b=hAjjXoSJ8/uoT63IPaUrDX4Eiiz5nXbyMgdbPlshkCMp6cwyEiUPuLNfKg6UcdNLhYamjkmT5oqZ2IDx30qZ1DxSUdFl4+w3WXAFl1Eil8PUfJ2dQLwksHYAxL90NKMmgqK3ET0sNxwnhn0JLrmU9jT6hd/VthxPBspIgOaJ+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846614; c=relaxed/simple;
	bh=evuVvMsPb4aPlMc2LL2oBDOV9a/NkvpIQachjy0QdQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzyKBCaVfj2xqTBAVirjT8WBfe+NmlQNyGKiBvWo22howS0lfD3YqQ8Zctd5GN6wK2AYFhnsscyz7Q1gdX3GTQvBYLAvYsHplMhc7U/gzy1Yu1OGLE4dy9UJRHl0sXy2P98QhXF912EM06UnfdRg3y5qiXOrrojuLDs8vvUxst4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JS0bfayk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CN4NWcP5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JS0bfayk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CN4NWcP5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68JGLDHg230422
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 19:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8khxm2834in
	Oi2hf+BqPw3Kjps7MjEnAVmyUuvQhJRY=; b=JS0bfaykEkC29m7S64lalu5C6wq
	6twFo8EeZFERKqupOwl8Sgcb/K1pSPLq7/hL0sZjAIU5Tod7ph9IRf9fQf7PiBMc
	T7l2lrg/qtxgJd+gptTjqst2po1gBP/PF/nBxhsQvbGYZ2r8AUYrUAd2P9CNAeBO
	QVOxBO8r9Woo4wgBPHjeVP8Do7AMebJPQCOxG0P/8B6AyAAGjrrkw7We6ihOM4OL
	FBC/tuX9bV2KcwCjdOqJrg4Y9FGSUJlqgHCGbTApiK93/H0qTnfzT7wgXaBkSTdt
	i48IWRPyyyD6vLkpQajypf7DxDOyk/1nJ8MbRmDOSLShKXxtXa0FEt/qvkw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjfuhh8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 19:36:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a0050a554so460455685a.1
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789846609; x=1790451409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8khxm2834inOi2hf+BqPw3Kjps7MjEnAVmyUuvQhJRY=;
        b=CN4NWcP5IFiJ778VENJtwPO42GIVPpXjnEpJi4oDWVMoJLtvUp0UJN+CdMO2Iv/7D9
         Xdnzy81Uhll5f876LDMV5Rn57cpoMTx7eOpNtGSlVNOYVMyOIOvjLVeyMUXB8h4/Zzll
         rAP5uSdddpmY8qj8UwpaKWcCX75aZGzJlrY9cnUKMQXTYFe1RPM0aNeVsTjkxIURno6i
         WRaLMb8+KUbQ2M7gTzNoPumF+l9U6lLZBz5SMdCKGTDrt+Z2ZYy6zri/9uqNR8y/HD6K
         CTIRpmgfHzSYTaIcSEZtbXm9ItA0Ke+lmkbv48uEG9Ig01gtqa+QTXDwXK/2fl7wajKG
         94XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789846609; x=1790451409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8khxm2834inOi2hf+BqPw3Kjps7MjEnAVmyUuvQhJRY=;
        b=TJqs5a7VfE9W4/5qAm83CnXFyUUz7qT2/m4LLVY11/umPu1FHVYTI2AaScj8PIePYh
         E+EILiX0A15IgJrrLaBqj5SAtmCAHSVewSz6HTUUo/zGh7bdiNQEhko3yFjl0oODvL4F
         MbNTAsOUxq7AYHy41Y3rFRx7quOgnYrdP7PsEw0+H03QVOSrK17IzWdibi2MRwLiebdj
         F3yjdiRFbgCCZltiYYSyjQzr7tlgDshRENlEhtGv07X/4o+XotunQbve5DDLXZY0GAZR
         GgsHT6Zs9duCoLVrlFjMVgG6MuFMiwITzpQ/p2jSco3sEnRwzhdXF/DfHRUZvHA3rDZ1
         /3rg==
X-Forwarded-Encrypted: i=1; AKwUvBxeWufZ6j3s/YfFRA2VOuQ+q0fjdWS4vqZnkg4Y0Ewc/dc8i8ZqoSRP9pMAL4EXXTD+7Osfq8RXfKz2@vger.kernel.org
X-Gm-Message-State: AFuF++lZ6UoTLfD17YStRENjjWszA7TGCVZ1VFk+B5rSykjEgSnEvntz
	jj6CFS1dcO9aU/MX6hSXqILWdb+0A4MbpIfyeikm90is6m53H1dPjrnALcrrgSpEL2tQsS7SOCP
	FxxLom8ttqlYBnZdWl9je04SX0lgOGilmp9ynffAQFr3OrWy9Vwp5TUGwoa5tQiNp
X-Gm-Gg: AYBFou1QgNlFlkol5ThBb5R7p+c38L2DIHyqi5VGiVcEze3lAiXZvdJ6o3/OkFjQISO
	2XTFg6NB4+ZKirKXjQ/seADhf5Uz5JkBWMIOgqBh+/NRIkuGt5cXkzXhfwcYKzlQvInJk4CSe2r
	/kG1mr5jWO4Up2MjGZmaA1s4XGl8zFtVkJzNlTbbdVMoWZK0jYmYl3bIdal0hIeNNw8QLyY22/r
	3laEuIw9VtpwfFu4csgkUcoqwd89eZLhLe7X3KNook64/DGfkhoYL1JUNNW9+4q70ZflQzHztz3
	r7QL5uvdH/XDfpRy6IAsC7tES6hyNvEV68XVzHCSi7MDoRfpV6M9lhbV/cimSRytI085QVzhId8
	1UM1ql717OUFX4REeKBRZkDCp6C80MKtjMhNfl+O25vV7WEVuArZABgPTZdOVm2DCvNuYQxv3J4
	NJRJRELKGgSNL7DQ==
X-Received: by 2002:a05:620a:1a13:b0:93b:d79e:1903 with SMTP id af79cd13be357-93bf578a159mr308372185a.70.1789846608964;
        Sat, 19 Sep 2026 12:36:48 -0700 (PDT)
X-Received: by 2002:a05:620a:1a13:b0:93b:d79e:1903 with SMTP id af79cd13be357-93bf578a159mr308369585a.70.1789846608530;
        Sat, 19 Sep 2026 12:36:48 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dafe8csm1623947a12.13.2026.09.19.12.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:36:46 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] i2c: acpi: Add AttribRawBytes accessor-type support to OpRegion handler
Date: Sat, 19 Sep 2026 21:36:42 +0200
Message-ID: <20260919193642.43058-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
References: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDI4NyBTYWx0ZWRfX1zwXUtCKFYI5
 8lWr73Cwpap6MjWoe+BON0MYYgupiRwODxPSZVQRtKQ5UD0dfcCVKnI0Py9Tull0Pu2raHPUk24
 w9djOVLafrH8XsgDAG1XI8wM7jeZoJ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDI4NyBTYWx0ZWRfX4Q32QEtfU2LF
 XjztJbwhmCtxALh8DwyBPhzij7NUNv9I4m761Lo+jNueacDmhX4vLJjt3PWauakSJMKU4BD4XPQ
 FoEnJOXKh4FgGDwT0OUOobCvOlp72YhMZg0ADQ8+PkH5hDjnKU39EJ3+rVl0qiL2XP/S0iWR1Oy
 CKADyNo87EkKZdgUFrpRGrE09Q9ML8wlM1g5IjV+SGzMQZrFIJI8Mnjtal8uk4AnGDMfQ+um0T2
 rb55bbEEsBc5fxzrXDrFSmkpHEEBH3R7wp95YALSPH4+wVQzU5pSFpB/7H1piqeZKhxewGyHfJ6
 f5aq+fT9V56OhQPGMrOYkcMcoSoU8cYSrRaPWozONURaO/OmYEvBCX8pFq2e0/ZOdSl6/BDbBp9
 G4pb+WN8MKX042CBB7+E/UMGXwxaufPiVTjca7JRvp02Zbrck/WxFqoD6AqrmnfY3hYia+29ilC
 qDZdoIhI0xxUBlVoLDg==
X-Proofpoint-ORIG-GUID: _KNIzKsnMLrWTjNe5DIcDI2uMJCO9iL1
X-Proofpoint-GUID: _KNIzKsnMLrWTjNe5DIcDI2uMJCO9iL1
X-Authority-Analysis: v=2.4 cv=QKv91QLL c=1 sm=1 tr=0 ts=6aaee451 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=JQQ7xCQNSWZi7JF5RkgA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609190287

Add AttribRawBytes accessor-type support to OpRegion handler, this is used
by the ACPI tables on a ThinkPad T14s gen6 Snapdragon laptop.

Looking at the AML it seems the expected behavior is to simply read or
write accessor-length bytes and this implementation allows successful
communication with the EC on a T14s gen6 Snapdragon laptop.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/i2c/i2c-core-acpi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 583d89c626e3..31fd88e63bf5 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -766,6 +766,18 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 		}
 		break;
 
+	case ACPI_GSB_ACCESS_ATTRIB_RAW_BYTES:
+		if (action == ACPI_READ)
+			status = i2c_master_recv(client, gsb->data, info->access_length);
+		else
+			status = i2c_master_send(client, gsb->data, info->access_length);
+
+		if (status >= 0) {
+			gsb->len = status;
+			status = 0;
+		}
+		break;
+
 	default:
 		dev_warn(&adapter->dev, "protocol 0x%02x not supported for client 0x%02x\n",
 			 accessor_type, client->addr);
-- 
2.55.0

