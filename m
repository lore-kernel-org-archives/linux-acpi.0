From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 15/16] device property: Add fwnode_get_next_parent()
Date: Thu, 23 Feb 2017 19:01:38 +0200
Message-ID: <20170223170138.GT16975@valkosipuli.retiisi.org.uk>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
 <9a481aec-92e6-ac01-b825-167bf73dfb11@redhat.com>
 <6293579.fEEljmGD4Z@aspire.rjw.lan>
 <7605668.5ZxNsBFnEG@aspire.rjw.lan>
 <20170221081749.GC16975@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:52524 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751637AbdBWRIf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:08:35 -0500
Content-Disposition: inline
In-Reply-To: <20170221081749.GC16975@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ahs3@redhat.com, Sakari Ailus <sakari.ailus@linux.intel.com>, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org

On Tue, Feb 21, 2017 at 10:17:49AM +0200, Sakari Ailus wrote:
> Hi Rafael,
> 
> On Wed, Feb 08, 2017 at 01:19:57PM +0100, Rafael J. Wysocki wrote:
> ...
> > > > I think I agree with Rob's prior comments about making an ops struct for DT
> > > > vs ACPI.  Out of the 16 patches, 2/16, 3/16, 5/16 (multiple times), and this
> > > > patch all end up using the same construct.  Maybe it needs to be a separate
> > > > refactoring effort, but if it's happening this often just in this patch set,
> > > > it seems like it's getting time to clean things up.
> > > 
> > > As long as there are two cases only (ACPI vs DT), an ops struct wouldn't
> > > really make things simpler and it would make the code more difficult to
> > > follow.
> > > 
> > > But we do have a third case (static or built-in properties) and it doesn't
> > > seem to be covered at all.
> > 
> > That said the ops struct could be introduced on top of this series just fine.
> > It even might be cleaner to do it this way, so I'm not asking for a redesign
> > here.
> > 
> > I'd like the built-in properties to be covered too, however.
> 
> That sounds good to me. 

After looking at the implementation, the fwnode interface is rather complete
for property sets --- graphs are inherently cross-device concepts and
property sets don't really lend themselves to that. I think it'd be good to
have at least a use case for that before implementing it based on a thought
that it might be needed for something.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
