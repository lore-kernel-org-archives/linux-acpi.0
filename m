From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 03:18:05 +0200
Message-ID: <2993052.nM4cQRt3uc@vostro.rjw.lan>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com> <20161005114129.GI1765@lahna.fi.intel.com> <20161011122815.GB24347@remoulade>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42284 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1750976AbcJLBLX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 21:11:23 -0400
In-Reply-To: <20161011122815.GB24347@remoulade>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Tuesday, October 11, 2016 01:28:15 PM Mark Rutland wrote:
> On Wed, Oct 05, 2016 at 02:41:29PM +0300, Mika Westerberg wrote:
> > The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
> > ACPI systems, so that the drivers can just call device_property_* and
> > get the properties regardless of the underlying firmware interface.
> > 
> > Are you saying that's not wanted?
> 
> Yes; at least from my PoV.
> 
> I have argued that this is the wrong level of abstraction multiple times,
> across many threads, and in person at conferences.
> 
> To be clear, I have no issue with the general concept of _DSD; describing
> intra-device properties with key-value pairs make sense. I am more than happy
> for _DSD bindings to be inspired by DT bindings, but I am less than happy with
> artificially tying the two together, and pretending that they are the same
> thing when they aren't.

Basically, we're trying to address a technical problem which is to avoid
having two different code paths, one for DT and one for ACPI, in every driver
(and in every piece of every subsystem that happens to take configuration
information from the outside of the kernel).

Today, Linux is the only OS really having this problem, so nobody else cares
realistically.  That may change in the future, but when exactly is rather hard
to say.

> > > It is an RFC and my comment is that I do not like the direction
> > > this ACPI->_DSD->DT is taking, I would like to understand where
> > > this is intended to stop because I am getting worried.
> > 
> > I understand that if there is already an existing native ACPI way of
> > doing things, that should be used. However, we do not have such thing
> > for remote endpoints used between camera components,
> 
> As I have said before, this kind of thing should be handled by the ASWG. This
> is a larger matter than a single device binding, there are related concerns to
> be addressed (e.g. power management), and there are others who deal in ACPI who
> need visibility of the issue, and need to have input.
> 
> > and on the other hand there is an exiting DT binding which only requires
> > small changes to the v4l2 framework (convert it to use fwnodes) to get the
> > thing supported on both DT and ACPI systems.
> 
> So we're blindly copying the DT binding, outside of the view of the ASWG and
> other ACPI users, in a manner that's only going to work with Linux.

I don't think that anyone is talking about copying DT bindings blindly.
At least I'm not FWIW.

> At this point, why bother with ACPI at all?

Because that's the only thing we can get from the firmware in many cases.

We are trying to make it possible to run Linux on systems that ship with
a different OS and with ACPI tables in the firmware without an option to
replace them with anything else.  In those cases, really, a lot of stuff
expected by the Linux kernel code using DT today is going to be missing,
because the other OSes expect to have drivers shipped along with the
platform with the specific knowledge on it based on the specific device
IDs used in it.  In such cases, it is not a problem if there are many
drivers handling the same piece of hardware in the ecosystem as long as
they match different ACPI/PNP device IDs.

That would be a problem in Linux, though, so we need to get the HW
configuration information to the drivers we have somehow.

Generally, there are two ways that can be done.  One is to put all of the
information needed and missing from the firmware-provided ACPI tables into the
kernel itself (which is rather not attractive, from a single-binary distro
kernel perspective, for example).  Another one is to be able to put that
*missing* information into something like an initrd matching the kernel that
will go with it.  It has to be on top of the firmware-provided ACPI stuff,
because usually we don't have enough information allowing us to replace it
with, say, a DT as a whole.

Another use case is when the board ships with ACPI tables in the firmware
and you want to extend it by adding some devices to it and you need to
describe those devices to the kernel somehow.  In that case, you only
really care about Linux and following DT is the most straightforward way.

It may not be possible to follow DT exactly for technical reasons (where
PM and similar are involved etc), but OTOH do we really have to reinvent
every piece of stuff already covered by DT just for the sake of it?

Thanks,
Rafael

