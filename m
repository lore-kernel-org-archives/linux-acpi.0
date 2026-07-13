Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1C38910D
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941318; cv=none; b=X46aNpI+3I1b3MCUmIahvnulyoSblC45s6/xXBpPYtQYyQ88+pZGY2KWCM6v2/77AB4dhH3Ze4GZplLqq5VY5eTjtRyQSu2NuaHJsNFVBk1KNJdr9kFts6U25NZVyA5O9hiGcwd2G92/Z2kGgPeh/dtLdSNtPnmOLOdRbdmMolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941318; c=relaxed/simple;
	bh=VYz0TYRwzOI7K0hlO+3u24CfmURLK/h7puPMYIu7DoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrpXO8pj/IrtXg7NQ+A3QYupQlKDIpHFBKWw+gMHI7qK8y+x3Wrq/7nJa7IboN+mzw955qYhIwGTgQDBgf+BoNvbMa2HSRyIdeuLwg0aFoCINQURzCmIhdy199cwAFflDrgD8lxwaa0N8++IpzjLOQY6qtN74+Esf05N5Yh5ljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jK5OFX8y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZvLSG0D/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jK5OFX8y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZvLSG0D/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D77PHg810519
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 11:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G1ndrEIR7n7BpzBb/bC1xzKI/CnXvp4qobfU8FGyanY=; b=jK5OFX8yDhdtk95h
	qV90IMpyKSbjgVEUlCVkTMXZtgXsLjkDcCFIOihzkzl09kMXg5b90oDpSI6EAfY1
	A8XEpZMjaOL9Fr2OO/Y4fBkIqJ0T5tbjrcraAsD+w0LA36mYz7oLEzyF9JB6GDlb
	EHIIUgZu6xhLW26JzwGch0vUSVkPAYgn75/gHdza0yKA84yiLrK5ZdokP9jl3r7C
	l7uj1/jL9ksIE8sN59WJiyrU23dwt50mlKK6YnND8mZBrU7rN0Teuy3eIEpwmWeM
	uRlO3uvTWT/fF0Go3Q35OrBAR024uwLNkTt+K8BuHJXlKho3L6+zTlnc+TThAJHz
	hFIk8A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubsrvy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 11:15:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bfe3fa93bso53450311cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783941313; x=1784546113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1ndrEIR7n7BpzBb/bC1xzKI/CnXvp4qobfU8FGyanY=;
        b=ZvLSG0D/5YtiX1aqdsOxskilMOE/8P+jGw7PXgjBt78nq/VSsyaE8ScNi9fAMBrQNj
         k3/YYuStwv1f9bvgXkyGRPfEp9mWGkdZhSzIxiwSg/BI/IrTocukWLg/EQXDpisSjX8/
         8EwDlIMg271ziRr7l3OeEInVQLa7EcvNF2dNWRpf+U9SYriuX2SZuhpYHoQko0Yx2/MN
         OxvYjUWjhSEKJWiJVg1mooQzw0fLM/JHKZoMsyb2iLqC66VFRplxoVUxjg7fR/z4upip
         emK+1l48gHyoPBN1D6RfjpH6Ryrop1+Y3mY9iYFBfhThD+Z4FZ6rpxDLK9GJ1PySaAh0
         VwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941313; x=1784546113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1ndrEIR7n7BpzBb/bC1xzKI/CnXvp4qobfU8FGyanY=;
        b=n0WtUkWw+qOZ3GejuPySzE1d2uzDdA8CIqdKo+RJk0lyS3DlGt8rMmHgzrU254E6dt
         WaM5c0BZ6IX74KbifpQuW1YxNk142q5Od7Ysa+G5l39DptprHdgddaSPITXPimlb+Vx+
         262tuuoF2JKW5l+/g1eUZazJMlpZx7xxHpM6qH9A0PEuLGEUJwov3LrMvCcPp6IMuKgL
         T6OT2sZRVQOJE58mrTpgAPYIKJYSFJK7xxrxQ7+yszaR7s5dsNWTHAppDtN2wFDnOus5
         wg4mF6Kh/u5kFzR0TzFCKJYogIDJRIF1LKKVGJ861EG2u4ICV0Vr2zGtsUZcaIfWX28L
         E5xw==
X-Forwarded-Encrypted: i=1; AHgh+RoF2x2G7qTl34zUHz3NDRaKjqfUVOgSQ5VIrMtJP1oCuAfXBTJ2xXZxx6wtwn1Ao5HAbOpykJvg6gMg@vger.kernel.org
X-Gm-Message-State: AOJu0YyqaNQvFgyLFsanhvQP2sSQbo4c/GaV9dmo3IXd7v8yLea2eKZV
	1uKGKwB9tyqlit17daE0ABkcKLZYIKGJ5t8BvEv4En0CVlc5/2ShGLDEhMqvqBgyh8/TDr4KKNT
	ZSz3YW/pGAtPP0J0ScQWwSMHYHZxoMyu4eMzUoEqznXFA+N3BzUxhr6VH6A6nn+QK
X-Gm-Gg: AfdE7cmNtNCM9KYUND8kKg4I3rvvoUzzLSkopvSwukgEkl8ZfgMXhP0Sja24xy0dZKQ
	CWiy2qMwxB3XQYXPMUCwZwjBSo9NKyobubE/VvDMPgzCXJnTwckY2BDfHe8xCiL+cuKeMqbYFbL
	DQoLW8KGpQ8C0NMkckHrEiSH2BO5f3AjhjVkVVJzD/gZqY6eOefsGqIWH4BMXxPD9iWTCiYoKOn
	zGuHg9OYHxJMpiK4oOXhnoIm0qLoApHcIw13Wkjmy4yP8bWNoyc0+po86t9E9iyzN1zO8YqnUbm
	yoM4my8h+Wqg6NWoncU1xhJ/jKMxI1dQurgKa29c8GlfBdH+iRD3GKVN4luOOouOjMEilBdxJ57
	wXg/7zv5Fn/iWGI1zCLVZIKtAl4jIW5OERx9t6PZ8
X-Received: by 2002:a05:622a:1918:b0:51c:8fb:fa45 with SMTP id d75a77b69052e-51cbf2fab81mr88878161cf.58.1783941312978;
        Mon, 13 Jul 2026 04:15:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1918:b0:51c:8fb:fa45 with SMTP id d75a77b69052e-51cbf2fab81mr88877321cf.58.1783941312140;
        Mon, 13 Jul 2026 04:15:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm82323160f8f.33.2026.07.13.04.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:15:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:14:46 +0200
Subject: [PATCH v4 3/5] software node: add kunit tests for fw_devlink
 support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-swnode-fw-devlink-v4-3-d4f2dee27ad9@oss.qualcomm.com>
References: <20260713-swnode-fw-devlink-v4-0-d4f2dee27ad9@oss.qualcomm.com>
In-Reply-To: <20260713-swnode-fw-devlink-v4-0-d4f2dee27ad9@oss.qualcomm.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-acpi@vger.kernel.org,
        driver-core@lists.linux.dev, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13715;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VYz0TYRwzOI7K0hlO+3u24CfmURLK/h7puPMYIu7DoE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVMiwKqOvnQ53efJ+Gdvxj32YrXGjDJCupbdAS
 hOlNL2qYGeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalTIsAAKCRAFnS7L/zaE
 w+WZD/wLXZP4GYrLA8mBNJtgA29WG2H+RCY4Za27dUOwLErpZ5h10IUhuObHX1hNl0gTIieh7d4
 ckbBw6udTFyxfAdz5DmNYO7UxIqYI1sZcITsZYQe5Ux+1/MM2CckJesxyTXcDcojFpPfDxsA7wE
 guftCRAdYVUGALM8tchVFSVK2EFjcbGphenY/yGkzOf4ryBbQEgdkbGXzzNnk3D3WR7PJadoKZZ
 1V659cFXZ9bG0xZUFPbuFWrtoQ9t2P1Wt9hYmWIFN1Zj0l7aM0e/RREEMjYdj7TAbWeUWSaI3rh
 K0x5BaV6HHHhTC9YC0z2K4JCEs92dpCAvuwb+ruJ4gdGCfljhIFUwhQTqHAPgo48apjJVnuPRp+
 0loYSMbGwkSuMfaZ8AbHXwYm2jqtzSuMy7EJo34SHgJdTLwJzLDjtKd19vrcwHOYQOi6mF6f6r/
 /hbSICWu+JjTtAr/SU9s8a9kPSFCWUTsyNudU2DTPu04ILH9VN/F9oVVx3cEREBHebHuJB2QoO6
 +/nvifSEMRR+cF+w70b0j/lLxYC7+dGN4cJbmYdFO48boD4RYbXRIM1ZSSqJ/HehIwVkRp08bhR
 wR0vBSS0i+H8LD7G47I6qoSWO8R+zEFExDhGnWJqF+4MTp1JBqKoWX1F2PVCUSL4SxH1Bam+T+z
 0tu7cLHxVMWEFOw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54c8c1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QyXUC8HyAAAA:8
 a=nzuXsxulAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=9zVEpjMGfH8rPmTIezIA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Jn5cl5okm61iLnyvC_SE:22
X-Proofpoint-ORIG-GUID: SjxipvWHmNQx2cKkXBzQGYyGtInER_sF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX6CX+7m8TEN/q
 xlBzO1aHLGF4eeEyaOJpWmqfymw+y+IZKTXOkb0P49/cYTD9x75pwgGM0OA0CwrVhIB4XTxQoUS
 1xhsTPRgoXsyIbMKrdmHihzECPP4wy8=
X-Proofpoint-GUID: SjxipvWHmNQx2cKkXBzQGYyGtInER_sF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX0BwhEFO7f4j+
 vT2pBKUPYx2O3froNSnlZioia7gjO0xPYfTQT9dC1eMUw6dBgCEAV5EOQWWBUo9w49/Nsg18vIS
 r2WVtFZUas0PYffAd4sbYKJX0zE4OPvPnUR7g/cS9pwHSl0oT2oekkSJKpdPjllybIQVK+iFjph
 Ivdg2eEKiRqDzKng31GUPE0Kt2ZURB862j6reBRzyfvPsYQd9nZZgTGoP2KQZe8amIISCjTym3l
 voFRSR1mnHzvl3Fhiss6BlDumjKACO0rhou0OYRCYVf9YfB2yXM2sD0FrQzihB1TTfP9bkaWFEI
 viAx3E4zmelF+w9GgsOyDWRZR/PKXtlmZv0mbtP9T+rnzAhZbLE2ifXlzRBAANZFJYzglkI+WP5
 hJHUJ5cFnFKHZCmy/JCtJDTozoApJoohtFnWY2sdrtOwfPkFqNWYVOyQdDeEDyeweo6yCwxokrm
 2Rbew+oJz/m0lPzfcyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130117

Add a kunit test suite for fw_devlink support for software nodes.

Most cases call add_links() directly and inspect the resulting fwnode
supplier/consumer lists: a single reference, multiple references, a
reference to an unregistered node, a "remote-endpoint" reference and a
reference array. The last case is end-to-end - it registers real consumer
and supplier platform devices together with their drivers, adds the
consumer first and checks that fw_devlink defers its probe until the
supplier has been bound.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: David Gow <david@davidgow.net>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 MAINTAINERS                             |   1 +
 drivers/base/test/Kconfig               |   5 +
 drivers/base/test/Makefile              |   2 +
 drivers/base/test/swnode-devlink-test.c | 337 ++++++++++++++++++++++++++++++++
 4 files changed, 345 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d153537393761df322165f683954d50..f9dfb14b9d477fc0331441f96c158b0474f63026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25106,6 +25106,7 @@ L:	linux-acpi@vger.kernel.org
 S:	Maintained
 F:	drivers/base/property.c
 F:	drivers/base/swnode.c
+F:	drivers/base/test/swnode-devlink-test.c
 F:	include/linux/fwnode.h
 F:	include/linux/property.h
 
diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 2756870615ccab67ec26d8671c1e4dba69342134..1ecf0791241a1b2eee7e1e787772217724abacb9 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -18,3 +18,8 @@ config DRIVER_PE_KUNIT_TEST
 	tristate "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
+
+config DRIVER_SWNODE_KUNIT_TEST
+	tristate "KUnit Tests for software node fw_devlink links" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index e321dfc7e92266d2073d442f652cadb6e911dba5..9ced7bbd569fc49ba2719aa0cab57c7d8245dde1 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -6,3 +6,5 @@ obj-$(CONFIG_DM_KUNIT_TEST)	+= platform-device-test.o
 
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
 CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
+
+obj-$(CONFIG_DRIVER_SWNODE_KUNIT_TEST) += swnode-devlink-test.o
diff --git a/drivers/base/test/swnode-devlink-test.c b/drivers/base/test/swnode-devlink-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..f53549e926118fd4a1e109ece67d58d45d52193d
--- /dev/null
+++ b/drivers/base/test/swnode-devlink-test.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) Qualcomm Technologies, Inc. and/or its subsidiaries
+ */
+
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/fwnode.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <kunit/fwnode.h>
+#include <kunit/platform_device.h>
+#include <kunit/test.h>
+
+static int swnode_count_suppliers(struct fwnode_handle *fwnode)
+{
+	struct fwnode_link *link;
+	unsigned int count = 0;
+
+	/*
+	 * The suppliers and consumers lists should typically only be accessed
+	 * with the fwnode_link_lock taken but it's private to the driver core.
+	 *
+	 * These are tests and at this point nobody should be modifying them so
+	 * let's just access the list.
+	 */
+	list_for_each_entry(link, &fwnode->suppliers, c_hook)
+		count++;
+
+	return count;
+}
+
+/* True if a supplier link con->sup exists, checked from both list ends. */
+static bool swnode_has_link(struct fwnode_handle *consumer,
+			    struct fwnode_handle *supplier)
+{
+	bool from_con = false, from_sup = false;
+	struct fwnode_link *link;
+
+	list_for_each_entry(link, &consumer->suppliers, c_hook) {
+		if (link->supplier == supplier && link->consumer == consumer)
+			from_con = true;
+	}
+
+	list_for_each_entry(link, &supplier->consumers, s_hook) {
+		if (link->supplier == supplier && link->consumer == consumer)
+			from_sup = true;
+	}
+
+	return from_con && from_sup;
+}
+
+/* A single reference creates exactly one supplier link, on both list ends. */
+static void swnode_devlink_test_single_ref(struct kunit *test)
+{
+	static const struct software_node supp_swnode = {
+		.name = "swnode-devlink-test-supplier",
+	};
+
+	struct fwnode_handle *cons_fwnode, *supp_fwnode;
+	int ret;
+
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_REF("supplier", &supp_swnode),
+		{ }
+	};
+
+	supp_fwnode = kunit_software_node_register(test, &supp_swnode);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, supp_fwnode);
+
+	cons_fwnode = kunit_fwnode_create_software_node(test, props, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons_fwnode);
+
+	ret = fwnode_call_int_op(cons_fwnode, add_links);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, swnode_count_suppliers(cons_fwnode), 1);
+	KUNIT_EXPECT_TRUE(test, swnode_has_link(cons_fwnode, supp_fwnode));
+}
+
+/* Multiple distinct references create multiple supplier links. */
+static void swnode_devlink_test_multiple_refs(struct kunit *test)
+{
+	static const struct software_node supp1_swnode = {
+		.name = "swnode-devlink-test-supplier-1",
+	};
+	static const struct software_node supp2_swnode = {
+		.name = "swnode-devlink-test-supplier-2",
+	};
+	static const struct software_node *supp_nodes[] = {
+		&supp1_swnode, &supp2_swnode, NULL
+	};
+
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_REF("foo", &supp1_swnode),
+		PROPERTY_ENTRY_REF("bar", &supp2_swnode),
+		{ }
+	};
+
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	ret = kunit_software_node_register_node_group(test, supp_nodes);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fwnode = kunit_fwnode_create_software_node(test, props, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	ret = fwnode_call_int_op(fwnode, add_links);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, swnode_count_suppliers(fwnode), 2);
+	KUNIT_EXPECT_TRUE(test, swnode_has_link(fwnode, software_node_fwnode(&supp1_swnode)));
+	KUNIT_EXPECT_TRUE(test, swnode_has_link(fwnode, software_node_fwnode(&supp2_swnode)));
+}
+
+/* A reference to an unregistered node creates no link (graceful skip). */
+static void swnode_devlink_test_unregistered_ref(struct kunit *test)
+{
+	static const struct software_node supp_swnode = {
+		.name = "swnode-devlink-test-supplier",
+	};
+
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_REF("supplier", &supp_swnode),
+		{ }
+	};
+
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	fwnode = kunit_fwnode_create_software_node(test, props, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	ret = fwnode_call_int_op(fwnode, add_links);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, swnode_count_suppliers(fwnode), 0);
+}
+
+/* Graph "remote-endpoint" references are excluded. */
+static void swnode_devlink_test_remote_endpoint_excluded(struct kunit *test)
+{
+	static const struct software_node ep_swnode = {
+		.name = "swnode-devlink-test-end-point"
+	};
+
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_REF("remote-endpoint", &ep_swnode),
+		{ }
+	};
+
+	struct fwnode_handle *cons_fwnode, *supp_fwnode;
+	int ret;
+
+	supp_fwnode = kunit_software_node_register(test, &ep_swnode);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, supp_fwnode);
+
+	cons_fwnode = kunit_fwnode_create_software_node(test, props, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cons_fwnode);
+
+	ret = fwnode_call_int_op(cons_fwnode, add_links);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, swnode_count_suppliers(cons_fwnode), 0);
+}
+
+/* A reference array creates one link per registered element. */
+static void swnode_devlink_test_ref_array(struct kunit *test)
+{
+	static const struct software_node supp1_swnode = {
+		.name = "swnode-devlink-test-supplier-1",
+	};
+	static const struct software_node supp2_swnode = {
+		.name = "swnode-devlink-test-supplier-2",
+	};
+	static const struct software_node *supp_nodes[] = {
+		&supp1_swnode, &supp2_swnode, NULL
+	};
+	static const struct software_node_ref_args refs[] = {
+		SOFTWARE_NODE_REFERENCE(&supp1_swnode),
+		SOFTWARE_NODE_REFERENCE(&supp2_swnode, 4, 2),
+	};
+
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_REF_ARRAY("suppliers", refs),
+		{ }
+	};
+
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	ret = kunit_software_node_register_node_group(test, supp_nodes);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fwnode = kunit_fwnode_create_software_node(test, props, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	ret = fwnode_call_int_op(fwnode, add_links);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, swnode_count_suppliers(fwnode), 2);
+	KUNIT_EXPECT_TRUE(test, swnode_has_link(fwnode, software_node_fwnode(&supp1_swnode)));
+	KUNIT_EXPECT_TRUE(test, swnode_has_link(fwnode, software_node_fwnode(&supp2_swnode)));
+}
+
+/*
+ * End-to-end test: fw_devlink must defer a consumer's probe until its
+ * supplier has probed.
+ *
+ * The reference created by software_node_add_links() is only useful if the
+ * driver core promotes it to a real device_link and uses it to order probing.
+ * This test drives actual probing through the platform bus and asserts the
+ * supplier binds before the consumer.
+ */
+
+#define SWNODE_DEVLINK_TEST_SUPPLIER	"swnode-link-supplier"
+#define SWNODE_DEVLINK_TEST_CONSUMER	"swnode-link-consumer"
+#define SWNODE_DEVLINK_TEST_TIMEOUT_MS	(2 * MSEC_PER_SEC)
+
+struct swnode_test_probe_order {
+	/* Names in the order their drivers' .probe ran. */
+	const char *probed[2];
+	unsigned int count;
+	wait_queue_head_t wq;
+};
+
+static int swnode_test_record_probe(struct platform_device *pdev)
+{
+	struct swnode_test_probe_order *order = platform_get_drvdata(pdev);
+
+	if (order && order->count < ARRAY_SIZE(order->probed)) {
+		order->probed[order->count++] = dev_name(&pdev->dev);
+		wake_up_interruptible(&order->wq);
+	}
+
+	return 0;
+}
+
+static struct platform_driver swnode_test_supplier_driver = {
+	.probe = swnode_test_record_probe,
+	.driver = {
+		.name = SWNODE_DEVLINK_TEST_SUPPLIER,
+	},
+};
+
+static struct platform_driver swnode_test_consumer_driver = {
+	.probe = swnode_test_record_probe,
+	.driver = {
+		.name = SWNODE_DEVLINK_TEST_CONSUMER,
+	},
+};
+
+static void swnode_devlink_test_probe_order(struct kunit *test)
+{
+	static const struct software_node supplier_swnode = {
+		.name = "swnode-devlink-test-supplier",
+	};
+
+	const struct property_entry consumer_props[] = {
+		PROPERTY_ENTRY_REF("supplier-ref", &supplier_swnode),
+		{ }
+	};
+
+	struct platform_device *supplier, *consumer;
+	struct swnode_test_probe_order *order;
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	order = kunit_kzalloc(test, sizeof(*order), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, order);
+	init_waitqueue_head(&order->wq);
+
+	fwnode = kunit_software_node_register(test, &supplier_swnode);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fwnode);
+
+	ret = kunit_platform_driver_register(test, &swnode_test_supplier_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = kunit_platform_driver_register(test, &swnode_test_consumer_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	supplier = kunit_platform_device_alloc(test, SWNODE_DEVLINK_TEST_SUPPLIER,
+					       PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, supplier);
+	consumer = kunit_platform_device_alloc(test, SWNODE_DEVLINK_TEST_CONSUMER,
+					       PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, consumer);
+
+	platform_set_drvdata(supplier, order);
+	platform_set_drvdata(consumer, order);
+
+	ret = kunit_device_add_software_node(test, &supplier->dev, &supplier_swnode);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = device_create_managed_software_node(&consumer->dev,
+						  consumer_props, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_platform_device_add(test, consumer);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = kunit_platform_device_add(test, supplier);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = wait_event_interruptible_timeout(order->wq,
+					       order->count == 2,
+					       msecs_to_jiffies(SWNODE_DEVLINK_TEST_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	KUNIT_EXPECT_STREQ(test, order->probed[0], SWNODE_DEVLINK_TEST_SUPPLIER);
+	KUNIT_EXPECT_STREQ(test, order->probed[1], SWNODE_DEVLINK_TEST_CONSUMER);
+
+	/* Tear down the consumer (and its device link) before the supplier. */
+	kunit_platform_device_unregister(test, consumer);
+}
+
+static struct kunit_case swnode_test_cases[] = {
+	KUNIT_CASE(swnode_devlink_test_single_ref),
+	KUNIT_CASE(swnode_devlink_test_multiple_refs),
+	KUNIT_CASE(swnode_devlink_test_unregistered_ref),
+	KUNIT_CASE(swnode_devlink_test_remote_endpoint_excluded),
+	KUNIT_CASE(swnode_devlink_test_ref_array),
+	KUNIT_CASE(swnode_devlink_test_probe_order),
+	{ }
+};
+
+static struct kunit_suite swnode_test_suite = {
+	.name = "software-node-links",
+	.test_cases = swnode_test_cases,
+};
+
+kunit_test_suite(swnode_test_suite);
+
+MODULE_DESCRIPTION("Test module for software node fw_devlink support");
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");

-- 
2.47.3

