Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F436654C
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000520; cv=none; b=m+wlnf5cktf19H/E6kpfr2PSwk35O1nPD6U1hcpR7XkVeyismG02pL9m74TH5YXxQ7TJS7EVt3mPeDE9h400dFSUiDEJugtfmA3vXvsMb4yRblE2e0joiezBcY5iplDVSjvSvcg3Xog9t54kx8/rvuZoRinwLJtQBv+4Yj/24KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000520; c=relaxed/simple;
	bh=AfXL3q0vbi+ErhWp0sf0qNwkRrSWh63+VtvCFfblEmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU5AvVIZHam+TONwWEoncD/aTjAyGYsxU3eOP03t4YzdfMfXmQlVLUAdO3u7D8n5CzEr+rc5cIc7nKOgBJQ5FY0YiD8rahOc9fdEG4CwTlM2hUqV7FKEofxTINoG9GfSE7jesuQd9YTe7MK63kpTNPe9nMUCYwVGcFE9QIcdZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ArlZew6o; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ArlZew6o"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9296B3F1C0
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 03:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784000513;
	bh=ZzY5wsxKMGI2Mc8KyAc8hy+PbK57bT4tiVLOUWTC/h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=ArlZew6oS9E1gcWgXpWsYISP++l57mfGBOTjveLipWLdu0eqIN6NNNqQM7L6CE4lQ
	 H/e9/HRXn0P6Y7bsa4UhTnR16uIs7I1hr1kNJbhxII7F8W1QqYlFx91uHEvA8+ly1Q
	 TakM8BUHbMQ5ByB5l0ff15cAxsNHPsFpePVzGvYsxpw2+Hjr8UzDm8l/Q33HIrS5ov
	 bldY10V5cvQFoRrp4XlQ6ya4oZ30ApV7AfRTLPcxXR7J7WyeNvLkFn+KUW4A4Uy+6J
	 VHhduoZulVuS/NRRTrjlfYqSxMzb+p8hOWG5CY54Lft/BoXN8uFw9np+AM1H5H5EV0
	 IWRpIdoFtCohhlNI0vx79nqSapnbQKmDk5tenInv6YO8osyBivzcFZuecdFJBbIy/H
	 MuH6c3yuOmU+nnpncnuoiBNqn5Ps3XDe6cWe6FDRW+V7mHJTv07IQ5ilxWeMNG0Xew
	 a93nFgM7wcxjLagaFDXu+Wp2Vx3NYOFvk16ztWTDN1cwsPqTUMCkHyFeNQjc0tPCiz
	 mJEgVk5wPciiJLsBrt3skIJIn3BjikWk22vAIG7v6wWl9Q834uMCJFICFZlpi3T2au
	 Ez4zqndQYkpUx2YlDXBClEHo77HNUhDS7kDgnff0zAiwNKNxBR/gK5HNMfKHh63cNa
	 bd0adK3p+dcHbB2qzXPzqIPU=
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c354050c34so68225345ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 20:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784000512; x=1784605312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZzY5wsxKMGI2Mc8KyAc8hy+PbK57bT4tiVLOUWTC/h0=;
        b=cjyIqJzYj78MBO2Nsp0cNWn6sXqrZAq6dDPFmUmqmAns5zXPogMbS1v5FJY2ACuySr
         SyTu3/6lshOsForK6lRhVwx/YZRj4Ash8wXpwrHwTPW32spps0zTKiZ7hjs62b5OwQ0E
         kx1x9cFxj5e6nP4DJPz/4xp7Rwhlk1EEwFBr6nEQckmomt+uynxPIzBtu4tk+jc0SEXM
         xkECKenANDzHaLM0kl/b+RqQQegu233IU0swErQw7TCRXiBmWTqOhvTevIHi+znf6y99
         TsVmBOcgGGkZUNeHeViIsqfcgpVFgeA9p3MqIVMfykgIED99xbJZ7pAmj/+A3GsDoRfu
         eebw==
X-Forwarded-Encrypted: i=1; AHgh+RqOeKgfSKqSgFIn1yEV2+N09cq+L/tYG8jy/OGxs9QE2a4uj/OI/lYdXuDxyKBMBC1bmtrNXE1qnbbq@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEYhwnat9SLfy9M1rkYnfN5J2x1FliHbAHEgfOLsdI36/OHid
	Nr3Q1XRI2wGlG9tJvduifEWr3pztuzhWuBRj8fh0Xeix5796G1FwRSmYmAVJAZHC1b7flPSUTHM
	0m3GaDBOqjQSUu7Vo524uRaajlf3auNDuOOetEAp3oGbF4qL89M29qbkvOW8IqlcMpNyh2lQrlI
	Kqli4=
X-Gm-Gg: AfdE7cnRL2O5K0i7dR/JBwUh3tdH3cgVpDPbylafTteQa1hB9kTH9xGCrARDQw8lcAa
	yMWkGGoN/DAOcccyvz80N84rRmJ7M6dnCOo/oQO/llJMIXFLaSs71IYBS60Do/SCrs1qp0NG0be
	TrPMmhrf7YV35bkbRQPGC4ox3DEfsz15HeE3emK/pCbD+ZZaS7zI+n4MZh7PV6Cp895qGmAZKAY
	thIar/QlNalcCtcpwFqoo5eESN8klMV6yPrunowlEIqC+rFpolZrponH/3bYiHgVCcMe2yThcaD
	UHu0alYT7W5MI051v3vrCnb9CkAw5MiiY6/qMLXpWrfj2dWPwH/tiB9TmyWOJy+R16seB5IiAo6
	xVVKyEo3I+09rU6dWx2Ha8JafAtztoaZXj8e4HRZJLqEfXxjdxQ0lAk2EHzDdjeWNroM=
X-Received: by 2002:a17:902:f605:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2ce9eab85f7mr111631045ad.13.1784000512002;
        Mon, 13 Jul 2026 20:41:52 -0700 (PDT)
X-Received: by 2002:a17:902:f605:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2ce9eab85f7mr111630695ad.13.1784000511502;
        Mon, 13 Jul 2026 20:41:51 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d602fdsm108054185ad.81.2026.07.13.20.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:41:50 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:44 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: hub: call ACPI _PRR reset during port
 power-cycle on enumeration failure
Message-ID: <alWq9GI8c4e4PCRD@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260706080117.3754550-1-acelan.kao@canonical.com>
 <a2bf1966-d6a7-4871-b553-51d81ac10597@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2bf1966-d6a7-4871-b553-51d81ac10597@leemhuis.info>

On Mon, Jul 13, 2026 at 05:02:09PM +0200, Thorsten Leemhuis wrote:
> On 7/6/26 10:01, Chia-Lin Kao (AceLan) wrote:
> > Some USB-connected devices (e.g. MT7925 Bluetooth on Dell laptops) expose
> > their hardware reset line via an ACPI Power Resource for Reset (_PRR)
> > rather than relying solely on VBUS cycling for recovery.  When the reset
> > GPIO gets stuck low the device stops responding on USB; a VBUS power-cycle
> > alone cannot recover it because the chip remains in reset regardless of
> > VBUS state.
>
Hi,

> Not my area of expertise, so handle this mail with care and forgive if
> I'm the following question is stupid:
>
> Is this fixing a regression, e.g. some problem caused or maybe suddenly
> exposed by a recent change?
This could be treated as a regression, but this issue is a little bit
complex.
1. There is a new firmware for the Mediatek MT7925 BT chip.
2. There is an updated driver for the Mediatek MT7925 BT chip which is
not compatible with the old firmware.
If we reboot the system with the new driver and the old firmware, then
the issue occurs.

The issue is that we update both firmware and driver and do a warm
reboot. The BT firmware won't reload with a warm reboot, and then
encounter the BT device gone issue. Do other warm reboots do not help.

It requires a power cycle to force the BT firmware to reload. And
after the power cycle, we won't encounter the issue anymore.
>
> It doesn't contain a Fixes: tag, so doesn't look like it. I'm asking
> nevertheless, as I have seen one[1] (and IIRC at least one, likely two)
> other report along the lines of "remains in reset regardless of VBUS
> state.":
> https://lore.kernel.org/all/20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe/
That could be another issue.

>
> And I have seen a user in a fedora-kernel chatroom that also had a
> problem that sounded similar. All with Mediatek wifi.
>
> Ciao, Thorsten
>
> > Add usb_acpi_port_prr_reset() in usb-acpi.c that, given a hub device and
> > one-based port number, looks up the port's ACPI companion handle, evaluates
> > _PRR to obtain the power-resource reference, and then calls _RST on that
> > reference to toggle the reset line.  The function is a no-op if the port
> > has no ACPI handle or no _PRR method, so it is safe to call unconditionally
> > for every port.
> >
> > Wire it into hub_port_connect() during the mid-retry VBUS power-cycle
> > (at (PORT_INIT_TRIES-1)/2 iterations), calling usb_acpi_port_prr_reset()
> > *after* VBUS goes off and *before* VBUS comes back on.  The ordering is
> > critical: on the tested hardware the ACPI _RST method (MBTR._RST) drives
> > BT_RST low for 200 ms then high again.  If _RST is called after VBUS is
> > already restored the GPIO pulse races with device enumeration starting on
> > the live bus; the device begins asserting USB signals while still held in
> > reset and enumeration fails.  Performing the reset while the port is
> > de-powered ensures the GPIO pulse completes fully before the device is
> > given power and time to initialise.
> >
> > After VBUS is restored, add an msleep(100) conditional on _PRR._RST having
> > succeeded.  USB 2.0 spec §7.1.7.3 (Fig. 7-29) mandates a minimum of 100 ms
> > between VBUS power-on and the first reset signalling for power settling.
> > On root hubs, hub_power_on_good_delay() returns bPwrOn2PwrGood * 2 with
> > no minimum floor; on the tested xHCI root hub bPwrOn2PwrGood = 10, yielding
> > only 20 ms — well below the spec minimum.  (External hubs already enforce
> > a 100 ms minimum via hub_power_on_good_delay().)  When _PRR._RST has been
> > exercised the device must also complete its full power-on sequence (GPIO
> > de-assertion, internal oscillator start, firmware load) before USB
> > enumeration begins.  The 100 ms sleep enforces the spec minimum and gives
> > the device adequate settling time.
> >
> > Tested on a Dell laptop with MT7925 Bluetooth (idVendor=0489,
> > idProduct=e139) whose BT_RST GPIO was stuck low.  With this fix the
> > device recovers autonomously at boot without requiring a G3
> > (mechanical power-off) cycle.  The relevant dmesg sequence:
> >
> >   [    1.448491] usb 3-10: new high-speed USB device number 4 using xhci_hcd
> >   [    6.813942] usb 3-10: device descriptor read/64, error -110
> >   [   22.685978] usb 3-10: device descriptor read/64, error -110
> >   [   22.901715] usb 3-10: new high-speed USB device number 5 using xhci_hcd
> >   [   28.317963] usb 3-10: device descriptor read/64, error -110
> >   [   44.189949] usb 3-10: device descriptor read/64, error -110
> >   [   44.294065] usb usb3-port10: attempt power cycle
> >   [   44.872709] usb 3-10: new high-speed USB device number 6 using xhci_hcd
> >   [   44.888293] usb 3-10: New USB device found, idVendor=0489, idProduct=e139, bcdDevice= 1.00
> >   [   44.888318] usb 3-10: Manufacturer: MediaTek Inc.
> >
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> > v1 -> v2:
> > - Cc the ACPI maintainer and linux-acpi so the _PRR/_RST usage can be
> >   reviewed by the subsystem owners, and trimmed the recipient list to
> >   the people/lists actually relevant to this change (per Greg's request).
> > - Tighten the _PRR package check from "count < 1" to "count != 1" so the
> >   single-element invariant mandated by ACPI 6.4 §7.3.26 is explicit,
> >   matching the existing in-tree _PRR/_RST users (btintel.c,
> >   iwlwifi .../pcie/gen1_2/trans.c).  No functional change: only the
> >   first (and only) element is ever used.
> >
> > [v1] https://lore.kernel.org/lkml/20260326011708.1128840-1-acelan.kao@canonical.com
> > ---
> >  drivers/usb/core/hub.c      | 14 ++++++++
> >  drivers/usb/core/usb-acpi.c | 68 +++++++++++++++++++++++++++++++++++++
> >  drivers/usb/core/usb.h      |  3 ++
> >  3 files changed, 85 insertions(+)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 24960ba9caa9..1740e96f73cc 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -5603,11 +5603,25 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
> >
> >  		/* When halfway through our retry count, power-cycle the port */
> >  		if (i == (PORT_INIT_TRIES - 1) / 2) {
> > +			int prr_reset;
> > +
> >  			dev_info(&port_dev->dev, "attempt power cycle\n");
> >  			usb_hub_set_port_power(hdev, hub, port1, false);
> >  			msleep(2 * hub_power_on_good_delay(hub));
> > +			prr_reset = usb_acpi_port_prr_reset(hdev, port1);
> >  			usb_hub_set_port_power(hdev, hub, port1, true);
> >  			msleep(hub_power_on_good_delay(hub));
> > +			/*
> > +			 * USB 2.0 spec §7.1.7.3 requires at least 100 ms
> > +			 * between VBUS power-on and the first reset for power
> > +			 * settling.  hub_power_on_good_delay() on an xHCI root
> > +			 * hub returns bPwrOn2PwrGood * 2 with no minimum floor,
> > +			 * which can be as little as 20 ms.  When _PRR _RST was
> > +			 * also exercised the device must complete its power-on
> > +			 * sequence before enumeration; enforce the spec minimum.
> > +			 */
> > +			if (prr_reset == 0)
> > +				msleep(100);
> >  		}
> >  	}
> >  	if (hub->hdev->parent ||
> > diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> > index 489dbdc96f94..bb1b5e8cdc15 100644
> > --- a/drivers/usb/core/usb-acpi.c
> > +++ b/drivers/usb/core/usb-acpi.c
> > @@ -142,6 +142,74 @@ int usb_acpi_set_power_state(struct usb_device *hdev, int index, bool enable)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
> >
> > +/**
> > + * usb_acpi_port_prr_reset - issue an ACPI _PRR reset on a hub port
> > + * @hdev: USB device belonging to the usb hub
> > + * @port1: port number (one-based)
> > + *
> > + * Some devices expose their hardware reset line via an ACPI Power Resource for
> > + * Reset (_PRR).  When such a device fails to enumerate (e.g. because the reset
> > + * GPIO is stuck low), the USB power-cycle alone is not enough; the firmware
> > + * reset path must also be exercised.
> > + *
> > + * This function evaluates _PRR on the port's ACPI companion to obtain the
> > + * power-resource reference and then calls _RST on that resource to toggle the
> > + * reset line.  It is intended to be called alongside the mid-retry VBUS
> > + * power-cycle already performed by hub_port_connect().
> > + *
> > + * Returns 0 on success, -ENODEV if the port has no ACPI handle or no _PRR
> > + * method, or a negative error code on failure.
> > + */
> > +int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1)
> > +{
> > +	acpi_handle port_handle;
> > +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > +	union acpi_object *pkg, *ref;
> > +	acpi_status status;
> > +	int ret = 0;
> > +
> > +	port_handle = usb_get_hub_port_acpi_handle(hdev, port1);
> > +	if (!port_handle)
> > +		return -ENODEV;
> > +
> > +	if (!acpi_has_method(port_handle, "_PRR"))
> > +		return -ENODEV;
> > +
> > +	status = acpi_evaluate_object(port_handle, "_PRR", NULL, &buffer);
> > +	if (ACPI_FAILURE(status)) {
> > +		dev_dbg(&hdev->dev, "port%d: _PRR evaluation failed: %s\n",
> > +			port1, acpi_format_exception(status));
> > +		return -ENODEV;
> > +	}
> > +
> > +	pkg = buffer.pointer;
> > +	if (!pkg || pkg->type != ACPI_TYPE_PACKAGE || pkg->package.count != 1) {
> > +		dev_dbg(&hdev->dev, "port%d: _PRR returned unexpected object\n",
> > +			port1);
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	ref = &pkg->package.elements[0];
> > +	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE || !ref->reference.handle) {
> > +		dev_dbg(&hdev->dev, "port%d: _PRR element is not a reference\n",
> > +			port1);
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	status = acpi_evaluate_object(ref->reference.handle, "_RST", NULL, NULL);
> > +	if (ACPI_FAILURE(status)) {
> > +		dev_dbg(&hdev->dev, "port%d: _RST evaluation failed: %s\n",
> > +			port1, acpi_format_exception(status));
> > +		ret = -EIO;
> > +	}
> > +
> > +out:
> > +	kfree(buffer.pointer);
> > +	return ret;
> > +}
> > +
> >  /**
> >   * usb_acpi_add_usb4_devlink - add device link to USB4 Host Interface for tunneled USB3 devices
> >   *
> > diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> > index a9b37aeb515b..4d3dc3bd881b 100644
> > --- a/drivers/usb/core/usb.h
> > +++ b/drivers/usb/core/usb.h
> > @@ -211,7 +211,10 @@ extern int usb_acpi_register(void);
> >  extern void usb_acpi_unregister(void);
> >  extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
> >  	int port1);
> > +extern int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1);
> >  #else
> >  static inline int usb_acpi_register(void) { return 0; };
> >  static inline void usb_acpi_unregister(void) { };
> > +static inline int usb_acpi_port_prr_reset(struct usb_device *hdev,
> > +					  int port1) { return -ENODEV; }
> >  #endif
>
