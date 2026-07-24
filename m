Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D62FE07D;
	Fri, 24 Jul 2026 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859956; cv=none; b=rcbgTyYremAnZRVY1RfMcBaVXZJGYMe4KVy737pmLRmcjyeF4kyxv55jAag6ihTeB0H23MfmaS4vy/+ELSdjtuceLGdEyeEDahLsLAiM80W8/D5dV7iUWi2PheErsm9pNCltLx9Cx9PyQ0qpCYMyA0vSCjvNQ2H+A4yp3DO9PpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859956; c=relaxed/simple;
	bh=vR37dMYxASDvFAAcTy+t0fyeEO2IqhYdu5ZdK6huXds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TinCQeMfhsKgbkY9YaFOue6fAaDRdpuay15YGesF5NQlGp0yeZFc2kaMtTl9sAgCiwVTvAJcp9C3uoGhzYK22l8lx0aFf7g//rdWO9CoVHCtZynPpttCGF21p3vj10nwvEwB6JwwG9scPak+CfRwZ3ZRvbWLc8ipRmQTUnzM5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hEwmQ7AC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hEwmQ7AC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784859951; x=1785464751; i=w_armin@gmx.de;
	bh=2qGkW5IDIDpgVl8My3ODiAecgzop5vUsyHT6AYoXDJk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hEwmQ7ACf9Om+cRywBTHtOm7r3dOpDYw401ooSFsnJ5f786TNtWk4yFeKFbL0sUA
	 TNgq18+RTIax3crAGCR5noJvohX200guZP76lG2BoPVLumiRuzYVkWvk84GNXv8Fx
	 MCT5AZEvH9oMvxaflF2Fq7iDUh+WRmBna3QzzlAUNxdy3Q1s0FaPdDPDnG95Yjd+F
	 47uAOO0SRBfpvYWNf9hdodINzRjqEi7fb1VlG1Bk+AOnSKUFZhSkKavB42B4V6H3o
	 YeIh37umsIRcPvC14FEM88fcbTRoVSMZ8wbfUpSIXYSRsCYJT/iYOCIPgTHI+qSLT
	 AB/mpsu6O5nyu85e/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1x39DE1hcd-01541x; Fri, 24
 Jul 2026 04:25:51 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	intel-gfx@lists.freedesktop.org,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	intel-xe@lists.freedesktop.org
Subject: [PATCH v2 0/3] platform/wmi: Add aarch64 support
Date: Fri, 24 Jul 2026 04:25:23 +0200
Message-Id: <20260724022526.139370-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MLfKRpNO6nS1LngI27vrPWgZMqr/zoES9fILiLM7ihhune/Rl/w
 rLzT8yEaIURU42tHiBT56Lq69UB/u/ciPQQetClZFygcgUBHZhBn79e6SMgIYi5QJLo/XHE
 lIA/fEeY7oCG+ri+TXqXjTv3fd8DmKmqVgkIeVpFET+mPVhSHE+ySBj1AnX9RPzszssSCou
 dbIIJB3gkFzcjzpnHp1wQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i+RwJ6L46rs=;EI7yg/pk9H6POsf9Yh6KgX1WdnE
 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

The aarch64-laptops project found out that some Windows-on-Arm
notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
exactly like on x86. Those devices however are currently not
supported by the WMI driver core due to only supporting x86.

The first patch removes this restriction and allows the WMI
driver core to run on all architectures that support ACPI.
The second patch updates the acpi-video driver to take advantage
of the improved support for architectures other than x86, and
the last patch enables the generic WMI BMOF driver to support
aarch64 as well.

All patches have been tested on a ACPI-based aarch64 VM and
work just fine.

Changes  since v1:
- add additional tags

Armin Wolf (3):
  platform/wmi: Remove dependency on CONFIG_X86
  ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_ec_supported()
  platform/x86: wmi-bmof: Move to generic WMI code

 MAINTAINERS                                     |  2 +-
 drivers/acpi/Kconfig                            |  2 +-
 drivers/acpi/video_detect.c                     |  8 --------
 drivers/gpu/drm/amd/amdgpu/Kconfig              |  4 +---
 drivers/gpu/drm/gma500/Kconfig                  |  1 -
 drivers/gpu/drm/i915/Kconfig                    |  1 -
 drivers/gpu/drm/radeon/Kconfig                  |  4 +---
 drivers/gpu/drm/xe/Kconfig                      |  5 ++---
 drivers/platform/wmi/Kconfig                    | 14 +++++++++++++-
 drivers/platform/wmi/Makefile                   |  4 ++++
 drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} |  0
 drivers/platform/x86/Kconfig                    | 12 ------------
 drivers/platform/x86/Makefile                   |  3 ---
 13 files changed, 23 insertions(+), 37 deletions(-)
 rename drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} (100%)

=2D-=20
2.39.5

