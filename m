Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AE3451C8;
	Mon, 13 Jul 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955416; cv=none; b=FGJ5r1q+IjK0eqXCSE78Qx968w33CaEiW9FnIHYxeOzU+2hklhdnQmGM0QwRn1On9GDcKrj4uDAoXdwRVPB1wqerSHckRl5tIrTDpbNWvk1SiYdaTWaiGy1oA4xegR0cr0M3oRL/e4W+Js/wSWGkou0wK9FHuJX2Bh40wcO+8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955416; c=relaxed/simple;
	bh=HYYhU4eMd4AGn7SqrjaLGKBfaEn12OOFA2Z/bVyybXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nW87A3Vfg6vDBQgAKZJhslTWX+fRfEpX3TL5PnI+l9QsxAGXXyTL6X2+dptzu69O2c9RDCalJRc5S0WDuacd1bSQc2YwGyO9U4nOSaaQk7HLgbCtbudpBIJbVbPnDmkdY4MhXJAeG7IJV3ZymalcNmySzLKv+jWMBebgtcD5t4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=L8ZMm1nI; arc=none smtp.client-ip=188.68.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="L8ZMm1nI"
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4gzQdc1rXSz72p0;
	Mon, 13 Jul 2026 17:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783954932;
	bh=HYYhU4eMd4AGn7SqrjaLGKBfaEn12OOFA2Z/bVyybXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L8ZMm1nIxXpHk47hdcoX0nFVthkuJvpsVWQtzPHiSmr0kn94hmjjEcQsgda29+YlJ
	 X8HsG3zB34/mM9T48iRq+3UCCXpieh5seshpqBAMbE5F+dRNYd0IbzWpx2qPbV4QKI
	 KOXxlEWFufXMsoNDukN4Mi+N2lrbPwUTe3H2LXAh7pYB6v1sPDS31hUb9hTZS48RIS
	 p9vNdu6jv3iI3/vRrRX1oEHCxosR8Sw42yofHN9jHVu1rJdESMM0ExTfQhOsA4aa9/
	 yLYvvrQPjPZoAW+4Snpahd0BRt+x84IOtaTpA5U43cHulrC3rcWcHCnBVVlCVC+2ZM
	 mx7kMqj9bMSEA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4gzQdc16z1z72m8;
	Mon, 13 Jul 2026 17:02:12 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gzQdb2vRNz8svT;
	Mon, 13 Jul 2026 17:02:11 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id A4B8260305;
	Mon, 13 Jul 2026 17:02:10 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <a2bf1966-d6a7-4871-b553-51d81ac10597@leemhuis.info>
Date: Mon, 13 Jul 2026 17:02:09 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB: hub: call ACPI _PRR reset during port power-cycle
 on enumeration failure
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Mathias Nyman <mathias.nyman@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260706080117.3754550-1-acelan.kao@canonical.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260706080117.3754550-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178395493106.1107700.12952718980436100014@mxe9fb.netcup.net>
X-NC-CID: 6SlzxSgwACbuBBJEcj2AzsA/T089DgsOnaqNlvWAWbNDFSTN+lc=

On 7/6/26 10:01, Chia-Lin Kao (AceLan) wrote:
> Some USB-connected devices (e.g. MT7925 Bluetooth on Dell laptops) expose
> their hardware reset line via an ACPI Power Resource for Reset (_PRR)
> rather than relying solely on VBUS cycling for recovery.  When the reset
> GPIO gets stuck low the device stops responding on USB; a VBUS power-cycle
> alone cannot recover it because the chip remains in reset regardless of
> VBUS state.

Not my area of expertise, so handle this mail with care and forgive if
I'm the following question is stupid:

Is this fixing a regression, e.g. some problem caused or maybe suddenly
exposed by a recent change?

It doesn't contain a Fixes: tag, so doesn't look like it. I'm asking
nevertheless, as I have seen one[1] (and IIRC at least one, likely two)
other report along the lines of "remains in reset regardless of VBUS
state.":
https://lore.kernel.org/all/20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe/

And I have seen a user in a fedora-kernel chatroom that also had a
problem that sounded similar. All with Mediatek wifi.

Ciao, Thorsten

> Add usb_acpi_port_prr_reset() in usb-acpi.c that, given a hub device and
> one-based port number, looks up the port's ACPI companion handle, evaluates
> _PRR to obtain the power-resource reference, and then calls _RST on that
> reference to toggle the reset line.  The function is a no-op if the port
> has no ACPI handle or no _PRR method, so it is safe to call unconditionally
> for every port.
> 
> Wire it into hub_port_connect() during the mid-retry VBUS power-cycle
> (at (PORT_INIT_TRIES-1)/2 iterations), calling usb_acpi_port_prr_reset()
> *after* VBUS goes off and *before* VBUS comes back on.  The ordering is
> critical: on the tested hardware the ACPI _RST method (MBTR._RST) drives
> BT_RST low for 200 ms then high again.  If _RST is called after VBUS is
> already restored the GPIO pulse races with device enumeration starting on
> the live bus; the device begins asserting USB signals while still held in
> reset and enumeration fails.  Performing the reset while the port is
> de-powered ensures the GPIO pulse completes fully before the device is
> given power and time to initialise.
> 
> After VBUS is restored, add an msleep(100) conditional on _PRR._RST having
> succeeded.  USB 2.0 spec §7.1.7.3 (Fig. 7-29) mandates a minimum of 100 ms
> between VBUS power-on and the first reset signalling for power settling.
> On root hubs, hub_power_on_good_delay() returns bPwrOn2PwrGood * 2 with
> no minimum floor; on the tested xHCI root hub bPwrOn2PwrGood = 10, yielding
> only 20 ms — well below the spec minimum.  (External hubs already enforce
> a 100 ms minimum via hub_power_on_good_delay().)  When _PRR._RST has been
> exercised the device must also complete its full power-on sequence (GPIO
> de-assertion, internal oscillator start, firmware load) before USB
> enumeration begins.  The 100 ms sleep enforces the spec minimum and gives
> the device adequate settling time.
> 
> Tested on a Dell laptop with MT7925 Bluetooth (idVendor=0489,
> idProduct=e139) whose BT_RST GPIO was stuck low.  With this fix the
> device recovers autonomously at boot without requiring a G3
> (mechanical power-off) cycle.  The relevant dmesg sequence:
> 
>   [    1.448491] usb 3-10: new high-speed USB device number 4 using xhci_hcd
>   [    6.813942] usb 3-10: device descriptor read/64, error -110
>   [   22.685978] usb 3-10: device descriptor read/64, error -110
>   [   22.901715] usb 3-10: new high-speed USB device number 5 using xhci_hcd
>   [   28.317963] usb 3-10: device descriptor read/64, error -110
>   [   44.189949] usb 3-10: device descriptor read/64, error -110
>   [   44.294065] usb usb3-port10: attempt power cycle
>   [   44.872709] usb 3-10: new high-speed USB device number 6 using xhci_hcd
>   [   44.888293] usb 3-10: New USB device found, idVendor=0489, idProduct=e139, bcdDevice= 1.00
>   [   44.888318] usb 3-10: Manufacturer: MediaTek Inc.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
> v1 -> v2:
> - Cc the ACPI maintainer and linux-acpi so the _PRR/_RST usage can be
>   reviewed by the subsystem owners, and trimmed the recipient list to
>   the people/lists actually relevant to this change (per Greg's request).
> - Tighten the _PRR package check from "count < 1" to "count != 1" so the
>   single-element invariant mandated by ACPI 6.4 §7.3.26 is explicit,
>   matching the existing in-tree _PRR/_RST users (btintel.c,
>   iwlwifi .../pcie/gen1_2/trans.c).  No functional change: only the
>   first (and only) element is ever used.
> 
> [v1] https://lore.kernel.org/lkml/20260326011708.1128840-1-acelan.kao@canonical.com
> ---
>  drivers/usb/core/hub.c      | 14 ++++++++
>  drivers/usb/core/usb-acpi.c | 68 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/usb.h      |  3 ++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 24960ba9caa9..1740e96f73cc 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5603,11 +5603,25 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>  
>  		/* When halfway through our retry count, power-cycle the port */
>  		if (i == (PORT_INIT_TRIES - 1) / 2) {
> +			int prr_reset;
> +
>  			dev_info(&port_dev->dev, "attempt power cycle\n");
>  			usb_hub_set_port_power(hdev, hub, port1, false);
>  			msleep(2 * hub_power_on_good_delay(hub));
> +			prr_reset = usb_acpi_port_prr_reset(hdev, port1);
>  			usb_hub_set_port_power(hdev, hub, port1, true);
>  			msleep(hub_power_on_good_delay(hub));
> +			/*
> +			 * USB 2.0 spec §7.1.7.3 requires at least 100 ms
> +			 * between VBUS power-on and the first reset for power
> +			 * settling.  hub_power_on_good_delay() on an xHCI root
> +			 * hub returns bPwrOn2PwrGood * 2 with no minimum floor,
> +			 * which can be as little as 20 ms.  When _PRR _RST was
> +			 * also exercised the device must complete its power-on
> +			 * sequence before enumeration; enforce the spec minimum.
> +			 */
> +			if (prr_reset == 0)
> +				msleep(100);
>  		}
>  	}
>  	if (hub->hdev->parent ||
> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> index 489dbdc96f94..bb1b5e8cdc15 100644
> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -142,6 +142,74 @@ int usb_acpi_set_power_state(struct usb_device *hdev, int index, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
>  
> +/**
> + * usb_acpi_port_prr_reset - issue an ACPI _PRR reset on a hub port
> + * @hdev: USB device belonging to the usb hub
> + * @port1: port number (one-based)
> + *
> + * Some devices expose their hardware reset line via an ACPI Power Resource for
> + * Reset (_PRR).  When such a device fails to enumerate (e.g. because the reset
> + * GPIO is stuck low), the USB power-cycle alone is not enough; the firmware
> + * reset path must also be exercised.
> + *
> + * This function evaluates _PRR on the port's ACPI companion to obtain the
> + * power-resource reference and then calls _RST on that resource to toggle the
> + * reset line.  It is intended to be called alongside the mid-retry VBUS
> + * power-cycle already performed by hub_port_connect().
> + *
> + * Returns 0 on success, -ENODEV if the port has no ACPI handle or no _PRR
> + * method, or a negative error code on failure.
> + */
> +int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1)
> +{
> +	acpi_handle port_handle;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *pkg, *ref;
> +	acpi_status status;
> +	int ret = 0;
> +
> +	port_handle = usb_get_hub_port_acpi_handle(hdev, port1);
> +	if (!port_handle)
> +		return -ENODEV;
> +
> +	if (!acpi_has_method(port_handle, "_PRR"))
> +		return -ENODEV;
> +
> +	status = acpi_evaluate_object(port_handle, "_PRR", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_dbg(&hdev->dev, "port%d: _PRR evaluation failed: %s\n",
> +			port1, acpi_format_exception(status));
> +		return -ENODEV;
> +	}
> +
> +	pkg = buffer.pointer;
> +	if (!pkg || pkg->type != ACPI_TYPE_PACKAGE || pkg->package.count != 1) {
> +		dev_dbg(&hdev->dev, "port%d: _PRR returned unexpected object\n",
> +			port1);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ref = &pkg->package.elements[0];
> +	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE || !ref->reference.handle) {
> +		dev_dbg(&hdev->dev, "port%d: _PRR element is not a reference\n",
> +			port1);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	status = acpi_evaluate_object(ref->reference.handle, "_RST", NULL, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		dev_dbg(&hdev->dev, "port%d: _RST evaluation failed: %s\n",
> +			port1, acpi_format_exception(status));
> +		ret = -EIO;
> +	}
> +
> +out:
> +	kfree(buffer.pointer);
> +	return ret;
> +}
> +
>  /**
>   * usb_acpi_add_usb4_devlink - add device link to USB4 Host Interface for tunneled USB3 devices
>   *
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index a9b37aeb515b..4d3dc3bd881b 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -211,7 +211,10 @@ extern int usb_acpi_register(void);
>  extern void usb_acpi_unregister(void);
>  extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
>  	int port1);
> +extern int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1);
>  #else
>  static inline int usb_acpi_register(void) { return 0; };
>  static inline void usb_acpi_unregister(void) { };
> +static inline int usb_acpi_port_prr_reset(struct usb_device *hdev,
> +					  int port1) { return -ENODEV; }
>  #endif

