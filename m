From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 13:28:15 +0100
Message-ID: <20161011122815.GB24347@remoulade>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbcJKMgf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 08:36:35 -0400
Content-Disposition: inline
In-Reply-To: <20161005114129.GI1765@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Wed, Oct 05, 2016 at 02:41:29PM +0300, Mika Westerberg wrote:
> The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
> ACPI systems, so that the drivers can just call device_property_* and
> get the properties regardless of the underlying firmware interface.
> 
> Are you saying that's not wanted?

Yes; at least from my PoV.

I have argued that this is the wrong level of abstraction multiple times,
across many threads, and in person at conferences.

To be clear, I have no issue with the general concept of _DSD; describing
intra-device properties with key-value pairs make sense. I am more than happy
for _DSD bindings to be inspired by DT bindings, but I am less than happy with
artificially tying the two together, and pretending that they are the same
thing when they aren't.

> > It is an RFC and my comment is that I do not like the direction
> > this ACPI->_DSD->DT is taking, I would like to understand where
> > this is intended to stop because I am getting worried.
> 
> I understand that if there is already an existing native ACPI way of
> doing things, that should be used. However, we do not have such thing
> for remote endpoints used between camera components,

As I have said before, this kind of thing should be handled by the ASWG. This
is a larger matter than a single device binding, there are related concerns to
be addressed (e.g. power management), and there are others who deal in ACPI who
need visibility of the issue, and need to have input.

> and on the other hand there is an exiting DT binding which only requires
> small changes to the v4l2 framework (convert it to use fwnodes) to get the
> thing supported on both DT and ACPI systems.

So we're blindly copying the DT binding, outside of the view of the ASWG and
other ACPI users, in a manner that's only going to work with Linux.

At this point, why bother with ACPI at all?

Mark.
