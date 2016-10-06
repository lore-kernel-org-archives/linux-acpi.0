From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 15:26:59 +0300
Message-ID: <20161006122659.GJ30800@lahna.fi.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <20161006091133.GF30800@lahna.fi.intel.com>
 <20161006104058.uqdkv3pfihicxyfv@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64584 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755616AbcJFMb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Oct 2016 08:31:26 -0400
Content-Disposition: inline
In-Reply-To: <20161006104058.uqdkv3pfihicxyfv@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 06, 2016 at 12:40:58PM +0200, Mark Brown wrote:
> On Thu, Oct 06, 2016 at 12:11:33PM +0300, Mika Westerberg wrote:
> 
> > One reason is that we have boards like Joule where developers are
> > allowed to connect different peripherals using buses such as I2C and SPI
> > where there is no native enumeration mechanism. This includes camera
> > sensors and related so there needs to be a way for a developer to
> > describe this in ACPI. Just as can be done when using ARM and DT.
> 
> One of my biggest concerns with this approach is that I'm really not
> clear to me that that this has broad buy in from the x86/ACPI community
> and therefore that we might end up needing to support several different
> styles of ACPI bindings.  Reuse would be great but it can be confusing
> if there's multiple different styles of bindings in use at the same
> time.

Yes, that's possible unfortunately. And we can't force people to use
whatever _DSD properties we came up. Instead they use whatever is
convenient for them, even if it is already available in the _DSD
properties database.

> The audio systems that have this issue (which include production laptops
> and tablets with both Windows and ChromeOS) don't seem to be showing
> much interest in reusing any of the DT work beyond the device level
> properties and I didn't think the OS level support for using _DSD in
> Windows was great.  There were also the pinctrl bindings which had some
> issues too.

Right and it does not always follow DT work even on device level.

Here is an example what Windows is supporting. They use _DSD device
properties but it is completely different to what Linux and DT use:

https://msdn.microsoft.com/en-us/windows/uwp/devices-sensors/enable-usermode-access

We have had all that stuff in DT already but they chose not to use it.
