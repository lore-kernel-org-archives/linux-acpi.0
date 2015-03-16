From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [resend PATCH] driver core: property: support for generic property
Date: Mon, 16 Mar 2015 09:47:22 +0000
Message-ID: <CACxGe6tiDszPDpP_u1yxNgMA8HjagDKtGuu35hfkyJtZdGE0Aw@mail.gmail.com>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
 <CACxGe6tCJAPJc=Pj7vYiJ-cakvL9EsexGMpOD_G0DEPF3iTguQ@mail.gmail.com>
 <2794681.zGttLrs2tn@wuerfel> <1615473.geXTLLKD0n@vostro.rjw.lan> <20150314094231.GA24718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36262 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbCPJrn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2015 05:47:43 -0400
Received: by igbue6 with SMTP id ue6so36671306igb.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2015 02:47:43 -0700 (PDT)
In-Reply-To: <20150314094231.GA24718@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Sat, Mar 14, 2015 at 9:42 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Mar 14, 2015 at 02:09:06AM +0100, Rafael J. Wysocki wrote:
>> On Friday, March 13, 2015 04:24:11 PM Arnd Bergmann wrote:
>> > On Friday 13 March 2015 15:10:38 Grant Likely wrote:
>> > > On Thu, Mar 12, 2015 at 1:41 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > > > On Monday, January 26, 2015 03:17:40 PM Heikki Krogerus wrote:
>> > > > That doesn't seem to go in the right direction to be honest.
>> > > >
>> > > > Actually, having introduced struct fwnode_handle, we should perhaps try to
>> > > > replace both of_node and acpi_node with a single struct fwnode_handle pointer
>> > > > and then add a new fwnode_type for the "pdata" stuff.
>> > >
>> > > I agree on this, but it will be a lot of work to convert...
>> > >
>> > > > If you don't want to deal with of_node, which I can understand easily, it
>> > > > may be worth trying with acpi_node alone at this point and once you have
>> > > > the fwnode_handle pointer, you might use it for both ACPI and "pdata"?
>> > > >
>> > > > Grant, Arnd, I wonder what you think?
>> > >
>> > > That makes sense, and we can populate the fwnode_handle even when
>> > > using DT. That will allow a transition period to move everyone over to
>> > > the fwnode_handle.
>> >
>> > Agreed on both as well.
>>
>> OK
>>
>> So below is what it takes to use struct fwnode_handle to represent ACPI
>> companions.
>>
>> Rafael
>>
>>
>> ---
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: driver core / ACPI: Represent ACPI companions using fwnode_handle
>>
>> Now that we have struct fwnode_handle, we can use that to point to
>> ACPI companions from struct device objects instead of pointing to
>> struct acpi_device directly.
>>
>> There are two benefits from that.  First, the somewhat ugly and
>> hackish struct acpi_dev_node can be dropped and, second, the same
>> struct fwnode_handle pointer can be used in the future to point
>> to other (non-ACPI) firmware device node types.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/acpi/acpi_platform.c    |    2 +-
>>  drivers/acpi/dock.c             |    2 +-
>>  drivers/base/platform.c         |    2 +-
>>  drivers/i2c/i2c-core.c          |    4 ++--
>>  include/acpi/acpi_bus.h         |    3 ++-
>>  include/linux/acpi.h            |    7 ++++---
>>  include/linux/device.h          |   13 +++----------
>>  include/linux/fwnode.h          |   25 +++++++++++++++++++++++++
>>  include/linux/i2c.h             |    4 ++--
>>  include/linux/platform_device.h |    2 +-
>>  include/linux/property.h        |   11 +----------
>>  11 files changed, 43 insertions(+), 32 deletions(-)
>
> Nice, I like the driver core changes:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I like it too. The only comment I have is I would use a static inline
helper for getting/setting the fwnode_handle pointer. The reason being
that there are situations where we're going to want to attach both a
DT node and static data to the same node. Using a helper isolates the
rest of the kernel from any future changes here.

However, despite that comment:

Acked-by: Grant Likely <grant.likely@linaro.org>

My comment isn't significant enough to hold up this change.
