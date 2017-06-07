From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 0/3] Preparation for further fwnode property cleanup
Date: Wed, 7 Jun 2017 14:42:45 +0300
Message-ID: <20170607114244.GX1019@valkosipuli.retiisi.org.uk>
References: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com>
 <20170531122849.GG1019@valkosipuli.retiisi.org.uk>
 <CAL_JsqJtB-UVNLo3SM6apB-MODOSWwZzgeAE+ifsmT7U-5WJmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:45298 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751481AbdFGLn3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2017 07:43:29 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqJtB-UVNLo3SM6apB-MODOSWwZzgeAE+ifsmT7U-5WJmw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>

Hi Rob / Frank,

On Mon, Jun 05, 2017 at 10:12:24AM -0500, Rob Herring wrote:
> > I figured out that others are starting to have patches that depend on my
> > other patchsets getting merged. Those patches are for the fwnode property
> > API that most likely should go through the linux-pm tree as well as for the
> > media tree.
> >
> > <URL:http://www.spinics.net/lists/linux-media/msg115893.html>
> >
> > I have hopes of being able to get the fwnode cleanup patchset (which the
> > aforementioned patches depend on) in within this merge window --- assuming I
> > could have your ack on the OF portions.
> >
> > Would it be possible to have an immutable branch for these or would you
> > accept a pull request on v4.12-rc1?
> 
> I've applied this series. The stable branch is here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/property-move

Thanks you!

Could I still have yours / Frank's ack on the fwnode cleanup set patches
2--4 that touch the OF framework, please (naturally assuming you're fine
with them)?

<URL:http://www.spinics.net/lists/devicetree/msg179939.html>

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
