Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4646AEDF;
	Tue, 14 Jul 2026 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036304; cv=none; b=TJOFY5l3iZMXmPoFgMazvAHFF8/ksgfQ9NiuJ/E0IffPyEfr+1DBAbpNVe8WwNU7kFI8/P9tNw0rYLp9UZUom4GCuUjfxrYFRF6G+F6QbdxZYOJl9Xx2ictN/Z5Ov6a6rbF4YheE2/ltIfHwQ7zbG1rqCiSvp70VMJ5VTYFkJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036304; c=relaxed/simple;
	bh=lbOwyUuDW44faROuDg1y6sB8kA7MZIgcZOM12uyOyXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ExSaDpkGt+A9mWIvjPO67UzMIfzQKtpEa2MIJB8TLiy2ZaLE8XdcuXsRd7cMffguW1Xocy9U5/GIdKMfC4ZJJ5cW9qr+8Zz+JzYqzpIj0SZ90sl3QxYFHabzfHNhyVgv0iMe/4XiJG6o1CMcXGMK26AZ6XTriHxm4SWBpSpm5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SmeP1fvP; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SmeP1fvP"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4h00jq0xQkz8B3P;
	Tue, 14 Jul 2026 15:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1784036271;
	bh=lbOwyUuDW44faROuDg1y6sB8kA7MZIgcZOM12uyOyXs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SmeP1fvPfCJj9PCyZugqhweLV++CpVrnRhCnUXyK4TX+8Bg0vcIXc2uR24usc7hWg
	 +RHPf5jODVzppTEEsztc5lPpsyt4d/pOMwmb20pLeLojf4Wo4lbORg3CmVypnthpA0
	 DK/tkWIetEtAHeaJ5o6Wi7J6QioHURIv+Ys1sMNAG0O9y2msU0fA0KybsLndV9DvVG
	 FYecA1ewXBZy0CUCg1OnjOKiKpwVH4HJIpZGFlYmEmDruFY3R1By642Q6voG4vw5PA
	 Vns3AhekEIpAPuhr16gkcIwUKN6xAIzHv4dxjZXj3lM0vKATFpO4zsQFT22ews+fC2
	 E1f+aiYmqVn3Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4h00jq0DHPz4xtt;
	Tue, 14 Jul 2026 15:37:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4h00jn2FxCz8sbj;
	Tue, 14 Jul 2026 15:37:49 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 73ED16010D;
	Tue, 14 Jul 2026 15:37:48 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <5bd01cc0-4aef-4805-9508-3b57ecc70344@leemhuis.info>
Date: Tue, 14 Jul 2026 15:37:48 +0200
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
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Mathias Nyman <mathias.nyman@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260706080117.3754550-1-acelan.kao@canonical.com>
 <a2bf1966-d6a7-4871-b553-51d81ac10597@leemhuis.info>
 <alWq9GI8c4e4PCRD@acelan-Precision-5480>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <alWq9GI8c4e4PCRD@acelan-Precision-5480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178403626893.2934893.12171439083457132937@mxe9fb.netcup.net>
X-NC-CID: LZ89qh/5g4nZUGzUcWEedTl+MJ41kv31w4jxHMGK2fONsoQGx5Q=

On 7/14/26 05:41, Chia-Lin Kao (AceLan) wrote:
> On Mon, Jul 13, 2026 at 05:02:09PM +0200, Thorsten Leemhuis wrote:
>> On 7/6/26 10:01, Chia-Lin Kao (AceLan) wrote:
>>> Some USB-connected devices (e.g. MT7925 Bluetooth on Dell laptops) expose
>>> their hardware reset line via an ACPI Power Resource for Reset (_PRR)
>>> rather than relying solely on VBUS cycling for recovery.  When the reset
>>> GPIO gets stuck low the device stops responding on USB; a VBUS power-cycle
>>> alone cannot recover it because the chip remains in reset regardless of
>>> VBUS state.
> 
>> Not my area of expertise, so handle this mail with care and forgive if
>> I'm the following question is stupid:
>>
>> Is this fixing a regression, e.g. some problem caused or maybe suddenly
>> exposed by a recent change?
>
> This could be treated as a regression, but this issue is a little bit
> complex.

Many thx for your explanation, this helps a lot. And yeah, it's somewhat
tricky. But from what I see this looks a whole lot like a regression due
to one aspect you mentioned:

> 1. There is a new firmware for the Mediatek MT7925 BT chip.
> 2. There is an updated driver

Updated in-kernel driver I assume. Please correct me if I'm wrong.

> for the Mediatek MT7925 BT chip which is
> not compatible with the old firmware.

Why is that? Do you by chance know which change caused this? I'm asking,
because according to
https://docs.kernel.org/driver-api/firmware/firmware-usage-guidelines.html
states tat users "should not have to install newer firmware files to
keep their hardware working" (for example when switching to a newer
kernel version and hence its newer drivers). So the driver should
continue to work even with the older firmware.

Of course the driver therefore needs to notice that the firmware upload
failed and that it's using the old firmware. Is it maybe that a check
for that needs to be added?

Or am I missing something/got something wrong somewhere along the lines
here?

Ciao, Thorsten

> If we reboot the system with the new driver and the old firmware, then
> the issue occurs.
> 
> The issue is that we update both firmware and driver and do a warm
> reboot. The BT firmware won't reload with a warm reboot, and then
> encounter the BT device gone issue. Do other warm reboots do not help.
> 
> It requires a power cycle to force the BT firmware to reload. And
> after the power cycle, we won't encounter the issue anymore.
>>
>> It doesn't contain a Fixes: tag, so doesn't look like it. I'm asking
>> nevertheless, as I have seen one[1] (and IIRC at least one, likely two)
>> other report along the lines of "remains in reset regardless of VBUS
>> state.":
>> https://lore.kernel.org/all/20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe/
> That could be another issue.
> 
>>
>> And I have seen a user in a fedora-kernel chatroom that also had a
>> problem that sounded similar. All with Mediatek wifi.
>>
>> Ciao, Thorsten
>>
>>> Add usb_acpi_port_prr_reset() in usb-acpi.c that, given a hub device and
>>> one-based port number, looks up the port's ACPI companion handle, evaluates
>>> _PRR to obtain the power-resource reference, and then calls _RST on that
>>> reference to toggle the reset line.  The function is a no-op if the port
>>> has no ACPI handle or no _PRR method, so it is safe to call unconditionally
>>> for every port.
>>>
>>> Wire it into hub_port_connect() during the mid-retry VBUS power-cycle
>>> (at (PORT_INIT_TRIES-1)/2 iterations), calling usb_acpi_port_prr_reset()
>>> *after* VBUS goes off and *before* VBUS comes back on.  The ordering is
>>> critical: on the tested hardware the ACPI _RST method (MBTR._RST) drives
>>> BT_RST low for 200 ms then high again.  If _RST is called after VBUS is
>>> already restored the GPIO pulse races with device enumeration starting on
>>> the live bus; the device begins asserting USB signals while still held in
>>> reset and enumeration fails.  Performing the reset while the port is
>>> de-powered ensures the GPIO pulse completes fully before the device is
>>> given power and time to initialise.
>>>
>>> After VBUS is restored, add an msleep(100) conditional on _PRR._RST having
>>> succeeded.  USB 2.0 spec §7.1.7.3 (Fig. 7-29) mandates a minimum of 100 ms
>>> between VBUS power-on and the first reset signalling for power settling.
>>> On root hubs, hub_power_on_good_delay() returns bPwrOn2PwrGood * 2 with
>>> no minimum floor; on the tested xHCI root hub bPwrOn2PwrGood = 10, yielding
>>> only 20 ms — well below the spec minimum.  (External hubs already enforce
>>> a 100 ms minimum via hub_power_on_good_delay().)  When _PRR._RST has been
>>> exercised the device must also complete its full power-on sequence (GPIO
>>> de-assertion, internal oscillator start, firmware load) before USB
>>> enumeration begins.  The 100 ms sleep enforces the spec minimum and gives
>>> the device adequate settling time.
>>>
>>> Tested on a Dell laptop with MT7925 Bluetooth (idVendor=0489,
>>> idProduct=e139) whose BT_RST GPIO was stuck low.  With this fix the
>>> device recovers autonomously at boot without requiring a G3
>>> (mechanical power-off) cycle.  The relevant dmesg sequence:
>>>
>>>   [    1.448491] usb 3-10: new high-speed USB device number 4 using xhci_hcd
>>>   [    6.813942] usb 3-10: device descriptor read/64, error -110
>>>   [   22.685978] usb 3-10: device descriptor read/64, error -110
>>>   [   22.901715] usb 3-10: new high-speed USB device number 5 using xhci_hcd
>>>   [   28.317963] usb 3-10: device descriptor read/64, error -110
>>>   [   44.189949] usb 3-10: device descriptor read/64, error -110
>>>   [   44.294065] usb usb3-port10: attempt power cycle
>>>   [   44.872709] usb 3-10: new high-speed USB device number 6 using xhci_hcd
>>>   [   44.888293] usb 3-10: New USB device found, idVendor=0489, idProduct=e139, bcdDevice= 1.00
>>>   [   44.888318] usb 3-10: Manufacturer: MediaTek Inc.
>>>
>>> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>>> ---
>>> v1 -> v2:
>>> - Cc the ACPI maintainer and linux-acpi so the _PRR/_RST usage can be
>>>   reviewed by the subsystem owners, and trimmed the recipient list to
>>>   the people/lists actually relevant to this change (per Greg's request).
>>> - Tighten the _PRR package check from "count < 1" to "count != 1" so the
>>>   single-element invariant mandated by ACPI 6.4 §7.3.26 is explicit,
>>>   matching the existing in-tree _PRR/_RST users (btintel.c,
>>>   iwlwifi .../pcie/gen1_2/trans.c).  No functional change: only the
>>>   first (and only) element is ever used.
>>>
>>> [v1] https://lore.kernel.org/lkml/20260326011708.1128840-1-acelan.kao@canonical.com
>>> ---
>>>  drivers/usb/core/hub.c      | 14 ++++++++
>>>  drivers/usb/core/usb-acpi.c | 68 +++++++++++++++++++++++++++++++++++++
>>>  drivers/usb/core/usb.h      |  3 ++
>>>  3 files changed, 85 insertions(+)
>>>
>>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>>> index 24960ba9caa9..1740e96f73cc 100644
>>> --- a/drivers/usb/core/hub.c
>>> +++ b/drivers/usb/core/hub.c
>>> @@ -5603,11 +5603,25 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>>>
>>>  		/* When halfway through our retry count, power-cycle the port */
>>>  		if (i == (PORT_INIT_TRIES - 1) / 2) {
>>> +			int prr_reset;
>>> +
>>>  			dev_info(&port_dev->dev, "attempt power cycle\n");
>>>  			usb_hub_set_port_power(hdev, hub, port1, false);
>>>  			msleep(2 * hub_power_on_good_delay(hub));
>>> +			prr_reset = usb_acpi_port_prr_reset(hdev, port1);
>>>  			usb_hub_set_port_power(hdev, hub, port1, true);
>>>  			msleep(hub_power_on_good_delay(hub));
>>> +			/*
>>> +			 * USB 2.0 spec §7.1.7.3 requires at least 100 ms
>>> +			 * between VBUS power-on and the first reset for power
>>> +			 * settling.  hub_power_on_good_delay() on an xHCI root
>>> +			 * hub returns bPwrOn2PwrGood * 2 with no minimum floor,
>>> +			 * which can be as little as 20 ms.  When _PRR _RST was
>>> +			 * also exercised the device must complete its power-on
>>> +			 * sequence before enumeration; enforce the spec minimum.
>>> +			 */
>>> +			if (prr_reset == 0)
>>> +				msleep(100);
>>>  		}
>>>  	}
>>>  	if (hub->hdev->parent ||
>>> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
>>> index 489dbdc96f94..bb1b5e8cdc15 100644
>>> --- a/drivers/usb/core/usb-acpi.c
>>> +++ b/drivers/usb/core/usb-acpi.c
>>> @@ -142,6 +142,74 @@ int usb_acpi_set_power_state(struct usb_device *hdev, int index, bool enable)
>>>  }
>>>  EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
>>>
>>> +/**
>>> + * usb_acpi_port_prr_reset - issue an ACPI _PRR reset on a hub port
>>> + * @hdev: USB device belonging to the usb hub
>>> + * @port1: port number (one-based)
>>> + *
>>> + * Some devices expose their hardware reset line via an ACPI Power Resource for
>>> + * Reset (_PRR).  When such a device fails to enumerate (e.g. because the reset
>>> + * GPIO is stuck low), the USB power-cycle alone is not enough; the firmware
>>> + * reset path must also be exercised.
>>> + *
>>> + * This function evaluates _PRR on the port's ACPI companion to obtain the
>>> + * power-resource reference and then calls _RST on that resource to toggle the
>>> + * reset line.  It is intended to be called alongside the mid-retry VBUS
>>> + * power-cycle already performed by hub_port_connect().
>>> + *
>>> + * Returns 0 on success, -ENODEV if the port has no ACPI handle or no _PRR
>>> + * method, or a negative error code on failure.
>>> + */
>>> +int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1)
>>> +{
>>> +	acpi_handle port_handle;
>>> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>>> +	union acpi_object *pkg, *ref;
>>> +	acpi_status status;
>>> +	int ret = 0;
>>> +
>>> +	port_handle = usb_get_hub_port_acpi_handle(hdev, port1);
>>> +	if (!port_handle)
>>> +		return -ENODEV;
>>> +
>>> +	if (!acpi_has_method(port_handle, "_PRR"))
>>> +		return -ENODEV;
>>> +
>>> +	status = acpi_evaluate_object(port_handle, "_PRR", NULL, &buffer);
>>> +	if (ACPI_FAILURE(status)) {
>>> +		dev_dbg(&hdev->dev, "port%d: _PRR evaluation failed: %s\n",
>>> +			port1, acpi_format_exception(status));
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	pkg = buffer.pointer;
>>> +	if (!pkg || pkg->type != ACPI_TYPE_PACKAGE || pkg->package.count != 1) {
>>> +		dev_dbg(&hdev->dev, "port%d: _PRR returned unexpected object\n",
>>> +			port1);
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	ref = &pkg->package.elements[0];
>>> +	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE || !ref->reference.handle) {
>>> +		dev_dbg(&hdev->dev, "port%d: _PRR element is not a reference\n",
>>> +			port1);
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	status = acpi_evaluate_object(ref->reference.handle, "_RST", NULL, NULL);
>>> +	if (ACPI_FAILURE(status)) {
>>> +		dev_dbg(&hdev->dev, "port%d: _RST evaluation failed: %s\n",
>>> +			port1, acpi_format_exception(status));
>>> +		ret = -EIO;
>>> +	}
>>> +
>>> +out:
>>> +	kfree(buffer.pointer);
>>> +	return ret;
>>> +}
>>> +
>>>  /**
>>>   * usb_acpi_add_usb4_devlink - add device link to USB4 Host Interface for tunneled USB3 devices
>>>   *
>>> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
>>> index a9b37aeb515b..4d3dc3bd881b 100644
>>> --- a/drivers/usb/core/usb.h
>>> +++ b/drivers/usb/core/usb.h
>>> @@ -211,7 +211,10 @@ extern int usb_acpi_register(void);
>>>  extern void usb_acpi_unregister(void);
>>>  extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
>>>  	int port1);
>>> +extern int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1);
>>>  #else
>>>  static inline int usb_acpi_register(void) { return 0; };
>>>  static inline void usb_acpi_unregister(void) { };
>>> +static inline int usb_acpi_port_prr_reset(struct usb_device *hdev,
>>> +					  int port1) { return -ENODEV; }
>>>  #endif
>>

