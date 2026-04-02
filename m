Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF93E3C58
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139322; cv=none; b=YrufOH/hGS76ofz/0UjVnYo1kczUkzPEJVDOezk1zn1ASXU/gUuTguJm+lYj0du3dwhFCerQF46Jhiv+9/yLQz+z1CY6Dba7jV9QUNctQjaK20FZAgQswQyy6xKb3lijGdmq6cTbv/mQluOPLsnhHicARY/dSPE0+iiuqUNAtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139322; c=relaxed/simple;
	bh=9xHP9YGJtqo9V/BvuF1Xk3Wt1TALDLTxAhAxwgZviEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ixg4AJBLljHBe1LPBLbbLmcMX4b/56w7AfwPomIz1+wShOIuqDbtCMpcX4nyxScwigtdPOVj83GnsRbFl+2/3koHWJzpXlK5p6bBbP/aSQgpbTi2UBIUQW37rDwEwdAP/Qi6NeSsA2psvUWfy/wvb+ZA/tp1f62q+CpTJGDX+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VMfUXqfE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BO2UsRsu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VMfUXqfE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BO2UsRsu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BlJ7d2337948
	for <linux-acpi@vger.kernel.org>; Thu, 2 Apr 2026 14:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I0iEYnM6TxpFjlb6DDopS2
	eLno0oaG8tAIZJH9RCSIc=; b=VMfUXqfEvL1i05v9ML1s09gEgzAP8RxxtyO0GR
	PbaWK6ex2ZXp4fX9pnyChWWI5ch0d3wSZb7Sg4H8+D9yUJ1dD4iv2HZJVKOyiyvR
	dWbzTl35sh18TTuk9fhAl3F88y7Q6ZDomkjzYPiLjMLwgC0afQoPeQ2wCU30ysBz
	BHa6PLsM/2mlEpORmwLwQCtX43DYgaT4OEUbyhVXFh70asqmwERtsSnw97QUGv2a
	+o8G+GZrcQZzgUDZG7oABwbqQU+8LzwG+dHeOq5TciIXJTNyN9qy4lGSBcZi7SHG
	J2+V8SIDyGQehrSL9uKLW9uevE+ocum0dLc02mderrSyyZrg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qw08mja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 14:15:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b802961ecso10259761cf.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775139319; x=1775744119; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0iEYnM6TxpFjlb6DDopS2eLno0oaG8tAIZJH9RCSIc=;
        b=BO2UsRsu5KRQ6rZ2pIxkxBw/ve4+c+CyyTsNv6M4ivu2f5IDRtzxkIRwO1B332eLF0
         mfNFUnrj1Ln1n9WpBKG+svEBVcAWia29ix3gGr33uyDSIjfAnhixOjVp1exmbwtXqIOP
         VjfO+YsgACvDssAeoikj6daq0EuKHFhgk74jgBslvsS2PpuvpS8V2WBgv0rvEJL1PLA+
         54oqhPk/HPG83vgXf5FWB/KReDM5FteHytApfk6XoxmTwhQQ3uHe3ClGGUyqcOkQfY9C
         uO27egWiTCUFjSOtC4XC+aTVJ6Y7ipYqM292WWPOFJiT5imvBnk7KQnSRionu8TZaeGM
         u09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139319; x=1775744119;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0iEYnM6TxpFjlb6DDopS2eLno0oaG8tAIZJH9RCSIc=;
        b=r5XVoHCDv+3SVCV8zB3gGlq6xnBMJaUbh2C/TqQV7C5f0DW/KcGFPocERBl4WKBo7t
         QVJzqKhNltnANjMQo11YPS0IWlI0zkd2ewD7Eg0CWBPUcrgilRkwf3ksaiz2ItG0B1K0
         dVijmS5Z6fqYSX8LNjW82/ReLNSgKzdb4l5wiM+yZdNdsoEmAzoW2jYNuq1niD9n/6Jp
         iUCD5zzI3XLViw6nurCCMay2yne2wontsTLi9U2WcawTl6pDEuD5OiFch6SVZKIBzj4Y
         Z80Ff1+Jww9aUrbrlfgnO7HvbixfJRTZaW2SlATgXOHbnFvxxmehYmkCV+XwDZgN34Mp
         Ocog==
X-Forwarded-Encrypted: i=1; AJvYcCXkixP+sWtBKHPhZcIsB6j9kwTYioV/+aHQeRzx7ZNwIavDi7WOfBj4Gc2YfyTpe8DMCM1w21+73xrw@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYpjM5PPHxlifnQ/3uk+tQZiPhav931/ZILPI04Bw8dJqugjz
	hJlhKwX03sBfVp2dl7d7vwYDn4WO+jGWJ4s4RAI90DW/Xs0jk/tru/jV/oa6F7s15ZeiqvWN5fS
	jFSUxa1UMZwSJEn9XoRGqKSkK3FLUvvcBm0762EKvyQpsBtvmbz9Mm0Lwq0f+FF9o
X-Gm-Gg: ATEYQzwtV22UAJav+Wuw7KGOZ5kLd5f7+OkUegsc6Oylo21hWWEz5d//XsGRy6O6bfW
	DYCBfKkg/tkbGNLw72Aq4z7NPwM6Ag0W1gib1qNBQF1Y3j0xSIzhaBaWzaatbIkL9bImCKFlF1m
	wfWOKQjcKeVCOh1eJfp/n7FYggRuSl8RggaTnImEH0au6XbktPXfe5gZzz42PIMH5X8zhYYw1pI
	p3bh6RNzqAuvglS++486atoKjMQWGoCDRwua6mJVhEGywIL8g69RaW6B9bGaS0MPWHJE+akiyxw
	fvAOEM2Pty2058uavEgR/DZQhSH64Lv5SjjqE/s5n6oUXxH7i8eX1fEolTFMwo7xg6/HMVDuv7b
	pl/uFKD5+nPqRKCQ4ktQ4xMFEgDSQkPU7OjNiaTvRnPs1y+2oKsKp
X-Received: by 2002:ac8:5a91:0:b0:50b:5056:fcc4 with SMTP id d75a77b69052e-50d3bb92f71mr104570981cf.4.1775139318320;
        Thu, 02 Apr 2026 07:15:18 -0700 (PDT)
X-Received: by 2002:ac8:5a91:0:b0:50b:5056:fcc4 with SMTP id d75a77b69052e-50d3bb92f71mr104568721cf.4.1775139316950;
        Thu, 02 Apr 2026 07:15:16 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm192824885e9.1.2026.04.02.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:15:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 0/4] ARM: omap1: use real firmware node lookup for GPIOs
 on Nokia 770
Date: Thu, 02 Apr 2026 16:15:01 +0200
Message-Id: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOV5zmkC/4WNQQ6CMBBFr0K6dkhDKQVX3sOwKHSEidJiR1FDu
 LuVC7j5yfvJf38VjJGQxTFbRcSFmIJPoA+Z6EfrBwRyiUUhi0oqJcGHK1ljJAwzBeCXDw4ZtLN
 1Z5VuygpF2s4RL/Tevec28Uj8CPGz3yzlr/1nXEqQ0FW1bgpsjHHyFJjz+9Pe+jBNeQrRbtv2B
 eDGddLBAAAA
X-Change-ID: 20260330-nokia770-gpio-swnodes-5da8ba35946e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9xHP9YGJtqo9V/BvuF1Xk3Wt1TALDLTxAhAxwgZviEQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpznnpgbWuE8PB92kyk7oxM0EhrfC9uGBqdWjbK
 5/AVS9z4L6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac556QAKCRAFnS7L/zaE
 wxWDEACXpxQ47yMXyNOUQwCxOnke7iYT5ZQOnqkVVZvzIPH/rpFUqujwJTR6i77GBhHklwMd76n
 nz0VXCWCxBstpkby2i801FON5C1se1aityaTE0UexGxIDX6a7UlDqNJfpwgkyWNdGXm/bhOawr5
 Gt5aQZHe9u0bHKJf6Ocv5YdO/ATOtNygibon8PvTR43Bu1iynN3LWQH2I29xPtQfSTPf5eYtzef
 4CtWkr1jd8ZqLnth3r4J1T68um/z3XHqjl59apZ4/gdQh9EXsx1pJTYwrwdIt5RZ4l5ezVnpDWa
 Wrg4S3WMXyWmKmJP+XPoZkzKIcSImHJqA1Qm5Q4Tq2Do0G46aRg8WPiSIOsqjX7WByQ/gBEqMDN
 WKvH8saFlplZ05ZJ7TVQKwRxBKHMhRzq0QdullzLHCnEJ3tT85P7P4Du9Zl8TKbWZWmKiXny1qw
 a7p1JALeRLwCRDbgDVY+ZPhblU3YF5s7AmgkX5UOxZMhvOxZSwyPtvneHGZs66I5Q0S3qS9tH7R
 aT/AcxEeqJZHS96PIYfpFFkFYl0yb9WrxZh5E2tu3Cl1AqPJ04bO4UVKuHbtXm+LvMgp5Dy09jm
 PlR1ufRVBI7A7QanvZfKMEz6Y+EcB88mzBac88+prWUsCZT7PpV00MHuHH/11UE3KZURkZDNdF9
 6tH4XwQ8V4izhbw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEyOSBTYWx0ZWRfXxQN+xLC9ZjtU
 HoRAZwh0uxvpgbH7R6CU13NMSP71Jkvq+Cq2Se0QJmXrPhS/D0Wd3CSFkrNV9QczCjQbYH6vV/d
 HZKIsZdftGVxabsgIhPxbOh+iPuHJFhD2e+1158smPf+T4EfQBaixMPjNn+02HbX7LmS5TPgRGJ
 H8RTryY2leK6Vy+iogqRP8lX1DZxA0jkw9eIvs/2E3ao/FYDRG1b1uNVSqeTvQFWhxkjDttxoGC
 y0g+aBoO5lPk+dYEEV8zpfZlKOUnIDARSD6VNaPqx5aXFAVkhlz6YPxtkAn666u1BupePoFAdxl
 JpVzk7UXe+b4kNwYMw3gR8UgCBKTe7b/wKW/ugUykC+b6zKPLGXFgOHag9bRErHqwLU32vw9nf8
 QdDOWV5Pxibg/W07fCJKfiGftanJ7tXD669nmBc3DctIf294ZPXgYY1EvilNL+AQ6z4qOmPxGTJ
 M9k16vDi36R+vyIf3TA==
X-Authority-Analysis: v=2.4 cv=PNICOPqC c=1 sm=1 tr=0 ts=69ce79f8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=WeWpliTHXVVyQaQyHOwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: ew7Y1CUspZIzRNHqsdpxMAWettmS4SrV
X-Proofpoint-ORIG-GUID: ew7Y1CUspZIzRNHqsdpxMAWettmS4SrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020129

Mergin strategy: It would be awesome if patches 1-3 could make v7.1
through the driver core tree after which the final patch could go
through ARM-SoC separately in v7.2.

This converts Nokia 770 to using real firmware node lookup for GPIOs by
attaching the software nodes describing GPIO controllers to their target
devices.

As determined by Aaro's testing, both omap16xx_gpio_init() and
software_node_init() run in postcore_initcall() so we need to make
software nodes available earlier hence the new patches in v4.

Please note that while the goal of this series is to allow Nokia 770 to
use software nodes earlier, we're not modifying core kernel code just to
accomodate an old ARM platform - more such conversions are coming up so
the change will be useful to more consumers of the software node API.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v5:
- Put ksysfs_init() in a separate new header
- Remove software_node_exit() in a separate patch
- Link to v4: https://patch.msgid.link/20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com

Changes in v4:
- Add patches making software nodes available earlier
- Remove stray newline
- Link to v3: https://lore.kernel.org/all/20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com/

Changes in v3:
- fix references to the MPU node

Changes in v2:
- fix build with CONFIG_I2C_CBUS_GPIO
- only export the two symbols that are actually required by the nokia
  board file

---
Bartosz Golaszewski (4):
      kernel: ksysfs: initialize kernel_kobj earlier
      software node: remove software_node_exit()
      driver core: make software nodes available earlier
      ARM: omap1: enable real software node lookup of GPIOs on Nokia 770

 MAINTAINERS                          |  1 +
 arch/arm/mach-omap1/board-nokia770.c | 30 +++++-------------------------
 arch/arm/mach-omap1/common.h         |  3 +++
 arch/arm/mach-omap1/gpio16xx.c       | 28 +++++++++++++++++++++++++++-
 drivers/base/base.h                  |  1 +
 drivers/base/init.c                  |  1 +
 drivers/base/swnode.c                | 13 ++-----------
 include/linux/ksysfs.h               |  8 ++++++++
 init/main.c                          |  2 ++
 kernel/ksysfs.c                      |  9 ++++-----
 10 files changed, 54 insertions(+), 42 deletions(-)
---
base-commit: bd0f139e5fc11182777b81cefc3893ea508544ec
change-id: 20260330-nokia770-gpio-swnodes-5da8ba35946e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

