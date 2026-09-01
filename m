Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD546C84F;
	Tue,  1 Sep 2026 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293501; cv=none; b=OjAnNWP67Xa9b2RJOPhMmGr6L6GGYKfqzpbzfA7ACqWy3YA5eK3AjyhdIA1yLxPTPa/CEKemDZp1x13zkU7yWO+sbm0NF+HjgzEU1ETwfuBbfF4OevmsKLSI6vGV/owFl3zEoPi/ifTSUWWuRSUqxp5jUTy+jhfeX2rj7uNLpqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293501; c=relaxed/simple;
	bh=4rrOO5RmTNcYce98c5CVMEljbzpzESIav41BrZuMdYc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QkMtPHlbbrygpK3Mp5nmI2qLkbxFFXB5LUeMqm2nKJrO5ym9sC1aJBdPdIWmafAf5iegyATN+tG/z7LMi/Z2TUI4H6ojaxBR+NQ23IL0US3Y6Ulrpf2aKiSutUEdbYpwgdXryl+TH1vAcJMDZwbG8pCoZX4ctc3X0ZhCSp1owys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TJe/gG8j; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TJe/gG8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788293485; x=1788898285; i=w_armin@gmx.de;
	bh=cYYjVXKEwdQqiXfDx284bv7LmQFsfQlKlgn+mmdAy/w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TJe/gG8j1BmIJz6JMVl6b0ZlXW61nP6apq1xEylMOHqB7TvKfWR0gZbvP8ZPQtHc
	 8hw9/5jTXEhwPH/fPDfevBJi65TcvpIf6qKQxvMONkIWLe5p65Jo2skSXYuW9Um1U
	 hsrMMmzA5sXRDhCxm8pnGIjYpzvBMQnnb8f4M7Zzx/uvwWiJD4TxpUE39WExe3WYO
	 kLfsNkEFL834+xhpzAULzvzrPCA42ND38QuBJ3Qa553g0g4xPVaZ5iSPOEZKPkU7f
	 9QJExhwP5tm/zmfdg1a4YUtIlED3iiyU+cDNybwRUM+B0MZJlh/u50IgXCxdgwkCT
	 JfQPTbuYfLnuTOQ7ZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1wn52G1PyH-00tvLZ; Tue, 01
 Sep 2026 22:11:25 +0200
Message-ID: <f2f17b0d-22a1-4a57-895b-318bb50456f3@gmx.de>
Date: Tue, 1 Sep 2026 22:11:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: battery: Fix bogus cycle count values on systems
 without _BIX
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 wse@tuxedocomputers.com
References: <20260806233817.622975-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20260806233817.622975-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Z2miM3dFEGfGIvuR2cZH7irIJBj9MtphVrcGyOPbFsEDaMLezr
 GDMqlMiibbm0agB8z9U4+4oWkvwSfSz6ufry2ASCVRHCbC0+fxJjRg0sMpt4kP0hVag4bKl
 Dr1U5iim5fkQ3mApQTSXzGcPfL08e9WmvpsGvVcyk/GeJZylKAseTEZY54c58tBPaN4Fmc6
 8k6sFPe0rBvQiBI6MQMZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+afLtQyPX00=;nhKZd7HlTQDUdm2uY8ktap9P895
 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
 /RXSCoMdcqbMf34xKhaByfk

Am 07.08.26 um 01:38 schrieb Armin Wolf:

> Devices supporting only the legacy _BIF ACPI control method cannot
> know the cycle count of the associated battery, so cycle_count always
> remains 0. Claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT on
> such devices can thus mislead userspace applications and prevents
> power supply extensions from supplying correct cycle count values.
>
> Fix this by not claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT
> on devices without _BIX.

Any thoughts on this? I tested it on my device, and so far everything seem=
s
to work flawlessly.

Thanks,
Armin Wolf

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/acpi/battery.c | 131 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 113 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 0084f308b790..b64f876f93cb 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -324,7 +324,9 @@ static int acpi_battery_get_property(struct power_su=
pply *psy,
>   	return ret;
>   }
>  =20
> -static const enum power_supply_property charge_battery_props[] =3D {
> +/* For devices supporting the _BIX ACPI control method */
> +
> +static const enum power_supply_property charge_battery_extended_props[]=
 =3D {
>   	POWER_SUPPLY_PROP_STATUS,
>   	POWER_SUPPLY_PROP_PRESENT,
>   	POWER_SUPPLY_PROP_TECHNOLOGY,
> @@ -342,7 +344,7 @@ static const enum power_supply_property charge_batte=
ry_props[] =3D {
>   	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>   };
>  =20
> -static const enum power_supply_property charge_battery_full_cap_broken_=
props[] =3D {
> +static const enum power_supply_property charge_battery_full_cap_broken_=
extended_props[] =3D {
>   	POWER_SUPPLY_PROP_STATUS,
>   	POWER_SUPPLY_PROP_PRESENT,
>   	POWER_SUPPLY_PROP_TECHNOLOGY,
> @@ -356,7 +358,7 @@ static const enum power_supply_property charge_batte=
ry_full_cap_broken_props[] =3D
>   	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>   };
>  =20
> -static const enum power_supply_property energy_battery_props[] =3D {
> +static const enum power_supply_property energy_battery_extended_props[]=
 =3D {
>   	POWER_SUPPLY_PROP_STATUS,
>   	POWER_SUPPLY_PROP_PRESENT,
>   	POWER_SUPPLY_PROP_TECHNOLOGY,
> @@ -374,7 +376,7 @@ static const enum power_supply_property energy_batte=
ry_props[] =3D {
>   	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>   };
>  =20
> -static const enum power_supply_property energy_battery_full_cap_broken_=
props[] =3D {
> +static const enum power_supply_property energy_battery_full_cap_broken_=
extended_props[] =3D {
>   	POWER_SUPPLY_PROP_STATUS,
>   	POWER_SUPPLY_PROP_PRESENT,
>   	POWER_SUPPLY_PROP_TECHNOLOGY,
> @@ -388,6 +390,68 @@ static const enum power_supply_property energy_batt=
ery_full_cap_broken_props[] =3D
>   	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>   };
>  =20
> +/* For devices supporting only the _BIF ACPI control method */
> +
> +static const enum power_supply_property charge_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +};
> +
> +static const enum power_supply_property charge_battery_full_cap_broken_=
props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +};
> +
> +static const enum power_supply_property energy_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_ENERGY_FULL,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +};
> +
> +static const enum power_supply_property energy_battery_full_cap_broken_=
props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +};
> +
>   /* Battery Management */
>   struct acpi_offsets {
>   	size_t offset;		/* offset inside struct acpi_sbs_battery */
> @@ -875,6 +939,7 @@ static void __exit battery_hook_exit(void)
>  =20
>   static int sysfs_add_battery(struct acpi_battery *battery)
>   {
> +	bool extended_info_available =3D test_bit(ACPI_BATTERY_XINFO_PRESENT, =
&battery->flags);
>   	struct power_supply_config psy_cfg =3D {
>   		.drv_data =3D battery,
>   		.attr_grp =3D acpi_battery_groups,
> @@ -888,25 +953,55 @@ static int sysfs_add_battery(struct acpi_battery *=
battery)
>  =20
>   	if (battery->power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
>   		if (full_cap_broken) {
> -			battery->bat_desc.properties =3D
> -			    charge_battery_full_cap_broken_props;
> -			battery->bat_desc.num_properties =3D
> -			    ARRAY_SIZE(charge_battery_full_cap_broken_props);
> +			if (extended_info_available) {
> +				battery->bat_desc.properties =3D
> +					charge_battery_full_cap_broken_extended_props;
> +				battery->bat_desc.num_properties =3D
> +					ARRAY_SIZE(charge_battery_full_cap_broken_extended_props);
> +			} else {
> +				battery->bat_desc.properties =3D
> +					charge_battery_full_cap_broken_props;
> +				battery->bat_desc.num_properties =3D
> +					ARRAY_SIZE(charge_battery_full_cap_broken_props);
> +			}
>   		} else {
> -			battery->bat_desc.properties =3D charge_battery_props;
> -			battery->bat_desc.num_properties =3D
> -			    ARRAY_SIZE(charge_battery_props);
> +			if (extended_info_available) {
> +				battery->bat_desc.properties =3D
> +					charge_battery_extended_props;
> +				battery->bat_desc.num_properties =3D
> +					ARRAY_SIZE(charge_battery_extended_props);
> +			} else {
> +				battery->bat_desc.properties =3D
> +					charge_battery_props;
> +				battery->bat_desc.num_properties =3D
> +					ARRAY_SIZE(charge_battery_props);
> +			}
>   		}
>   	} else {
>   		if (full_cap_broken) {
> -			battery->bat_desc.properties =3D
> -			    energy_battery_full_cap_broken_props;
> -			battery->bat_desc.num_properties =3D
> -			    ARRAY_SIZE(energy_battery_full_cap_broken_props);
> +			if (extended_info_available) {
> +				battery->bat_desc.properties =3D
> +					energy_battery_full_cap_broken_extended_props;
> +				battery->bat_desc.num_properties =3D
> +					ARRAY_SIZE(energy_battery_full_cap_broken_extended_props);
> +			} else {
> +				battery->bat_desc.properties =3D
> +					energy_battery_full_cap_broken_props;
> +				battery->bat_desc.num_properties =3D
> +					ARRAY_SIZE(energy_battery_full_cap_broken_props);
> +			}
>   		} else {
> -			battery->bat_desc.properties =3D energy_battery_props;
> -			battery->bat_desc.num_properties =3D
> -			    ARRAY_SIZE(energy_battery_props);
> +			if (extended_info_available) {
> +				battery->bat_desc.properties =3D
> +					energy_battery_extended_props;
> +				battery->bat_desc.num_properties =3D
> +					ARRAY_SIZE(energy_battery_extended_props);
> +			} else {
> +				battery->bat_desc.properties =3D
> +					energy_battery_props;
> +				battery->bat_desc.num_properties =3D
> +					ARRAY_SIZE(energy_battery_props);
> +			}
>   		}
>   	}
>  =20
