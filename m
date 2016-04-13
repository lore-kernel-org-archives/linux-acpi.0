From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] device property: don't bother the drivers with struct property_set
Date: Wed, 13 Apr 2016 06:25:48 +0200
Message-ID: <CAJZ5v0gniH61nKzVEbrMEdPYFVkK2buO5r=aMCsDKTnT2Gki2w@mail.gmail.com>
References: <1459252343-105426-1-git-send-email-heikki.krogerus@linux.intel.com>
	<20160411082027.GF4592@x1>
	<20160411095234.GA26606@kuha.fi.intel.com>
	<CAJZ5v0iHWvp1UvLx1X=MozD0EZ7+L2h7aJYKm6WGBYO0FzGj7g@mail.gmail.com>
	<20160411140541.GY8094@x1>
	<CAJZ5v0hqTj0r=Ky7SNO8ZwhycnNrLefFmx3Vi9qgOyoA02NeHQ@mail.gmail.com>
	<20160411162034.GA8094@x1>
	<CAJZ5v0irXZTVAPrP40oEPahxQb-DNOO_-CKLBhJFx_7rmQodiA@mail.gmail.com>
	<20160412072401.GF8094@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36747 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbcDMEZv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2016 00:25:51 -0400
In-Reply-To: <20160412072401.GF8094@x1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Daniel Mack <daniel@zonque.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Apr 12, 2016 at 9:24 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 11 Apr 2016, Rafael J. Wysocki wrote:
>
>> On Mon, Apr 11, 2016 at 6:20 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Mon, 11 Apr 2016, Rafael J. Wysocki wrote:
>> >
>> >> On Mon, Apr 11, 2016 at 4:05 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> >> > On Mon, 11 Apr 2016, Rafael J. Wysocki wrote:
>> >> >
>> >> >> On Mon, Apr 11, 2016 at 11:52 AM, Heikki Krogerus
>> >> >> <heikki.krogerus@linux.intel.com> wrote:
>> >> >> > On Mon, Apr 11, 2016 at 09:20:27AM +0100, Lee Jones wrote:
>> >> >> >> On Tue, 29 Mar 2016, Heikki Krogerus wrote:
>> >> >> >>
>> >> >> >> > Since device_add_property_set() now always takes a copy of
>> >> >> >> > the property_set, and also since the fwnode type is always
>> >> >> >> > hard coded to be FWNODE_PDATA, there is no need for the
>> >> >> >> > drivers to deliver the entire struct property_set. The
>> >> >> >> > function can just create the instance of it on its own and
>> >> >> >> > bind the properties from the drivers to it on the spot.
>> >> >> >> >
>> >> >> >> > This renames device_add_property_set() to
>> >> >> >> > device_add_properties(). The function now takes struct
>> >> >> >> > property_entry as its parameter instead of struct
>> >> >> >> > property_set.
>> >> >> >> >
>> >> >> >> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >> >> >> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> >> >> >> > Acked-by: Thierry Reding <treding@nvidia.com>
>> >> >> >> > Acked-by: Lee Jones <lee.jones@linaro.org>
>> >> >> >> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> >> >> >> > ---
>> >> >> >> >  arch/arm/mach-pxa/raumfeld.c      | 12 ++++--------
>> >> >> >
>> >> >> > Daniel, I think we just need your ACK for this one.
>> >> >> >
>> >> >> > Otherwise I think we are covered.
>> >> >> >
>> >> >> >> >  arch/arm/mach-tegra/board-paz00.c |  6 +-----
>> >> >> >> >  drivers/base/platform.c           | 19 ++++++++++---------
>> >> >> >> >  drivers/base/property.c           | 34 +++++++++++++++++++++-------------
>> >> >> >> >  drivers/mfd/intel-lpss-acpi.c     | 12 ++----------
>> >> >> >> >  drivers/mfd/intel-lpss-pci.c      | 20 ++++----------------
>> >> >> >> >  drivers/mfd/intel-lpss.c          |  2 +-
>> >> >> >> >  drivers/mfd/intel-lpss.h          |  4 ++--
>> >> >> >> >  drivers/mfd/mfd-core.c            |  4 ++--
>> >> >> >> >  include/linux/mfd/core.h          |  4 ++--
>> >> >> >> >  include/linux/platform_device.h   |  6 +++---
>> >> >> >> >  include/linux/property.h          | 15 +++------------
>> >> >> >> >  12 files changed, 55 insertions(+), 83 deletions(-)
>> >> >> >>
>> >> >> >> What's happening with this patch?  I believe we're still missing
>> >> >> >> Acks.  Once they are collected someone needs to create an immutable
>> >> >> >> branch and send out a pull-request.
>> >> >> >
>> >> >> > Rafael, have you had time to take a look at this?
>> >> >>
>> >> >> Yes, it's in my bleeding-edge branch now.  I'm planning to move it to
>> >> >> linux-next this week
>> >> >
>> >> > Please ensure you send out the relevant pull-requests.  Linus doesn't
>> >> > look his best when he's angry.
>> >>
>> >> I guess you mean I should expose by device-properties branch and
>> >> notify the relevant people about that, right?
>> >
>> > Exactly.  And the easiest way to do that is by sending out a
>> > pull-request.
>>
>> I hoping that sending a message with the relevant information in a
>> reply to this one will be sufficient.
>
> Because of the nature of MFD, I end up doing this kind of thing a lot.
>
> Here's what I normally do.  Normally in reply to the cover-letter (0/x):
>   https://lkml.org/lkml/2015/8/12/138

OK, makes sense.

Thanks,
Rafael
