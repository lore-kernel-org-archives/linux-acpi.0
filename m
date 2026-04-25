Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9B3624BC;
	Sat, 25 Apr 2026 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154275; cv=none; b=RDmHjTDaKI2pNsCIpYgI4oE1BWvQjjhP71y2/I/LDPnLwKRl8d0nEg/rq59O6VYkRouEBpWYJD+Mnq96y5yLOh2iW9ezuHzYL7rBe10FbzUL1a4hu7hj2LFnkk3yv9zXK3XUREtbkBNC1Ynvf7/rvGJuTAEeyn58JPHdBFhRwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154275; c=relaxed/simple;
	bh=AP89DkESuwydEd7J0wae54cCZMvXIyheVKlao9Qrhgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqJV+BnCYunoCzsO8KBBATMz1Y9Cc9elrigoW82vqB35XRaXuO8bqRLFDa3AQEEM6Yb+an0OHhTaPtCDZe7s8BNa1YcpoxVZgwATrNmYfCeiK+iOHeUUvbl5aNvkU506EpBpCQwYtpymmBlgkoF1EbK5M7ZCvgKs+QnAp3/Gqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=cpYsQhvU; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="cpYsQhvU"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id BA180C1878;
	Sun, 26 Apr 2026 00:57:50 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 3BD53C1848;
	Sun, 26 Apr 2026 00:57:50 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id ED8CE1FD47E;
	Sun, 26 Apr 2026 00:57:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777154269;
	bh=N4qEeycmmz0KE5x0LMZMn4VfPN7YU/1xc0CRVvTcA4c=; h=From:To:Subject;
	b=cpYsQhvU5eEA1YnmYyhu0hkUeYL1KwGspF+Jynri2yThhfyQQunWD9PTDY5B9UMmo
	 /TmAqKKSP3Iv869Pq/tM/OVgYKcZo32FM5feLTNAM5vXgsZc/iHa8qP2Rony0tT7au
	 y484MLKqJu4i4PoTKDx3H89SLsa1HRtUNowipXUPW85XfO4PJF0730b47OiO2MJJ+e
	 u9Yk7m4ouUD7BJaQ9ssZfwXiWu7vAYtUm0ynVgL23X1lJsQr7x6vUS7TJIQU6VFDpj
	 yczwxTCSuhAHwkV3578SXmCt8Z4DOpe5Q2FI/8FfQJewuf+YzgTmoogADjoSvvAH7+
	 eO9vXa1cP9zpQ==
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
Subject: [RFC v2 07/10] Documentation: Add documentation for the new sysfs
 hints class
Date: Sat, 25 Apr 2026 23:57:31 +0200
Message-ID: <20260425215734.14116-8-lkml@antheas.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425215734.14116-1-lkml@antheas.dev>
References: <20260425215734.14116-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177715426979.3678271.16250783409712348661@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The new sysfs hints class allows adding standardized hints to inform
devices of the host state. The initial hint added is the idle hint,
which allows userspace to inform devices of the host's idle state
based on user interaction (e.g., inactive). Add the documentation for
the new class and the currently available activity hint.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-class-hint | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-hint

diff --git a/Documentation/ABI/testing/sysfs-class-hint b/Documentation/ABI/testing/sysfs-class-hint
new file mode 100644
index 000000000000..9d6ec956ebb4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-hint
@@ -0,0 +1,78 @@
+What:		/sys/class/hint/*/name
+Date:		June 2026
+KernelVersion:	7.2
+Description:	Name of the class device given by the driver.
+
+		RO
+
+What:		/sys/class/hint/*/idle_choices
+Date:		June 2026
+KernelVersion:	7.2
+Description:	If the device supports idle states, this file contains
+		space-separated list of idle states supported for this device.
+		These states can be used to modify the runtime appearance of the
+		device (e.g., turn off the fan for snooze, turn off the keyboard
+		backlight for inactive) in response to user activity and host
+		state. Userspace can keep track of the idle state of the host
+		and inform devices with idle hint support of the current state.
+
+		The following idle states are supported:
+
+		==========	========================================
+		active		The user is actively interacting with the host.
+				The device appearance is unchanged and normal.
+		inactive	The user has stopped interacting with the
+				host and triggered an inactivity timer (e.g.,
+				lockscreen timeout) and the host displays
+				(if any) are off. The device may choose to
+				change its appearance (e.g. turn off its
+				backlight) or suspend if it is user facing
+				(e.g., handheld controller).
+		snooze	  The host enters a "dark resume" state where the
+				host should look like it is suspended. In
+				response, platform devices may turn off the
+				device fan, pulse the power light, or lower
+				the thermal envelope of the device.
+		resume	  While in the snooze state, userspace has decided
+				to prepare for user interaction while remaining
+				in snooze (e.g., user pressed a keyboard
+				button). If the device lowered its thermal
+				envelope for the snooze state, it can use this
+				hint to restore the normal thermal envelope and
+				lower the time to interaction.
+		==========	========================================
+
+		Reference the following diagram for userspace implementations:
+
+		<Suspend> <-> <Snooze> <-> <Inactive> <-> <Active>
+			       ->  <Resume>  /\
+
+		Where Suspend is the normal suspend path (e.g., s2idle). Devices
+		may support a subset of these idle states (e.g., only active and
+		inactive). In this case, userspace should report the closest
+		supported idle state that's higher than the target one.
+
+		Examples:
+			1) Device supports inactive and active:
+			   If the desired state is snooze, choose inactive
+			2) Device supports snooze and active:
+			   If the desired state is inactive, choose active
+			3) Device does not support resume:
+			   If the desired state is resume, stay in snooze
+
+		RO
+
+What:		/sys/class/hint/*/idle
+Date:		June 2026
+KernelVersion:	7.2
+Description:	Reading this file gives the current selected idle hint for
+		this device. Writing this file with one of the strings from
+		idle_choices changes the idle state to the new value.
+
+		Depending on the device, certain transition combinations may
+		be disallowed. Specifically, devices can choose to reject
+		entering resume from a state other than snooze and re-entering
+		snooze from resume. In this case, the device rejects the change
+		with -EINVAL.
+
+		RW
-- 
2.53.0


