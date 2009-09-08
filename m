From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] topstar_acpi: add new driver for hotkeys support on
	Topstar N01
Date: Tue, 8 Sep 2009 14:03:31 +0100
Message-ID: <9b2b86520909080603u798eb14dn29dadeeb1b4a87df@mail.gmail.com>
References: <200909050229.55665.herton@mandriva.com.br>
	 <9b2b86520909050602q1c62c648kdce76dc77b9f3dfd@mail.gmail.com>
	 <200909071626.03334.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59077 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbZIHNDb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2009 09:03:31 -0400
Received: by bwz19 with SMTP id 19so2173922bwz.37
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2009 06:03:32 -0700 (PDT)
In-Reply-To: <200909071626.03334.herton@mandriva.com.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>

On 9/7/09, Herton Ronaldo Krzesinski <herton@mandriva.com.br> wrote:
> Em S=E1b 05 Set 2009, =E0s 10:02:32, Alan Jenkins escreveu:
>> On 9/5/09, Herton Ronaldo Krzesinski <herton@mandriva.com.br> wrote:
>> > This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
>> > functionality with Topstar N01 netbook. Besides hotkeys there are
>> > other functions exposed by its ACPI firmware, but for now only
>> > hotkeys reporting on Topstar N01 is supported. Topstar is a chines=
e
>> > manufacturer, its website can be currently reached at
>> > http://www.topstardigital.cn/
>> >
>> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
>>
>> > +static void __exit acpi_topstar_exit(void)
>> > +{
>> > +	acpi_bus_unregister_driver(&acpi_topstar_driver);
>> > +
>> > +	printk(KERN_INFO "Topstar Laptop ACPI extras driver unloaded\n")=
;
>>
>> Oh... and this type of message always strikes me as gratuitous.  rmm=
od
>> doesn't happen during normal operation.  So if the user removed the
>> module... they know they did it.  They can check lsmod if they forge=
t
>> and are not sure.
>>
>> If (as a developer) you want to be sure the acpi driver was really
>> unregistered, you can (and probably should) look in sysfs.
>
> Hi, thanks for review. I addressed all issues you pointed out, and re=
named
> the
> driver to topstar-laptop as suggested by Corentin Chary. I'll attach =
also
> the
> diff on top of previous topstar_acpi.c as reference (before the renam=
e and
> without Kconfig/Makefile changes). I only compiled tested it, as beca=
use of
> bank holidays here will only be able to retest wednesday this, but th=
e
> changes
> are safe anyway. Here is new version of the patch (feel free to add y=
our
> Reviewed-by to it):
>
> From e4fb36e01af04248e1a4ddda0964187e4b7fdb4a Mon Sep 17 00:00:00 200=
1
> From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> Date: Mon, 7 Sep 2009 16:12:48 -0300
> Subject: [PATCH] topstar-laptop: add new driver for hotkeys support o=
n
> Topstar N01
>
> This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> functionality with Topstar N01 netbook. Besides hotkeys there are
> other functions exposed by its ACPI firmware, but for now only
> hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> manufacturer, its website can be currently reached at
> http://www.topstardigital.cn/
>
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

Great!

Reviewed-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

I found two more style points to bug you with.

> +
> +#include <linux/module.h>

The other drivers explicitly include <linux.init.h> for __init.  The
LDD3 book says to do so as well.

It also seems conventional to include <linux/kernel.h> for printk.
(LDD3 thinks module.h is enough, but I disagree since module.h doesn't
directly include kernel.h).

> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>

[whereas the different prefix for the ac_types.h etc suggested that we
should get away without them]

> +
> +static int is_tps_dev;
> +

bool?

"is_tps_dev" seems confused.  I think the phrase should be either "is
a tps _laptop_" or "_has_ a tps device".  Perhaps "found_tps_dev"
would be even better.

> []'s
> Herton

And the same to you :-).
Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
