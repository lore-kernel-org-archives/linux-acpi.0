From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 00/16] ACPI graph support
Date: Fri, 10 Mar 2017 00:05:04 +0100
Message-ID: <1810272.34jmmMEX8i@aspire.rjw.lan>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com> <CAJZ5v0iNqTb55xrq21Byn5q6XUeFYSa2mMLj+Jnu1_d0DyMvxQ@mail.gmail.com> <20170307134936.GJ3220@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55935 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751875AbdCIXKZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2017 18:10:25 -0500
In-Reply-To: <20170307134936.GJ3220@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Tuesday, March 07, 2017 03:49:36 PM Sakari Ailus wrote:
> Hi Rafael,

Hi,

> On Tue, Mar 07, 2017 at 02:23:33PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 7, 2017 at 8:49 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > > Hi Rafael,
> > >
> > > On Mon, Mar 06, 2017 at 04:19:14PM +0200, Sakari Ailus wrote:
> > >> This set contains patches written by Mika Westerberg and by myself. The
> > >> patchset brings support for graphs to ACPI. The functionality achieved by
> > >> these patches is very similar to what the Device tree provides: the port
> > >> and the endpoint concept are being employed. The patches make use of the
> > >> _DSD property and data extensions to achieve this. The fwnode interface is
> > >> extended by graph functionality; this way graph information originating
> > >> from both OF and ACPI may be accessed using the same interface, without
> > >> being aware of the underlying firmware interface.
> > >
> > > I've tested the patches again on ARM (OF) and x86-64 (ACPI).
> > 
> > OK
> > 
> > > I have V4L2 patches depending on the ACPI graph patchset that I'd like to
> > > have in during the same merge window. Would you either accept a pull
> > > request, or could I have a branch on top of v4.11-rc1 containing these
> > > patches only (for media tree)?
> > >
> > > The patchset "Move firmware specific code to firmware specific locations"
> > > depends on "Fwnode property API fixes for OF, pset". Would you prefer to
> > > send the bugfixes as fixes to v4.11 or just put it all to v4.12?
> > 
> > I'll put it all into v4.12 if that's not a problem.
> 
> That's fine for me but see below...
> 
> > 
> > Also I don't really have the time to take care of that this week due
> > to other work.  I'll get to it next week, most likely.
> 
> Ack.
> 
> Would you prefer me to send a pull request, or pick up the patches --- in
> the latter case I'd like to request an immutable branch with these patches
> only on v4.11-rc1 which I could use for basing my dependent V4L2 patches
> that go to the media tree.

So from this series I can queue up patches [1-7/16] no problem.

Patch [8/16] requires an ACK from Rob for me to take it.

Patch [9/16] is not even related to this series technically, so please send it
separately to Greg.

Patch [10/16] needs to be folded into the one that depends on it IMO.

I also have questions to patches [11-16/16], but I'll respond to those
separately later.

Thanks,
Rafael

