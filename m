Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BF370AC2
	for <linux-acpi@vger.kernel.org>; Tue, 18 Aug 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036349; cv=none; b=ITcm83XcIVkrgtKsxOoVNAFqzZMn2Yy7FyW/Y9+7vucGj2QlGuukkAmP9d/POYebSy/52IvDM2Qyx0dHp2656zff1kjR9YtPl9cbC3CDhccJfHbyC/56E3eg/zjyFmXHAvorspRnBb4Rczy1dcAjtacRIlIPEJAbFgF/RY+jH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036349; c=relaxed/simple;
	bh=D/pmpT1MHUXbBSsDgHnw4mLi6p3iwlFDCAYqzCrg8no=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=asv9MkWWloYgcXZsACFNi+ASb18R65UD8+Ze/BXKaht+RB8JUJWAMFYc3B9xseX+yK9EhlTzax5YfgJy4iz4onAlsDXX5cIFZ7pJ25igow3BrV8/VVlu/zQYFF5XeT6MCNwUFyu5P+BkskeWM48d/p8kpHCHVKx36775Dzz+0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMqXuTuI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMqXuTuI"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9d7464b71so3119761a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2026 23:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036341; x=1787641141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DeMyVaMFOea0yLlM8gVonhIGCBF8ArkQ/Fdvw30KkVU=;
        b=LMqXuTuIYP2L1kXgtO5Vs15MIDEiz/nNk7wUQcMnvDBdMV6Ujzy80KENsGA8eUcwKy
         Qh6lfMO1Zp76HOWrkfTEMkpiPz/qpFU8B2H04K2w7wpsMZk0eR6USKkx+NKA7x4SMqAX
         aSWB6Qk0lD+cbsGD79U0AJCeHQT5+/oEF3TjQM3SbpSqKW4RB9XN2cLcR6mvoG+Hw8zs
         A60voU5YrbqrsHsXnGwrTa0TAtTelS82KNiaS6Wh/7ycTgQQdkX0YNzxQNYz9kY88j1n
         imYV2fQhfX8i9pyi3bHXJSHRcavBp+7S/dBT1iO4ddNso+6mKnLEtN2BQRHQ+WUaNMNV
         chlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036341; x=1787641141;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DeMyVaMFOea0yLlM8gVonhIGCBF8ArkQ/Fdvw30KkVU=;
        b=BrTSq/RkoAAjf49iFvq4R8gDExwfC3ORny//GuBUf93TyurCkyDGlAMqlq5WSo4AR2
         3L/AI/9q5AuSF8qViIoQCAxxDCj1fDExCaJ957iF5kOn7O+ClPqm6fb+zGH5H14fYv5O
         niAjLQoif8xRJlMMM4Fsbd/qLoZcTJDwdMS6xQ3Bgk5N0heiSIfwbq8WS/NsUuWQocoC
         z5qnD8IxGsO366cCwiTZV146cgd1LEqvd+4Yz7bKVqyIb7c8g94EHlxDlpWCkyX5XB8s
         nbFrJQD0E/EQq8K7dtIx60rig0CZivTRBSKnpx/3Hy1Je+cc8NwmuEHoe3ACc6JAidjH
         RgyA==
X-Forwarded-Encrypted: i=1; AHgh+RrklC/V++A54o5Uor70UbeGbvGAWXpJrXMSt5CTvgrma2CX0a4wkK6LXnJ7JPpSfVh1Rnr7uo9MBvQ/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62M0qLU6/lA1q2PhtiIeW3xNQDA9Tpx471y1KNK+oJf/7QbRs
	rQ4wcNUjzvExB5kxUYpLKrehZyWCr+nRQvBzxBG2IGn9UibwLXHNtLPM
X-Gm-Gg: AR+sD10AdF6XaJQoMMpKT8130J8klzQvjhFF58gb3HcxqeinhgnSg98kbxlV6PY0wZH
	Rwla6t1s6EDSPWVpKJ8DSvQFZqtkOFsWAvclH1NhoCVyemgR/lrEX1+YNl4QZ0pTdmwPQWl4sFr
	56smSVjLpstXkSjkKkivq6eZAYHBrj3ZETMZOjwL7/Dxr2DiKojzZMSo9yt45NPtpHkO+n2dr+q
	kUteEDfldfCnAMkyqNci0ZfsKVjmRQdAl6puOemPhJw5QAWvBGbP35V4f5s16aepp70HoYhze35
	Qa/0C65RbA/qSI+KZaBDckRPYK1KP5mWdyojlWzbkZ7GgjCYY4gZ0xtykyAlmXd6DsuBpwy4w/w
	bolFVdEDERTFaDwCR4iSmurOBpkDa6Lpy9zZjf4iBcv2oC5JqhuBTm9LZqnQUM5B3DXGDBR3DDj
	g+7NICgPU6dUrx0SjCWJDd4/Hacon2/QjfGKB4AuncfpqMWZKx6w5Oxhe+IcdUfYHeF+lX1dBjC
	ptsUKLMiavySeRDGBTJCVCZYsgUJrcQOeVwgCOK/qUHPseq78qsph/jnvaITQO+vtL4P6i5D4sV
	/81tgD+lj2vOCMAmjDVktHfZd61qX6ZdoAFCzfCyWsKbnQfyA9xzS/vsAKeA0/A3i8JDsz3S0fu
	roY33JMSyBFxrsOFN
X-Received: by 2002:a05:6830:6996:b0:7eb:89e4:8f5c with SMTP id 46e09a7af769-7f423ec621emr6353519a34.14.1787036341544;
        Mon, 17 Aug 2026 23:59:01 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41beef430sm3599463a34.5.2026.08.17.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:59:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v3 0/4] driver core, net: handle fw_devlink for
 class devices and PHY packages
Date: Tue, 18 Aug 2026 00:58:56 -0600
Message-Id: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6tqYUiuDKexgXtZ3KKBRCa4UY7
 m6tG3eazOZn/rw3T+JgQnBknz3JBAEdDjaGYpMR1Up7AYo6ZsIZr1idl9Tdzz16OrYLHaW6ydg
 wDw2hQ3ujIae7StamAQOiaEikjBMYnJPhSCx4amH25PTZRNgVlH8L3t0WnR+mJT0T8nTxtzcOo
 7zIm7osDRM7ebj0ErutGvpkC/ybV/3m8cQDIbQWjZH6m7eu6wtIR6VdOgEAAA==
X-Change-ID: 20260814-submit-phy-package-fwdevlink-v1-76a8f9efe539
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Managed device links normally advance through probe and removal alongside
a device driver. Driverless class devices are added directly, so their
links do not currently receive equivalent transitions. A class supplier
can leave its consumers dormant, while sync-state-only links from a class
consumer can indefinitely prevent suppliers from receiving sync_state().
Removal also does not unbind consumers of a class supplier.

Ethernet PHY packages expose both sides of this problem. A package node
describes resources shared by member PHYs, but is a container rather than
a device. fw_devlink preserves that topology and temporarily represents
those dependencies through the closest device, which for OF MDIO is the
driverless MDIO bus class device. Its proxy links previously remained
after the real PHY had probed and kept the package suppliers from reaching
sync_state().

Handle the generic class-device lifecycle in the driver core. Put
driverless class devices into the probing state while device_add()
publishes them, complete their incoming and outgoing managed links after
class interfaces run, and apply the corresponding unbind and cleanup
transitions during device_del(). This supports class devices as either
suppliers or consumers and keeps descendant firmware links available for
devices created later. Keep inferred links to probing and registered class
suppliers out of no-driver fallback paths, and recognize class-backed
nodes when refreshing dependencies after firmware-tree overlays.

Keep generic firmware parsing faithful to the described topology. Add a
helper through which a subsystem can copy a container node's direct
supplier links onto the firmware node for a real child device, then use it
from PHY registration before device_add(). The ordinary fw_devlink path
consequently creates each managed PHY link at the normal
device-registration stage.

Finally, defer supplier sync-state callbacks across OF MDIO bus
registration and child population. This closes the interval between
completion of the bus class device and installation of the member PHY
links without adding an MDIO-specific device-link state transition.

This was found while validating an X-Powers AC300 package whose input
clock is supplied by PWM. Before the fix, the PWM driver reported that
sync_state() was pending due to stmmac-0 after the PHY had probed.

The complete series was tested on an Allwinner H616 board with an X-Powers
AC300 PHY package. All five package-derived supplier links targeted the
member PHY and no proxy link remained on the driverless MDIO bus. The PWM
supplier reached state_synced while continuing to generate the PHY clock.
These properties remained true after unbinding and rebinding the MAC, and
the PHY renegotiated a 100 Mbps full-duplex link. Both before and after
that lifecycle test, 8 MiB transfers in each direction compared correctly
and 100 consecutive pings completed without loss.

Validation also included:

  - a full arm64 defconfig Image and modules build with W=1;
  - KUnit tests for class supplier/consumer transitions, inferred-link
    preservation, and fwnode supplier copying and device-link conversion;
    and
  - strict per-patch checkpatch and whitespace checks.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v3:
- Replace the framework-specific proxy cleanup with generic managed-link
  lifecycle handling for driverless class suppliers and consumers, as
  suggested by Saravana Kannan
- Handle registered class consumers during supplier teardown without a
  no-op driver release or driver-only cleanup warning
- Derive class handling inside the shared bound helpers and clarify the
  lifecycle documentation
- Keep inferred links to probing and registered class suppliers out of
  no-driver fallback paths and include class nodes in overlay refresh
- Keep firmware parsing topology-only and let the PHY layer project package
  suppliers onto member PHYs through a new fwnode-link copy helper, as
  suggested by Saravana Kannan
- Defer supplier sync across MDIO bus and OF child population instead of
  deleting proxy links from the MDIO framework
- Add driver-core KUnit coverage and device-link lifecycle documentation
- Drop the unrelated malformed-graph guard because no concrete DT or
  runtime reproducer was found
- Rebase on current net-next/main
- Link to v2: https://patch.msgid.link/20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com

Changes in v2:
- Add a preparatory guard for malformed graph consumers
  (reported by Sashiko)
- Rebase on net-next/main
- Link to v1: https://patch.msgid.link/20260814-submit-phy-package-fwdevlink-v1-v1-0-2319844f057a@gmail.com

---
James Hilliard (4):
      driver core: add fw_devlink supplier-copy helper
      net: mdio: link PHY package suppliers to member PHYs
      net: mdio: defer supplier sync during OF population
      driver core: handle managed links for class devices

 Documentation/driver-api/device_link.rst   |  47 ++-
 drivers/base/base.h                        |   2 +
 drivers/base/core.c                        | 332 +++++++++++++++-----
 drivers/base/dd.c                          |  21 +-
 drivers/base/test/Makefile                 |   2 +
 drivers/base/test/device-link-class-test.c | 479 +++++++++++++++++++++++++++++
 drivers/base/test/fwnode-link-test.c       | 207 +++++++++++++
 drivers/net/mdio/of_mdio.c                 |  34 +-
 include/linux/device.h                     |   9 +-
 include/linux/fwnode.h                     |   2 +
 10 files changed, 1042 insertions(+), 93 deletions(-)
---
base-commit: 47226bbdef69fc0de815b8f5b81b39673f50bbee
change-id: 20260814-submit-phy-package-fwdevlink-v1-76a8f9efe539

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

