From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 10:22:15 +0100
Message-ID: <20161005092215.GA20248@red-moon>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbcJEJVn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Oct 2016 05:21:43 -0400
Content-Disposition: inline
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

[ +MarkR, MarkB, Rob, Al - I suspect they may want to have a say]

On Wed, Oct 05, 2016 at 01:45:33AM +0300, Sakari Ailus wrote:
> Hello everyone,
> 
> I've been working awhile with my collegue Mika Westerberg to bring
> firmware graph support to ACPI based systems. In practice the
> functionality achieved by these patches is very similar to what the Device
> tree provides: the port and the endpoint concept are being employed. The
> patches make use of the _DSD property and data extensions to achieve this.
> The fwnode interface is extended by graph functionality; this way graph
> information originating from both OF and ACPI may be accessed using the
> same interface.

There is an ongoing effort to avoid wholesale import of DT bindings
into ACPI, I am not a V4L2 expert but it seems to me that with patches
like the one you have submitted we are getting closer and closer to
achieving it instead of avoiding it.

For your information, Al is working on a process to submit _DSD
bindings and this patchset should at least be vetted within that
context.

It is an RFC and my comment is that I do not like the direction
this ACPI->_DSD->DT is taking, I would like to understand where
this is intended to stop because I am getting worried.

Thanks,
Lorenzo

> The last patch of the set contains ASL documentation including and
> example.
> 
> The entire set may also be found here:
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=acpi-graph>
> 
> The resulting fwnode graph interface has been tested using V4L2 async with
> fwnode matching and smiapp and omap3isp drivers, with appropriate changes
> to make use of the fwnode interface.
> 
> The V4L2 patches can be found here --- I'll send them to the linux-media
> list in the near future:
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=v4l2-acpi>
> 
> Both sets can be found here, applied on the same tree (the V4L2 patches
> depend on other patches not in Linus's tree yet):
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=v4l2-acpi-on-graph>
> 
> Feedback would be very welcome.
> 
> -- 
> Kind regards,
> Sakari
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
