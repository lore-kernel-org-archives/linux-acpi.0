Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13B3D9DAC;
	Thu, 16 Jul 2026 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784245555; cv=none; b=L3gsACiAJEwEpWKKon8it4OC5JqLbYEcAozw6WNBqkhPo0YoN0XNo+3LdEo4G4UCZUCC42mS3oJjEt8YC2zP5J82ggn1Q8CNrTOyNURNWkNdyy6lfADkP7XnbXpMt2Og9Ac7EJKeNYdk6yFnEpUJY/TkVIF3GF3tKhQpDDTzYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784245555; c=relaxed/simple;
	bh=s8TYe5nzldhyA5fnj7fqcZhPu87HDXPkqLGtq22pJBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RY9BTNBNpQ1R38VezbtXvWRLGye5dXV1W+lcW4x8YqtTHw3GohF+VglWCNph0yUY8z6rdX/2yDOam17nzf+4+L8O9pbinFbQjVIvvw/54nn8lMvgbLcLe1MAQqAqYFlHxF8Xr1KXn1UAqj0T1e3SLt65dH8W0gHavQ2+jQ+rAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RSy+uvlt; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RSy+uvlt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784245547; x=1784850347; i=w_armin@gmx.de;
	bh=PKXiaLaW3+Aba6I3ZQqmkedA4zKQ+T+LneQYnYvL5VU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RSy+uvltsWcjEfr2EABwA2boqnuxZ9PpO5m5hOkPGjLdL6A7yg4fz6KmvLw50sEa
	 6EedysOvUpDtm39Ns8dK+FoSICu71d488h3gFqWQqPhknlaEPNz8KaGrcDTOBhoWr
	 RPHUcKqf7iK1oDftN61UtEIGN3HtiyNGQU8dOEKkdvaMxn5VV4FVDjWzIS0B+Tac9
	 q5SqnpPwVUx3U4nZwQs9pduPVylj11YE24O/P4qGZ1NtmdmwrVbj67xlrn0qQcDIM
	 VZJQYe8byRleVlDD4Em8nVLvnjWGRB5iuwgJ30r1etrRLA+HztEnXqchFxWepsMFN
	 Rse4EnhuA5aSZ1DsVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1x8jiN1sjo-010udq; Fri, 17
 Jul 2026 01:45:47 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] platform/wmi: Add aarch64 support
Date: Fri, 17 Jul 2026 01:45:35 +0200
Message-Id: <20260716234538.1303811-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UZfzpks7SW/NsmlYvZZjtYPjgFIhxxeLHVq6yJsFf2QYI9uyVYO
 yUC6pyme6s+wLTWQrJuqSlJ0p8b2T9MiLw99NDE8CxGxXmtINoy85XpxYpBgCkSUrB8Dnnn
 +j53rfKBA07QqVqVJnOAJ98JIElMw5TydpjDnTsEc6ZxZhZc1ytcO5HE4G7z0wNjfhdHSNK
 tyZn5NkXnH5IkD5Sme2KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zb4h+jhYit8=;vSA4Cx/f+oSBQVuXRcn98bH7DDt
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

