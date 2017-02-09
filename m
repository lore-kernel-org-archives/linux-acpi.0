From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Thu, 9 Feb 2017 11:38:18 +0200
Message-ID: <20170209093818.GX19313@lahna.fi.intel.com>
References: <20170202111222.aoiwinw37jrquhbh@sig21.net>
 <20170202113508.GM2053@lahna.fi.intel.com>
 <20170202121639.GO2053@lahna.fi.intel.com>
 <20170202135257.q2djuvnhlsu2qv2v@sig21.net>
 <20170202142618.GX2053@lahna.fi.intel.com>
 <20170202143145.xnjnicrxf5uapuwl@sig21.net>
 <20170202150212.GA2053@lahna.fi.intel.com>
 <20170202154243.wxrdcy6yqohcwvw3@sig21.net>
 <20170202155826.GF2053@lahna.fi.intel.com>
 <20170209092426.6jkcv2sxwwifygwk@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8325 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752237AbdBIJnd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Feb 2017 04:43:33 -0500
Content-Disposition: inline
In-Reply-To: <20170209092426.6jkcv2sxwwifygwk@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Cohen <david.a.cohen@linux.intel.com>, ramakrishna.pallala@intel.com, erik.veijola@intel.com

On Thu, Feb 09, 2017 at 10:24:26AM +0100, Johannes Stezenbach wrote:
> On Thu, Feb 02, 2017 at 05:58:26PM +0200, Mika Westerberg wrote:
> > On Thu, Feb 02, 2017 at 04:42:43PM +0100, Johannes Stezenbach wrote:
> > > On Thu, Feb 02, 2017 at 05:02:12PM +0200, Mika Westerberg wrote:
> > > > Is the model Asus E200HA? Something like this (sorry the information is
> > > > in Finnish but the machine should look the same):
> > > > 
> > > > https://www.karkkainen.com/verkkokauppa/asus-e200ha-fd0005ts-11-6--hd-kannettava-tietokone
> > > 
> > > Looks right, mine is E200HA-FD0004TS but I think that just means dark blue color.
> > 
> > OK, we have one other Cherrytrail machine here which may have the same
> > PMIC. We'll check that first and if it does not have the same, I'll
> > order the above machine.
> 
> Probably it's too early to ask, but did you go for the E200HA
> or what device are you going to use?  And did you start poking
> at it, or what timeframe can we expect some patches to test?

I ordered E200HA from the above link. It should arrive soon so I have
not yet started working on it. My colleaque (Erik Veijola, CC'd) is
actually doing the real work - I'll help him when there is need.

About the time frame, once the machine arrives we'll start working and
try to get the patches ready as soon as possible (but remember we have
other things to do as well).

Let's use the bugzilla entry to track progress.

> BTW, just to clarify about the test patches I added in bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=193891
> You can use them but I also don't mind if they go to the
> garbage can, they were just quickly cobbled together
> for testing.

OK, thanks.
