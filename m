Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3438C42A
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324901; cv=none; b=CTDPjQImfvKehoXpYUOB+sqBVeohLX2GwvEX2nqV37F9aFy5XEjh3Z7GmWFom6/5OqOg+DLQCMB0GzpSnHtmgLr7KgqskffQF6HmzP0AVRd9DlpOEWOrHpYPVrHBLaW1omt8IeLrETNZSjJeUgfPHFZ86aEcWdsTeoZuvO8JIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324901; c=relaxed/simple;
	bh=WxT6lVs9MgsuWp/JAwT66ZAX1dKhM5RJCq8dbsRGhow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ABxnufjNf/n25fw7zv0GwJbmGQUEIvrWPC6szZPlBTfEPpNS7+FLxT9L+xDRse6RRgsPSBX8NmXnZ+v943/svMpkFFyRuNLL5uCJqZ+yNmqmaKpqFP7Z5XIEEOJ3RwSj+03Ld3hwxLu2dlK4XncQ5Y1lhFJcKBqQtEH2iWwPGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0d7/323; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0d7/323"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso2027028a91.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783324889; x=1783929689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gJvKFBhbLNKrQe8U6iLR7ngf05g4B/STtc91x5bvpI4=;
        b=b0d7/323Jr2YmomoVuSGxEmkp4K6sAREODe2rC91Wo1BlgMXhc6v9UsDNEuDpwWmli
         IfYmBsUuxxzfeTBCkAdOQhwAJofuGlkDJlDvE7z0UCYgnGQZ6omEVCysOFpfrmNNuE+p
         4BMMo5o9nM5dqntqetgBIl1o1JAhHzIRUVrfPnBvZx4HbTtC755FYoa1WmvT+trfi5ne
         ZLNNaRkBu1MzAaSryPIV5qTMBZrGyCCkpCwyGsFfwy4PVoB5UgS47OsmS9CX0VUqh/yq
         ktdlXmMuJo3A4MwVnwwKvUGQDXMOSFADwL2V7zlKlDsZ/i9TxZL2thI0KlGC+b6RuDF6
         2HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783324889; x=1783929689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJvKFBhbLNKrQe8U6iLR7ngf05g4B/STtc91x5bvpI4=;
        b=iJiDdCY8MZPrnrp0ZoyafdyQXhCP2USggEeQE1O5OJxSsCFzAikqpxDcqdk5ZzNPPL
         06bm8U2U8StKXKtbwsOF4TUdbKB6idAqsw/fa/ZfLVYbMz1vVpL7t1FX6UlwzefR7EF8
         HbsTjF61Ujwsx/tPy2kNr3AtzKU9ubu+BT0wXXJVI0uhMNFSmVB2gttXWdwZlKGigcqp
         LE/GpauqXD8OB5Js3UVANDTFzuUd93PTJJVIgn6shrL3wnCwgwGOiXc92xyjwPxEHEJq
         1Rc4rw24/G0Xdl/3T8l7n08MPBxR1zb5lL7rk9DaQ5qwzIy3PEupPGEfr5mbY9ZxG1QT
         nOgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpg+MtgRkLOOgf7wwdb+RRsvw5vXdT/E6+AWvCmCJSsZ5nH2LDG5jYZbRatTe/s4OmPHY78mb8jO1Ca@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3pVUOwQBPbcNvi0oMVtJxn45Q6wOeo+OG5Nul21LCdID5Abz
	GvTkR0madVYgs9zvGEghz9qFO4f75izoHuookhH8rucmB0dAcdrquwPMwvEE2390EUU=
X-Gm-Gg: AfdE7ck90jP7WpjEVH72KihDynRG146ybMv9tld7WHKZfxa0L5hyfO3jS377RsBFa8h
	M/wVNwMy4oOCCBdul/ZzRjOfOTTXg9a0zry0bkakXWM3rPF3b2sDIgcZmaNB1vdj2ZSVc7tFtJB
	sQWxbRCJZoSSZ1dUsxIlFMxxRfSPojWGtrP41/wMvQtWEJWvhwS//eV6k4aWRVAdjE9M3aR8zLc
	MhRSOwE+GYwRics7Y2nmTRQeovyQbhHzimxAxEiwM+DJKRMPUdB6tHIqbqFAvzp/l+7OarAIYY6
	a9ZHEwgBuNJGTuL3d2D5vVfI67YCJ/57O3VE5nYeekbu5gSFwV0+I4ul6VIl99jsNandgntCuKL
	KCZy4s/f3l4I+m/0ExFZD+8C4X+5pnzdngXXbX+dRkWzcDc3JS4jCEyWlzbqG+VBe0EVYDGSE8w
	P4nhb22qKenuwNgp+adSkVHFhZMhM/jd4tYHK11s1PXyvCRMqVkwNQ38+mVsFCltMtI4nM
X-Received: by 2002:a17:90b:3909:b0:37f:e8d6:72c0 with SMTP id 98e67ed59e1d1-382806b46d2mr9180596a91.1.1783324888740;
        Mon, 06 Jul 2026 01:01:28 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3812801ebcbsm4429685a91.11.2026.07.06.01.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:01:27 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] USB: hub: call ACPI _PRR reset during port power-cycle on enumeration failure
Date: Mon,  6 Jul 2026 16:01:17 +0800
Message-ID: <20260706080117.3754550-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some USB-connected devices (e.g. MT7925 Bluetooth on Dell laptops) expose
their hardware reset line via an ACPI Power Resource for Reset (_PRR)
rather than relying solely on VBUS cycling for recovery.  When the reset
GPIO gets stuck low the device stops responding on USB; a VBUS power-cycle
alone cannot recover it because the chip remains in reset regardless of
VBUS state.

Add usb_acpi_port_prr_reset() in usb-acpi.c that, given a hub device and
one-based port number, looks up the port's ACPI companion handle, evaluates
_PRR to obtain the power-resource reference, and then calls _RST on that
reference to toggle the reset line.  The function is a no-op if the port
has no ACPI handle or no _PRR method, so it is safe to call unconditionally
for every port.

Wire it into hub_port_connect() during the mid-retry VBUS power-cycle
(at (PORT_INIT_TRIES-1)/2 iterations), calling usb_acpi_port_prr_reset()
*after* VBUS goes off and *before* VBUS comes back on.  The ordering is
critical: on the tested hardware the ACPI _RST method (MBTR._RST) drives
BT_RST low for 200 ms then high again.  If _RST is called after VBUS is
already restored the GPIO pulse races with device enumeration starting on
the live bus; the device begins asserting USB signals while still held in
reset and enumeration fails.  Performing the reset while the port is
de-powered ensures the GPIO pulse completes fully before the device is
given power and time to initialise.

After VBUS is restored, add an msleep(100) conditional on _PRR._RST having
succeeded.  USB 2.0 spec §7.1.7.3 (Fig. 7-29) mandates a minimum of 100 ms
between VBUS power-on and the first reset signalling for power settling.
On root hubs, hub_power_on_good_delay() returns bPwrOn2PwrGood * 2 with
no minimum floor; on the tested xHCI root hub bPwrOn2PwrGood = 10, yielding
only 20 ms — well below the spec minimum.  (External hubs already enforce
a 100 ms minimum via hub_power_on_good_delay().)  When _PRR._RST has been
exercised the device must also complete its full power-on sequence (GPIO
de-assertion, internal oscillator start, firmware load) before USB
enumeration begins.  The 100 ms sleep enforces the spec minimum and gives
the device adequate settling time.

Tested on a Dell laptop with MT7925 Bluetooth (idVendor=0489,
idProduct=e139) whose BT_RST GPIO was stuck low.  With this fix the
device recovers autonomously at boot without requiring a G3
(mechanical power-off) cycle.  The relevant dmesg sequence:

  [    1.448491] usb 3-10: new high-speed USB device number 4 using xhci_hcd
  [    6.813942] usb 3-10: device descriptor read/64, error -110
  [   22.685978] usb 3-10: device descriptor read/64, error -110
  [   22.901715] usb 3-10: new high-speed USB device number 5 using xhci_hcd
  [   28.317963] usb 3-10: device descriptor read/64, error -110
  [   44.189949] usb 3-10: device descriptor read/64, error -110
  [   44.294065] usb usb3-port10: attempt power cycle
  [   44.872709] usb 3-10: new high-speed USB device number 6 using xhci_hcd
  [   44.888293] usb 3-10: New USB device found, idVendor=0489, idProduct=e139, bcdDevice= 1.00
  [   44.888318] usb 3-10: Manufacturer: MediaTek Inc.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
v1 -> v2:
- Cc the ACPI maintainer and linux-acpi so the _PRR/_RST usage can be
  reviewed by the subsystem owners, and trimmed the recipient list to
  the people/lists actually relevant to this change (per Greg's request).
- Tighten the _PRR package check from "count < 1" to "count != 1" so the
  single-element invariant mandated by ACPI 6.4 §7.3.26 is explicit,
  matching the existing in-tree _PRR/_RST users (btintel.c,
  iwlwifi .../pcie/gen1_2/trans.c).  No functional change: only the
  first (and only) element is ever used.

[v1] https://lore.kernel.org/lkml/20260326011708.1128840-1-acelan.kao@canonical.com
---
 drivers/usb/core/hub.c      | 14 ++++++++
 drivers/usb/core/usb-acpi.c | 68 +++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h      |  3 ++
 3 files changed, 85 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 24960ba9caa9..1740e96f73cc 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5603,11 +5603,25 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 
 		/* When halfway through our retry count, power-cycle the port */
 		if (i == (PORT_INIT_TRIES - 1) / 2) {
+			int prr_reset;
+
 			dev_info(&port_dev->dev, "attempt power cycle\n");
 			usb_hub_set_port_power(hdev, hub, port1, false);
 			msleep(2 * hub_power_on_good_delay(hub));
+			prr_reset = usb_acpi_port_prr_reset(hdev, port1);
 			usb_hub_set_port_power(hdev, hub, port1, true);
 			msleep(hub_power_on_good_delay(hub));
+			/*
+			 * USB 2.0 spec §7.1.7.3 requires at least 100 ms
+			 * between VBUS power-on and the first reset for power
+			 * settling.  hub_power_on_good_delay() on an xHCI root
+			 * hub returns bPwrOn2PwrGood * 2 with no minimum floor,
+			 * which can be as little as 20 ms.  When _PRR _RST was
+			 * also exercised the device must complete its power-on
+			 * sequence before enumeration; enforce the spec minimum.
+			 */
+			if (prr_reset == 0)
+				msleep(100);
 		}
 	}
 	if (hub->hdev->parent ||
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 489dbdc96f94..bb1b5e8cdc15 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -142,6 +142,74 @@ int usb_acpi_set_power_state(struct usb_device *hdev, int index, bool enable)
 }
 EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
 
+/**
+ * usb_acpi_port_prr_reset - issue an ACPI _PRR reset on a hub port
+ * @hdev: USB device belonging to the usb hub
+ * @port1: port number (one-based)
+ *
+ * Some devices expose their hardware reset line via an ACPI Power Resource for
+ * Reset (_PRR).  When such a device fails to enumerate (e.g. because the reset
+ * GPIO is stuck low), the USB power-cycle alone is not enough; the firmware
+ * reset path must also be exercised.
+ *
+ * This function evaluates _PRR on the port's ACPI companion to obtain the
+ * power-resource reference and then calls _RST on that resource to toggle the
+ * reset line.  It is intended to be called alongside the mid-retry VBUS
+ * power-cycle already performed by hub_port_connect().
+ *
+ * Returns 0 on success, -ENODEV if the port has no ACPI handle or no _PRR
+ * method, or a negative error code on failure.
+ */
+int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1)
+{
+	acpi_handle port_handle;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *pkg, *ref;
+	acpi_status status;
+	int ret = 0;
+
+	port_handle = usb_get_hub_port_acpi_handle(hdev, port1);
+	if (!port_handle)
+		return -ENODEV;
+
+	if (!acpi_has_method(port_handle, "_PRR"))
+		return -ENODEV;
+
+	status = acpi_evaluate_object(port_handle, "_PRR", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_dbg(&hdev->dev, "port%d: _PRR evaluation failed: %s\n",
+			port1, acpi_format_exception(status));
+		return -ENODEV;
+	}
+
+	pkg = buffer.pointer;
+	if (!pkg || pkg->type != ACPI_TYPE_PACKAGE || pkg->package.count != 1) {
+		dev_dbg(&hdev->dev, "port%d: _PRR returned unexpected object\n",
+			port1);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ref = &pkg->package.elements[0];
+	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE || !ref->reference.handle) {
+		dev_dbg(&hdev->dev, "port%d: _PRR element is not a reference\n",
+			port1);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	status = acpi_evaluate_object(ref->reference.handle, "_RST", NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		dev_dbg(&hdev->dev, "port%d: _RST evaluation failed: %s\n",
+			port1, acpi_format_exception(status));
+		ret = -EIO;
+	}
+
+out:
+	kfree(buffer.pointer);
+	return ret;
+}
+
 /**
  * usb_acpi_add_usb4_devlink - add device link to USB4 Host Interface for tunneled USB3 devices
  *
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index a9b37aeb515b..4d3dc3bd881b 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -211,7 +211,10 @@ extern int usb_acpi_register(void);
 extern void usb_acpi_unregister(void);
 extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
 	int port1);
+extern int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1);
 #else
 static inline int usb_acpi_register(void) { return 0; };
 static inline void usb_acpi_unregister(void) { };
+static inline int usb_acpi_port_prr_reset(struct usb_device *hdev,
+					  int port1) { return -ENODEV; }
 #endif
-- 
2.53.0

