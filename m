From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 14:42:25 +0200
Message-ID: <CAJZ5v0gfJ+7=YLHtzDAG70H95Pbdx_DuhfJ0g6UbpZCbfLM3zA@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade> <20161012090003.GR2774@lahna.fi.intel.com>
 <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk> <CAJZ5v0gPNF9sm9ya6yG-kNi6F3EF01ra=O0NegbEu4+eB1itHg@mail.gmail.com>
 <20161012123205.rcq6bsl4ujihg6tt@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35407 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755175AbcJLMm2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 08:42:28 -0400
Received: by mail-lf0-f65.google.com with SMTP id x79so6945054lff.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Oct 2016 05:42:27 -0700 (PDT)
In-Reply-To: <20161012123205.rcq6bsl4ujihg6tt@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, Oct 12, 2016 at 2:32 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 12, 2016 at 01:14:18PM +0200, Rafael J. Wysocki wrote:
>> On Wed, Oct 12, 2016 at 12:28 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > We appear to not even be trying to set a better standard for how to do
>> > things here.
>
>> Sorry, who's "we"?
>
> Linux.
>
>> In one case, alternative OSes can handle devices on them through
>> drivers that contain code dependent on specific device IDs in their
>> ACPI tables.
>
> Right, this is currently the idiomatic way to handle these things in
> ACPI unfortunately and it's what Windows (which I'm assuming is the
> alternative OSs you're referencing here!) does.  Are people working on
> trying to move this forwards?

"Forward" in what way?  To convince the Windows people to change their
ecosystem?  No.

>>               Linux has drivers for those devices too, but they are
>> based on the of_* interface and expect information from DT that is not
>
> If the drivers have DT code that's not well partitioned in the
> initialization code that sounds like a general problem :(
>
>> available from the ACPI tables (and it is not available, because the
>> drivers working with the alternative OS simply don't need it, as for
>> them the device ID is sufficient to convey all of the information on
>> the given device).
>
> What we've been doing up until now to support these systems in Linux is
> to have platform data in the driver that's matched via DMI information.

That is becoming more and more problematic, though, and generally
leads to inflated DMI tables in drivers which is not perfect to put it
lightly.

> The Windows systems don't appear to be in the slightest bit interested
> in using the Linux bindings or updating their firmware to accomodate us
> so the sensible thing is to work in the same way as they do.

That would mean adding static data tables to drivers based on device
IDs somehow, but that pretty much would be what happened in the ARM
camp before DT, wouldn't it?

Thanks,
Rafael
