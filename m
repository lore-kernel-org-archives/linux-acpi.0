Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E463D2737F9
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821972; cv=none; b=C0Xz3jdcRWUuEeg02lTQJUsxKikJGi8Kl6+0K22/wXzDBYCoP2vA2GHaHssfHEVrN9T8RnKwqgZE1FNdVfN7L6vtFyKf1MoumKZPKmJ9HOeP7mMamvhtZ9LRPJPAkgzpkTN9L4+biMJJTPrVVqkuv9Qm0t6LDGvspPtWacYQscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821972; c=relaxed/simple;
	bh=9u8saJQNhIa5GAaKPVwyke/agQsWF7nIzH+baj65GzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pc0+jz32HqPqOEZmwz8Jr+OjeFxcubZTIr9ROYtyVT3EN/kbv9Y/0R2ePcR//Uwpm7kkfqPqB/ImMsKKmi3Un/+5cRDDpB9zqJ9QnZ0Y+gJihVOpmzD9nTioPpF2Je/HJNBzFPzO++6Q4hAnbvXS4+oYg/rZffF4M5Z6z5UIHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cI+7jIDy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hUyhUSW0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cI+7jIDy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hUyhUSW0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J9tXRY146393
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/sInAJoAJnYOw56BL8MBLGDtE2ILc1I81zg
	PKUuuIqE=; b=cI+7jIDyiLX+4Btnr5djQ61vxO2ERqpLeQ+BGsEXjey/V68q4bm
	OJzUqUS57C5QFHHDTNPTyr9R2+cHncoUajhBvLCqKAsaCoO8wHuyoUWuIj4WTEeT
	YybuM+4pmlssKvbA22jYH4Kh5ovRQ5V1j1BevVUKfeuIPpxRCpXxYHjU36j5XrcQ
	lb2uNquRZVqdoMJEQnUMuzoK6D9WmyprtdYBQBq89ZxB3xQoSQhMt1UZGGhwV477
	gt43UBh4cIWpqMmbV/uoTg8S1VRwFH9cYnT6B50M4ikTosLC468W75V917QdwPCC
	ZiCj7bV+TrAIq+SYljQDn/VhJPyKMFOdO4A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshbs91rc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 12:46:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9308eafb465so98844785a.2
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789821969; x=1790426769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/sInAJoAJnYOw56BL8MBLGDtE2ILc1I81zgPKUuuIqE=;
        b=hUyhUSW0Yes0e+UsU/U1h+5h/c3GiI8zNwUsIae1mwmF7tfbv1WkweTc/ylLc3qGZf
         wXF7PTLD5CmyU6iXuCa1r9aZ/8wfombx0C15CSQ/Mkr+pUfZuTtct9CLL5p3G77ZmS+C
         72FsGLX2oQpAYim+MZCAE4bAWv7U6h94iG88FVz7WT5/HQQQEsuQvQgw/hw49r9oErCU
         9qNDyiXJ5lMdmzLHfQHWFGn3SQzYqJBb02r6AVKDtCl6GdxcH8lo5fmk9pdp4jh7wx/c
         FaaZUI/FfWfPbxwzQwJ12EcOoway2gTcSKgHlTCEBTZp8c0n6VzfziQXAyXOsaeIMbY9
         PP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821969; x=1790426769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sInAJoAJnYOw56BL8MBLGDtE2ILc1I81zgPKUuuIqE=;
        b=zvLHE+6WxMRJ2XbVujeZoU0Wt1UQSuOoDzhPlLqet+QdYRYTRWHXrHUa6fLmX7iNwF
         gWOxRmsKigeoPHp3nMoeC/fzi0ADXyRMrCcOP/Z1JOLRkLrej95oNU0R2gMEP8wkcFGf
         I7T+6gWifEJ90LfKLGpvUjypXvbTblh3B7bZuaFrFtSm0aT2Z1P0MQ0FjleEr3R1nWbC
         tQBgncAMTFd1iutip+99JusBVavo/C0u3thtilzghXxej8UnvVwe837wpORFDkwhjphe
         HmOHBHDBmv2buklOu/v8GKYakC3srhIn2MXjjsAZdr5Fmwp4WGx0m++k+ej8crfj59SZ
         9SXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0YrKolilq+I9RfjMdPA/p6mNh7c+s1Fn73YCGXC0Oi/1fOgeTkFVQ2bJyGqedDB8BYQw/Q8jcWT1j@vger.kernel.org
X-Gm-Message-State: AFuF++ksBqs0zLBBRvDjfc4EkTUMAtAU8A2nyOIGvzFr9GezLXQ+7juZ
	hp05EayQOmcCo0yzzMQeKmzZKiirI9hxBFK5/L316QrqA42EQRnf2QoCFQVPKFsuHFcPT9fG301
	yJB8PeOLYnJbXLx/qc/jZLtEK7m6CXVNqOj1jEqmor5K0qX0V1fhh+5O/iHCW+y7o8Ed1lXHY
X-Gm-Gg: AYBFou1BaQiILi4HfbDvs9189JuQi7dbqSThkXWfNILleCUHGr7Rl3s3pC8lLbQC5s9
	26JcGD7ubOy1RNLV3IXZ0NmKVPc37OJGtLG/ALK9GfbKKhjXoCpXHdhrVcv6YvNOJU7/gjCxX4g
	6+ic2qZ10ibfm6Rn0OEpz6MAp2WIFzD4qDeap0hLfZed6fgfmJoEdixBLvddsLGkn6jSK1xdl8e
	CBnNSBCNhnnK0utMsQLPyrIILOEWuDJVvTT3VrCJLh+F0WV5XpQyZCs240Dc/wss9js5Sv8JqvB
	BoS+01SibhSLX7oWIv+vUI2TbvJds1eBMy3HdUbT9sZzmHlYDYSXl7D6K1k/+s3VvsINru+AU+r
	NSpJMumYvKymxYXgj4KgRZgmmx8C2gUFLPGrrcn+Ews5QqGPIS9KPL57v79TCZ6eFo1MNnOrG4t
	4mi0Lwfltk4Px6QQ==
X-Received: by 2002:a05:620a:6885:b0:937:6c0a:9b65 with SMTP id af79cd13be357-93bf5524058mr123236185a.7.1789821969008;
        Sat, 19 Sep 2026 05:46:09 -0700 (PDT)
X-Received: by 2002:a05:620a:6885:b0:937:6c0a:9b65 with SMTP id af79cd13be357-93bf5524058mr123232585a.7.1789821968542;
        Sat, 19 Sep 2026 05:46:08 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dbaf0esm1332269a12.15.2026.09.19.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:46:06 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] ACPI: scan: Handle _DEP for thermal devices
Date: Sat, 19 Sep 2026 14:46:03 +0200
Message-ID: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u2bAQKnQcDr_V0c6CjvLMjT9viIHShKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDE4NCBTYWx0ZWRfX4xWFDcz27OaS
 kAudmi/xUZB0vU5udTWxBI476sgZVGvblqb/em2paKfzIQJRqcL+9NIjMtTH8Zo01IvYbmkeA81
 1Q1hVuBKSxIa2pjZKsDeqSFpGRMtDVhLQSAJ3Ws5dLObxFJkGHcYrUj0QYKJoe+L2meLhOCIqz1
 zzxY76Jf65rpliiFHles87h5eGHbamnfMKx7MtZDXT9FvSsf0ndkNoo2F7MTCUFx27g2K05bqDA
 0/cN7LmvZ9rOp8TPBwoLe4+meWkve5VnaIyBfIpw0IanH0fc8X7fipW+bKv7z3WiUYwA+ztvces
 R6/GZZ+9QGGLA0NtxqZwITieBidtg/b+gdO+NEdoBaudKH+mDEBvdvQK6n22yKiwUo7JcZBoXSb
 XQkZy05Pr8wwuk5r52TO39Y39GG94hmsk5vci+1/OUalNvagaWeKczQluOhXIb/z7OKHxXKn5y3
 CI6aRU0rboHSD0aKeUQ==
X-Proofpoint-ORIG-GUID: u2bAQKnQcDr_V0c6CjvLMjT9viIHShKO
X-Authority-Analysis: v=2.4 cv=bPqDs/+Z c=1 sm=1 tr=0 ts=6aae8411 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=7YopTHT55K8r9Su6qGMA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDE4NCBTYWx0ZWRfX/XbLvNizdLo2
 SBvpHM9uF4bCbxpqQKu6seNHgvJylzczCLLMHtbDdO08nheZXJE7YRsdC6FzuMl7hBWICwrkv2M
 lfqYip/3f1CNyv76huYoVE5ZrqMXHwQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190184

Hi All,

Here are 2 patches to handle _DEP for thermal devices.

This was tested on a Lenovo ThinkPad T14s gen 6 Snapdragon (arm64) using
the ACPI thermal zones through the DT-ACPI hybrid work I've done:

https://lore.kernel.org/linux-acpi/20260623145225.143218-1-johannes.goede@oss.qualcomm.com/

The _TMP method of the thermal zones here unconditionally use an I2C
opregion, without waiting for the opregion to be marked as available,
causing _TMP to fail which fails the probe of the acpi-thermal driver.

The thermal zones do have a _DEP on the I2C controller, adding the HID
of the I2C controller to acpi_honor_dep_ids[], combined with this series
fixes this.

Patch 1/2 is more of a bugfix and is my main reason for posting this
upstream. IMHO it would be good to have this mainlined independent of
the DT-ACPI hybrid work.

RFC 2/2 is only useful when actually adding any HIDs which thermal-zones
might depend on to the acpi_honor_dep_ids[] list. I guess this might
come in handy if we ever hit similar issues on some x86 devices with
thermal zones only probing properly if their _DEP-s are ready first,
so I thought it would be good to have it out there.

Regards,

Hans


Hans de Goede (2):
  ACPI: scan: Skip acpi_scan_dep_init() for processor devices
  ACPI: scan: Handle _DEP for thermal devices

 drivers/acpi/scan.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

-- 
2.55.0

