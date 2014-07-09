From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH 2/2] ACPI/Wakup: Enable button wakeup GPEs if these
 GPEs have associated GPE methods.
Date: Wed, 09 Jul 2014 11:08:42 +0800
Message-ID: <53BCB23A.1070304@intel.com>
References: <1404802679-24019-1-git-send-email-tianyu.lan@intel.com> <1404802679-24019-2-git-send-email-tianyu.lan@intel.com> <3011365.oYtXFx0LHa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58441 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbaGIDKQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2014 23:10:16 -0400
In-Reply-To: <3011365.oYtXFx0LHa@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2014=E5=B9=B407=E6=9C=8808=E6=97=A5 21:26, Rafael J. Wysocki wrote:
> On Tuesday, July 08, 2014 02:57:58 PM Lan Tianyu wrote:
>> The button wakeup GPEs are enabled unconditionally in the current wo=
rld by
>> commit 2a5d24(ACPI / Wakeup: Enable button GPEs unconditionally duri=
ng
>> initialization). Because button's GPE methods needs to be run to cle=
ar
>> GPE status on some machines when there is GPE interrupt. If not, it =
will
>> cause machines resume immediately after being suspended since GPE st=
atus
>> isn't cleared correctly.
>>
>> But if there is no GPE method for button wakeup GPE, these GPEs shou=
ld not
>> be enabled since nothing needs to be done when they are triggered an=
d this
>> also causes LID GPE storm on Lenovo Ideapad y560p.
>>
>> This patch is to check Button GPE method and enable it if there is a=
ssociated
>> GPE method.
>=20
> Part of the problem is that we call acpi_setup_gpe_for_wake() for but=
tons too
> and it sets ACPI_GPE_DISPATCH_NOTIFY unconditionally.

Yes, this is why the GPE wasn't disabled by CA. From my opinion,
original reason of enabling button wakeup GPE in the runtime is that it
may have associated GPE method and the method will notify button driver
and clear some hardware status. But if it didn't have GPE method, I
don't why we need to enable the GPE. I check some machines and they use
EC Query event to notify button driver.

>  While we could address
> this the way you're proposing, it seems a bit less than straightforwa=
rd so to
> speak.
>=20
> Let me think more about how to address that.

Ok. I get it.

>=20
>> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=3D61051
>> Reported-by: James Tocknell<aragilar@gmail.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/wakeup.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
>> index 1638401..5b20ae4 100644
>> --- a/drivers/acpi/wakeup.c
>> +++ b/drivers/acpi/wakeup.c
>> @@ -86,9 +86,14 @@ int __init acpi_wakeup_device_init(void)
>>  						       struct acpi_device,
>>  						       wakeup_list);
>>  		if (device_can_wakeup(&dev->dev)) {
>> -			/* Button GPEs are supposed to be always enabled. */
>> -			acpi_enable_gpe(dev->wakeup.gpe_device,
>> -					dev->wakeup.gpe_number);
>> +			/*
>> +			 * Button GPEs are supposed to be always enabled if
>> +			 * they have associated GPE methods.
>> +			 */
>> +			if (ACPI_SUCCESS(acpi_check_gpe_method(
>> +			    dev->wakeup.gpe_device, dev->wakeup.gpe_number)))
>> +				acpi_enable_gpe(dev->wakeup.gpe_device,
>> +						dev->wakeup.gpe_number);
>>  			device_set_wakeup_enable(&dev->dev, true);
>>  		}
>>  	}
>>
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
