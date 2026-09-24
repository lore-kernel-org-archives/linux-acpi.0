Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A942E419
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235487; cv=none; b=Nr2rgbUwqbczNuNDQlREvXMRelYi82scrAhKWDFBQ2rO8f4EU8RLqMn/AwjhavIrITTHGMlP4se6RvnF8DhwWWIHrGvVygSzPgkE3zVOZxvoo/Lc5f+2efZaS+nXktbzRZ86SB/GrkBV4LiaeBEe69Mru9AWzDYdjXkzjOIppW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235487; c=relaxed/simple;
	bh=PL8UoLF+ygZWvMxeFtx85isf5jQ4edZiCN25qkiuVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2nsPtVYBcFfdfqTp3H7DEYCQRVjepSOOKRtMJCchjoskEp4HskdZ+5ByLzYYvRjfFQlwMV39ttLq8v8peOTsPDwtGpOmurDyKdc9/F3mDiD+FU5642qyWzAMav6i2OCogo7R77GTgqX3Z397/I3eiGtvoTK6pFMHNA1vL5H5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sww/9JMG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eyjUzuyQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sww/9JMG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eyjUzuyQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eOxx1278393
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9ko9wYXNb1l
	9AJ4BTleLCn1bm6Eblo34heY8xr2hrJM=; b=Sww/9JMGycO/MuG9UC6K+WzENPb
	Ik/71spcOH+1tGG/HaLWYAHINktuuyBGK3SROiojJndlkOsmfbeUEC05l3LPaAFQ
	m+XZaOqGc4/KUqv9jRERX/+W600Q7J443C7rTtIwft7ddRjU71oLEIBe5Lu89ywx
	mNIxMEDVc7UROB2DLovIbWv8F0Rk356pjV/L0NIm+EHLgozUs7r5vmhDgsVtuRtW
	3EYaGt4H6yRXZE36c04XUxOwJuGYFZi3s0HPF7XIMIXzEccSn+VW7C1bLPGIJdJA
	MjF8AVgSt5lWVCWsUHnocS/U8b8kYA+7GWtMGWEXz0IA7pW+H/bXST6B8QA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb37x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 07:38:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so3295420eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2026 00:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790235483; x=1790840283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ko9wYXNb1l9AJ4BTleLCn1bm6Eblo34heY8xr2hrJM=;
        b=eyjUzuyQVP3Vu1BuqBc8KD1nCEzpx1JoiHS975yD0+iQGNsn9irFZHhdywBvbX5gzA
         +6Sr0ku6UWeBsGxbLhABwoB+X/iVK/UrREx/7xn3Down7uEjOJSxyCkGoK874qDBvQGx
         KIWaZNMolxgRizmKZ9LMb5YGPJBqsWgPMzRCAW00ObJ2YQiFZfqzN4d92EA+SotjYqwO
         iu0kqiiNKh60uijq6v976z6Sc8Agyj/Fx7WwIdkWvRITDh3onA/LBeEuV2xMJEXtuNpv
         HgfcGBUcobw57zCswe/+4lWnFqHixpaqDjiynzb58YG0xizhqUMXFUhk9MhC+sJlybsK
         8gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235483; x=1790840283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ko9wYXNb1l9AJ4BTleLCn1bm6Eblo34heY8xr2hrJM=;
        b=JFBLOAtznFRJb7cSDL5EboNvjbMrETfYEmW3/rpV3XcbanoQO5LjDWi68WCu7HWMgv
         HDkqhNEJaplX8BR+ZZtLv1j5NwytbmqZCNclb2T6aE94hOk8GaGTcTJ6b3ywCpFl/k8t
         WxmrXeuFlcgoSIv0ABe7iLsgTK0EYxn5GRqmVRWud1Q9KeeCbBI8NjWcSMYJ+qyZ0wxQ
         K5R8Fvxsxfhx8mLQH21E9SEVQWhgwWJxHW8MkwyicCBOV9JRSbJohdGeIqldfObWmQJb
         rSDlpTGglq0ipoSWx+fMdJoH31MB1Fl6bwViAbo46uCATscSdCdF9aSi1FT1G+yzZdEj
         +eeQ==
X-Forwarded-Encrypted: i=1; AKwUvByKLdeSbGUcJsvKdJ5uE+bWANt94bBSieIPa+nZWXc5I2gSTNeaJzP+JQcWtm1ne8E44+t61OtIr3GU@vger.kernel.org
X-Gm-Message-State: AFuF++k7yYC/E4iV/0eQoqrc56zkRf4t/ayNTsKUjRnV67aPXOtybcqS
	/AWdupok0DToZGzBCsn2uya9xz7pptQDtNOrvf0z01Y7rAUbZkUTWy0Jt3Vw8Y3B4PZ5eco0Fd/
	nyFOt4vpZsnD7jaFYg59a9NfnIlHg+ym0eUZqTtO9JUzVr1RwvBTMkoHScclCZIiU
X-Gm-Gg: AYBFou17RW3H9m9Tpnnt8IfvlGYC4uSCALMpNiTK8Nclt6l18Gp93g2Px7f+ZprXtQQ
	wk2/miAQTkPMKIikfflynybZbqsva6qMt5Pr8uQK1GDzOE8v8eduZcfFyRWm5JM6JwZs/Sp7fDj
	8b0VNI58+zMxJzWG4qj0DWrdjYxnNAD/UkthYsBKUgF0xS+vbd3f+atyNMiur/XJGUmi+gP5M4M
	DoIjzJ7gvkZHlRMuC/tmBHjLhVemVj3O3bkVnaCWYgOvR2q9II1Geat7NUhTTkcmUj/e72d9STi
	Bfr9vqcTqRFN/ey/LHXVlKYp8z1nJwiZZZ5W0Us/MkkCaLaaalXIuAGxypKV1YrkruMg0dmfEM2
	49cU5G5Pb8b3CSZV8Mlxin8w9I6A0yEIxrmV+dU1XDf8Uvi0FkpRuex4DqvuGXaOjEK16kjfSex
	uYDWf7gtFSeFnGA6EmAn3hj9fT
X-Received: by 2002:a05:7300:d115:b0:33c:e82:70c6 with SMTP id 5a478bee46e88-34000b32287mr1161297eec.29.1790235482986;
        Thu, 24 Sep 2026 00:38:02 -0700 (PDT)
X-Received: by 2002:a05:7300:d115:b0:33c:e82:70c6 with SMTP id 5a478bee46e88-34000b32287mr1161277eec.29.1790235482398;
        Thu, 24 Sep 2026 00:38:02 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm12120680eec.5.2026.09.24.00.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:38:01 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, anup.patel@oss.qualcomm.com, ardb@kernel.org,
        conor@kernel.org, james.morse@arm.com, lenb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robert.moore@intel.com,
        sunilvl@oss.qualcomm.com, tony.luck@intel.com,
        zhangzhanpeng.jasper@bytedance.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v5 6/9] riscv: Add RISC-V entries in processor type and ISA strings
Date: Thu, 24 Sep 2026 13:07:11 +0530
Message-ID: <20260924073714.1650588-7-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260924073714.1650588-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: evwXEHpZMHnAl_eHZ_ywBvpgce5o74ui
X-Proofpoint-ORIG-GUID: evwXEHpZMHnAl_eHZ_ywBvpgce5o74ui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfXxkpGPe/IR46Z
 AZo3r9XKCzBRWa2Oys0Rfbs9N2ynmcHvxO4w2JyHITbQZK570A0IrnU4xiMmXi5QlMkv8Dp5LB6
 6r8S488SGfqLdsaDQvdP/jizBSWY9tLN1HSHzOgoXn+KhIjwvmmp2SHJFJkK3lOCDT69f/Cq0GJ
 4ulWxvGUDET1jw4E6lIi1raxjD7p0FIc2fjln9OAAEGpdn8oOa6ADZXPTG63nz1HSECVcUwRGk6
 bFav0fymKTnNPk2OggvxBR7ijPyLZfDJnB2e+52obwo8/uZ3Bmw+VBCHNiJ8ngMFhyTwCHnoHzg
 o6ZCJ1ZP0Zpd8IGIdoPiMKutOeSdU+cepUV8lHSjAg02x55FpY3qLM8idJZfenOdq/Vqd2IU5p2
 bmA8AN/UzA2EhLw+4zFlLCkT3Y6yYqZSwuECL6O2XQY4CYu7s7jiHu2G5lD+4mvsWwGtax2oXqU
 IQiw9gAsoNbriTlV2wA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX4KxJDW8n6Sy/
 tF4wpLupYEJQKfH56pj4vmPnT6P4dfqhCijrchgD/J9Uk/lA8yfzoPCen7AD0Iq4q/znTGWZK1d
 gndzOu9gNLyU03UxWyalGGN/yjSE4g0=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab4d35c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=osVkw33_48dge00NZUcA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..1b1ab2f1355b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -170,6 +170,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISC-V",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RV32/RV32E",
+	"RV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0

