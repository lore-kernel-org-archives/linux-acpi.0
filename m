Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB63FCC
	for <linux-acpi@vger.kernel.org>; Mon,  4 May 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892356; cv=none; b=Ab6KbbA5CQsapVwgnPq9sEDUJXSFydERecXcTwKdWRd9PJeEsAxQ3rBArOxI9eUGpoPwfvZ149DKv/JDF7ijfA0Xry3v4orgxbM9t0OG3wtO1QSoCykmS1QVEgYhPp/5ozjV/QJrC837NOUPAEHuJ6NmVi5LzanQwQ+feumTzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892356; c=relaxed/simple;
	bh=GeuwkKmozEXjhOSGYCTl0B+YpFwHa9j+X8dOyTudOQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IVKjZ4RiBYAVGm7z7qgASoQcEhs1vYR9PvuITh8bzJyACp+oXOK0kEWsg2sM2L6BjnU8NfVg5760XTiLg4RlzsEd5aE5Ti8W1gqRD/W2rBWOuXf4YwgG/6BQ+BG0ZHfn9f15l5RCx29QkxFpIEy7ImJALkz7tyYdxr46vt2Apb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oj6RBsZg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DDB5LbIl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oj6RBsZg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DDB5LbIl"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fIgS3824038
	for <linux-acpi@vger.kernel.org>; Mon, 4 May 2026 10:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4tPK9/9PrhrR5/3nqyIB4Y
	/UqkEl2w9g31g3wcJI37g=; b=Oj6RBsZgyiSVHBLzxFsTEujDwR/xeyrC0ksPbS
	KxLiAzbtk4PVlDIPCjxE1D45PJv6BtqfCcjWYJK7TuFVxKGneAVf/FQpmWsS2e5K
	4lpLC4E0uw2XMNirb7ekNGCwSk1e+YdN83Iftesx26rQdJ8WXBWchK+jKy5kH+k2
	rmmRt30dYNYevyh6KEJh6pZ3LlWtqLZA/HvDN/1oY6nLuGcCDS+ULL8K4O4QDIzb
	K+qiqQVhjgG47x45+BXL2Hw9Yoxosl9/rhnXfI6tinkt0bMqU7nMTyqA2nNsYK2R
	3AlACs7BDGILTYQkS9lFHerVj6A0QaR0u29nT8vpUz7Sq+xQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9g3ndbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 04 May 2026 10:59:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e2592ea3bso38289711cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2026 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777892353; x=1778497153; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4tPK9/9PrhrR5/3nqyIB4Y/UqkEl2w9g31g3wcJI37g=;
        b=DDB5LbIlrRB/x5fEGirnReER1vlY8zBVGAlGmK/Liefkd5IVbLCqO6zLuLxLeQqB6F
         C218vHdYCMxRxYz9CN4iX5a5RVyKDpOa5CGbNoOJxLsPqlGU72LKJzjvTyHm8PzY3MFD
         VVBrPKWfUkDAL138pZMZgB78V2uqDhULJ5st2mgktp2jkwyKLOHi+hbi0MSu86F47SRy
         VET2rOOxQcLnwT9P26hmsVrgcIx/Si0dJZCo5Q3/2xlAqiJf49u6BNQ8BCYLuVF4LHhC
         HOsFP7n7kgHOgvN/A7gN4dTD0RddpCfDwoS4EyfpW8aX43uBM1rlMSaK0xLIdGGpvsb0
         gwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777892353; x=1778497153;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tPK9/9PrhrR5/3nqyIB4Y/UqkEl2w9g31g3wcJI37g=;
        b=AlnJtbgNC3vllpuRG1FpGUVeR9LeWGPHSij7fnDcGY48vwS0sZcEhlivzDvulcK0ca
         Jbvm5UX3w8+ioMF3TwvJLN29pBpBgVC6ivduz1QfeEmIm21SSEo+hjp7Mio1xZ5qbFjV
         ZEPwR9JnDCduYLwSACuMaRmTho8dwZIDTezicEv3SMDCtZ7qWsb4/9Xk4aVRQlpnWq1v
         Fjlb4TOroEBkiuJ/AJGv2ozLJ0JZOOv93wPMTEJ/SJhMgo07gQHPsRBf3ZmbYAGhDBmS
         9Pfaj5kf9YO8nWg6PLlkZI4/wlHX1cFap7Gu+vzFzuRKRGasK5RpUJLwuFuv3hpNxNLF
         zJpg==
X-Gm-Message-State: AOJu0YwzzcVBtq5NQImLi3Qz7QJ/1ne3tgSNjnq4gfr/2DF/AryO4suG
	D/NT0luJuolmK2hJM/xNHCnZK+DK1KMXOo3dpsIAz2vzQlyfAiJnCJt8keIDOnnOvUyL7aJvD6d
	y9LVqlLPsazl7R2oUOQ1exPPdtEuqUOaLn/TGYQwDF8OuuujQZuik1sVUizMdXshy
X-Gm-Gg: AeBDieueqROXYVEPMFkwXBQqtNUAdcGkBqc1VsLBYKq/+wVZtOiZ0/KOM7+vwzYFN8J
	/QZ2vXZyHOyO/OM2juUvRoznbSP62TKsNKSLxNOqHxQgmUZjzYwr4hbhIituwXuwRTxQj2cnxGE
	F6IPuuTowas6nlnuSMseQMpSRXgzq8m+FrRONxZ94cjKCUx2FtjlAp2a0YmC/oXpjMOIE6G1l1R
	R3cq8fvnSdS+3PYyQwXX9pyLjmpGweyd6lRBfqjQPNSegou0y9VyOOfbH7MCL4mE7tcp74lwOCo
	gpGdwfXqpH5oEILmcWPv25yzh2OMf9wHEXwNOgzxz/G9krshctIRa+wFMURcvnZT/Udmb7E9Jve
	xsoWAM3hR2VXr39fyL8nHY1FQ677CTRqK0d7pUeKMSFHtz0X16A6exHuGz98ZXQ==
X-Received: by 2002:a05:622a:13cf:b0:50b:1e5d:992b with SMTP id d75a77b69052e-5104c15bca1mr130483251cf.54.1777892353130;
        Mon, 04 May 2026 03:59:13 -0700 (PDT)
X-Received: by 2002:a05:622a:13cf:b0:50b:1e5d:992b with SMTP id d75a77b69052e-5104c15bca1mr130482731cf.54.1777892352563;
        Mon, 04 May 2026 03:59:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:56cb:50e1:b507:63d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm474728135e9.1.2026.05.04.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:59:11 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 0/2] platform/x86: x86-android-tablets: use real
 firmware node references with intel drivers
Date: Mon, 04 May 2026 12:58:55 +0200
Message-Id: <20260504-baytrail-real-swnode-v5-0-c7878b69e383@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO97+GkC/4XPwW7CMAwG4FdBOS/ITdK4cNp7TBxM6oxIpYEEu
 iHUdyflAodFu1j6Lfmz/rvInAJnsV3dReIp5BDHEtqPlXAHGr9Zhr5koUBZ0M1G7ul2SRQGmZg
 GmX/G2LPEnpF0h+CxE+X0lNiH3yf7tSv5EPIlptvzy9Qs23/AqZEgsfVKWUNsNv4z5rw+X2lw8
 XhclyEWd1Ivy4CqWKpY1rfQGjLOAVYs/WYprFi6WACg2bgGoXMVy7xZGiqWWTpa3LuerLX4V8d
 5nh/WBKtzowEAAA==
X-Change-ID: 20260319-baytrail-real-swnode-7de7a3870f78
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4351;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GeuwkKmozEXjhOSGYCTl0B+YpFwHa9j+X8dOyTudOQc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp+Hv3kfn9q3KLtlCm3fn11mOqUrE7q+1UTfRCU
 lgfgXAFan6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCafh79wAKCRAFnS7L/zaE
 w16rEACxZPHTuVyvPShATd3lcVT/leZP/rXZFhzEUi52xDze3Bbkzj6+1mWA4uLzzF+EYPs7WWH
 sx6n+kV4Kjow5+KNnsxVvMNBafH4h0xtZ2toUrzaBg0sG3Stys8hNyiTsR9wDsUiydJdHr/WnAK
 Hfs9crQeLDjh+pZekxDdwhFGeLhvNTN9jxqEAb25PZOvAJPDg7MQecn4qZhRpVyMh9PNhhMBv0p
 Hpttf5qmFZ5u1qNx/vLQMiuiEYURmL3o8Gt7xRgUiTODpoAAiggy1vRjK2vqfVeO/zwzNqqm4d7
 uS8RTn1c5r3AVEbeiAAQ9SU3A6lvbQh9CgicZt+U7lNR7UsXDzPXZcnuYVfyTPCoh0Kip1g/PNR
 sZaFsDso0fT1AJal0y+89mY4x5ycWyMvOHVKYI58qIC4WKpp6KIIfFmCC+kInz2BJ8uO6JWQFfj
 7MsxYUR7GYWg/m7SstGa44ZYLDXPSNfSvncyzYrpUHiVDEmmS2V879gXx3vA+aApuVcjOAxNujP
 q7bahQLtxxcYuE7kqo9xrYf23B8Msmjq1kRtxIbctZ6QazZFZ/Md9KcueeEiZz0P3TaZ45iAvI6
 qfRnmaFwbavDNS+WZ9xNItobM8JA/ubnD/EN96cWV4/LJOOVUluFgI2qHvvXm2CTCSb4sSAmGrK
 j3tPfeBXOmKs3bw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDExNiBTYWx0ZWRfXwBAUueVWQPUH
 ejRxKzxTyIPLRHmh//qSlklCkKOd2WlgDu9x3a2d26ALqUzErBhTCwuZkutjOpHg6/FZGPUoPnu
 cEu3gN8yx1scxmdBf8a4xwnavNIr8tUnZHQ3ubOmRKieVPEzn+JVYpAHmYRZDrLlRUcYwnDHLAa
 L7INka31YwU2xC5kXdxUQJwN+cGhFvmu2hUrO+iZd7ruUTpyLejmhxDVrZbpjNuwVPf9EfFhfp9
 kGdf2Af8wH2Z6nyleF+SPKGNi7nIO3D8B1M39SF2UD67GDvyIOkE240YqM7R/6hZHeX7lFpm/M6
 20tmtCvYuHL9jP/guuHeJzWRIFND5AjSqciOovlz3cFeMe2hwt3w2U0j3I1aPk020Lb/FJvxONx
 oq87onW7JpQWVdzBY682jAF6T7HLXeCbPzj+MJ/b/dArlEHSFypJCuXYgOk8z0PuwcsGAa37BdN
 3OV+tWlCZloH0LQhmjA==
X-Proofpoint-GUID: BW85poPViUCgPL-wlb_DF0u3AACNbDuF
X-Authority-Analysis: v=2.4 cv=Ge4nWwXL c=1 sm=1 tr=0 ts=69f87c02 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=_-RKUVJSXb7bi1SkcEYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: BW85poPViUCgPL-wlb_DF0u3AACNbDuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040116

First let me repeat the problem statement:

==

GPIO software node lookup should rely exclusively on matching the
addresses of the referenced firmware nodes. I tried to enforce it with
commit e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the
key for GPIO lookup") but it broke existing users who abuse the software
node mechanism by creating "dummy" software nodes named after the device
they want to get GPIOs from but never attaching them to the actual GPIO
devices. They rely on the current behavior of GPIOLIB where it will match
the label of the GPIO controller against the name of the software node
and does not require a true link.

x86-android-tablets driver is one of the abusers in that it creates
dummy software nodes for baytrail and cherryview GPIO controllers but
they don't really reference these devices. Before we can reapply
e5d527be7e69 and support matching by fwnode address exclusively, we need
to convert all the users to using actual fwnode references.

==

Now for the new approach:

Now with the recent patches I sent or plan to send out, it turns out
that almost all existing users of software node lookup can easily have
the software node's representing the GPIO controllers attached to their
target devices as their primary firmware node. The remaining complex
cases are: pcengines-apuv2 and geode-common but in the first case we
have control over the creation of the GPIO device - we can assign it a
firmware node - and in the second case, we deal with an MFD driver so
can export the cell's software node in a header.

The only remaining use-case where we need to reference a GPIO controller
described in ACPI from a software node is the x86-android-tablets
driver. In this case, I think it no longer makes sense to propose a new
generic interface. Instead, I'd like to propose to keep it as a
driver-specific quirk.

This series proposes the following changes:
1. Provide acpi_bus_find_device_by_name() for looking up ACPI devices.
2. Implement support for dynamic assignment of secondary firmware nodes
in the x86-android-tablets driver. More details on how it's approached
are in the relevant commit message.

The dependencies in driver core and GPIOLIB are already upstream.

Merging strategy: Both patches should go through the X86 platform tree
with an Ack from Rafael.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v5:
- Mention the responsibility of the caller to call put_device() on the
  object returned by acpi_bus_find_device_by_name()
- Use set_secondary_fwnode() instead of hand-coding it
- Link to v4: https://patch.msgid.link/20260430-baytrail-real-swnode-v4-0-767bcda6667f@oss.qualcomm.com

Changes in v4:
- As pointed out by Hans: we don't need the notifier logic so replace
  patch 1/2 with another, providing an ACPI helper for locating devices
  by name and simplify patch 2/2
- Link to v3: https://patch.msgid.link/20260427-baytrail-real-swnode-v3-0-0003e4c1708c@oss.qualcomm.com

Changes in v3:
- Drop dependencies that got upstream for v7.1
- Rebase on top of v7.1-rc1
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
      ACPI: provide acpi_bus_find_device_by_name()
      platform/x86: x86-android-tablets: enable fwnode matching of GPIO chips

 drivers/acpi/bus.c                              | 15 ++++++
 drivers/platform/x86/x86-android-tablets/core.c | 63 +++++++++++++++++++++++--
 include/linux/acpi.h                            |  7 +++
 3 files changed, 82 insertions(+), 3 deletions(-)
---
base-commit: 085f14acda1c46ab815605ecf2341afe5a691eb9
change-id: 20260319-baytrail-real-swnode-7de7a3870f78

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

