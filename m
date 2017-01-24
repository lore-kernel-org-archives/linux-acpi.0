From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Tue, 24 Jan 2017 10:41:12 +0100
Message-ID: <20170124094112.ssmpe6vl4iijsjh6@sig21.net>
References: <20160920104014.GO1811@lahna.fi.intel.com>
 <20160920155943.zrj7wwgg7ugqyv6i@sig21.net>
 <20160920211153.y7ntwwik2l6ppoqz@sig21.net>
 <20160921090614.GY1811@lahna.fi.intel.com>
 <20160921091635.tjnc2gvj75jixycv@sig21.net>
 <20160923081904.GM1218@lahna.fi.intel.com>
 <20161005124648.4fkl55q2i4qnug2x@sig21.net>
 <20161005130511.GM1765@lahna.fi.intel.com>
 <20161204185219.j45aabkpvptadmcx@sig21.net>
 <20161205110608.GF1459@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:48948 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751110AbdAXKZo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Jan 2017 05:25:44 -0500
Content-Disposition: inline
In-Reply-To: <20161205110608.GF1459@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, David Cohen <david.a.cohen@linux.intel.com>

Hi,

On Mon, Dec 05, 2016 at 01:06:08PM +0200, Mika Westerberg wrote:
> On Sun, Dec 04, 2016 at 07:52:19PM +0100, Johannes Stezenbach wrote:
> > On Wed, Oct 05, 2016 at 04:05:11PM +0300, Mika Westerberg wrote:
> > > On Wed, Oct 05, 2016 at 02:46:48PM +0200, Johannes Stezenbach wrote:
> > > > On Fri, Sep 23, 2016 at 11:19:04AM +0300, Mika Westerberg wrote:
> > > > > David (CC'd) is working on getting the Dollar Cove PMIC driver
> > > > > upstreamed to the mainline kernel.
> > > > 
> > > > May I ask when to expect a patch?  I'm ready if you
> > > > have something to test, even if it's not in
> > > > shape for mainline yet.
> > > 
> > > It typically takes quite some time to get all the legal stuff done
> > > before the code can be published. And if people are busy with other
> > > things it takes even more time.
> > > 
> > > So please be patient, it will happen sooner or later ;-)
> > 
> > I don't want to nag, but just so it doesn't drop off
> > the TODO list due to "lack of interest":  What's the
> > status?  Will Santa bring the the TI Dollar Cove PMIC driver?
> 
> David, do you have any estimate?


Meanwhile I found out the TI PMIC and power button drivers
has been published as part of the Asus ZenFone Zoom (ZX551ML)
Android kernel code drop (based on linux-3.10.x):

https://www.asus.com/support/Download/39/1/0/26/BXbNqJplzZiLmk6G/32/

Please let me know if there is anything I could do
to help get it mainlined soon.


Thanks,
Johannes
