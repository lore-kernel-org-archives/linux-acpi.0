Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75488632B;
	Sat, 25 Apr 2026 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154679; cv=none; b=iIHhmW7Jy9h48ZKeV/ZqUr1kCDSc7rdURJAa3eZHJz9vu4cokyWqNIP2+LfAiRYctLtg/sTZCGxOsdW6OQJiFb49BS62RmPShYDgBjNzPA8+Op1padjqfu7D9h1i+D3h3luJ5GPwk2nvGaj1dEz62LGHX1S2zSUQ5rqUK+HF7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154679; c=relaxed/simple;
	bh=qFoA68qJoxFaDhUwNjSkwYTuzBtVxlDxR0s+93L+DMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBvJv5y5hVOUOERC7u7gBOMUAAF1Uulcl6U9+gFKw0qi8QAfPHQ8aZrXmJzDxROu2LI3H0LJE5h18L3oil/4gboC7TkvWFp3Q4ey4w4PIUqvUIldJAyvcRxb1aH1INg/4gDCMjdAUvmyePadofoWmqLPTDqjBnD38q6nFfmhI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=fyYz9pJ6; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="fyYz9pJ6"
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id EFF4D5E523;
	Sun, 26 Apr 2026 00:57:44 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 05CF75DF14;
	Sun, 26 Apr 2026 00:57:43 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id DA8471FD3E1;
	Sun, 26 Apr 2026 00:57:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154261;
	bh=+hRBfrc7QNgBCkrLSy3/5OgSPTeqy/HzF416UVWhnyI=; h=From:To:Subject;
	b=fyYz9pJ6rdJTejkbrLo/uYuyPZpJP4wAyor8y9AaQGLbamrwS9fepI/tHRnMjWyU+
	 b7mmS2f4QWJwIvHPNAx39U3MAXYvPH7n0WjBh1Hs4DKb5o8AAd0HJuS2gZpLSDCtt2
	 ToSKpFwCrJhedJ6rkMDvU2wsIl8ReMecj1uDPn0b63QfzKaBcAILY7AN46aLuBMMCW
	 M2i7Z2GocUge33UVu1HU3boEYEqi5DaO2xuyq9j0ztTWU1SfYpAo0sbxkOT76/tC/M
	 T0LdfT9a8dDLrbRRumS2+kcFyA2mAg+RjfbPH6sRvLuE7jE40U1zTN+RJNuVN67SBe
	 7JnRk610UOGAg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v2 00/10] acpi/x86: s2idle: Introduce and implement hint class
 ABI and idle hint for s2idle
Date: Sat, 25 Apr 2026 23:57:24 +0200
Message-ID: <20260425215734.14116-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177715426163.3677629.16268935746966871182@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

This is a two-part RFC series that in the first part cleans up the Modern
Standby firmware notification order and in the second part exposes them to
userspace using a new hint class ABI that can be extended in the future to
add more userspace hints to devices.

For more information, see the V1 description.

In the first part, we begin by renaming the s2idle.c constants to match
their spec from Windows. Following, we place all MS firmware notifications
to begin() and end() to match Windows, ensuring that the USB subsystems and
EC are active when they fire, eliminating a class of bugs due to the
mismatch. Finally, we add a small delay quirk to begin that is required by
ROG Ally devices, which is bound to asus-wmi through the handler interface
exposed by s2idle.

Since these bugs completely fix the sleep behavior for all models and
firmware versions of Ally devices, including those introduced with the
previous suspend fixes when mcu_powersave is off (which is part of the
reason the driver forced it to on; not just standby battery drain), a
cleanup follows that removes the duplicate handling of CSEE (the underlying
function of the Display On/Off _DSMs and which malfunctioned because the
USB subsystem was suspended during its calls) and the now unnecessary
firmware version checks and error logging.

In the second part, a new /sys/class/hint interface is introduced with an
initial hint, "idle", which allows modifying the idle state of the device.
I chose the name "idle" instead of "activity" to leave "activity" free to
use in the future for e.g. "gaming", "video", which might be useful
especially for embedded devices. "idle" might alias with "s2idle" so the
name is not set in stone.

Each driver that wants to implement hints can register a hint class and add
hints to it, which are then exposed in /sys/class/hint/<class>/idle
allowing them to receive updates as well. Current WMI drivers should not,
as their behavior is already handled by the initial s2idle idle hint.
However, non-MS devices can e.g. the ChromeOS EC or even the CPU scheduler.

The two parts are designed to be independent of each other, so that we can
merge the re-order in an initial kernel version and the hint interface in a
later kernel version, if needed. As such, after the first part is cleaned
up it will be resent as non-RFC and the Asus/hid/px86 maintainers will be
cc'd. Then, we will iterate on the hint interface.

To test this series, it is recommended to enable logs with:

sudo bash -c "cat > /sys/kernel/debug/dynamic_debug/control" << EOF
file drivers/acpi/x86/s2idle.c +p
file kernel/power/suspend.c +p
file drivers/base/hint.c +p
EOF
echo 1 | sudo tee /sys/power/pm_debug_messages

Here are some commands afterwards:

echo "active" | sudo tee /sys/class/hint/s2idle/idle; cat /sys/class/hint/s2idle/idle
echo "inactive" | sudo tee /sys/class/hint/s2idle/idle; cat /sys/class/hint/s2idle/idle
echo "snooze" | sudo tee /sys/class/hint/s2idle/idle; cat /sys/class/hint/s2idle/idle

I have not tested this series on Ally devices yet, focusing on the Z13.
A previous version of the series performed correctly and is what was used
in e.g., Bazzite, with around 5-10k Ally users.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---

Changes since v1:
  - Rebase to v7.0
  - Other than the first patch, the rest are re-written.
  - The hint class is based on a simplified version of platform-profiles
  - Transition handling is now done in s2idle.c exclusively and is not
    part of the main ABI. Drivers receive idle hints updates instead.
  - The rename patch now also renames upstream ACPI_MS_TURN_ON_DISPLAY to
    ACPI_LPS0_TURN_ON_DISPLAY for consistency. It is also fired
    unconditionally now by the transition handler in patch n-1.

V1: https://lore.kernel.org/all/20251226102656.6296-1-lkml@antheas.dev/

Antheas Kapenekakis (10):
  acpi/x86: s2idle: Rename LPS0 constants so they mirror their function
  acpi/x86: s2idle: Move Modern Standby calls to s2idle begin/end
  acpi/x86: s2idle: Add support for adding a delay after begin MS calls
  platform/x86: asus-wmi: add s2idle begin delay for Ally devices
  HID: asus: remove quirk handling for Ally devices
  platform/x86: asus-wmi: Remove Ally s2idle resume fixes
  Documentation: Add documentation for the new sysfs hints class
  hint: Add hint class ABI for devices to receive updates on host
    activity
  acpi/x86: s2idle: Listen to idle hints to perform MS transitions
  acpi/x86: s2idle: Subtract delay from last DSM fire in begin delay

 Documentation/ABI/testing/sysfs-class-hint |  78 ++++++
 MAINTAINERS                                |   8 +
 drivers/acpi/Kconfig                       |   1 +
 drivers/acpi/x86/s2idle.c                  | 309 ++++++++++++++++-----
 drivers/base/Kconfig                       |   3 +
 drivers/base/Makefile                      |   1 +
 drivers/base/hint.c                        | 283 +++++++++++++++++++
 drivers/hid/hid-asus.c                     | 113 +-------
 drivers/platform/x86/asus-nb-wmi.c         |  40 +++
 drivers/platform/x86/asus-wmi.c            | 132 +--------
 drivers/platform/x86/asus-wmi.h            |  14 +
 include/linux/acpi.h                       |   1 +
 include/linux/hint.h                       |  38 +++
 include/linux/platform_data/x86/asus-wmi.h |   8 -
 14 files changed, 727 insertions(+), 302 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-hint
 create mode 100644 drivers/base/hint.c
 create mode 100644 include/linux/hint.h


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.53.0


