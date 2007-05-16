From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: [PATCH] ACPI: Remove possible recursion from thermal driver
Date: Wed, 16 May 2007 06:19:22 +0400
Message-ID: <8f8ff01d0705151919i23fe8edchce960bef242ce145@mail.gmail.com>
References: <8f8ff01d0705142254r97c8dd9h8aa82eb67e44ae5f@mail.gmail.com>
	 <200705151626.02687.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:38062 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758692AbXEPCTY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 May 2007 22:19:24 -0400
Received: by wr-out-0506.google.com with SMTP id 76so33083wra
        for <linux-acpi@vger.kernel.org>; Tue, 15 May 2007 19:19:22 -0700 (PDT)
In-Reply-To: <200705151626.02687.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Please read the spec 11.1.2 and 11.1.2.3. Trip points change _only_ to
create a hysteresis loop, not by themselves. This means that we will
get 0x81 type _only_ in response to us changing active state, the
moment then we have temperature and just decided to move away from
this trip point, not closer to it.
If the temperature change, we get another event, 0x80, and _then_ we
do thermal_check()...

Regards,
Alex.


On 5/16/07, Len Brown <lenb@kernel.org> wrote:
>
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -1106,7 +1106,6 @@ static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
> >               break;
> >       case ACPI_THERMAL_NOTIFY_THRESHOLDS:
> >               acpi_thermal_get_trip_points(tz);
> >-              acpi_thermal_check(tz);
> >               acpi_bus_generate_event(device, event, 0);
> >               break;
> >       case ACPI_THERMAL_NOTIFY_DEVICES:
>
> I don't think we can do this.
> When the thresholds change, there must be a check to compare the temperature
> with the thresholds -- otherwise what good was it to change the thresholds?
>
> -Len
>
