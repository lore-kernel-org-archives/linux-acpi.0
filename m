From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: why do drivers evaluate _INI?
Date: Tue, 23 Jun 2009 10:53:07 +0200
Message-ID: <71cd59b00906230153q38f2d9b5h6c57621c389ecb0f@mail.gmail.com>
References: <200906221732.35993.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:41578 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbZFWIxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 04:53:05 -0400
Received: by fxm9 with SMTP id 9so76298fxm.37
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2009 01:53:08 -0700 (PDT)
In-Reply-To: <200906221732.35993.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

On Tue, Jun 23, 2009 at 1:32 AM, Bjorn Helgaas<bjorn.helgaas@hp.com> wr=
ote:
> [Sorry for the duplicate; I meant to CC: linux-acpi, so I added it he=
re.]
>
> Why do we have ACPI device drivers evaluating _INI? =A0That seems
> like something that should be done by Linux/ACPI, not by the driver.
>
> I see the following drivers using _INI:
> =A0drivers/hwmon/hp_accel.c
> =A0drivers/platform/x86/fujitsu-laptop.c
> =A0drivers/platform/x86/sony-laptop.c
>
> I looked at the git logs where the _INI usage was introduced in
> these drivers, but none gives enough information for me to understand
> why.
>
> If running _INI in the driver makes a difference, I think it's
> really telling us about a problem in Linux/ACPI, and we should
> fix that problem rather than sprinkling _INI evaluation around
> in drivers.
>
> I do see _INI evaluation in this path:
>
> =A0 =A0acpi_init
> =A0 =A0 =A0 =A0acpi_bus_init
> =A0 =A0 =A0 =A0 =A0 =A0acpi_initialize_objects(ACPI_FULL_INITIALIZATI=
ON)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_ns_initialize_devices
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_ns_walk_namespace .. acpi=
_ns_init_one_device
>
> The spec (section 6.5.1) says OSPM should run _INI when a
> description table is loaded. =A0I assume the above path does
> this for the DSDT, at least, but I'm not smart enough about
> the ACPI CA to know whether we also handle SSDTs and dynamic
> LoadTables correctly.
>
> Bjorn
>
> P.S. =A0I'm about to go on vacation for a couple weeks, so I'll
> be slow in responding to any discussion here.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Hi,
I don't know if it's related, but:
eeepc-laptop is calling "INIT" for device ASUS010
asus-laptop is calling "INIT" for device ATK0100

But for eeepc-laptop we provide some flags special to INIT, and in
asus-laptop it returns the model name.
So I don't think we can move INIT for these.

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
