From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v4 00/16] ACPI graph support
Date: Tue, 7 Mar 2017 15:49:36 +0200
Message-ID: <20170307134936.GJ3220@valkosipuli.retiisi.org.uk>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
 <20170307074948.GE3220@valkosipuli.retiisi.org.uk>
 <CAJZ5v0iNqTb55xrq21Byn5q6XUeFYSa2mMLj+Jnu1_d0DyMvxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:37844 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752390AbdCGNto (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2017 08:49:44 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iNqTb55xrq21Byn5q6XUeFYSa2mMLj+Jnu1_d0DyMvxQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

Hi Rafael,

On Tue, Mar 07, 2017 at 02:23:33PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 7, 2017 at 8:49 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > Hi Rafael,
> >
> > On Mon, Mar 06, 2017 at 04:19:14PM +0200, Sakari Ailus wrote:
> >> This set contains patches written by Mika Westerberg and by myself. The
> >> patchset brings support for graphs to ACPI. The functionality achieved by
> >> these patches is very similar to what the Device tree provides: the port
> >> and the endpoint concept are being employed. The patches make use of the
> >> _DSD property and data extensions to achieve this. The fwnode interface is
> >> extended by graph functionality; this way graph information originating
> >> from both OF and ACPI may be accessed using the same interface, without
> >> being aware of the underlying firmware interface.
> >
> > I've tested the patches again on ARM (OF) and x86-64 (ACPI).
> 
> OK
> 
> > I have V4L2 patches depending on the ACPI graph patchset that I'd like to
> > have in during the same merge window. Would you either accept a pull
> > request, or could I have a branch on top of v4.11-rc1 containing these
> > patches only (for media tree)?
> >
> > The patchset "Move firmware specific code to firmware specific locations"
> > depends on "Fwnode property API fixes for OF, pset". Would you prefer to
> > send the bugfixes as fixes to v4.11 or just put it all to v4.12?
> 
> I'll put it all into v4.12 if that's not a problem.

That's fine for me but see below...

> 
> Also I don't really have the time to take care of that this week due
> to other work.  I'll get to it next week, most likely.

Ack.

Would you prefer me to send a pull request, or pick up the patches --- in
the latter case I'd like to request an immutable branch with these patches
only on v4.11-rc1 which I could use for basing my dependent V4L2 patches
that go to the media tree.

Thanks.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
