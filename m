Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1604312815
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098135; cv=none; b=ndlFrNqvpcYxboPWyeWgFVfDFpnZZ/2AWl8bXUO2RJNblfW2KWZGng6/o8ToCknRYvVOn3+7eOUc4oXOFwvY8nIfvKn1wXPkJ0Dx1t//xSDa3FYjDWZ1ROfXbSuSaIB+944igUoC0suRhVyz2v9KNwoOkMWE8vNJh/IsBDmmBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098135; c=relaxed/simple;
	bh=yUjyjzqBWffdDrM9Hd9iKH6rT3lt+O2Br0tdTRSSDNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyzMujkmtMrLACDismuX24T1902Tq61s900s0UQERu1UwnIMZn53+FuFVee8mw9PuqQ2/k0pPO8RLQY/1pchux+lmg6kWsuYV1qK4EgD6jfK+Ugone2f94FBD5K07oCR4twOAZJJOPa+BNKyUguxvnH23o4YmyQ4R8q0Z69MjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=idQk5FaP; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="idQk5FaP"
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D15543F59A
	for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2026 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784098130;
	bh=18J4ewnhQ4dgN01/nzQM9rqfSD/XRfcHsgK+nRt6MlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=idQk5FaPbx9DiAfwHLR75gz6QDsQYMgrJLMjkQonGYu31DhHOBKGThOLApf4uUGuS
	 536HwXXzPj3RAod0zlenNKm4rvaG2MjYpM3PmmNkfpkym3eVRBzeJ1pzY2/tMfd1/9
	 lLARpP+vmIlXyh6OZJLJzhmLF62G84DtALPz2/VVx88QMorBQ7aSD5vbIoM+wwKTMK
	 wL97Opu2hyM02+91xKNhGo3UgHqiuytLb1Z6YbHNG0OubkU30ssLuk8NSE0KtlIpGL
	 C2fjgdjmW4CKlGMmljO4tnwTRH1fnsk066oOdA5vacFaw99FE6LHBjuZesHrsxGwN6
	 SjC9dCt4EWMNtEONcWSQKvcQhPDy5BlOPLpRCgP/bCzrcXXxF0GhJg39ARAPqeQl4K
	 ktYhhq1GCBEFBvA7E7qID+Ps/RJa27dP/58cBg4WOI0nWTcJSdkKaHpQBAZGuQ5y9L
	 No4Pir0X3NXCLt3sQ+lmTk9RipSHTVEf9uJi9X/rYp4p6NpoEihWhQ92/9vkZMwUsq
	 ifbMOOeE3UtvoNx8yxeuImODN2I5NngAJ7PAbTcila4Z/XyA2RdjoYzvf0WvVWiDZj
	 L2vsCoE85nxxki8aVg+MZXvBmqg8x2H+CoRjhDXaXRKGCXm8I3gTVEuPS+8B0eK4Q5
	 GZ126U2OWRhqI7Mz3ZS8YxxE=
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88ab059052so1987622a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 23:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784098128; x=1784702928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=18J4ewnhQ4dgN01/nzQM9rqfSD/XRfcHsgK+nRt6MlE=;
        b=Mk2KQb++aYBpq3D+teJ3zHFshAhLV3xwkNV2WjL0P8fF2wjNoiHTqL+msU+w1BKAXK
         EYz9X8faKwR9C9c3f633VCRNp1CTyBNqRxBw5082JDxCOdivdeKZZrqL5wTlUhAwI20/
         /zBOvmXmg2aEaNxhOM1BeefyUPEcHqmx6jFFIKrIAR2Ib7EMb9jGhEjLPHn/T03Uuzs4
         Zn6ooOO0hhKD+eb6UUtiyhA1pllfBaHxJfmYvGqkces2q9INdi/af3M+OnRMoGt/qVi3
         N6pxDu0mpoxShynROwqDa7RT8AigaBzgyVx1Dle8Hd1JjFY7CFDK9bnao4ubt0cIWc+U
         pCyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRPbshzrr9f71t2i1X5xi822L0Z/fBt5XlBQjQ3jw65EXh1gDa0SntNH9M97ZZpyIpfVnC35WnpYch@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6iovdbsbOWSnTML28oDYN8JUTQ8QTux4vAY4+SIEfYtpaTDP
	kUESvI5aSoFRDherhais4rxr/6peG8QKo4mZsfw3bcSiQKm86/kayPuRFxHNVezHkJE41C3NfvL
	jnk83S1XFZrPjuSKllbLLYGLKZErZBEsxWPPmr4M3KJ4kB232S+syGPFRvRESkSCgalX3cr9WC5
	fzegU=
X-Gm-Gg: AfdE7cm5MS0f4cYY1S4yeu1/oxuUt9eGfATmtO+OErxaCxkymIrKYtBCs1vMTay/5Po
	k+SQ/rkEpV3fW9KstGwO+QkmstHVYlygYGuTbRIDS0Ho+nDhXn0dXrnfA26nnFZcuuOyiskvTJN
	1kljtHwIwEFH7hlnQDb1HCthVtqkKx6Z46IKkZmvij7wGWP/cRqBEKAg/LtgPKkTtS2roa2V24h
	d3gXTcW9ch6OIDAPXJFzYcrqnAREigb9dudvZtEkBkX27j2j1AkBRKJrTKMYCyONk4LvqUSPobD
	e0Ksr/CeIxGz9jdAZu+fJS4w6z8gBgkovl8BN3nzJVzJryqIhZQZSgHFsm2ZCtBzKY+J387W947
	paWjD5qYqLxak+uI/4X+T9i23jXDD935g6/Suke3hGZDA6h6noOZqUKIxlRmUtIC0pgo=
X-Received: by 2002:a05:6a20:3d24:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3c0f0af5f2dmr25143548637.22.1784098128203;
        Tue, 14 Jul 2026 23:48:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d24:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3c0f0af5f2dmr25143514637.22.1784098127725;
        Tue, 14 Jul 2026 23:48:47 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8deb2a21sm36207092c88.3.2026.07.14.23.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:48:47 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:48:41 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] USB: hub: call ACPI _PRR reset during port
 power-cycle on enumeration failure
Message-ID: <alcist0vcwQmk8Bc@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260706080117.3754550-1-acelan.kao@canonical.com>
 <a2bf1966-d6a7-4871-b553-51d81ac10597@leemhuis.info>
 <alWq9GI8c4e4PCRD@acelan-Precision-5480>
 <5bd01cc0-4aef-4805-9508-3b57ecc70344@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bd01cc0-4aef-4805-9508-3b57ecc70344@leemhuis.info>

On Tue, Jul 14, 2026 at 03:37:48PM +0200, Thorsten Leemhuis wrote:
> On 7/14/26 05:41, Chia-Lin Kao (AceLan) wrote:
> > On Mon, Jul 13, 2026 at 05:02:09PM +0200, Thorsten Leemhuis wrote:
> >> On 7/6/26 10:01, Chia-Lin Kao (AceLan) wrote:
> >>> Some USB-connected devices (e.g. MT7925 Bluetooth on Dell laptops) expose
> >>> their hardware reset line via an ACPI Power Resource for Reset (_PRR)
> >>> rather than relying solely on VBUS cycling for recovery.  When the reset
> >>> GPIO gets stuck low the device stops responding on USB; a VBUS power-cycle
> >>> alone cannot recover it because the chip remains in reset regardless of
> >>> VBUS state.
> >
> >> Not my area of expertise, so handle this mail with care and forgive if
> >> I'm the following question is stupid:
> >>
> >> Is this fixing a regression, e.g. some problem caused or maybe suddenly
> >> exposed by a recent change?
> >
> > This could be treated as a regression, but this issue is a little bit
> > complex.
>
> Many thx for your explanation, this helps a lot. And yeah, it's somewhat
> tricky. But from what I see this looks a whole lot like a regression due
> to one aspect you mentioned:
>
> > 1. There is a new firmware for the Mediatek MT7925 BT chip.
> > 2. There is an updated driver
>
> Updated in-kernel driver I assume. Please correct me if I'm wrong.
Correct
>
> > for the Mediatek MT7925 BT chip which is
> > not compatible with the old firmware.
>
> Why is that? Do you by chance know which change caused this? I'm asking,
> because according to
> https://docs.kernel.org/driver-api/firmware/firmware-usage-guidelines.html
> states tat users "should not have to install newer firmware files to
> keep their hardware working" (for example when switching to a newer
> kernel version and hence its newer drivers). So the driver should
> continue to work even with the older firmware.
>
> Of course the driver therefore needs to notice that the firmware upload
> failed and that it's using the old firmware. Is it maybe that a check
> for that needs to be added?
>
> Or am I missing something/got something wrong somewhere along the lines
> here?
I re-read the internal ticket and check this issue again.
This issue happens when we dist-upgrade the system from 6.11 to 6.17
kernel.
Upgrade firmware or kernel alone doesn't invoke this issue.
So, we may say that the new driver manages the backward compatibility
with the old firmware. But when new firmware is installed, the new
driver has trouble to load the new firmware when the old firmware is
loaded and needs a power cycle.
Consulted with the Mediatek team, they said this is a known issue and
a global reset is required after upgraded the kernel.

>
> Ciao, Thorsten
>
> > If we reboot the system with the new driver and the old firmware, then
> > the issue occurs.
> >
> > The issue is that we update both firmware and driver and do a warm
> > reboot. The BT firmware won't reload with a warm reboot, and then
> > encounter the BT device gone issue. Do other warm reboots do not help.
> >
> > It requires a power cycle to force the BT firmware to reload. And
> > after the power cycle, we won't encounter the issue anymore.
> >>
> >> It doesn't contain a Fixes: tag, so doesn't look like it. I'm asking
> >> nevertheless, as I have seen one[1] (and IIRC at least one, likely two)
> >> other report along the lines of "remains in reset regardless of VBUS
> >> state.":
> >> https://lore.kernel.org/all/20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe/
> > That could be another issue.
> >
> >>
> >> And I have seen a user in a fedora-kernel chatroom that also had a
> >> problem that sounded similar. All with Mediatek wifi.
> >>
> >> Ciao, Thorsten
> >>
> >>> Add usb_acpi_port_prr_reset() in usb-acpi.c that, given a hub device and
> >>> one-based port number, looks up the port's ACPI companion handle, evaluates
> >>> _PRR to obtain the power-resource reference, and then calls _RST on that
> >>> reference to toggle the reset line.  The function is a no-op if the port
> >>> has no ACPI handle or no _PRR method, so it is safe to call unconditionally
> >>> for every port.
> >>>
> >>> Wire it into hub_port_connect() during the mid-retry VBUS power-cycle
> >>> (at (PORT_INIT_TRIES-1)/2 iterations), calling usb_acpi_port_prr_reset()
> >>> *after* VBUS goes off and *before* VBUS comes back on.  The ordering is
> >>> critical: on the tested hardware the ACPI _RST method (MBTR._RST) drives
> >>> BT_RST low for 200 ms then high again.  If _RST is called after VBUS is
> >>> already restored the GPIO pulse races with device enumeration starting on
> >>> the live bus; the device begins asserting USB signals while still held in
> >>> reset and enumeration fails.  Performing the reset while the port is
> >>> de-powered ensures the GPIO pulse completes fully before the device is
> >>> given power and time to initialise.
> >>>
> >>> After VBUS is restored, add an msleep(100) conditional on _PRR._RST having
> >>> succeeded.  USB 2.0 spec §7.1.7.3 (Fig. 7-29) mandates a minimum of 100 ms
> >>> between VBUS power-on and the first reset signalling for power settling.
> >>> On root hubs, hub_power_on_good_delay() returns bPwrOn2PwrGood * 2 with
> >>> no minimum floor; on the tested xHCI root hub bPwrOn2PwrGood = 10, yielding
> >>> only 20 ms — well below the spec minimum.  (External hubs already enforce
> >>> a 100 ms minimum via hub_power_on_good_delay().)  When _PRR._RST has been
> >>> exercised the device must also complete its full power-on sequence (GPIO
> >>> de-assertion, internal oscillator start, firmware load) before USB
> >>> enumeration begins.  The 100 ms sleep enforces the spec minimum and gives
> >>> the device adequate settling time.
> >>>
> >>> Tested on a Dell laptop with MT7925 Bluetooth (idVendor=0489,
> >>> idProduct=e139) whose BT_RST GPIO was stuck low.  With this fix the
> >>> device recovers autonomously at boot without requiring a G3
> >>> (mechanical power-off) cycle.  The relevant dmesg sequence:
> >>>
> >>>   [    1.448491] usb 3-10: new high-speed USB device number 4 using xhci_hcd
> >>>   [    6.813942] usb 3-10: device descriptor read/64, error -110
> >>>   [   22.685978] usb 3-10: device descriptor read/64, error -110
> >>>   [   22.901715] usb 3-10: new high-speed USB device number 5 using xhci_hcd
> >>>   [   28.317963] usb 3-10: device descriptor read/64, error -110
> >>>   [   44.189949] usb 3-10: device descriptor read/64, error -110
> >>>   [   44.294065] usb usb3-port10: attempt power cycle
> >>>   [   44.872709] usb 3-10: new high-speed USB device number 6 using xhci_hcd
> >>>   [   44.888293] usb 3-10: New USB device found, idVendor=0489, idProduct=e139, bcdDevice= 1.00
> >>>   [   44.888318] usb 3-10: Manufacturer: MediaTek Inc.
> >>>
> >>> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> >>> ---
> >>> v1 -> v2:
> >>> - Cc the ACPI maintainer and linux-acpi so the _PRR/_RST usage can be
> >>>   reviewed by the subsystem owners, and trimmed the recipient list to
> >>>   the people/lists actually relevant to this change (per Greg's request).
> >>> - Tighten the _PRR package check from "count < 1" to "count != 1" so the
> >>>   single-element invariant mandated by ACPI 6.4 §7.3.26 is explicit,
> >>>   matching the existing in-tree _PRR/_RST users (btintel.c,
> >>>   iwlwifi .../pcie/gen1_2/trans.c).  No functional change: only the
> >>>   first (and only) element is ever used.
> >>>
> >>> [v1] https://lore.kernel.org/lkml/20260326011708.1128840-1-acelan.kao@canonical.com
> >>> ---
> >>>  drivers/usb/core/hub.c      | 14 ++++++++
> >>>  drivers/usb/core/usb-acpi.c | 68 +++++++++++++++++++++++++++++++++++++
> >>>  drivers/usb/core/usb.h      |  3 ++
> >>>  3 files changed, 85 insertions(+)
> >>>
> >>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> >>> index 24960ba9caa9..1740e96f73cc 100644
> >>> --- a/drivers/usb/core/hub.c
> >>> +++ b/drivers/usb/core/hub.c
> >>> @@ -5603,11 +5603,25 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
> >>>
> >>>  		/* When halfway through our retry count, power-cycle the port */
> >>>  		if (i == (PORT_INIT_TRIES - 1) / 2) {
> >>> +			int prr_reset;
> >>> +
> >>>  			dev_info(&port_dev->dev, "attempt power cycle\n");
> >>>  			usb_hub_set_port_power(hdev, hub, port1, false);
> >>>  			msleep(2 * hub_power_on_good_delay(hub));
> >>> +			prr_reset = usb_acpi_port_prr_reset(hdev, port1);
> >>>  			usb_hub_set_port_power(hdev, hub, port1, true);
> >>>  			msleep(hub_power_on_good_delay(hub));
> >>> +			/*
> >>> +			 * USB 2.0 spec §7.1.7.3 requires at least 100 ms
> >>> +			 * between VBUS power-on and the first reset for power
> >>> +			 * settling.  hub_power_on_good_delay() on an xHCI root
> >>> +			 * hub returns bPwrOn2PwrGood * 2 with no minimum floor,
> >>> +			 * which can be as little as 20 ms.  When _PRR _RST was
> >>> +			 * also exercised the device must complete its power-on
> >>> +			 * sequence before enumeration; enforce the spec minimum.
> >>> +			 */
> >>> +			if (prr_reset == 0)
> >>> +				msleep(100);
> >>>  		}
> >>>  	}
> >>>  	if (hub->hdev->parent ||
> >>> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> >>> index 489dbdc96f94..bb1b5e8cdc15 100644
> >>> --- a/drivers/usb/core/usb-acpi.c
> >>> +++ b/drivers/usb/core/usb-acpi.c
> >>> @@ -142,6 +142,74 @@ int usb_acpi_set_power_state(struct usb_device *hdev, int index, bool enable)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
> >>>
> >>> +/**
> >>> + * usb_acpi_port_prr_reset - issue an ACPI _PRR reset on a hub port
> >>> + * @hdev: USB device belonging to the usb hub
> >>> + * @port1: port number (one-based)
> >>> + *
> >>> + * Some devices expose their hardware reset line via an ACPI Power Resource for
> >>> + * Reset (_PRR).  When such a device fails to enumerate (e.g. because the reset
> >>> + * GPIO is stuck low), the USB power-cycle alone is not enough; the firmware
> >>> + * reset path must also be exercised.
> >>> + *
> >>> + * This function evaluates _PRR on the port's ACPI companion to obtain the
> >>> + * power-resource reference and then calls _RST on that resource to toggle the
> >>> + * reset line.  It is intended to be called alongside the mid-retry VBUS
> >>> + * power-cycle already performed by hub_port_connect().
> >>> + *
> >>> + * Returns 0 on success, -ENODEV if the port has no ACPI handle or no _PRR
> >>> + * method, or a negative error code on failure.
> >>> + */
> >>> +int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1)
> >>> +{
> >>> +	acpi_handle port_handle;
> >>> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> >>> +	union acpi_object *pkg, *ref;
> >>> +	acpi_status status;
> >>> +	int ret = 0;
> >>> +
> >>> +	port_handle = usb_get_hub_port_acpi_handle(hdev, port1);
> >>> +	if (!port_handle)
> >>> +		return -ENODEV;
> >>> +
> >>> +	if (!acpi_has_method(port_handle, "_PRR"))
> >>> +		return -ENODEV;
> >>> +
> >>> +	status = acpi_evaluate_object(port_handle, "_PRR", NULL, &buffer);
> >>> +	if (ACPI_FAILURE(status)) {
> >>> +		dev_dbg(&hdev->dev, "port%d: _PRR evaluation failed: %s\n",
> >>> +			port1, acpi_format_exception(status));
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	pkg = buffer.pointer;
> >>> +	if (!pkg || pkg->type != ACPI_TYPE_PACKAGE || pkg->package.count != 1) {
> >>> +		dev_dbg(&hdev->dev, "port%d: _PRR returned unexpected object\n",
> >>> +			port1);
> >>> +		ret = -EINVAL;
> >>> +		goto out;
> >>> +	}
> >>> +
> >>> +	ref = &pkg->package.elements[0];
> >>> +	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE || !ref->reference.handle) {
> >>> +		dev_dbg(&hdev->dev, "port%d: _PRR element is not a reference\n",
> >>> +			port1);
> >>> +		ret = -EINVAL;
> >>> +		goto out;
> >>> +	}
> >>> +
> >>> +	status = acpi_evaluate_object(ref->reference.handle, "_RST", NULL, NULL);
> >>> +	if (ACPI_FAILURE(status)) {
> >>> +		dev_dbg(&hdev->dev, "port%d: _RST evaluation failed: %s\n",
> >>> +			port1, acpi_format_exception(status));
> >>> +		ret = -EIO;
> >>> +	}
> >>> +
> >>> +out:
> >>> +	kfree(buffer.pointer);
> >>> +	return ret;
> >>> +}
> >>> +
> >>>  /**
> >>>   * usb_acpi_add_usb4_devlink - add device link to USB4 Host Interface for tunneled USB3 devices
> >>>   *
> >>> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> >>> index a9b37aeb515b..4d3dc3bd881b 100644
> >>> --- a/drivers/usb/core/usb.h
> >>> +++ b/drivers/usb/core/usb.h
> >>> @@ -211,7 +211,10 @@ extern int usb_acpi_register(void);
> >>>  extern void usb_acpi_unregister(void);
> >>>  extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
> >>>  	int port1);
> >>> +extern int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1);
> >>>  #else
> >>>  static inline int usb_acpi_register(void) { return 0; };
> >>>  static inline void usb_acpi_unregister(void) { };
> >>> +static inline int usb_acpi_port_prr_reset(struct usb_device *hdev,
> >>> +					  int port1) { return -ENODEV; }
> >>>  #endif
> >>
>
