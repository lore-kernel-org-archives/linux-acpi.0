From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: Toshiba Bluetooth enabler (v2) (was: Re: [PATCH] Toshiba
	Bluetooth enabler (rfkill))
Date: Wed, 9 Dec 2009 13:17:48 +0000
Message-ID: <9b2b86520912090517l458bc21cobbb138d460e11f53@mail.gmail.com>
References: <4B192D08.9080608@gmail.com>
	 <9b2b86520912080205x478b47eek2377dacdbe44a522@mail.gmail.com>
	 <4B1E85A9.3030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60981 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbZLINRn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 08:17:43 -0500
In-Reply-To: <4B1E85A9.3030005@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jes Sorensen <jes.sorensen@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On 12/8/09, Jes Sorensen <jes.sorensen@gmail.com> wrote:
> On 12/08/2009 11:05 AM, Alan Jenkins wrote:
>> Cool.  This must be the shortest ACPI driver :-).
>
> Hi Alan,
>
> Here's an updated version that addresses most of your comments.

Hi again

>> Try to send patches inline if possible, it makes them easier to review.
>
> Not possible with Thunderbug, sorry.

I'm guessing you mean Thunderbird.  I manage in Thunderbird by

a) composing in HTML
b) selecting "preformat" from the drop-down menu (the default is "body text"
c) copy+pasting the patch

I seem to have word wrap disabled as well (under
prefs->composition->general), but I think "Preformat" is enough on its
own.


>> Good to see you're handling resume, but what happens if the rfkill
>> switch is _not_ set to on?  It looks like resume will return an error,
>> which will produce a warning message in the kernel log.  I don't think
>> we want that.
>
> Fixed, this version only calls the enabler if the switch is at ON at
> resume time.

Ah... I think add() has the same problem as well though?  I.e. the
driver will not work if the switch is disabled at load time.

I would change it in enable() (and then try to think of a new name for
it, maybe try_enable()).

>>> +	status = acpi_evaluate_integer(device->handle, "_STA", NULL,
>>> +				&bt_present);
>>
>> I think this would benefit from an explanation.
>
> Comments added.

Thanks.

> +static int __init toshiba_bt_rfkill_init(void)
> +{
> +	int result;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;

Sorry for not spotting this earlier, but this test is redundant.
acpi_bus_register() will check if acpi_disabled for you (and return
-ENODEV).

>>> +	result = acpi_bus_register_driver(&toshiba_bt_rfkill_driver);
>>> +	if (result<  0) {
>>> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>>> +				  "Error registering driver\n"));
>>> +		return -ENODEV;
>>> +	}
>>
>> I would suggest you return result, instead of ignoring it and always
>> returning ENODEV.
>
> I agree, added.

Ok.

>>> +	depends on RFKILL
>>> +	depends on BT
>>
>> But you doesn't use either of these subsystems :-). The BT one
>> definitely seems bogus; please drop it.
>
> It seemed kinda silly to me to enable this driver on kernels with no
> BT subsystem, but it's not a biggie so I pulled it.

This is linux :-).  Maybe someone wants to disable the BT drivers and
write their own using libusb, or access the device from an emulated OS
("qemu -usb host:<vendor_id:product_id>").  Let's not stop them.

I don't think it should depend on RFKILL either.  None of the other
platform drivers do a literal "depends on RFKILL" at the moment.  I
agree that this driver is a bit special, but I think complex
cross-menu depends are more frustrating than helpful.

Configuring kernels is hard - I think depends like this make it
harder.  If you don't enable RFKILL, you won't see "If you have a
modern Toshiba laptop with a Bluetooth and an RFKill switch (such as
the Portege R500), say Y".  Then your bluetooth will mysteriously stop
working when you toggle the switch off and on again :).

Thanks
Alan
