Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F541DDE3
	for <linux-acpi@vger.kernel.org>; Tue,  1 Sep 2026 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278454; cv=none; b=qdGaPJufLbTA5Q1Q1HV9fZclqCnFXwB0QXlKKmt7sA8GqIT0J+jmty+DEtNaY/3mqF0pvrWG0H12nPsDGJAi/jm2ZPKwFD3H94v0OzjjjFIISl8WQByX5FioRc19aD1hwaaSecPv7ImfK5by4Fzgttrnckaxka4dGvfUSevZLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278454; c=relaxed/simple;
	bh=VWsXx0oUb/3cr023vldlEdubGn4liZ5nYTzyVVD9Pso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwqpMIZjhQiMEcAuuBm7zleOHsi4989haeVdJ96/XcH5z+PHPH7VegPSQkLOMxa1C35JeQqBI44ZR286JCEgwFHoRqG83xzDJ/0DlPFYw3FQAEMwV0apZZNZWQu4T+ptxAnj/+91eBYiKRj3zuqrGyYZokHAn6OEGwQ4mw/fx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O23rdkJI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RfAWnGfN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O23rdkJI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RfAWnGfN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E9BWl2647424
	for <linux-acpi@vger.kernel.org>; Tue, 1 Sep 2026 16:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s4J8eQJ9hKtkVUcAFRu9iHtJLeOFXzc723DIMlxjsbk=; b=O23rdkJIh/Al3g4I
	7HkC+OcZ7W0SgTtl8NgVSu/avNHVZc7hsCvhT4YhH936ODyxkaF+skSyRXcydeOW
	I192VD41gpMnYAVdY2qZH5ajE92nq6yfUF9Cp2ShrKCpXBj0T5WM7LQzvEu8zpWQ
	btFnVtqWjJOFdlABBy7ORiTPZyS3mhEmMopZXaiH+zlQk7Eo3o6zKzeKOvSBaEEI
	XDNJfzjjGMkextk3rmN/ZswgLcI4FrWY7/VomOY0AYyYvDm9pyY64dqkZsUivk2D
	Yc/JDM3+SZ8vFB+uphi/442vX7hdpxn/zKkU4+F/faHBr85EDZQXTuYDyyIhEZyu
	regG5g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp8fu8qq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 01 Sep 2026 16:00:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5fc4c7e9so9328585a.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Sep 2026 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788278450; x=1788883250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s4J8eQJ9hKtkVUcAFRu9iHtJLeOFXzc723DIMlxjsbk=;
        b=RfAWnGfN13dHD+B8s16eZhWjqd2QVIEFG+u4B9PLgOavrBmzxz6RY169EBg9jvLlux
         D9qJ6Ynh1O6NpyuFjIHPIi7dteKdhOR9j7B3Lm5Z3MiqjJ6xrE9JrZ2upgxijnTVNuEp
         cQIoffINLJwNN3t/rlgKYOQ3BpsyVO2BO0TyhPD/V7I6NOrdy5B9ILSKeSWwi3LhswuX
         lh/2uxaxiVfCVVwkG1L4SJuawR0NoPVvU3J7l6qK/NWiWXRWTJwbT+l1aa7ObptRfOKG
         EGy7VBA4gpjGOS0vaiKK8tN1YE60K2+EzYlS2/BpFGnrSlhH65X/EgQQmV+HqEShJfmJ
         83lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278450; x=1788883250;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4J8eQJ9hKtkVUcAFRu9iHtJLeOFXzc723DIMlxjsbk=;
        b=LR+iXO/km/ip/G0N2J2DqOezOaHeS/8mmhOyeBo2lRDyivVc0VajuL8rj9nvFISZGi
         HUW40RDZvyLh340q5PaumFbHFRbpqYD3IfP1MvGZZhzB5BVW0jq37JoLWFSfUC06D7Jq
         0keUC8YhzbCY7HqI7F5KqW8P/VUrhMjaTeJaffGu0+jlF+xqvLqgBxwXPYfH2QflPhAI
         XyHP/B2jKhNXRQ7OxMIw64fte1zGwn/bCOAIwsxwnowd2FJnQfgBbpD/GsPqSlNyPLIq
         wwj2DJUhONIA0vMW6xsXTfnERwHL/XuhDwRcguSIUxo5qp320H1x5ZxRHGzT0fC60knS
         9wfA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8dSDNuAmREfxOCEd8rO2F+WEHCzCj4LeYmE+Dn21qqXGqUaCSTfiFdp0XzL74a0a9IfYYtMKH/KXt@vger.kernel.org
X-Gm-Message-State: AFuF++lRBGv5DgsEb1NksmjmW9cF5c4deHiF3eaxbrXpcWe+4w0hGT2A
	wHhyVtGhBMVQK/+yjopjTjy6bWWURrnyH4zCPK/8O7Qv9J222ZSRB3ZFLqFe01lVdYUWy/UBX3B
	xTsSlxFH0nAf0HG08jRu/t2AbZ1JteWfi4oTMpoak8HNy8kc2QYoJ3n+Bn+gPB/Rm
X-Gm-Gg: AR+sD126/4cPXYjaB0C0SLV7Gxuf7wDZxNhGyOOoXyhhUC5Si5wCwV9M957SYK8VBlR
	CtjPWMm93HgMmiQits7Cc4FWB/wgxbYU3S0Z2anZQsd4cN3gi20y0Py4bjEtzc27pjYoCnerQxv
	feOL73H87rpX3VS2x08jLAdWjMeVByc+eP033bBj9iWa2bhYJrPBSt+YavZSr5Cxe82GnUrFlVg
	tm22IG/q1bg+2AlSGix91zYFFgAE1UJ2C2L8k2GvcuSEX8Ksdk7rUjLhjMysHGYv9STnnkDhn9A
	GH3xgSeyX4oTHpi6D7BF3OuMUzX4R9T83nLfB/MWy2t+fYybCHoWszH4XHO6h4yQ8/cysPb0FHK
	vKstqrXIEMKZqGuhNhxK/8gNWqA==
X-Received: by 2002:a05:620a:6190:b0:936:41fe:2351 with SMTP id af79cd13be357-939138fc2a3mr4281592285a.30.1788278449949;
        Tue, 01 Sep 2026 09:00:49 -0700 (PDT)
X-Received: by 2002:a05:620a:6190:b0:936:41fe:2351 with SMTP id af79cd13be357-939138fc2a3mr4281573085a.30.1788278449321;
        Tue, 01 Sep 2026 09:00:49 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:fd4:cb20:f8d2:dc94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8148fbdsm89484475e9.3.2026.09.01.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:00:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kivan <vaknins33@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
Date: Tue,  1 Sep 2026 18:00:46 +0200
Message-ID: <178827844334.39529.382963115769227795.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821070651.39763-1-vaknins33@gmail.com>
References: <20260821070651.39763-1-vaknins33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2R2I1lhaxA2HI9-UYFDmAYetN6ZNYkQG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0MSBTYWx0ZWRfXwtiuq1ke0144
 8rFklve21L6iCCvrxFsnJI8hnndcuUby2vxHigIm8uaIi0DqI21ThcuROCsslpDHYGRIX0rqyPX
 hvV4RW9YcoPIoeiD7ZUHRFGg2JHYvqI=
X-Proofpoint-ORIG-GUID: 2R2I1lhaxA2HI9-UYFDmAYetN6ZNYkQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0MSBTYWx0ZWRfX7Tk30stY+91V
 RxsqDEji9cgLbQNrX2isA/lJ3zHkC/sc0XRpnRn33E29tJxeg2yu6Q6vfAtSV9EzVJo0Zb/KT+b
 kxwprnqp1EXQJf9z6/5XO+nMQlwcIwKoGuBIjPYE+6wQUz4+sHWMbjsA264K1BCrjtIAx+aTjph
 jeSpisdh/OXsTqoPSYPXtV45CyJNYLONsKdTDr8zBPgMWNvsQ997id7DSJSEzfHITTHjprdD09B
 RtDCmp35ymxM/eyJKDfGz1ys1NQvY/2aFF2vVnDBUU06Jemo8ZEEZGLcQGmwEkMRH0cFIOIyLA0
 dSuWD+V2FYALkkaDXh/X3wf9XJfHyQ2sw9VhZj7uZDVFEMcx40WlP/iKE+2Qiz87e8vgaCDqLSI
 Z732DmkuvsK8m5pKPM2ZNilv5ZJySAXrarPuAjCqSLg5TJbCeBhwfrg+eMAHi/wzofcqky9k9aG
 5TCgndFwJwsotBOaGtw==
X-Authority-Analysis: v=2.4 cv=BPWDalQG c=1 sm=1 tr=0 ts=6a96f6b2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=uIWaOjwd8bGiIQV9JQEA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010141


On Fri, 21 Aug 2026 10:06:50 +0300, Kivan wrote:
> The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
> to stay suspended in s2idle (Modern Standby), prematurely waking
> after 1-3 seconds with 0% hardware sleep achieved.
> 
> In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
> defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
> \_SB.PCI0.GPP3:
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
      https://git.kernel.org/brgl/c/1900b5a41493e7050c68c1e62780d6fb9a209457

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
