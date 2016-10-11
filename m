From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 14:30:10 +0100
Message-ID: <20161011133009.GA25049@remoulade>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <57F6BDDE.1010904@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752657AbcJKNg4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 09:36:56 -0400
Content-Disposition: inline
In-Reply-To: <57F6BDDE.1010904@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com, rafael@kernel.org, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Fri, Oct 07, 2016 at 12:10:54AM +0300, Sakari Ailus wrote:
> The ACPI standard defines the syntax for _DSD property and data
> extensions but it does not provide a solution for documenting these
> properties. In other words, it does provide a mechanism but it does not
> tell how and for which specific purposes that mechanism should or may be
> used. The _DSD property extension specification strongly discourages the
> use of _DSD for purposes that already are within the scope of the ACPI
> standard. In this respect, the use of _DSD in this RFC patchset does
> conform to the ACPI standard specifications.
> 
> That said, I do recognise that --- as we do have a single interface to
> access the properties in drivers --- there must be uniform use of these
> properties by firmware implementations or there will be problems. This
> holds true independently of the firmware implementation, be it Device
> tree, ACPI or both.

We only have that 'single interface to access the properties in drivers' (by
which I assume you mean the device_property_* accessors), because they were
specifically added with PRP in mind. So I don't follow.

> The Device tree binding documentation is part of the kernel and that's
> what the FDT binaries are expected to use, too. The bindings are Linux
> specific and, as far as I understand, cannot be expected to be used by
> other operating systems even on same hardware.

While it's true that Linux is the largest user, bindings are definitely not
intended to be OS specific, and there are other users today (e.g. FreeBSD).
There's an effort to properly factor out bindings into the devicetree.org spec,
where the very core DT bindings live today.

> I do not agree with the proposition of making concepts and implementation
> different on ACPI for the sake of it being ACPI.

No one is suggesting difference for difference's sake.

There are two large issues:

* PRP* circumvents ASWG, and its intended semantics are at best unclear. Due to
  this, it's a free-for-all.

* There *are* differences between ACPI and DT models which require
  consideration. For both componentised devices and pinctrl there are concerns
  w.r.t. how that interacts with the usual ACPI PM model, for example.

> With _DSD, the ACPI does support the same tree structure of nodes and
> properties as DT; I see no reason why "ACPI native" support for this class of
> constructs could not (or yet, even should not) use the same mechanisms as the
> Device tree does.There's simply no need to reinvent the wheel.

If the ASWG are fine with a DT-inspired (and perhaps identical) model, I have
no problem with that. I think it needs to be raised there first.

[...]

> The ports and endpoints are not part (or have not been a part) of Device
> tree itself, but they are the established practice on Linux and they have
> worked well. Yet they do not have anything Linux specific as such: they
> simply are a mechanism to describe the hardware.

This is true, in that it is a description of hardware, and certainly is not
intended to be Linux-specific.

It is not true, in that other communities have had no input. If other ACPI
users want to solve this problem in a different way, this will be
Linux-specific (and until it's in the ACPI spec, it must be assumed that is the
case).

Thanks,
Mark.
