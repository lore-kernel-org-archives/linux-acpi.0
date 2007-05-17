From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Remove possible recursion from thermal driver
Date: Thu, 17 May 2007 14:23:45 -0400
Message-ID: <200705171423.45700.lenb@kernel.org>
References: <8f8ff01d0705142254r97c8dd9h8aa82eb67e44ae5f@mail.gmail.com> <200705151626.02687.lenb@kernel.org> <8f8ff01d0705151919i23fe8edchce960bef242ce145@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53805 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756558AbXEQSZD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 14:25:03 -0400
In-Reply-To: <8f8ff01d0705151919i23fe8edchce960bef242ce145@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tuesday 15 May 2007 22:19, Alexey Starikovskiy wrote:
> Please read the spec 11.1.2 and 11.1.2.3. Trip points change _only_ to
> create a hysteresis loop, not by themselves. This means that we will
> get 0x81 type _only_ in response to us changing active state, the
> moment then we have temperature and just decided to move away from
> this trip point, not closer to it.
> If the temperature change, we get another event, 0x80, and _then_ we
> do thermal_check()...
> 

Hmm, this sounds promising.
Bob and I discussed this a few weeks ago and for some reason
we were convinced that we needed to get the temperature and
compare it to the new trip points.  Maybe we were wrong.

-Len

> 
> On 5/16/07, Len Brown <lenb@kernel.org> wrote:
> >
> > > --- a/drivers/acpi/thermal.c
> > > +++ b/drivers/acpi/thermal.c
> > > @@ -1106,7 +1106,6 @@ static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
> > >               break;
> > >       case ACPI_THERMAL_NOTIFY_THRESHOLDS:
> > >               acpi_thermal_get_trip_points(tz);
> > >-              acpi_thermal_check(tz);
> > >               acpi_bus_generate_event(device, event, 0);
> > >               break;
> > >       case ACPI_THERMAL_NOTIFY_DEVICES:
> >
> > I don't think we can do this.
> > When the thresholds change, there must be a check to compare the temperature
> > with the thresholds -- otherwise what good was it to change the thresholds?
> >
> > -Len
> >
> 
