Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100320;
	b=qN5nStu9laR+GZNikvtOSdw+EOemrjmKJIiSq9XIt5okUkJ4DKUGj6KAY4ytloDT+IhW
	 Y/d8eniJfl3N+Rta48PZFQ+2hYCs54ZAZEBVHK9iO63E4TTyXwt4dY5UVdQ2Eh9hGHNHk
	 YSQGJ9qtLPmAecBS29cAMka+UtV9ZQbnVgAxsxQI4A4VKNOGjP7BQOv7gLbNgSoRVI88n
	 LxIpMtWUIyosV8pbnFVFViomx9Nhswc2B7VvWrUFYVyGCq7U+5cPdg1G3tLUjQFihl/ym
	 fIgFGkhfikXk1KtfPQG5WUD37xgOMGyUFRqQ3Im4YIrFQLpEUmH7iZuVXhy/JbrsieA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100320;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PvTDu3ub3WuI+McDfeKMZQvkv7vLhsdO8CMX4Yjkthg=;
	b=xlXmQdBtGdYKsO5EFmihTjkhxQFpPpS2Dxiw8NOqwA14WEgFjTLl4dV5QN0MdP1hFTqh
	 te9RieGlbV/r/GJch28jSx2YcCUarZ9PDbYinj37KrnNaZiB6WNMD1e8sHLWzTfJWQpOY
	 809sIUXhJcHCLZzaWXJfBntCTLOiHCqRJ8I47DSlE051eXQH62hva5V4zr3IVyD2rq5AD
	 wrsplcJcaFMC7uP1Lx8ez0lf15+Mh58oz/hH4y6Uj4eep6R3Bix8WWBpfBXIhICN0fG84
	 3xISzHQLzGeaaJOEuoBfFCBU3WHe08LjXz8h+O9MpCIdncgReAfhuq02gO0tnZu/xWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ6Rk8Vh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9C606A320;
	Thu, 19 Nov 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ6Rk8Vh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDA81F000C5;
	Thu, 19 Nov 2026 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795100320;
	bh=PvTDu3ub3WuI+McDfeKMZQvkv7vLhsdO8CMX4Yjkthg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QZ6Rk8Vhs7GBeqORdalWB5FZn87JLm2jt/1+yA6NTSQkxSPhJAGKeg1lED7J2L1cz
	 N1xau+cTY2cGjHGBYenPQqUk3FGOw2T/m9VzUN46plDHpcIM8666qx2FmU94h37HW2
	 F4w0QYDimLdil0XBzQx3NKQGyvR4APuHD4OMAoTZ92jVpdufHiNDAWvDFDJTm1LUXg
	 cGaYv44IzhE02LGIgU9zOoQOilDdejV+kC5kI4BC6R3UUr2jODLBatbidns2PtoWo7
	 NVt94r3wP2K632RIs5/II5CePQ4VjEUe4GIapIziPfb/4fh/+y9YGXCU4Fyr0NHWdi
	 g5CdjZDz4gOZw==
Message-ID: <4cc3a198-fe54-4970-b21d-9cc11480fe39@kernel.org>
Date: Thu, 19 Nov 2026 08:58:32 -0600
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] USB: hub: call ACPI _PRR reset during port power-cycle
 on enumeration failure
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-acpi@vger.kernel.org, "Chia-Lin Kao (AceLan)"
 <acelan.kao@canonical.com>
References: <20260706080117.3754550-1-v3-1-0e3069228fe9@kernel.org>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260706080117.3754550-1-v3-1-0e3069228fe9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/3/26 00:08, Mario Limonciello wrote:
> Some USB-connected devices (e.g. MT7925 Bluetooth on Dell laptops) expose
> their hardware reset line via an ACPI Power Resource for Reset (_PRR)
> rather than relying solely on VBUS cycling for recovery.  When the reset
> GPIO gets stuck low the device stops responding on USB; a VBUS power-cycle
> alone cannot recover it because the chip remains in reset regardless of
> VBUS state.
> 
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
>    [    1.448491] usb 3-10: new high-speed USB device number 4 using xhci_hcd
>    [    6.813942] usb 3-10: device descriptor read/64, error -110
>    [   22.685978] usb 3-10: device descriptor read/64, error -110
>    [   22.901715] usb 3-10: new high-speed USB device number 5 using xhci_hcd
>    [   28.317963] usb 3-10: device descriptor read/64, error -110
>    [   44.189949] usb 3-10: device descriptor read/64, error -110
>    [   44.294065] usb usb3-port10: attempt power cycle
>    [   44.872709] usb 3-10: new high-speed USB device number 6 using xhci_hcd
>    [   44.888293] usb 3-10: New USB device found, idVendor=0489, idProduct=e139, bcdDevice= 1.00
>    [   44.888318] usb 3-10: Manufacturer: MediaTek Inc.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Link: https://patch.msgid.link/20260706080117.3754550-1-acelan.kao@canonical.com
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> This was sent last cycle but got no feedback except for my review comment.
> I think we should bring it forward this cycle.
> 
> Changes from v2:
> * Rebase on 7.4-rc1
> * Link to v2: https://lore.kernel.org/linux-usb/20260706080117.3754550-1-acelan.kao@canonical.com/
> ---
>   drivers/usb/core/hub.c      | 14 ++++++++++
>   drivers/usb/core/usb-acpi.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
>   drivers/usb/core/usb.h      |  3 ++
>   3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 199d3f535a891..72da7aea94cc4 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5621,11 +5621,25 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>   
>   		/* When halfway through our retry count, power-cycle the port */
>   		if (i == (PORT_INIT_TRIES - 1) / 2) {
> +			int prr_reset;
> +
>   			dev_info(&port_dev->dev, "attempt power cycle\n");
>   			usb_hub_set_port_power(hdev, hub, port1, false);
>   			msleep(2 * hub_power_on_good_delay(hub));
> +			prr_reset = usb_acpi_port_prr_reset(hdev, port1);
>   			usb_hub_set_port_power(hdev, hub, port1, true);
>   			msleep(hub_power_on_good_delay(hub));
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
>   		}
>   	}
>   	if (hub->hdev->parent ||
> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> index 489dbdc96f94a..bb1b5e8cdc15e 100644
> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -142,6 +142,74 @@ int usb_acpi_set_power_state(struct usb_device *hdev, int index, bool enable)
>   }
>   EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
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
>   /**
>    * usb_acpi_add_usb4_devlink - add device link to USB4 Host Interface for tunneled USB3 devices
>    *
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index a9b37aeb515be..4d3dc3bd881b2 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -211,7 +211,10 @@ extern int usb_acpi_register(void);
>   extern void usb_acpi_unregister(void);
>   extern acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev,
>   	int port1);
> +extern int usb_acpi_port_prr_reset(struct usb_device *hdev, int port1);
>   #else
>   static inline int usb_acpi_register(void) { return 0; };
>   static inline void usb_acpi_unregister(void) { };
> +static inline int usb_acpi_port_prr_reset(struct usb_device *hdev,
> +					  int port1) { return -ENODEV; }
>   #endif
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20260706080117.3754550-1-acelan.kao@canonical.com
> 
> Best regards,
> --
> Mario Limonciello <superm1@kernel.org>

Hi Greg,

Ping on this patch please from a few weeks ago.

Thanks,
