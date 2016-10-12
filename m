From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 19:50:22 +0200
Message-ID: <CAJZ5v0hREF5P7WyTTVsMAUJb=kTJYNcxSfhvaVQ5foqRNNDp=g@mail.gmail.com>
References: <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade> <20161012090003.GR2774@lahna.fi.intel.com>
 <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk> <CAJZ5v0gPNF9sm9ya6yG-kNi6F3EF01ra=O0NegbEu4+eB1itHg@mail.gmail.com>
 <20161012123205.rcq6bsl4ujihg6tt@sirena.org.uk> <CAJZ5v0gfJ+7=YLHtzDAG70H95Pbdx_DuhfJ0g6UbpZCbfLM3zA@mail.gmail.com>
 <20161012145936.s3llzl26j3ziga7u@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33304 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754922AbcJLRuj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 13:50:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id l131so5491669lfl.0
        for <linux-acpi@vger.kernel.org>; Wed, 12 Oct 2016 10:50:25 -0700 (PDT)
In-Reply-To: <20161012145936.s3llzl26j3ziga7u@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, Oct 12, 2016 at 4:59 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 12, 2016 at 02:42:25PM +0200, Rafael J. Wysocki wrote:
>> On Wed, Oct 12, 2016 at 2:32 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Right, this is currently the idiomatic way to handle these things in
>> > ACPI unfortunately and it's what Windows (which I'm assuming is the
>> > alternative OSs you're referencing here!) does.  Are people working on
>> > trying to move this forwards?
>
>> "Forward" in what way?  To convince the Windows people to change their
>> ecosystem?  No.
>
> Well, at least trying to get standard ACPI able to express these ideas
> better.

There are things that could be covered by ACPI proper (clocks and
regulators support in particular), but some other things covered by DT
in Linux really go beyond that.

The "ports" and "endpoints" concept is a good example of that I think,
as the use case is not in the traditional ACPI space (configuration
and PM).  I'm not really sure if the ASWG is the right venue to talk
about that would-be standard even and if the ACPI spec is the right
place to put it into.

>> > What we've been doing up until now to support these systems in Linux is
>> > to have platform data in the driver that's matched via DMI information.
>
>> That is becoming more and more problematic, though, and generally
>> leads to inflated DMI tables in drivers which is not perfect to put it
>> lightly.
>
> Tell me about it - as far as I can see we're going to end up with a
> kernel patch for most laptops or tablets anyone tries to run Linux on in
> order to get audio working which is going to be a pretty miserable
> experience for users and distros.

Exactly.

>> > The Windows systems don't appear to be in the slightest bit interested
>> > in using the Linux bindings or updating their firmware to accomodate us
>> > so the sensible thing is to work in the same way as they do.
>
>> That would mean adding static data tables to drivers based on device
>> IDs somehow, but that pretty much would be what happened in the ARM
>> camp before DT, wouldn't it?
>
> Yes, that's what it means.  It's pretty much a step backwards from what
> architectures doing board files have - no changes are needed in the
> drivers, instead when you add a new board you add a file which describes
> everything on the board including all the platform data for the device.
> It at least keeps all the support for the board and the matching code in
> one place rather than scattering it through drivers.

Right.

Thanks,
Rafael
