From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 0/3] Preparation for further fwnode property cleanup
Date: Wed, 31 May 2017 15:28:49 +0300
Message-ID: <20170531122849.GG1019@valkosipuli.retiisi.org.uk>
References: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:43216 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751000AbdEaM3B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 08:29:01 -0400
Content-Disposition: inline
In-Reply-To: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robh@kernel.org
Cc: devicetree@vger.kernel.org, frowand.list@gmail.com, linux-acpi@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com, kieran.bingham@ideasonboard.com

Hi Rob,

On Wed, May 24, 2017 at 05:53:52PM +0300, Sakari Ailus wrote:
> Hi Rob, Frank, others,
> 
> Here's the 6th version of what used to be a single patch to prepare for
> fwnode property cleanup.
> 
> Beyond this, I have a couple of other patchsets I'll post in the near
> future:
> 
> - fwnode property cleanup (for linux-pm) which moves the property API 
> implementation to FW specific locations; depends on these patches,
> 
> - V4L2 fwnode patches (for media_tree, no unmerged dependencies, pull
>   request sent) and
> 
> - fwnode const patchset which allows making the fwnode argument for the 
>   property API functions const. It depends on both of the previous sets.
>   Might be for linux-pm.

I figured out that others are starting to have patches that depend on my
other patchsets getting merged. Those patches are for the fwnode property
API that most likely should go through the linux-pm tree as well as for the
media tree.

<URL:http://www.spinics.net/lists/linux-media/msg115893.html>

I have hopes of being able to get the fwnode cleanup patchset (which the
aforementioned patches depend on) in within this merge window --- assuming I
could have your ack on the OF portions.

Would it be possible to have an immutable branch for these or would you
accept a pull request on v4.12-rc1?

Thanks.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
