Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783399;
	b=01j6elvuXu4Sc6nNEm9JAoSPXf9Amu3ajvNUVbmQcCHsgqzOk60lboI7oOwKoOcIBLi4
	 5YPGvxIpPsihbXyVi/SpFAc794KvuYSZB21lIVEibxFugOq3yFSQ0h9zZIDVxM1PxaMNS
	 GNLQZI1q97WX1/G0Al3sJa21F31JUFyr/DPLv9/6HefuITWHaaIpahoduN7gE+gDFoJhH
	 D5Ri227sXALmljImcW8mXENVia1ZFNYg/WEW3/c8xQ2Ic8A80ibPuzJ0mJh+j/BHi/xB2
	 G/sJyn46YmEU7xeF/kGXBpX+QFEdKg4Dp9kaqVFU5VU69evOARH73KqqD6JLFe9H7fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783399;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:MIME-Version:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Report:X-Spam-Score:
	 X-Spam-Bar:X-Rspamd-Score:X-Rspamd-Action:X-Rspamd-Bar;
	bh=SW7JHhiu41wfPquSMxR+o4KbZ3UG60Y+QaqGLDrhNjA=;
	b=VJPM3Q4QapC7Qx+0zWdx1LHZOVyiMbAOjj1WV20+bvoXh9urWoEhy0QlPrTpRrElllw5
	 tVz98FfSuxX+Irc9nUG+3hEwQGE1IXJJUy17LztfG6PK80qCDz0Ea8oNUPk7PhbCmGSWS
	 B0Yauo8Hw07rmcsB4eC9KQvD1jRnBYb0m3FMial8SaCEB5h9wksnTitAwT6M/tBLT6hLE
	 3wAtaAsNn0Pr+eKAMJdziulZuVMkbAutt45EWVu4j+vEAxwDn4tv1aYoaLsk14BAtDArn
	 Ha6MDf0bNA6VSvOjHG8OtoGHU74DOVF2lOY025K4V7mro6iHnb1IX9Vg7mEDS5ZIw0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=M1p+lQ2N;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217F606A31F;
	Fri, 27 Nov 2026 12:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4217F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=M1p+lQ2N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=SW7JHhiu41wfPquSMxR+o4KbZ3UG60Y+QaqGLDrhNjA=; t=1795783397; x=2111143397; 
	b=M1p+lQ2N6zAZO5LqctvioCV5yBrQL0nK4dJ4VrC9m0SUDSIYYPk2bdY2mKTyyCEqFta7MPWmBow
	2EmbOr4C6JdWHUTtP+jaEEcLqE1+BmL1LHfymhy4l3n1s11sJd8cDK91BspsDSKw6carYxmKu93kY
	boKZOZi8AnhCAUn6O8q04gbQtGhVZfG3xzQZue+YTTVLZcvsZHq7N61qxboWOg/JB64rOpSoeBPH0
	dj4iD7utbM+JsQrcBlTpnJsNReFKaTbjE8hS1i2BsickSz38HVJLg1BUzp1/AaZ0mnXKOkglC5qHw
	sNO/qXyt/XeWHbEvF0kWplyFQW9/juvn9hsQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xWvIJ-00000004nMP-3A2c;
	Fri, 27 Nov 2026 13:43:15 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xWvII-0000000HOUt-3AJa;
	Fri, 27 Nov 2026 13:43:15 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <uajain@igalia.com>)
	id 1xWvII-00000003lhK-2bSy;
	Fri, 27 Nov 2026 13:43:14 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 27 Nov 2026 12:43:14 +0000
From: Umang Jain <uajain@igalia.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v4 1/1] acpi: battery: Read Battery charge time("_BCT")
 for Steamdeck devices
In-Reply-To: <CAJZ5v0hu=6CxHc4LiUvX=82-St=xjLCtdgHZr_0iobnpbfLRuQ@mail.gmail.com>
References: <20261116102752.520062-1-uajain@igalia.com>
 <20261116102752.520062-2-uajain@igalia.com>
 <CAJZ5v0hu=6CxHc4LiUvX=82-St=xjLCtdgHZr_0iobnpbfLRuQ@mail.gmail.com>
Message-ID: <a447bf956dd45a8cef95a013f38dc19c@igalia.com>
X-Sender: uajain@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,BAYES_00=-1.9,KAM_DMARC_STATUS=0.007
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -0.4
X-Rspamd-Action: no action
X-Rspamd-Bar: /

Hi Rafael,

Sorry for late reply.

On 2026-11-20 13:35, Rafael J. Wysocki (Intel) wrote:
> On Mon, Nov 16, 2026 at 11:26 AM Umang Jain <uajain@igalia.com> wrote:
>>
>> Valve steamdeck devices can report battery status as
>> charging, even when low-powered power supply is connected
>> to the device. The battery status is reported as charging
>> through sysfs, even though in reality, it is discharging.
>>
>> To address this, introduce a battery quirk for Valve Steamdeck devices
>> ACPI_BATTERY_QUIRK_VALVE_STEAMDECK. This is required to detect
>> if a low-power supply unit is connected to the device.
>> To handle this case, read out Battery charge time ("_BCT")
>> as it is reported accurately on these devices and use that
>> information for report charging vs discharging status.
>> Battery charge time ("_BCT") with an eligible power supply unit
>> will have valid values whereas with a low-powered supply unit,
>> it shall report ACPI_BATTERY_VALUE_UNKNOWN. Use this as a
>> differentiator to determine, whether the battery of steamdeck
>> devices is really charging or not.
>>
>> Signed-off-by: Umang Jain <uajain@igalia.com>
> 
> Sashiko has feedback on this:
> 
> https://sashiko.dev/#/patchset/20261116102752.520062-1-uajain%40igalia.com

I'll post the feedback here and then reply.

> Should _BCT be evaluated inside acpi_battery_get_state() using an exclusive
> evaluation helper instead of directly in acpi_battery_get_property()?
> Evaluating _BCT here bypasses the cache_time rate-limiting in
> acpi_battery_get_state(), so every sysfs status read or uevent executes the
> method on the embedded controller.  In addition, all other battery control
> methods in this driver (_BIF, _BIX, _BST, and _BTP) serialize execution
> under acpi_exclusive_eval_lock via acpi_evaluate_object_exclusive() or
> acpi_execute_simple_method_exclusive(), whereas acpi_evaluate_integer() runs
> unlocked.

I agree on the part that battery control methods are evaluated in
acpi_battery_get_state(),
however we are not trying to determine and store "_BCT" here. We are
just using to get
the proper charging status for the steamdeck device using _BCT. We
rejected the idea of "_BCT"
being evaluated globally for all devices in previous reviews, which
would be fit in get_state().
We just bind _BCT evaluation to steamdeck's quirk case.

Regarding question of rate-limiting calls on every sysfs status read or
uevent, I don't
think it's necessary either, since get_property() calls are executed on
every power supply
changes from power_supply_core.c - hence as soon as you unplug and plug
or even replug a
low-powered charger it will go through acpi_battery_get_property() code
paths (since power
supply is effectively changed) and update the correct charging status.
We don't need to
constantly call/evaluate _BCT again in this case, since a charger won't
suddenly change from
low-power to high-power one or vice versa.

I agree with usage acpi_evaluate_integer_exclusive() though. I will
include it in next revision.

> Does this overwrite POWER_SUPPLY_STATUS_NOT_CHARGING with
> POWER_SUPPLY_STATUS_DISCHARGING when the battery is full and its charge rate
> is zero?

When the battery is full in steamdeck case, it is correctly inferred:
i.e. acpi_battery_is_charged() returns TRUE.

Hence the branch
```
else if (battery->state & ACPI_BATTERY_STATE_CHARGING) {
...
...
    if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags)) {
    ...
    }
}
```
is _not_ executed at all and instead the branch

		else if (acpi_battery_is_charged(battery))
			val->intval = POWER_SUPPLY_STATUS_FULL;

is evaluated instead and status is correctly updated to "Full". So no,
it would not overwrite.

> When acpi_battery_is_full(battery) is true and battery->rate_now is 0, the
> preceding else branch sets val->intval to POWER_SUPPLY_STATUS_NOT_CHARGING.
> Because the quirk check sits outside the if branch, it still runs, and
> _BCT(100) returns 0xffffffff (ACPI_BATTERY_VALUE_UNKNOWN) when the battery
> is already at 100% and not actively charging.  Moving the quirk check inside
> the branch that sets POWER_SUPPLY_STATUS_CHARGING would avoid this
> regression.
> 
> Please let me know what you think about it.

Hope the explanations clarifies things.

I'll send a v5 if there are no more things to discuss?
The only change in v5 would be use of acpi_evaluate_integer_exclusive()
instead
of acpi_evaluate_integer() for evaluating the _BCT.

> 
>> ---
>>  drivers/acpi/battery.c | 49 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 6edea559a5bc..458c2b23a05a 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -94,6 +94,15 @@ enum {
>>          * on a full charge, but showing degradation in full charge cap.
>>          */
>>         ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE,
>> +       /*
>> +        * Valve steamdeck devices can get discharged even when battery status
>> +        * is charging. This happens typically when low power supply unit is
>> +        * connected. To accurately determine this scenario, we shall read
>> +        * battery charge time ("_BCT") and set this quirk. This is the key
>> +        * differentiator to determine whether the steamdeck is actually
>> +        * charging or not.
>> +        */
>> +       ACPI_BATTERY_QUIRK_VALVE_STEAMDECK,
>>  };
>>
>>  struct acpi_battery {
>> @@ -234,7 +243,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
>>                                         : POWER_SUPPLY_STATUS_DISCHARGING;
>>                                 return 0;
>>                         }
>> -               else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>> +               else if (battery->state & ACPI_BATTERY_STATE_CHARGING) {
>>                         /* Check the rate and capacity to validate the status. */
>>                         if (!acpi_battery_is_full(battery) ||
>>                             (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
>> @@ -244,6 +253,27 @@ static int acpi_battery_get_property(struct power_supply *psy,
>>                                 /* Full and zero rate. */
>>                                 val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>>                         }
>> +
>> +                       if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags)) {
>> +                               unsigned long long bct;
>> +                               acpi_status status;
>> +                               union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>> +                               struct acpi_object_list args = { 1, &arg0 };
>> +
>> +                               arg0.integer.value = 100;
>> +                               status = acpi_evaluate_integer(battery->device->handle, "_BCT",
>> +                                                              &args, &bct);
>> +                               if (ACPI_FAILURE(status))
>> +                                       acpi_handle_debug(battery->device->handle,
>> +                                                         "_BCT evaluation failed: %s",
>> +                                                         acpi_format_exception(status));
>> +                               else if (bct > ACPI_UINT32_MAX)
>> +                                       acpi_handle_debug(battery->device->handle,
>> +                                                         "_BCT value is invalid");
>> +                               else if (bct == ACPI_BATTERY_VALUE_UNKNOWN)
>> +                                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>> +                       }
>> +               }
>>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
>>                         val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>>                 else if (acpi_battery_is_charged(battery))
>> @@ -1150,6 +1180,23 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
>>                 set_bit(ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE, &battery->flags);
>>                 battery->capacity_now = battery->full_charge_capacity;
>>         }
>> +
>> +       if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags))
>> +               return;
>> +
>> +       /*
>> +        * For Valve Steamdeck devices, determine _BCT presence as well before
>> +        * setting its battery quirk.
>> +        */
>> +       if (dmi_name_in_vendors("Valve") &&
>> +           acpi_has_method(battery->device->handle, "_BCT")) {
>> +               const char *name;
>> +
>> +               name = dmi_get_system_info(DMI_PRODUCT_NAME);
>> +               if ((name && (!strncmp("Jupiter", name, 7))) ||
>> +                   (name && (!strncmp("Galileo", name, 7))))
>> +                       set_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags);
>> +       }
>>  }
>>
>>  static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>> --
>> 2.55.0
>>
