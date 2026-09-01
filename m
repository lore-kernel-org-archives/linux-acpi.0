Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD846D541;
	Tue,  1 Sep 2026 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293910; cv=none; b=u6SUYdQyfSbR68HfxCSaoS3lBVwQQ2+YbPtt1ONowEhHIEKiP58kwJ1zBQQGY9tmAF3TBdyzjteWR+ydG5M+WHAQsFW68S0EBU0egpSN4pE22Lr8suZJpmPGnmcWOAzPR6tEKv6HP4oIn7n7rnUQAXpv9nsSodODIFSwU9tmamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293910; c=relaxed/simple;
	bh=dbbnJek3cMdn1+SVPIW8Bn2gHDmzwj/YfvEG/w5nNOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjd1K1TWAYgiDIKJuKonxHkD6qzEH2yfKxl5aZ5dqm+TXisu7NKiZUaAP0i9AVmeCHlm17nH7c7k6ZBB69aLlFrok93go3KXP7Kow+9+AbIXA3HDYRnw4i5y9t/z0wtSXncmcdvPCcaFRAaNHMSlbCKErEIZyd9zDrXX43ME7bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=HsKuvBI6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HsKuvBI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788293901; x=1788898701; i=w_armin@gmx.de;
	bh=HNme46btptdVXl0HZFxrwNdw1KW6rEuEwHuEGuakT9A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HsKuvBI6HYUuWvZ2Xmxe1LCbbmOkBzMNFLs96nyGQ2bRbqr+4FnzoEMFnadLXp3G
	 GOF0QIMWq8EPyEqTMZd50BjQDXprfocjG3uhrbkndpuYPaY4XLTonEVDRl/rzZs7k
	 cuPMJVpUuk9chncwdW6PqVQf97uIps6uvSxj2eJz1YAZt3l6dwxihG6jZ+lrmX9jB
	 YSMiHcBF4mNBiMXxQiOICdAidJRwerfVeLxYfIyfJPs6VEhfmLF3XjsUyh57mtu2C
	 mAP5ol9fAHsjhGhz7womnMYneFPAu3b3tV44cFN2IfAQayAXF9BoA8yE2ftSNbsj9
	 1IBBmHGDsCLxTiRnCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1wllKh1LEQ-00wh7r; Tue, 01
 Sep 2026 22:18:21 +0200
Message-ID: <dec5d721-8bc5-4be3-81cf-16b63829cbf0@gmx.de>
Date: Tue, 1 Sep 2026 22:18:20 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: battery: Fix bogus cycle count values on systems
 without _BIX
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, wse@tuxedocomputers.com
References: <20260806233817.622975-1-W_Armin@gmx.de>
 <f2f17b0d-22a1-4a57-895b-318bb50456f3@gmx.de>
 <CAJZ5v0j4EAZnrEA3Z7EKX5fdfhTWYbb=f0rOPnLsz5zaEMguGQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0j4EAZnrEA3Z7EKX5fdfhTWYbb=f0rOPnLsz5zaEMguGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00Nwyu4DHZ0aZ12TGI+Me2tNp3vASFEtIVM6+ZMQ3A75MP/1U62
 uXlcH9eW7Mq+A7TyDbjUSt+2a0iScV1tZZpefgrXxEd9s+2E0wUXETGwz0Qm1wmqpK1xfGq
 H5odmLmGgBOFTJ81T9taJpWO2lMmXeMPYRHbm9ZmFnRvpI0MF89ix+wUpVl2CJpcsCQIKlz
 YSnEegCbfYmOXtHEPBLRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R2maLBtXu/k=;KztQ1m3MQqM36OZzH15V2NMvRMF
 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

Am 01.09.26 um 22:16 schrieb Rafael J. Wysocki (Intel):

> On Tue, Sep 1, 2026 at 10:11=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 07.08.26 um 01:38 schrieb Armin Wolf:
>>
>>> Devices supporting only the legacy _BIF ACPI control method cannot
>>> know the cycle count of the associated battery, so cycle_count always
>>> remains 0. Claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT on
>>> such devices can thus mislead userspace applications and prevents
>>> power supply extensions from supplying correct cycle count values.
>>>
>>> Fix this by not claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT
>>> on devices without _BIX.
>> Any thoughts on this? I tested it on my device, and so far everything s=
eems
>> to work flawlessly.
> It looks good overall, but it is quite substantial, which is why it
> didn't make it into 7.3-rc1.
>
> I'm planning to apply it for 7.4.

Alright, that works for me.

Thanks,
Armin Wolf

>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>    drivers/acpi/battery.c | 131 +++++++++++++++++++++++++++++++++++---=
=2D--
>>>    1 file changed, 113 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>>> index 0084f308b790..b64f876f93cb 100644
>>> --- a/drivers/acpi/battery.c
>>> +++ b/drivers/acpi/battery.c
>>> @@ -324,7 +324,9 @@ static int acpi_battery_get_property(struct power_=
supply *psy,
>>>        return ret;
>>>    }
>>>
>>> -static const enum power_supply_property charge_battery_props[] =3D {
>>> +/* For devices supporting the _BIX ACPI control method */
>>> +
>>> +static const enum power_supply_property charge_battery_extended_props=
[] =3D {
>>>        POWER_SUPPLY_PROP_STATUS,
>>>        POWER_SUPPLY_PROP_PRESENT,
>>>        POWER_SUPPLY_PROP_TECHNOLOGY,
>>> @@ -342,7 +344,7 @@ static const enum power_supply_property charge_bat=
tery_props[] =3D {
>>>        POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>>    };
>>>
>>> -static const enum power_supply_property charge_battery_full_cap_broke=
n_props[] =3D {
>>> +static const enum power_supply_property charge_battery_full_cap_broke=
n_extended_props[] =3D {
>>>        POWER_SUPPLY_PROP_STATUS,
>>>        POWER_SUPPLY_PROP_PRESENT,
>>>        POWER_SUPPLY_PROP_TECHNOLOGY,
>>> @@ -356,7 +358,7 @@ static const enum power_supply_property charge_bat=
tery_full_cap_broken_props[] =3D
>>>        POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>>    };
>>>
>>> -static const enum power_supply_property energy_battery_props[] =3D {
>>> +static const enum power_supply_property energy_battery_extended_props=
[] =3D {
>>>        POWER_SUPPLY_PROP_STATUS,
>>>        POWER_SUPPLY_PROP_PRESENT,
>>>        POWER_SUPPLY_PROP_TECHNOLOGY,
>>> @@ -374,7 +376,7 @@ static const enum power_supply_property energy_bat=
tery_props[] =3D {
>>>        POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>>    };
>>>
>>> -static const enum power_supply_property energy_battery_full_cap_broke=
n_props[] =3D {
>>> +static const enum power_supply_property energy_battery_full_cap_broke=
n_extended_props[] =3D {
>>>        POWER_SUPPLY_PROP_STATUS,
>>>        POWER_SUPPLY_PROP_PRESENT,
>>>        POWER_SUPPLY_PROP_TECHNOLOGY,
>>> @@ -388,6 +390,68 @@ static const enum power_supply_property energy_ba=
ttery_full_cap_broken_props[] =3D
>>>        POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>>    };
>>>
>>> +/* For devices supporting only the _BIF ACPI control method */
>>> +
>>> +static const enum power_supply_property charge_battery_props[] =3D {
>>> +     POWER_SUPPLY_PROP_STATUS,
>>> +     POWER_SUPPLY_PROP_PRESENT,
>>> +     POWER_SUPPLY_PROP_TECHNOLOGY,
>>> +     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>>> +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>> +     POWER_SUPPLY_PROP_CURRENT_NOW,
>>> +     POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>>> +     POWER_SUPPLY_PROP_CHARGE_FULL,
>>> +     POWER_SUPPLY_PROP_CHARGE_NOW,
>>> +     POWER_SUPPLY_PROP_CAPACITY,
>>> +     POWER_SUPPLY_PROP_CAPACITY_LEVEL,
>>> +     POWER_SUPPLY_PROP_MODEL_NAME,
>>> +     POWER_SUPPLY_PROP_MANUFACTURER,
>>> +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>> +};
>>> +
>>> +static const enum power_supply_property charge_battery_full_cap_broke=
n_props[] =3D {
>>> +     POWER_SUPPLY_PROP_STATUS,
>>> +     POWER_SUPPLY_PROP_PRESENT,
>>> +     POWER_SUPPLY_PROP_TECHNOLOGY,
>>> +     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>>> +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>> +     POWER_SUPPLY_PROP_CURRENT_NOW,
>>> +     POWER_SUPPLY_PROP_CHARGE_NOW,
>>> +     POWER_SUPPLY_PROP_MODEL_NAME,
>>> +     POWER_SUPPLY_PROP_MANUFACTURER,
>>> +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>> +};
>>> +
>>> +static const enum power_supply_property energy_battery_props[] =3D {
>>> +     POWER_SUPPLY_PROP_STATUS,
>>> +     POWER_SUPPLY_PROP_PRESENT,
>>> +     POWER_SUPPLY_PROP_TECHNOLOGY,
>>> +     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>>> +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>> +     POWER_SUPPLY_PROP_POWER_NOW,
>>> +     POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>>> +     POWER_SUPPLY_PROP_ENERGY_FULL,
>>> +     POWER_SUPPLY_PROP_ENERGY_NOW,
>>> +     POWER_SUPPLY_PROP_CAPACITY,
>>> +     POWER_SUPPLY_PROP_CAPACITY_LEVEL,
>>> +     POWER_SUPPLY_PROP_MODEL_NAME,
>>> +     POWER_SUPPLY_PROP_MANUFACTURER,
>>> +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>> +};
>>> +
>>> +static const enum power_supply_property energy_battery_full_cap_broke=
n_props[] =3D {
>>> +     POWER_SUPPLY_PROP_STATUS,
>>> +     POWER_SUPPLY_PROP_PRESENT,
>>> +     POWER_SUPPLY_PROP_TECHNOLOGY,
>>> +     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>>> +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>> +     POWER_SUPPLY_PROP_POWER_NOW,
>>> +     POWER_SUPPLY_PROP_ENERGY_NOW,
>>> +     POWER_SUPPLY_PROP_MODEL_NAME,
>>> +     POWER_SUPPLY_PROP_MANUFACTURER,
>>> +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
>>> +};
>>> +
>>>    /* Battery Management */
>>>    struct acpi_offsets {
>>>        size_t offset;          /* offset inside struct acpi_sbs_batter=
y */
>>> @@ -875,6 +939,7 @@ static void __exit battery_hook_exit(void)
>>>
>>>    static int sysfs_add_battery(struct acpi_battery *battery)
>>>    {
>>> +     bool extended_info_available =3D test_bit(ACPI_BATTERY_XINFO_PRE=
SENT, &battery->flags);
>>>        struct power_supply_config psy_cfg =3D {
>>>                .drv_data =3D battery,
>>>                .attr_grp =3D acpi_battery_groups,
>>> @@ -888,25 +953,55 @@ static int sysfs_add_battery(struct acpi_battery=
 *battery)
>>>
>>>        if (battery->power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
>>>                if (full_cap_broken) {
>>> -                     battery->bat_desc.properties =3D
>>> -                         charge_battery_full_cap_broken_props;
>>> -                     battery->bat_desc.num_properties =3D
>>> -                         ARRAY_SIZE(charge_battery_full_cap_broken_pr=
ops);
>>> +                     if (extended_info_available) {
>>> +                             battery->bat_desc.properties =3D
>>> +                                     charge_battery_full_cap_broken_e=
xtended_props;
>>> +                             battery->bat_desc.num_properties =3D
>>> +                                     ARRAY_SIZE(charge_battery_full_c=
ap_broken_extended_props);
>>> +                     } else {
>>> +                             battery->bat_desc.properties =3D
>>> +                                     charge_battery_full_cap_broken_p=
rops;
>>> +                             battery->bat_desc.num_properties =3D
>>> +                                     ARRAY_SIZE(charge_battery_full_c=
ap_broken_props);
>>> +                     }
>>>                } else {
>>> -                     battery->bat_desc.properties =3D charge_battery_=
props;
>>> -                     battery->bat_desc.num_properties =3D
>>> -                         ARRAY_SIZE(charge_battery_props);
>>> +                     if (extended_info_available) {
>>> +                             battery->bat_desc.properties =3D
>>> +                                     charge_battery_extended_props;
>>> +                             battery->bat_desc.num_properties =3D
>>> +                                     ARRAY_SIZE(charge_battery_extend=
ed_props);
>>> +                     } else {
>>> +                             battery->bat_desc.properties =3D
>>> +                                     charge_battery_props;
>>> +                             battery->bat_desc.num_properties =3D
>>> +                                     ARRAY_SIZE(charge_battery_props)=
;
>>> +                     }
>>>                }
>>>        } else {
>>>                if (full_cap_broken) {
>>> -                     battery->bat_desc.properties =3D
>>> -                         energy_battery_full_cap_broken_props;
>>> -                     battery->bat_desc.num_properties =3D
>>> -                         ARRAY_SIZE(energy_battery_full_cap_broken_pr=
ops);
>>> +                     if (extended_info_available) {
>>> +                             battery->bat_desc.properties =3D
>>> +                                     energy_battery_full_cap_broken_e=
xtended_props;
>>> +                             battery->bat_desc.num_properties =3D
>>> +                                     ARRAY_SIZE(energy_battery_full_c=
ap_broken_extended_props);
>>> +                     } else {
>>> +                             battery->bat_desc.properties =3D
>>> +                                     energy_battery_full_cap_broken_p=
rops;
>>> +                             battery->bat_desc.num_properties =3D
>>> +                                     ARRAY_SIZE(energy_battery_full_c=
ap_broken_props);
>>> +                     }
>>>                } else {
>>> -                     battery->bat_desc.properties =3D energy_battery_=
props;
>>> -                     battery->bat_desc.num_properties =3D
>>> -                         ARRAY_SIZE(energy_battery_props);
>>> +                     if (extended_info_available) {
>>> +                             battery->bat_desc.properties =3D
>>> +                                     energy_battery_extended_props;
>>> +                             battery->bat_desc.num_properties =3D
>>> +                                     ARRAY_SIZE(energy_battery_extend=
ed_props);
>>> +                     } else {
>>> +                             battery->bat_desc.properties =3D
>>> +                                     energy_battery_props;
>>> +                             battery->bat_desc.num_properties =3D
>>> +                                     ARRAY_SIZE(energy_battery_props)=
;
>>> +                     }
>>>                }
>>>        }
>>>
