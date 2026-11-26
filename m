Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704985;
	b=3Ky4TeopqFP1ZTOeBcUh3RRX5UcazI4nYC1eLYm6+5hK1wZw1SwxSuEmI2fjoUZH/DOY
	 AVOE0vDxumnlFfug3YQm6Z0GhlBgkYBcbGYftPP2Sfc7Y2RzXhoabYO0kP7pCedCg93EB
	 3Aa9dJOHrZM/8swYV/wi0r/Fp+3Se2dhBPMPo3n1qzlQJNRWcaWKMiVsjlQg7Za5HR4f4
	 +J6Sbc+9PY7oJA9fuUfSN0zLxA+t9rxKA2w4AEcFSwv2jS/TIDrF/mRrmrbPmrwD6GdhC
	 b2dKs33Yw0LY1IsiQ/nQDuMeQjlCnaOWbAwBDnwU54XS+kOFh42BGBhIhELTdQ8tDGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TrHz6TOmRTj7K/IVnMz2oUxTcCVWtjA1RyFgDD9jfkY=;
	b=p9xvslSeWLFWNJ2PTqxFLfEcyuPRcLEDfb6w6fRa0ufDYUx3up1Q5F+NqAwob+/2lyGM
	 m4fZFFiwM10hwmjzncUb/2p6cx6dRnb/dLhkBvlE4Yk8u8RuF6zA1Y6s4q+OmrO2d2646
	 i/8BUT+OaeV3f9AzYumkznDIQ+Aw51NEe27dXaRnMe5VN4BNaYII+5u/Q5QRV6a2y2zmY
	 gTBQBvjdpnQwqKHsg99YTqToUp4xEPVvQWIwd3ZFkYLCQwvP3/Fl/bFBCtuR1eEPUW0Yp
	 5uppVCy7d+Gy9Nex12odJ+xP/rR9iLNwZGG6aL8L6juOU6cCmKgEvkrgOk004na4DkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=beagleboard.org;
	spf=fail smtp.mailfrom=beagleboard.org;
	dkim=pass header.d=beagleboard.org header.i=@beagleboard.org header.a=rsa-sha256 header.s=google header.b=kuWFX0qE;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D513606A31E
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 14:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D513606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard.org header.i=@beagleboard.org header.a=rsa-sha256 header.s=google header.b=kuWFX0qE
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b49a6e8212so2806653a91.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard.org; s=google; t=1795704983; x=1796309783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TrHz6TOmRTj7K/IVnMz2oUxTcCVWtjA1RyFgDD9jfkY=;
        b=kuWFX0qE3kh/bmWRoRYWh8Ng18vFAxRf5il3ZdEUyKMzo/0HNxSp31hT7PnXO6yLvF
         PkfPw/WLrJEotnIpGU035hL7l/5qz2HcSmN47wBoEVR0tjJKtc03Q23b+0KmfxzUn0ko
         zDRXnJxkJ9tn/MQE2vs6Ab7fktR2+8MHGy21NpTgkiabrrY3ogPxhNUVVlbKLcA8pSrI
         AvE7HqwrCy6rzhXf0Vt6SbE+XgCbyDpZugF58gPBTXbn7etHqdunGJA1c6fESeDQTfPA
         82/IRIVKWOkoFeEQH2JmGU8XMW0drJSComjFKWPYURGBBUWDBHWsR+UvpmmFBlui6+fp
         qArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704983; x=1796309783;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrHz6TOmRTj7K/IVnMz2oUxTcCVWtjA1RyFgDD9jfkY=;
        b=DaWCazi7XllpileSWtc/UdlproW4z7EjQ0GLICA+ihAh+yTYIqxzfCC+uKS+NaLT7R
         XYaahF57CBEDXjNFxUYN/CC7bed+ITcgnUAA2cwOzTIAtfW7EFW81rOTvXyNhVywT4qg
         YqvP6J+jfAYcEybsPFSFKij0N64w/hFlzdKR/7LNG0vuYV49JpbgLQ08vZSOwCVpH9PC
         5QIJtHxets+KMkdsdx0uHhmgjaiYyvEnukEu6HByB+VcreSa6PjLbt8Gv0knGSIbuSRE
         uqBpVmK6xqS031OmmIvXx0HFxj3zqShIFshva+TE4BbyRuUnX9FuDPNnQE5M/wEESOj/
         R7Kw==
X-Forwarded-Encrypted: i=1; AL+hErGo9rBv9XJBfujbn/sUAotLFSrlOlrZi98oLtAqhlTrydPOzrZOHwve2ADTcY7G5muHkPY464hnezOx@vger.kernel.org
X-Gm-Message-State: APuU4Z8FKWOFaodsTUdP8Btg+HpVI4OKlnZCdL6DEeWd9S1MJVB/WDbR
	BTew8+5b6C4a6mDDVyRMACWprgEu8JH1TpoHn+kLKf/h2YOVugOtrUwQ4ZujvQAYBA==
X-Gm-Gg: AZFdTZfbLxU8QfzhP1YZqwAIzgN4neObZ2LkXX5mJSQ3yXmER0qs2dJe0gk6c0qIhsV
	70MaLPQYr0ebrOWSjsJyQG27ZDt4XHZVhJL4N5Dpr+k/QNPCCNfgo35Fl07UAynVg8e5OMVAdDK
	cGeIZQxLd0+I113l7aJY8pwI4l54mJjSoy4zP2RqxMSsL/8gZDGaV8fL+7DM1B6MccMvaBxr4+J
	UBHWuC3fuz7pZCbjqVsz0BS06Ho42ejKNkKTRGx5jGTX6cjo916atm8J5Cvtnj8EpsAD6e0ajdN
	0aK1xxYjzsNLRKPNF4pY85Al2Et34ClN84O/8YY4OglG5QFMHDMW9CbNUOj/J9TXXlbNRNZDJqc
	h1rPgbNTjwJ7fa1bTalVmnh6v7k4kb9DhhUz1UYpTjBdo0i7zfUijUvcjNisipzTECANH94VLCj
	pJxlGAwP+QN277147ranrPlYVS3wCA68SUx1AyBhMbpPHYzgc4eOiliU8HeWGK/hh8TbQzlOCfC
	lNTRv+jlyBUpYWoD51JxYGh2NGkADd/tnR+83NTHwRNs1sbONEQsCa/+SCSwZgGdM2zsmecXAlo
	S4EoOgCVFm0HW+VdvtFN9D8wn79ZSYY=
X-Received: by 2002:a17:90b:3f10:b0:3b4:1982:45b4 with SMTP id 98e67ed59e1d1-3b41cb212d5mr19343715a91.57.1795704983367;
        Thu, 26 Nov 2026 06:56:23 -0800 (PST)
Received: from fedorapc ([2405:201:4019:32fc:3c55:6b24:5147:322b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm34215770a91.12.2026.11.26.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:56:23 -0800 (PST)
From: Ayush Singh <ayush@beagleboard.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ayush Singh <ayush@beagleboard.org>,  Len Brown <lenb@kernel.org>,
  linux-acpi@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: power: Add serialize_power_on_quirk
In-Reply-To: <CAJZ5v0hVX0vQ3oy_jiSAqERc4tmTZECFbsGfRi3=3Gz1Q2+H1w@mail.gmail.com>
References: <20261124-ssd-fix-v1-1-ee8ef43190b1@beagleboard.org>
	<CAJZ5v0hVX0vQ3oy_jiSAqERc4tmTZECFbsGfRi3=3Gz1Q2+H1w@mail.gmail.com>
Date: Thu, 26 Nov 2026 20:26:19 +0530
Message-ID: <8733sniquk.fsf@beagleboard.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki (Intel)" <rafael@kernel.org> writes:

> On Tue, Nov 24, 2026 at 1:16=E2=80=AFPM Ayush Singh <ayush@beagleboard.or=
g> wrote:
>>
>> On the Lenovo Yoga Pro 7 14AKP10 (83KG, AMD Krackan), the NVMe drive in
>> the second M.2 slot is frequently lost after resuming from s2idle:
>>
>>   pcieport 0000:00:02.1: broken device, retraining non-functional downst=
ream link at 2.5GT/s
>>   pcieport 0000:00:02.1: retraining failed
>>   pcieport 0000:00:02.1: Data Link Layer Link Active not set in 100 msec
>>   nvme nvme1: Disabling device after reset failure: -19
>>
>> The _ON methods of the two M.2 slots' power resources update a clock
>> control register shared by both slots without any locking, and sleep in
>> the middle of the update. Since the root ports are resumed
>> asynchronously, the two methods can run concurrently, and one of them
>> can undo the other's change, leaving that slot's reference clock
>> disabled. Its link then never trains.
>>
>> Evaluate power resource _ON methods one at a time on this machine.
>> With this, 20/20 s2idle cycles succeeded, versus failure within 1-2
>> cycles before. Also tested in normal laptop usage for a few days.
>>
>> The same symptom has been reported on the closely related IdeaPad Pro 5
>> 14AKP10 (83JL) [0], which may need this quirk as well, but it is not
>> included here as it could not be tested.
>>
>> [0]: https://ratatoskr.run/linux-pci/2026/04/6586201/t
>>
>> Assisted-by: claude-opus-5-5
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>> On the Lenovo Yoga Pro 7 14AKP10 (83KG, AMD Krackan, BIOS QFCN29WW),
>> the NVMe drive behind root port 00:02.1 (ACPI GPP3) is lost on nearly
>> every s2idle resume, while the drive in the other M.2 slot (GP10) always
>> comes back. Updating to the latest BIOS did not help, and neither did
>> disabling SSD power management via kernel parameters or recovering the
>> device from userspace.
>>
>> The "broken device, retraining non-functional downstream link at
>> 2.5GT/s" / "retraining failed" messages come from the Target Speed quirk
>> reacting to a link that cannot train at all. The actual cause is a race
>> between the two slots' power resource _ON methods in firmware, which
>> can leave one slot's reference clock disabled, as described in the
>> patch. I can share the relevant AML and debug logs if useful.
>>
>> Testing: 20/20 s2idle cycles with real S0i3 residency, versus failure
>> within 1-2 cycles without the patch. I have also done normal daily use
>> testing outside of synthetic suspend.
>>
>> The IdeaPad Pro 5 14AKP10 (83JL) appears to have the same problem on
>> the same root port [0]. I don't have one to test, so it is not in the
>> DMI table.
>>
>> I went with a DMI quirk that serializes power resource _ON methods
>> on this machine only. If serializing them unconditionally, or some
>> other approach, is preferred, I'm happy to rework it.
>>
>> [0]: https://ratatoskr.run/linux-pci/2026/04/6586201/t
>
> So there is acpi_evaluate_object_exclusive() now and you can use it
> for _ON evaluation.
>
> It will serialize the method with other things too, but that's not a big =
deal.
>
>> ---
>>  drivers/acpi/power.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
>> index 23a4e207a01e..b997d98f38c4 100644
>> --- a/drivers/acpi/power.c
>> +++ b/drivers/acpi/power.c
>> @@ -64,6 +64,10 @@ struct acpi_power_resource_entry {
>>
>>  static bool hp_eb_gp12pxp_quirk;
>>  static bool unused_power_resources_quirk;
>> +static bool serialize_power_on_quirk;
>> +
>> +/* Serializes _ON evaluation when serialize_power_on_quirk is set */
>> +static DEFINE_MUTEX(power_on_lock);
>>
>>  static LIST_HEAD(acpi_power_resource_list);
>>  static DEFINE_MUTEX(power_resource_list_lock);
>> @@ -362,13 +366,27 @@ void acpi_device_power_remove_dependent(struct acp=
i_device *adev,
>>                 acpi_power_resource_remove_dependent(entry->resource, de=
v);
>>  }
>>
>> +static acpi_status acpi_power_evaluate_on(acpi_handle handle)
>> +{
>> +       acpi_status status;
>> +
>> +       if (!serialize_power_on_quirk)
>> +               return acpi_evaluate_object(handle, "_ON", NULL, NULL);
>> +
>> +       mutex_lock(&power_on_lock);
>> +       status =3D acpi_evaluate_object(handle, "_ON", NULL, NULL);
>> +       mutex_unlock(&power_on_lock);
>> +
>> +       return status;
>> +}
>> +
>>  static int __acpi_power_on(struct acpi_power_resource *resource)
>>  {
>>         acpi_handle handle =3D resource->device.handle;
>>         struct acpi_power_dependent_device *dep;
>>         acpi_status status =3D AE_OK;
>>
>> -       status =3D acpi_evaluate_object(handle, "_ON", NULL, NULL);
>> +       status =3D acpi_power_evaluate_on(handle);
>
> So I'd replace acpi_evaluate_object() above with
> acpi_evaluate_object_exclusive().

Sure, that sounds good. Just to confirm though, I should do that only for
devices with the quirk though, right? i.e. behind a conditional. Or do you
mean that it should use acpi_evaluate_object_exclusive unconditionally?

>
>>         if (ACPI_FAILURE(status)) {
>>                 resource->state =3D ACPI_POWER_RESOURCE_STATE_UNKNOWN;
>>                 return -ENODEV;
>> @@ -1096,6 +1114,24 @@ static const struct dmi_system_id dmi_hp_eliteboo=
k_gp12pxp_quirk[] =3D {
>>         {}
>>  };
>>
>> +static const struct dmi_system_id dmi_serialize_power_on[] =3D {
>> +       /*
>> +        * On the Lenovo Yoga Pro 7 14AKP10, the _ON methods of the M.2 =
slot
>> +        * power resources update a shared clock control register without
>> +        * locking and sleep in the middle of the update. When the root =
ports
>> +        * are resumed concurrently, one slot's reference clock can end =
up
>> +        * disabled and its NVMe drive is lost after resume.
>> +        */
>> +       {
>> +               /* Lenovo Yoga Pro 7 14AKP10 */
>> +               .matches =3D {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83KG"),
>> +               },
>> +       },
>> +       {}
>> +};
>> +
>>  static const struct dmi_system_id dmi_leave_unused_power_resources_on[]=
 =3D {
>>         {
>>                 /*
>> @@ -1156,4 +1192,7 @@ void __init acpi_power_resources_init(void)
>>         hp_eb_gp12pxp_quirk =3D dmi_check_system(dmi_hp_elitebook_gp12px=
p_quirk);
>>         unused_power_resources_quirk =3D
>>                 dmi_check_system(dmi_leave_unused_power_resources_on);
>> +       serialize_power_on_quirk =3D dmi_check_system(dmi_serialize_powe=
r_on);
>> +       if (serialize_power_on_quirk)
>> +               pr_info("Serializing power resource _ON methods\n");
>>  }
>>
>> ---
>> base-commit: 988117cc1bb17338c586a4e21ade88b5397eac33
>> change-id: 20261122-ssd-fix-6b7ab639796d
>>
>> Best regards,
>> --
>> Ayush Singh <ayush@beagleboard.org>
>>
>>


Best Regards,
Ayush Singh

--=20
BeagleBoard.org Foundation
https://www.beagleboard.org
