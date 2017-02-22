From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 15/16] device property: Add fwnode_get_next_parent()
Date: Wed, 22 Feb 2017 15:12:47 +0200
Message-ID: <20170222131246.GP16975@valkosipuli.retiisi.org.uk>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
 <9a481aec-92e6-ac01-b825-167bf73dfb11@redhat.com>
 <6293579.fEEljmGD4Z@aspire.rjw.lan>
 <7605668.5ZxNsBFnEG@aspire.rjw.lan>
 <20170221081749.GC16975@valkosipuli.retiisi.org.uk>
 <CAJZ5v0iWj1gBThCAbY2m+R6VEp-88Pn=5FckvKv9Q=d2cidYyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:51962 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932211AbdBVNM4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Feb 2017 08:12:56 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iWj1gBThCAbY2m+R6VEp-88Pn=5FckvKv9Q=d2cidYyQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Al Stone <ahs3@redhat.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>

Hi Rafael,

On Wed, Feb 22, 2017 at 12:00:07AM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 21, 2017 at 9:17 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > Hi Rafael,
> >
> > On Wed, Feb 08, 2017 at 01:19:57PM +0100, Rafael J. Wysocki wrote:
> > ...
> >> > > I think I agree with Rob's prior comments about making an ops struct for DT
> >> > > vs ACPI.  Out of the 16 patches, 2/16, 3/16, 5/16 (multiple times), and this
> >> > > patch all end up using the same construct.  Maybe it needs to be a separate
> >> > > refactoring effort, but if it's happening this often just in this patch set,
> >> > > it seems like it's getting time to clean things up.
> >> >
> >> > As long as there are two cases only (ACPI vs DT), an ops struct wouldn't
> >> > really make things simpler and it would make the code more difficult to
> >> > follow.
> >> >
> >> > But we do have a third case (static or built-in properties) and it doesn't
> >> > seem to be covered at all.
> >>
> >> That said the ops struct could be introduced on top of this series just fine.
> >> It even might be cleaner to do it this way, so I'm not asking for a redesign
> >> here.
> >>
> >> I'd like the built-in properties to be covered too, however.
> >
> > That sounds good to me.
> 
> OK
> 
> Please update the patches to built-in properties into account, then. :-)

Will do.

I also noticed that I had accidentally merged two patches from RFC v1 to
PATCH v1 sets (device property: Obtain device's fwnode independently of FW
type). There's a redundant patch adding device_fwnode_handle() function as
well, I'll drop that patch (the same subject).

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
