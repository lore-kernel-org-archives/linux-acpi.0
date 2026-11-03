Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686128;
	b=ZmxkS5E5SQrNyxpcOpBNq12BsbWg0pV2gsjh/694W7AaEBu8QCWeRsd6dURVnbOG/gyI
	 19c4Foeac+foFpN8Um04Y+JwsSpNFPAlNsqfXmoo1pCD43thn2zCTtk5N1Pq09rFhNwGY
	 rjmJ1wn/S4feUwujTiWLF3sZkqwgoUwoo28rHb1Uz8h8FS23akEzohDqDjxIT1wLJ6ZVW
	 iainC0X70Bc+z+bIbIUMcy3uKCdcxLEt9mI/R5TPARbjaXK+G2E4Kb+UZgSF9kCDuhg7B
	 0bs7a3IYu/xdPDRCuute9CUkudFGFmXB636Mnsz3FHeFdTzueD4SCkM5MCcgqHhElXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686128;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=L6ho8vIeYjjJPXFr89E6+1FFlHcZOfNw8htX3591WFU=;
	b=EmTzB8fDinseEbXqbFbk9jxug6ukDmXDrKFrd6AVD010cFN2jsfyKyAF6Q0vMuY9Rvlw
	 xvMwC0h+yhevXTcY/N3bQVvt2VRZV4Kbgt5T/6yzSd23zdEEKXBLrMqRLkWkLT2LqZBs0
	 LVgucjhnYPc7oAb11Ahr9btaxHbZKBFxB59T/fxokKcmAtuWdDE7vGLtA9aD8w8qtow/x
	 JHC6B8nepQZ8FkjCGpfLXHGL1j8V6b66xB/lsKiPmAkQH6naTY2nJ5ZyoFUcYbAL2RyqB
	 nXpJMxZGwkTFOQVvHcYY6+O8Myht9F5xC4uTur2POsQHhRpP7jRA4wqGoIr7FcG0Ryg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EXxUngDJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E0606A324;
	Tue,  3 Nov 2026 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EXxUngDJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D71B1F000C1;
	Tue,  3 Nov 2026 06:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793686127;
	bh=L6ho8vIeYjjJPXFr89E6+1FFlHcZOfNw8htX3591WFU=;
	h=From:Date:Subject:To:Cc;
	b=EXxUngDJyvmP2yr16wdsWixP/SaWR65lfmiulCYkKQ0Yt40sgdHOTYioRjzxMO7Fi
	 PiXzmhkjfTPlMsbfATOmVl0PTT9BtdJC7BgPBKGHYhK+3iJ4+c+6dA97kQR5UOYIsY
	 Ec866l7ypWCMNfKzYjYW+Xw6VTBuePmCIPIBPo4SAKqyci+F3swh2TSNeu5Dif9hNR
	 uTBNAnn4iHdXbZxe+NLd0ES79dr5FQX7KIjB4y6Ftk0qy7NvrtPl8KNT5zy37hR34l
	 SDIODALxAGPBt1zkqrrWJ4d583HzwW5/iFsJhs/fY9ob9g9JPIRvZrCfUFjRrzGgMK
	 sk9x8IdURC1/w==
From: Mario Limonciello <superm1@kernel.org>
Date: Tue, 03 Nov 2026 00:08:43 -0600
Subject: [PATCH v3] USB: hub: call ACPI _PRR reset during port power-cycle
 on enumeration failure
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706080117.3754550-1-v3-1-0e3069228fe9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAwAwK9UnknktKRBTPwDdTDGgKEkKKEIq
 erfCTDecjMUySoFts0MWV5aNMWKbtUAXyiexeixGlpsewzY4wadC7YLfu09GmeIZaRob5R2TDF
 FZRotpzvU4ZHlpO/fvh/+LtPhKvz8lrAsH0iuGmV/AAAA
X-Change-ID: 20260706080117.3754550-1-acelan.kao@canonical.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-acpi@vger.kernel.org, 
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>
X-Mailer: b4 0.16.0

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
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Link: https://patch.msgid.link/20260706080117.3754550-1-acelan.kao@canonical.com
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
This was sent last cycle but got no feedback except for my review comment.
I think we should bring it forward this cycle.

Changes from v2:
* Rebase on 7.4-rc1
* Link to v2: https://lore.kernel.org/linux-usb/20260706080117.3754550-1-acelan.kao@canonical.com/
---
 drivers/usb/core/hub.c      | 14 ++++++++++
 drivers/usb/core/usb-acpi.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h      |  3 ++
 3 files changed, 85 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 199d3f535a891..72da7aea94cc4 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5621,11 +5621,25 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 
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
index 489dbdc96f94a..bb1b5e8cdc15e 100644
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
index a9b37aeb515be..4d3dc3bd881b2 100644
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

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260706080117.3754550-1-acelan.kao@canonical.com

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

