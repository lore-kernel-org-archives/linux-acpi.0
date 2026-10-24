Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792882582;
	b=IpuzgDRabAavhba1fW+UiHHOIQ1wEVzOWUrUXic3/ei6s21tisAlscxdN63CYf8TQMwb
	 IQOum0t7R9mwrHS3ES0PpbiogilMS6G3BciraNHbniZM3xGz1w497Pqthl8xEFyclJBSh
	 wiXqJDvpEuVSYPxh77MrM7g+pjgvfkLKWtSz6zeDH+x+whHK5prYiaSJGRdThckNtcXrI
	 03QpaX1TW4ormEX0QQ7btC4Hk6fbCL866MfJh/luXZ3K/OnRpzVCtYgUjbSZrvyN2F2hY
	 4YEK1wxls5JsE0zL6NG0KMXzjWSac6BvXFHSoljWWMjteEEvEhbpvXqYfXuMIC+dzWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882582;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KtdPkxiSZqOwEqjhj02FkI3Op22Kf/c+qdzJcWgt0Y4=;
	b=McEgcNOenEZcQE8VGH2MqvXgdr06AOhuSQ7pYO+kVvI7o+JKcAgBVO6e1RhIRPIaiTSm
	 RdRSPZAoSJ7KO+U9o/RI4TVmCwA8AtHgl0DgQHJ81zDSOj0kO+mLbNsLtzf1c2RE9snN2
	 Z/O/wv9lNq3DJpiwnUx6DRiSwZegwKl0flgZlJ2O4M26v1wTohG+WbnZadiiguQD/Nfwy
	 ulfoToqZjZStfF1Fal8O3dyNmlz2vFsbrtljk/Idtru5aO3UaRWQr0Z6Hvv9a77SHYQAc
	 0Bf3FDFwUsu35/ULmckBJ/pRgzY5U1qxCHftRSOokoyjSyidTg7yRylBzh/1WSO7qOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kV3KU4b1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJG4Rv8S;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4D606A31D
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D4D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kV3KU4b1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TJG4Rv8S
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69OLbtMu2662009
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KtdPkxiSZqOwEqjhj02FkI3Op22Kf/c+qdz
	JcWgt0Y4=; b=kV3KU4b1BH3js6u+LxfQy7/nA4zNAxsIo2oDBDDJjKRu543nKTH
	ukB+kmZ0NUnH50baqPtoF4uJWLZ2tbpnQ/0l06LoRCwItMMduJY5y+Vwz17A45xm
	PUN41d1+b7FF/BVWq2tXSgrkvM+weTAd7ibR/i4PqYsn0lt5Y0KV72aO6IHNBUiD
	eUpH64TSjPOH9APONiHInp/9AZB5dQTNTnLGKFhP0nsfiMg1y9t9Mn9NN/S9Msew
	BLW9+KA524sroFucPcv5TT6iOJ/g1SzIL+kGZGjHdGafLqNKjNX3v+hCfRBmqTqg
	35L/U6gHN/jzU1tsK9C9IVND1NNFk3nb8mw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmruhycn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 22:56:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so354169285a.3
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 15:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792882580; x=1793487380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtdPkxiSZqOwEqjhj02FkI3Op22Kf/c+qdzJcWgt0Y4=;
        b=TJG4Rv8SQTbY4SwOFYGIfAICdgKIDxbp+Qxjnhd/9IfK8lUZphB+/CGx8XtUqsXdQP
         3GeWjMJIvJrcaiDwWfT8AkIrM3ecXBvrsMc0FpvOOHzMtU/OjZy4XarNdb/fYWjiZwKq
         b2gUAmOjbAcY48H87KYPbtmbjWMDNVl9b2FcZtu1ssfMh0stLaXnn7SIiVS6ttVyExsy
         SuIDVIhDFRMrwgqvXPasKdHdGWgtXmJw10dbLznuEfUfsfC+iumY9eUdJTaOD1TVcmtU
         UE+pqeOpQS4/maZYb25M+tY6V0SIrDtH6IHeEF7kGp3NKy42S+qMMM6Sk1X6WVDvHb8E
         +UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792882580; x=1793487380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtdPkxiSZqOwEqjhj02FkI3Op22Kf/c+qdzJcWgt0Y4=;
        b=gUW8VkUE5QCjsCChTNqwU6fWsmScJ/2LQhVQNCRCHM/vy7dRrhtCm8+Qmf4++oQ3ph
         aEv0rcOYU6b4rqOddcQAl0eNhn+CckN+BAT1Su5O7wMkqSe/TrijjIP/2JwyflurnGq8
         jJRk1RFHZTSodfLU9LUAZI7HDVvQaVW03/snlFY3HWMTGQKdTK3HbGdtCLPUwqMXxG2o
         uXBiYZeG03z7ner8yG1Oq1SiQ/9gr0x1XJnrahFkBsqyQDhbVCd21Jg2Py9BLsau7ZfA
         l7dyUAaL27I8Yq+34VvVNXihD6DPYFx7VcdvfgBfsn8Z2yQ43lROBugyB0a9cXGTTIMg
         ShKQ==
X-Forwarded-Encrypted: i=1; AKwUvBybVlQzePt8wChOCgLVx1Ax/EwvISsPFkAnPTetuyXErq/ZbwbxgTL37vJsfF7Tf2mgntikDbOlCEVO@vger.kernel.org
X-Gm-Message-State: AFq9FYJH56OT7wh2DcA04J75IP7qB1JhOKCD3KkAMAq17MWO8RC+kkfQ
	CPtqfA6Al4+6KsNpRbwTmpFSrCETIano8lkQ2F7EOSXCsp+zmLVkujYW/jfYE6sex9SdRtnLjCm
	6JZVG1C19E+MnHZ9lGlpqdF5Evmvx/SVKVV9pJhvSi3LavtBjOZUaxRil1VKRbHb5
X-Gm-Gg: AYBFou2dnrwsFb5Mw9hoN3Ws2Dj3AoI+fhIXfUv51CMqK6A/MXcyGvizgsJq5r80Mno
	dG1O2VZRix/njZFwL1GFd5fDzb8lDmIq3BPJzLSXCVsIPT4868DUWgnyuOmmOhbleaOQXvG/edG
	SCIY1Xk8WkIzAOYX1UaapReKJVBBDM+DGwpTkr0Zxi+lRgztDS/7c3XKzhUsYQcbHOzYg1ufwGZ
	XD/OaPLxO3NlktWlyUPQy9VzZrmNAWq3/JKWTF3tR53Sl/1RdYvp5CK0W0mRcRyANhgI8U0ypxC
	PbpPXP0tuVf1YZLZJaVrhyBJw5deexMQ2SbteMRLtXhM+cgxqHiMUPedVxyjQwwHpn711jD8cnr
	wkmD7KG/DnTWtSn+vvowabOod0+o=
X-Received: by 2002:a05:620a:2909:b0:939:de48:e41f with SMTP id af79cd13be357-940ef8d8c8amr432341485a.31.1792882580097;
        Sat, 24 Oct 2026 15:56:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2909:b0:939:de48:e41f with SMTP id af79cd13be357-940ef8d8c8amr432338085a.31.1792882579489;
        Sat, 24 Oct 2026 15:56:19 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm98564145e9.1.2026.10.24.15.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:56:18 -0700 (PDT)
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
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 0/4] Make platform profiles firmware independent
Date: Sun, 25 Oct 2026 00:34:25 +0200
Message-ID: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfXxexCfi6i1x4Z
 3kDwWAn1loAyx2JM0sbQvOit0iUdozxlgUQzr4blSPT4NiM0oZ4WHlxTnld69rDMKKWYyuAGiCd
 XQWrU+uwCsAyw5foQuPh5MIzYdekxFWNpep8fhhuxVi5JuDyAiBQOd0spe1x2utJ6tGkebWrFTv
 je40XMNLZ+hQZBjQxKULGyWw00CJ8ClThhwqTVelpEAr7LsQSKHm197Lo4XzlvcF4wimmTBSRnc
 pvO6g4jwGb94RtRrPCSgTzdcFMWja1tV+OvPuUyhuRPclPIsvnXVGccHdLOrwVGbOHkuZNiUjiL
 kyvmcpxQbOuCQgF2RKpxBNAJWgdAlukvTJqCHDi6lqAnvQK5w0pahViCJY18FJ6bg+sWjNeTFzM
 PM25VYkAAo0W53T6Fy00/x6XY4pqkWU+uzkYoR3McaS+MsU2SgvdCMSEvDVfpp92dG5zKpY9+VW
 ziKysk3bbDRHXuz7TqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA5MSBTYWx0ZWRfXyzxjm74T1PO8
 /XHFHWzGpOLQmdGRHqym5G7OxOhRv8NL/V0ioaZVxrq5iINOjffeQjuG0IBYzrt5hbGgGPZgSci
 3ELobdc5E0xjWUJ86xGl1bMRdJRNRts=
X-Proofpoint-ORIG-GUID: leIz62djcDn-WbziNHIT-iYUdBf7K4E5
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6add3794 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=2DKhwoluTUTBQ7ciJkYA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: leIz62djcDn-WbziNHIT-iYUdBf7K4E5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240091

Make platform profile selection independent of ACPI firmware.

The provider API already uses struct device, profile enums and callbacks;
it does not require an ACPI handle or firmware node. However, the core is
built under drivers/acpi/, its Kconfig symbol depends implicitly on ACPI,
and initialization fails when ACPI is disabled, preventing non-ACPI
providers from using the existing firmware-independent class interface.

This series moves the core to drivers/platform/profile/ and introduces
CONFIG_PLATFORM_PROFILE, updating all existing provider selectors. It
retains the tristate configuration and platform_profile module name.
Firmware-specific discovery and profile operations remain with providers.
The core can also be selected directly through its Kconfig prompt.

An optional ACPI adapter obtains the legacy sysfs kobject and is linked
into the same module. The generic core contains no ACPI types or symbols
and initializes without ACPI support or with ACPI disabled at boot.
The existing /sys/firmware/acpi/platform_profile and
/sys/firmware/acpi/platform_profile_choices attributes remain available
on active ACPI systems.

CONFIG_PLATFORM_PROFILE_LEGACY controls the backwards-compatible aggregate
sysfs interface. It defaults to enabled to preserve existing userspace.
Disabling it omits the legacy sysfs callbacks and ACPI adapter while
retaining class devices and kernel profile cycling. New userspace should
discover and control individual class devices instead.
The interface is deprecated, with removal intended after the 2028 LTS
kernel once userspace migration is complete. A shared pr_notice_once()
warns on legacy attribute access rather than on merely loading the core.
The default remains enabled while userspace adopts released class-device
support; this series does not claim that ecosystem migration is complete.

The existing firmware-independent interface remains:

  /sys/class/platform-profile/platform-profile-X/name
  /sys/class/platform-profile/platform-profile-X/choices
  /sys/class/platform-profile/platform-profile-X/profile

Non-ACPI userspace controls providers individually through these class
devices. Aggregate selection remains available through the legacy ACPI
attributes, and aggregate profile cycling remains available to kernel
callers. No new sysfs directory or userspace ABI is introduced.

The original first patch, "Separate handler locking from sysfs lifetime",
fixing the handler access race and sysfs teardown locking issue, has been
sent separately as a standalone v3 fix. It is not included in this series.
The base tree used here already contains that fix.

Patch 1 extracts the core and initializes it before built-in consumers.
Patch 2 completes class-device notifications and registration cleanup.
Patch 3 documents firmware-independent profile selection through class
devices. Patch 4 makes the legacy ACPI aggregate sysfs interface optional
and documents its deprecation.

Validation performed during development (before this rebase):

  - ARM64 built-in core with CONFIG_ACPI=n: W=1 build and sparse.
  - x86 modular core with CONFIG_ACPI=y: W=1 object build and sparse.
    Both CONFIG_PLATFORM_PROFILE_LEGACY=y and =n are covered.
  - Full x86 kernel link and QEMU boot with lockdep and list debugging,
    with active ACPI and with acpi=off.
  - Firmware-less providers exercising common and hidden choices,
    profile reads/writes, invalid input, mixed profiles, cycling,
    partial callback failures and POLLPRI on the class and legacy ACPI
    interfaces. With acpi=off, class get/set, notifications and kernel
    cycling are exercised. Both runs check that no new aggregate sysfs
    directory is created.
  - Concurrent sysfs I/O with two persistent providers while a third
    provider is registered and removed 200 times, last-provider attribute
    removal and repeated provider module reloads.
  - QEMU with active ACPI and CONFIG_PLATFORM_PROFILE_LEGACY=n: verify
    the legacy attributes are absent, class get/set and notifications
    work, and kernel cycling and registration/removal stress pass.

The provider API and profile names are unchanged. Aggregate writes retain
their sequential, non-transactional behavior: a failing callback does not
roll back providers already updated.

Changes in v3:
  - Send the original first patch fixing the handler access race and
    sysfs lifetime locking separately as a standalone v3 fix, including
    the requested profile_lock protection comment and Fixes tag.
  - Reduce this series to the four remaining patches and renumber them.
  - Rebase the remaining changes onto the current base, which already
    contains the separately submitted locking fix.

Changes in v2:
  - Add the Fixes tag to patch 1 and explain how the mutex-guard conversion
    reintroduced the teardown deadlock previously fixed in 041142d7d252,
    and how class-device support subsequently extended the affected paths.
  - Drop the proposed /sys/kernel/platform_profile/ aggregate interface
    and its ABI documentation. Use the existing firmware-independent
    /sys/class/platform-profile/platform-profile-X/ devices instead.
  - Preserve aggregate selection through the legacy ACPI attributes and
    retain internal aggregation for kernel profile cycling.
  - Refocus patch 3 on class-device notifications for direct writes and
    restoring aggregate visibility after failed registration.
  - Update the Kconfig help and documentation to describe the existing
    class interface and distinguish it from ACPI aggregate selection.
  - Revalidate class controls and notifications with acpi=off, legacy
    aggregation with ACPI active, and the absence of a new aggregate ABI.
  - Add CONFIG_PLATFORM_PROFILE_LEGACY (default y) to make legacy aggregate
    sysfs code optional, independently of class devices and kernel cycling.
  - Mark the legacy ABI deprecated and describe removal after the 2028 LTS
    kernel, conditional on userspace migration. Emit one shared notice on
    legacy attribute access; retain the enabled default during migration.
  - Move the legacy ACPI ABI documentation from testing/ to obsolete/,
    document the replacement class attributes and update MAINTAINERS.

Changes in v1:
  - Initial series extracting the core from ACPI, separating handler
    locking from sysfs lifetime operations and retaining the legacy ABI.
  - Proposed a firmware-neutral aggregate sysfs interface alongside the
    existing per-provider class devices (removed in v2).

Daniel Lezcano (4):
  platform profile: Extract the core from ACPI
  platform profile: Complete class notifications and registration
    cleanup
  platform profile: Document firmware-independent profile selection
  platform profile: Make legacy ACPI aggregate interface optional

 .../sysfs-platform_profile                    |  12 ++
 .../ABI/testing/sysfs-class-platform-profile  |   2 +-
 .../userspace-api/sysfs-platform_profile.rst  |  55 ++++++--
 MAINTAINERS                                   |   5 +
 drivers/acpi/Kconfig                          |   3 -
 drivers/acpi/Makefile                         |   1 -
 drivers/cpufreq/Kconfig.x86                   |   2 +-
 drivers/platform/Kconfig                      |  35 +++++
 drivers/platform/Makefile                     |   2 +
 drivers/platform/profile/Makefile             |   5 +
 drivers/platform/profile/acpi.c               |  15 +++
 .../profile/core.c}                           | 122 ++++++++++++++----
 drivers/platform/profile/profile.h            |  17 +++
 drivers/platform/surface/Kconfig              |   6 +-
 drivers/platform/x86/Kconfig                  |  10 +-
 drivers/platform/x86/amd/pmf/Kconfig          |   2 +-
 drivers/platform/x86/dell/Kconfig             |   4 +-
 drivers/platform/x86/hp/Kconfig               |   2 +-
 drivers/platform/x86/lenovo/Kconfig           |   6 +-
 drivers/thermal/intel/int340x_thermal/Kconfig |   2 +-
 include/linux/platform_profile.h              |   3 +
 21 files changed, 255 insertions(+), 56 deletions(-)
 rename Documentation/ABI/{testing => obsolete}/sysfs-platform_profile (70%)
 create mode 100644 drivers/platform/profile/Makefile
 create mode 100644 drivers/platform/profile/acpi.c
 rename drivers/{acpi/platform_profile.c => platform/profile/core.c} (88%)
 create mode 100644 drivers/platform/profile/profile.h


base-commit: 8244dc8f69f0e73cb1789355260b7d68bf5494e7
-- 
2.43.0

