Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792882604;
	b=vsSiBuDMzeWkWQIFvTLDNbzuTtU6HLOu7qvKuBIFdoui9lIG/+R+ZHIWu9cLmz5FCw8A
	 e6tQGB+rVVDv2kDB9n39U4JSLFQl48sPJmdMfbAio/G9Ph8oxSIk3nPh7gRFul7PslUbF
	 Mi6G48unwyV3qGpamOlZ+ayllwmc9W0wHKPJ08G2eHS7GMsUvn4jOcRFuKReeRS5NPGGj
	 KVxruCuWjkgKOdiuRoZD4lBqk9AFwccIXne3gOzbWnpTZyASiehToNHyN78FSPqUzBrSy
	 sdE/2M227ZRWa+CwOj+7J9rqaAXtN0I9sO/DGxI0c3WNCbYdwU06Y50B0slV2ddo8ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882604;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KZkTpDbUwC0fq2vu8+gU0Jyh9+/zPfcLoyDt0p9UsAM=;
	b=oW/qUUAinxTCq5ajgeruF+lPVy//3kbuFo4GbuqbXscKZVkexOnYzcHFaQ2NErBrrQI2
	 3amObMzW55jo1jx3JUuUGEaCKflJWF1HSnTb2VxLR3al4w6n4YgVdIN4zDNST5g8DPE8t
	 WqOBgqj+LEvdY054uPxJMGec3bKkfMRODtAEkPhPiGQipU8RTdDWrtLb56bFogeHVsrLQ
	 PBtXOdeCchJA3s0p4MrsypKD+3Djb9KoVYQ57CdoWrmp4AZYrHJdc2RXYkc9LGANDw7Eo
	 r56i4ASqSU/mLfRAE1jes10jeRu61oT2KSJ7n6O0Bp89LE0CFykvQr9TP+2qL2eELgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OXQK9vDo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ESDqtqLb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE667606A31B
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE667606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OXQK9vDo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ESDqtqLb
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLb60L3751166
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KZkTpDbUwC0
	fq2vu8+gU0Jyh9+/zPfcLoyDt0p9UsAM=; b=OXQK9vDok0Pd2zTnDDYPnwVhRNM
	rb6IymPRqMdqH9PZaM8eGQU5nHcEwWPsSRIlEbrqiFOk+FeNUlnpAeAu7BgJ6qCs
	x1Q2pg4ARFeAAAmCKH0o+XXOTR3g/8bPLtGhAEUuWOZl5ofRnDu/pOtOB81HxWAY
	J+Au4v1CAIbadmDanQFpTqSfhR8B8qE6AQ/u3BwLzFRt1BZmtCAirp0x4UcStOf0
	5vW5/EXdQzTkaJK6i/FOF05da2/o4EFomOSQlCz/IZFoHRvBIV6JB4nJqou5wuqU
	LdMSsg7G3G/Rp8eN0DizluCgnZafQlCxG7d2GygbsgISlJQ6lAYqshwqf1g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsa3tf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1f2fafeaso266256885a.2
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792882602; x=1793487402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZkTpDbUwC0fq2vu8+gU0Jyh9+/zPfcLoyDt0p9UsAM=;
        b=ESDqtqLbejAC85WsQ5ky2Qy47VtT168us8dQyGXebe0vSlEwYWYcM9Km/M/C09loww
         fVzTA4kopAboMiR9jXnwHBAMLSR0M1vzRwTKVsuP1xM85ZTGgP9nIOOIaG9f6I1kr9xH
         gQ4V/bNKI8HUaErVqukwzDZNMYwvZQOhHPwO/1Rz+Yd14dYQtqynR8xvG2oVxIVbQp3p
         uvXPwy9xrqqEagMHU1ml9HcdA1bHCm8d6C43hJf9JlNqtkBwRnZhTsmnvVsoVTAuMTgg
         2y3q8JPJfh3HYf8q1Z5u84/ii9H43WGF7XAzhY/uuDcnYawrW5GI7Fu4ZHKExGNRycfB
         wxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792882602; x=1793487402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZkTpDbUwC0fq2vu8+gU0Jyh9+/zPfcLoyDt0p9UsAM=;
        b=0qhgAyLTOqO+fxYsLjTXSH+kYYpGBM6AzuCb1LijfeTzI3IXEyq+RGjp9aV17c1vXG
         +9ywvy+hKzddwaxeGEghZuVo6NIifFOYW/XrGqlxbH9S3KjdQCa7+QSgO+nBiwQFJ6Ac
         KhzcoksBdfvNPIgXV43Zur2eZaoJlSI0f4TlCeI5ZaxNQXQTHzde/Pqjt1IXF2MjDhfO
         2+Fmk/z5j0KTHsOE/kA+DL7Yvs2UluNukaG5sUI+VoUwgisNLvEE/q6S/xPX0sL4D+UE
         BAka5NK52QSiKYnayQwfML3tgzKhKtZvkwRlrckcayGeHuFSTE+QFvJCJAGMQvCdtrwV
         TLYw==
X-Forwarded-Encrypted: i=1; AKwUvByBDTae46gGkOkSeaATNACk4VeFkyvA25X8toBM9hAFOcgLUdu+CVsIthdcWQyM11eAhcSMvocbHeqI@vger.kernel.org
X-Gm-Message-State: AFq9FYLetNTH/RW6tP3j26oe5pHcqyZU8LwvpJhn+FJdnRmDXV4/15Mv
	Al5ydsUzr0CzJSz19abZRfyE6JU86g8Dw04+LM3mWYetf3+oakzz3EyXtgJERrMEXSdADAwJYeQ
	9qa/rLqTgSCMKJpN5ORa7Nq0QTOs3PhmaWEgN9A4VGVTh0rqGTszsVsm2XzvqxMws
X-Gm-Gg: AYBFou0PXj+nL/jxkje//qEfr5OvDtuksyna6qqpITs+FVS2DPyYCkmaFjhfDVzbQJu
	4vfbfOdFVD/rGuwV9ke6ROwHMbzmikcqI3BVvBzIQMJcB235Ou21MY3VtNNqoUi0kj98EZXnn24
	BHf/0BQUqLtSNwndgd0p/nPN/kdcoKJV56t+QQUCp8RbaX+wbp3Yr7oFAEqdMlPZr9zxztb3hfv
	ddcO8OFowzERTz2T6Ib7xcfS8mOnkuirWbfHzA8cYGE1K8rdEArpvt59oKhLlEe22lFNy4htBId
	zNxu8+Lf4OAOPEuRAUUSjYcC6qO8QHMEYpMsucAHc61fyc3alCh6h5DA003DbmGiWXCEuoypDML
	/0fuAl9Xxxg5YcIOBjz+0XwRokAE=
X-Received: by 2002:a05:620a:4414:b0:93c:aff9:52c with SMTP id af79cd13be357-940ef99b527mr438932285a.60.1792882601834;
        Sat, 24 Oct 2026 15:56:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4414:b0:93c:aff9:52c with SMTP id af79cd13be357-940ef99b527mr438928385a.60.1792882601319;
        Sat, 24 Oct 2026 15:56:41 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm98564145e9.1.2026.10.24.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:56:40 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Wu <jackbb_wu@compal.com>,
        "Mario Limonciello (AMD)" <superm1@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 3/4] platform profile: Document firmware-independent profile selection
Date: Sun, 25 Oct 2026 00:34:28 +0200
Message-ID: <20261024223501.1420953-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u6etkxpIHiXnTwtYMzaLFp35pkVhN9TG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfX4shZcFdil0vG
 R9X3VfzN0HWEw6aserVfr5UJeZK9tZ+W65SehmDATkhgHFfn/5z8bUNJmX6lc2E/zUHu8waJhqY
 WIeCKyoy8N5R+OjuG6MlBMLfQfDe8A2fqMXKZKZqFdAeGJwOgbs54fUyCrzssFIALgzSkpj7rO/
 qTEs0+5LuGL5FByi75I2VZilveF/nVem5AF06u56GYByhswEdaTRdTcvKpDS4ILN2JkOOQvTH+N
 Px55NbfaFpuuFeDKe/eVJxg4frszv0nL8OJsSkg9z5nJIViKygYYhEFuUKxxZDf5w1xJU/eBDgX
 3W2gAFFJwHRve/shZG9ZisvWSInErXvdrj+XHoltTH6lKsDloG8H17qGU86xh4SnnmC1tnBvfvi
 bjI8NGGVPJrNBjT/SpNEDHzHZjjhjxXqQ47XYY3q4WW6Pqt7BerkRtIVGIh1YNvlKabKoyciTEM
 tHphrbm/Vssnn3ce7XQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfX3G5iZb0aowbt
 QC0X9mMRuMr3ZJ98aM8X7KC5pCj4QEvg1zuIZEeSSj0kJFQsOHb79G7wKqfreVI1pMn926DiWA2
 bkgmS7/yX7ZMr6uCE6l7aVM9bqQxF20=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6add37ab cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=uEqVyaLVsi9FIuCuvY4A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: u6etkxpIHiXnTwtYMzaLFp35pkVhN9TG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240091

Describe the existing per-provider class devices as the firmware-neutral
userspace interface. Explain that providers can use any firmware transport
or implement profiles in software, without an ACPI companion or firmware
node on their parent device.

Retain the ACPI paths as compatibility interfaces for aggregate selection.
Clarify that non-ACPI userspace selects individual providers and document
the sequential application of aggregate writes and their partial-failure
behavior. No new userspace ABI is introduced.

Correct the per-provider choices attribute reference and extend existing
ACPI maintainer coverage to the extracted core and its interfaces.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 .../ABI/testing/sysfs-class-platform-profile  |  2 +-
 .../userspace-api/sysfs-platform_profile.rst  | 46 ++++++++++++++-----
 MAINTAINERS                                   |  5 ++
 include/linux/platform_profile.h              |  3 ++
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
index fcab26894ec3..75e0f6e2c128 100644
--- a/Documentation/ABI/testing/sysfs-class-platform-profile
+++ b/Documentation/ABI/testing/sysfs-class-platform-profile
@@ -35,7 +35,7 @@ Date:		March 2025
 KernelVersion:	6.14
 Description:	Reading this file gives the current selected profile for this
 		device. Writing this file with one of the strings from
-		platform_profile_choices changes the profile to the new value.
+		choices changes the profile to the new value.
 
 		This file can be monitored for changes by polling for POLLPRI,
 		POLLPRI will be signaled on any changes, independent of those
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index 6613e188242a..a85ede3fb8e5 100644
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -1,6 +1,8 @@
-=====================================================================
-Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
-=====================================================================
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Platform Profile Selection
+==========================
 
 On modern systems the platform performance, temperature, fan and other
 hardware related characteristics are often dynamically configurable. The
@@ -15,6 +17,21 @@ operation or towards performance.
 The purpose of the platform_profile attribute is to offer a generic sysfs
 API for selecting the platform profile of these automatic mechanisms.
 
+The framework is independent of the firmware interface used by a provider.
+Drivers can implement profile selection using ACPI, an embedded controller,
+or another platform-specific mechanism. The core does not discover providers
+or interpret firmware descriptions.
+
+The firmware-independent userspace interface is available under
+``/sys/class/platform-profile/platform-profile-X/``, with ``name``,
+``choices`` and ``profile`` attributes for each registered provider.
+
+On ACPI systems, ``/sys/firmware/acpi/platform_profile_choices`` and
+``/sys/firmware/acpi/platform_profile`` remain available as compatibility
+interfaces for aggregate profile selection across registered providers.
+On non-ACPI systems, userspace selects profiles through the individual
+provider class devices.
+
 Note that this API is only for selecting the platform profile, it is
 NOT a goal of this API to allow monitoring the resulting performance
 characteristics. Monitoring performance is best done with device/vendor
@@ -52,13 +69,14 @@ Multiple driver support
 =======================
 When multiple drivers on a system advertise a platform profile handler, the
 platform profile handler core will only advertise the profiles that are
-common between all drivers to the ``/sys/firmware/acpi`` interfaces.
+common between all drivers to the ``/sys/firmware/acpi`` interfaces, when
+ACPI is active.
 
 This is to ensure there is no ambiguity on what the profile names mean when
 all handlers don't support a profile.
 
-Individual drivers will register a 'platform_profile' class device that has
-similar semantics as the ``/sys/firmware/acpi/platform_profile`` interface.
+Individual drivers register a ``platform-profile`` class device with
+``name``, ``choices`` and ``profile`` attributes.
 
 To discover which driver is associated with a platform profile handler the
 user can read the ``name`` attribute of the class device.
@@ -71,10 +89,14 @@ by writing to the ``profile`` attribute of the driver's class device.
 
 This will allow users to set different profiles for different drivers on the
 same system. If the selected profile by individual drivers differs the
-platform profile handler core will display the profile 'custom' to indicate
-that the profiles are not the same.
+ACPI aggregate interface will display the profile 'custom' to indicate that
+the profiles are not the same.
+
+While the ACPI ``platform_profile`` attribute has the value ``custom``,
+writing a common profile from ``platform_profile_choices`` to it will set
+the profile for all drivers. ``custom`` cannot be written to this aggregate
+interface.
 
-While the ``platform_profile`` attribute has the value ``custom``, writing a
-common profile from ``platform_profile_choices`` to the platform_profile
-attribute of the platform profile handler core will set the profile for all
-drivers.
+Aggregate profile changes are applied to providers sequentially. If a provider
+returns an error, providers updated earlier are not rolled back. Userspace can
+read the per-provider interfaces to determine their resulting state.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9fe9c2a39b..ecb3bf5fdafc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -285,10 +285,14 @@ B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 F:	Documentation/ABI/testing/configfs-acpi
 F:	Documentation/ABI/testing/sysfs-bus-acpi
+F:	Documentation/ABI/testing/sysfs-class-platform-profile
+F:	Documentation/ABI/testing/sysfs-platform_profile
 F:	Documentation/firmware-guide/acpi/
+F:	Documentation/userspace-api/sysfs-platform_profile.rst
 F:	arch/x86/kernel/acpi/
 F:	arch/x86/pci/acpi.c
 F:	drivers/acpi/
+F:	drivers/platform/profile/
 F:	drivers/pci/*/*acpi*
 F:	drivers/pci/*acpi*
 F:	drivers/pnp/pnpacpi/
@@ -296,6 +300,7 @@ F:	include/acpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	include/linux/fw_table.h
+F:	include/linux/platform_profile.h
 F:	lib/fw_table.c
 F:	rust/kernel/acpi.rs
 F:	tools/power/acpi/
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 855b28340e95..f23f9827eac6 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -2,6 +2,9 @@
 /*
  * Platform profile sysfs interface
  *
+ * Providers may use any firmware interface or implement profiles in software.
+ * The parent device does not need an ACPI companion or a firmware node.
+ *
  * See Documentation/userspace-api/sysfs-platform_profile.rst for more
  * information.
  */
-- 
2.43.0
