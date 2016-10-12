From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 13:14:18 +0200
Message-ID: <CAJZ5v0gPNF9sm9ya6yG-kNi6F3EF01ra=O0NegbEu4+eB1itHg@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade> <20161012090003.GR2774@lahna.fi.intel.com> <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35004 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbcJLL1F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 07:27:05 -0400
Received: by mail-lf0-f67.google.com with SMTP id x79so6612562lff.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Oct 2016 04:26:17 -0700 (PDT)
In-Reply-To: <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, Oct 12, 2016 at 12:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 12, 2016 at 12:00:03PM +0300, Mika Westerberg wrote:
>
>> The _DEP method should be used for Operation Region dependencies but
>> here it is used for functional dependencies so that the audio machine
>> driver can find the corresponding codec. Why Microsoft used it like this
>> and not pushed it to ASWG to be added to the ACPI spec? Should we now
>> refuse to support it in Linux on the basis that it has not been
>> discussed with ASWG and it abuses _DEP?
>
> The fact that the ACPI community hasn't been doing a good job of working
> together is essentially the issue that people are pushing back on here.

But this is not the right venue to talk about it which you should know. :-)

> We appear to not even be trying to set a better standard for how to do
> things here.

Sorry, who's "we"?

> Sitting externally to the group at Intel doing this it really looks like
> there's been a decision to mirror DT into ACPI en masse.  If we really
> want to do that we should actually take that decision, preferrably with
> at least buy in from other ACPI users on Linux and with some review of
> existing ACPI standardization efforts to make sure we're not duplicating
> work there.  Ideally we'd also be pushing anything we do towards ASWG
> even if just as a fiat accomplait.
>
>> > By copying DT, but changing a few things, we're in effect creating a new
>> > ill-defined Linux-specific standard. If we're going to create a new standard,
>> > we should go through the ASWG, and make an actual standard. If we're not going
>> > to create a new standard, we should use DT directly, rather than trying to
>> > force DT into ACPI.
>
>> These boards we are talking about ship with ACPI based firmware. We
>> should not expect users of those boards to be cabable of replacing the
>> existing firmware with DT one.
>
> Since we're still at the point of defining bindings hopefully we're not
> shipping yet...

It seems to me that the problem is escaping you.

The systems in question are shipping in this form or another, with
ACPI tables in the firmware.

In one case, alternative OSes can handle devices on them through
drivers that contain code dependent on specific device IDs in their
ACPI tables.  Linux has drivers for those devices too, but they are
based on the of_* interface and expect information from DT that is not
available from the ACPI tables (and it is not available, because the
drivers working with the alternative OS simply don't need it, as for
them the device ID is sufficient to convey all of the information on
the given device).

In the second case, devices can be added to them through extensions
that require information on those devices to be provided to the kernel
in some way (IOW, they aren't auto-enumerable).  Again, there are
drivers for at least some of those devices in Linux already, but they
are based on the of_* interface and expect information from DT that is
not available from the ACPI tables (and it is not available, because
the devices were not there when the firmware was developed, so there
is no way it can contain information on them).

But this isn't the point of this patch series even.

The point is that ports/endpoints appear to be a useful concept.  I
agree with that.

Moreover, *in* *principle* I don't see anything wrong with adding code
to the kernel to support that (generally useful concept) through _DSD
properties.  Again, if you see anything wrong with this in particular,
please let me know, but please be specific.

Finally, if ports/endpoints can be supported through _DSD properties,
I don't see any reason to not follow DT in that respect.

Thanks,
Rafael
