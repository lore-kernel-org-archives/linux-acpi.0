From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] device property: Move FW type specific functionality to FW specific files
Date: Fri, 24 Mar 2017 16:21:17 +0100
Message-ID: <23298688.xfS8SVR2Ym@aspire.rjw.lan>
References: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com> <20170324114212.GA16657@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43728 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965617AbdCXP1A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Mar 2017 11:27:00 -0400
In-Reply-To: <20170324114212.GA16657@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

On Friday, March 24, 2017 01:42:13 PM Sakari Ailus wrote:
> On Fri, Mar 24, 2017 at 01:03:50PM +0200, Sakari Ailus wrote:
> > The device and fwnode property API supports Devicetree, ACPI and pset
> > properties. The implementation of this functionality for each firmware
> > type was embedded in the fwnode property core. Move it out to firmware
> > type specific locations, making it easier to maintain.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Oh, this escaped me a bit early.
> 
> This set is the other part split off from the earlier "Move firmware
> specific code to firmware specific locations" set. It depends on my earlier
> the fwnode fixes, ACPI graph support patchsets and patch "device property:
> Read strings using string array reading functions" that are intended for the
> PM tree. They also depend on patch "of: Move OF property and graph API from
> base.c to property.c" which is intended for the DT tree --- this patch
> additionally depends on the patches on DT tree.
> 
> The only change in the patches from the previous set is rebase, and a new
> patch adding support for fwnode_graph_get_remote_node() has been added. The
> last patch is currently untested. I'll test it in the near future; this set
> is not mergeable for a while until the dependent patches have been merged to
> the respective trees and a new rc1 release is available.
> 
> I'm uploading the patches to the two branches here:
> 
> Fwnode fixes + ACPI graph support + "device property:
> Read strings using string array reading functions":
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-all>
> 
> The previous patches on Rob H's for-next branch + "of: Move OF property
> and graph API from base.c to property.c" + this patchset:
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph-cleaned-on-next>
> 
> It may still take a while until the patches get there.

I'd prefer to see them in Patchwork, though.

Can you please repost all stuff you want to go into 4.12 that has no
dependencies in other trees afresh?

Thanks,
Rafael

