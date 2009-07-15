From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: drm/i915: LVDS lid patches
Date: Wed, 15 Jul 2009 15:11:22 -0700
Message-ID: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-35.bluehost.com ([69.89.18.155]:56769 "HELO
	outbound-mail-35.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753685AbZGOWSI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 18:18:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org


After some discussion with Matthew this morning, I decided to split this
patchset up a bit.  I'd appreciate acks/reviews on stuff that's ok so we
can get this upstream (the first two fix a real bug), and discussion on
the rest if there are issues.

This work was initially motivated by fdo bug #21230 (first to patches
cover that) but also adds some features that have been missing from our
LVDS support (second two patches).

Thanks,
Jesse
