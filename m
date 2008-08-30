From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] acer-wmi: Add rfkill support for wireless and bluetooth
Date: Sat, 30 Aug 2008 11:07:30 -0300
Message-ID: <20080830140730.GB12246@khazad-dum.debian.net>
References: <200808301206.56279.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52331 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750727AbYH3OHg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Aug 2008 10:07:36 -0400
Content-Disposition: inline
In-Reply-To: <200808301206.56279.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, linux-wireless@vger.kernel.org, Ivo van Doorn <ivdoorn@gmail.com>

On Sat, 30 Aug 2008, Carlos Corbacho wrote:
> +static void device##_rfkill_update(struct work_struct *ignored) \
> +{ \
> +	u32 state; \
> +	acpi_status status; \
> +	status = get_u32(&state, cap); \
> +	\
> +	if (ACPI_SUCCESS(status)) \
> +		rfkill_force_state(device##_rfkill, state); \
> +	queue_delayed_work(rfkill_workqueue, &device##_rfkill_work, \
> +		round_jiffies_relative(HZ)); \
> +}

Please explicitly map from state (int) to the parameter for
rfkill_force_state (enum rfkill_state).  The compiler will optimize it if it
is numerically equal.

> +static int acer_rfkill_init(struct device *dev)
> +{
> +	u32 state;
> +
> +	wireless_rfkill = rfkill_allocate(dev, RFKILL_TYPE_WLAN);

Where's the error handling?

> +	wireless_rfkill->name = "acer-wireless";
> +	get_u32(&state, ACER_CAP_WIRELESS);
> +	wireless_rfkill->state = state;

Needs proper map between types to be future-proof.

> +	wireless_rfkill->toggle_radio = wireless_rfkill_set;
> +	wireless_rfkill->user_claim_unsupported = 1;
> +
> +	bluetooth_rfkill = rfkill_allocate(dev, RFKILL_TYPE_BLUETOOTH);

Where's the error handling?

> +	bluetooth_rfkill->name = "acer-bluetooth";
> +	get_u32(&state, ACER_CAP_BLUETOOTH);
> +	bluetooth_rfkill->state = state;

Needs proper map between types to be future-proof.

BTW: you also need error handling on rfkill_register calls.

Since rfkill is a safety measure that the user will expect to be there
(after you add support and he starts using it), if you cannot register the
rfkill interfaces, you should fail the driver load.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
