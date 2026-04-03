Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89188330D4C
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224330; cv=none; b=Zu+sqJxtE5jHU5o8OLk5w46WuanyL9utTzmaEWj0DaNBuhIfvL7C61eNTP5+ChQkGtaJ9Iq3fe9vbAdsDFBi87SJBLLzE6tkEoG+Ig9RAfloG2jqSlNpwLUj/I8wG/XiNsJBjREIdnzaTUGKhj/L1BaHlmtme4r4euQlP6Xr1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224330; c=relaxed/simple;
	bh=NlWOA6UrBUxPU2ZmL/Aama748Uq244oTOSPRnxCWr80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CnVR4AV7HMBfg6W9jBhO3r0t5S7WroQ7oOtsEZm1bRydc7akB1EFIvAeLqkfMIn9wuhwku5QkMJdZKJGIN9nJLpF4OqSYYR3NX4zdR1dlI1P9/H/I3lbdKtkXHe4BeuoSrW1RYIuZFGwWcYZ1UOc5lYkiw5q4bDfQqXaLcQb/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uy6V79kX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VEu5G6pI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uy6V79kX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEu5G6pI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633BMcJK982208
	for <linux-acpi@vger.kernel.org>; Fri, 3 Apr 2026 13:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Jncd9S+sPgUnlMtnW1kBhI
	3ZQuWK02IAKrgbnLxtzqw=; b=Uy6V79kXpcuITgY8AQLFAO2QboAK3c6Ukc/jNq
	NNS1GhOkUrLZqRV/4L2c7Vj8CccSup7x21tx3YhNiBscrNeZK8//eLN8mS84JxW5
	mqvy6cXLwX2bTAd7jplLELf7jLFC7eYofCrrQeNd1ko0TPkcxyChjCcBBU20UJvE
	VXHj9zDVFghxgk8bzolx593Un0nygJQk4p2fItgmLfJnYF2CDupCHB4iaBtXU/6p
	rF87apN4QKkethSsvEsROoBKqxrMsLr+cfBksUjnlb0kXro6O881/lvKBtYBUoYH
	7T1z8Vnw6nCxax+YX80pSfPNfBZMN8gSeJIJqPce9bvMlnjg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9tupuqtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2026 13:52:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4076dc16so83271401cf.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2026 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775224324; x=1775829124; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jncd9S+sPgUnlMtnW1kBhI3ZQuWK02IAKrgbnLxtzqw=;
        b=VEu5G6pIXUbsu943laVERkpJezzcbWyJN8A4VDEZ18wNrVKXGH+I0L2J+VgaueVr7s
         k+xqUQdNtmlYaT5m1F5J8nSgWZrmaHj+DHEUtpBWkHooXV0+uUclr7lszRl7ZT7ibqfI
         affi+D2eVf4F/bUGwPLFKLzdMVvvz0ZQQAx/M2t2LH2Gcg88BvNv26u08qirzpYobRkM
         rh2bqRLGhTnG+VxSLehcSiNgrGRkgy4qtk3VkM2cKzuxCpUAuV1NKBknakVUuKddSQ87
         tIXJVTb45WdCx5n3SdbLUgtSVne3zSRmmWwLcpcwamD33XJ2fsfgxv7il8vpvkERj7kI
         qFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224324; x=1775829124;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jncd9S+sPgUnlMtnW1kBhI3ZQuWK02IAKrgbnLxtzqw=;
        b=NTRr4v9RNaiXy4InpjyHQFEZ4p2bpDwXw6QxjiA4IZuteRsX1kMx6HMssCm5wocQuG
         wwd+Ek1gewkucrfDp9bWk3gkZBCTjc3UdVb7ZTmhVe8UrsHRLC5C8M33w3ofXJ2oFo0g
         jH/4fuVYH9tSYb0KQuwHNW9MgrqwiTTpItBJMdHPxHSNiTKacS1T+54iIyozOWNfecJL
         BP0Et9p/2uhN/l0VlvZLp+F6BEUYHFIiUBH+WNVP0jORk3XarYjR+fVpbUeL/QF5gHkK
         nl84X/LHqCYvINHijNi5IzmeOzdu+bMwO5TAxSiEMCLeWiz8o8E1SkZYF32MDW3typki
         +s5g==
X-Gm-Message-State: AOJu0YzZia9VYHqmTYh2dzBmoatJE+WNb3FvuZlyNvwiukeXHPzIE30k
	l/k4lNx/keBIk0z3F2E9QzEYGe6s9KK3diMey9RsQST8tCBuiY0Kw3JY0VqSlWeMEdVLPUbNMMF
	D6K91TgvdhsGuoTRDOY9RHC8zx9nHIfb6L1AVjZd9vW41gzVYmSxp6J5iFCC9LTfU8ZJLo7q6
X-Gm-Gg: ATEYQzygIcWxy73FcKBctIiNK8eGTBnFC02jWVwAxd7Jas9XfhDPHWFyHxOHVDCp5ZP
	iEulW+EcEIRbOiyBCkkADTEGdPFtWYLTL+/+vm+/mBcu7dORKkNp/MHsWOnjO2f6d4GSdN9XG6q
	+imK2AKtEW0f4hrisJmfmo/6fL4d8ocDEtB3+fF+U9YVF5Ccl3Z1qhK9KumE/by4o4KSpj7geE6
	1mwoIk6jaSp6Kynr5IG/D+Qn+eQ6PDyztFn0VU8Wm2r18LSutUDU8x32HyXcIsvHsYOWmV0Mx8J
	To9uMXlyuJGeqDwq/M7E4gBXRR9KNDiMP75rnrIkSHm4VsT7t7W4IkF+uDLjfJ9ECcS7m8GkWEn
	zM/W+ehXnBn8z2Emz5wGEEXUj+ED4MX6HRBJSAGVDujHfk/fqLPFW
X-Received: by 2002:a05:622a:260f:b0:509:2448:410 with SMTP id d75a77b69052e-50d62ae8458mr42937841cf.47.1775224323932;
        Fri, 03 Apr 2026 06:52:03 -0700 (PDT)
X-Received: by 2002:a05:622a:260f:b0:509:2448:410 with SMTP id d75a77b69052e-50d62ae8458mr42937351cf.47.1775224323446;
        Fri, 03 Apr 2026 06:52:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:129d:59e8:f7c9:47ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm16948132f8f.21.2026.04.03.06.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:52:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3 0/2] driver core: make references to unregistered
 software nodes a special case
Date: Fri, 03 Apr 2026 15:51:49 +0200
Message-Id: <20260403-swnode-unreg-retcode-v3-0-7886092b28b4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXFz2kC/x3MSw5AMBRG4a3IHWvStAi2IgbKjzspufVKxN6V4
 Tc456YAYQSqk5sEBwdefIRNE+rnzk9QPEST0abQmbYqnH4ZoHYvmJRg6z/Z0uWuMuicKSmmq2D
 k69827fO8EvG3YWYAAAA=
X-Change-ID: 20260403-swnode-unreg-retcode-38b5b92eab28
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NlWOA6UrBUxPU2ZmL/Aama748Uq244oTOSPRnxCWr80=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpz8X6M2qYjAHwaPwqmT/pp9+4mIAqzXsPY+bba
 kOFCo306GSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac/F+gAKCRAFnS7L/zaE
 w1LuEACh3O8artkXQUwfvuuCLjG5ktBfI+U8MJhhKQCCBPkRGQnZ6rphdma2YLCZHXYMRx7G27i
 GV8ZdKW+/q+QQ6h3mgev46ldzgTc5MKF5STbxlMc96ctIr352g7BhqKNc2az2ItE/YuTLTbGFe3
 q+c7VXV8xoD3e1AZR9nEvGZd1rPnx3SvAf0MGNUHebfG7umL/jlHx5JGPBdHdxJ2ogP+rCW3Tc0
 ftLLcX+fC/2oWOM+b3lfwz/Lxps/oe06HmPUwDVcUeotQjSNBUVGOmp9ysbHka0LQYUGfe1MC7s
 6lyO8m6wx02afdnNLPFDAq/9QuBm80TIPT6OQLJiEVcqs8UE+z/hAsLaJj8IHaLxQy9N7iS8VLR
 8q3yE54xuM0fomeiy5yFI76SYHYXIMB9vajE0cDyilOuKapYBF8QXzwxIAqojSqJkKdAEoucHeD
 pV+DXYZNsHo/2ePt1/SF0mEvlNFgKj6h/qeNYC+ttJWVgsha5zvj7dRGe09z0L7oMsXfOYJWnLS
 /zdwt6KHQvf+Wj/zLpWz7DDc2It9cspD//3kDzP0AlKnZ2cn4vfjh8c7qMp6CSY4mEImYBbfJ8C
 kk5t40EMKxz0CI5BdkSm8J/g1o+stvJgX+6p3lXxW+4e68ZEjWL4LpXJZPrl/lH1yijL82eTFsd
 po+o2jNh6+zmkog==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyMyBTYWx0ZWRfX/mQXG2AF3gFU
 oCnuC0hkXT1Mrz28GyT+ylS0oSkYeyJg/aP4pIX5B+7WSDLJkg3/Tt6v9jB+QmJm4t7pfmAYU9+
 ffuqtj4xHqRmo7nzeweQ5uRECPcNI0aInj+jYNm7fxStQQVxZTUTXGKoNcfoMD8qMVoluIrEJV1
 xahFooxAgjCN0Zks2ZnZW68Qmm+v+m20AL/ChFWzXE0Jord4g61pIyitMaRSTdH+5cdnmcQ5RRp
 q7DE+TASEfEdf3QYHVfXH+9DlN5/usGcnq7BVdXrlozlI36KFgsAImuOD6WKFp2EE0+t+U7Jz15
 TnasVQ+eNMPaC/8pUzkyD2I47/oG/2Incgn1I+C8LAIwYmHx7GvNbO6960ZVUbMJ0i2oVPbM95T
 ISMGq2lQeuqOgo3dJsSfJkln41crDehPghqnrdVyfHOdmTWYKZdRqEAHfA5HCcQjscrsmn+a+KZ
 NFrcbRFqvut96ri3fTQ==
X-Proofpoint-ORIG-GUID: Knyxu6cnIWi0sxLLZGAXsYOBsMRNVvZV
X-Proofpoint-GUID: Knyxu6cnIWi0sxLLZGAXsYOBsMRNVvZV
X-Authority-Analysis: v=2.4 cv=DZ0aa/tW c=1 sm=1 tr=0 ts=69cfc605 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=h3m_6F4IQ1uC9WK5d8AA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030123

I spun this out of the bigger series (see: link to v2) in hopes that we
can get it in for v7.1 and make follow-up development easier next cycle.

This series proposes to make unregistered software nodes (ones that have
an address but which have not been passed to software_node_register()
yet) a special case with its dedicated error number. This will allow
subsystems to defer probe as if it was a firmware node not backed by
a device yet.

This is done in order to allow easier attaching of software nodes to
GPIO controllers and the removal of current label name matching against
the software node's name.

The patches can be picked up independently into driver core and GPIO
trees.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v3:
- Drop x86 changes from the series (will be resubmitted later)
- Use -ENOTCONN instead of -ENXIO to indicate unregistered software
  nodes
- Fix retval check logic in gpiolib-swnode
- Link to v2: https://patch.msgid.link/20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com

Changes in v2:
- Completely new approach
- Keep the cherryview and baytrail secondary fwnode handling as a
  driver-specific quirk for x86 tablets and don't introduce any new API
- Change the return value when resolving a reference to an unregistered
  software node and defer probe in GPIOLIB in that situation
- Export acpi_bus_type for use in x86-android-tablets
- Link to v1: https://patch.msgid.link/20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com

---
Bartosz Golaszewski (2):
      software node: return -ENOTCONN when referenced swnode is not registered yet
      gpio: swnode: defer probe on references to unregistered software nodes

 drivers/base/swnode.c         |  2 +-
 drivers/gpio/gpiolib-swnode.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)
---
base-commit: cc13002a9f984d37906e9476f3e532a8cdd126f5
change-id: 20260403-swnode-unreg-retcode-38b5b92eab28

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

