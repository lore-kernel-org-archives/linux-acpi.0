From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Mon, 5 Dec 2016 13:06:08 +0200
Message-ID: <20161205110608.GF1459@lahna.fi.intel.com>
References: <20160920101450.ylohouriienzrgtj@sig21.net>
 <20160920104014.GO1811@lahna.fi.intel.com>
 <20160920155943.zrj7wwgg7ugqyv6i@sig21.net>
 <20160920211153.y7ntwwik2l6ppoqz@sig21.net>
 <20160921090614.GY1811@lahna.fi.intel.com>
 <20160921091635.tjnc2gvj75jixycv@sig21.net>
 <20160923081904.GM1218@lahna.fi.intel.com>
 <20161005124648.4fkl55q2i4qnug2x@sig21.net>
 <20161005130511.GM1765@lahna.fi.intel.com>
 <20161204185219.j45aabkpvptadmcx@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41125 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbcLELIW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Dec 2016 06:08:22 -0500
Content-Disposition: inline
In-Reply-To: <20161204185219.j45aabkpvptadmcx@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, David Cohen <david.a.cohen@linux.intel.com>

On Sun, Dec 04, 2016 at 07:52:19PM +0100, Johannes Stezenbach wrote:
> Hi,
> 
> On Wed, Oct 05, 2016 at 04:05:11PM +0300, Mika Westerberg wrote:
> > On Wed, Oct 05, 2016 at 02:46:48PM +0200, Johannes Stezenbach wrote:
> > > On Fri, Sep 23, 2016 at 11:19:04AM +0300, Mika Westerberg wrote:
> > > > David (CC'd) is working on getting the Dollar Cove PMIC driver
> > > > upstreamed to the mainline kernel.
> > > 
> > > May I ask when to expect a patch?  I'm ready if you
> > > have something to test, even if it's not in
> > > shape for mainline yet.
> > 
> > It typically takes quite some time to get all the legal stuff done
> > before the code can be published. And if people are busy with other
> > things it takes even more time.
> > 
> > So please be patient, it will happen sooner or later ;-)
> 
> I don't want to nag, but just so it doesn't drop off
> the TODO list due to "lack of interest":  What's the
> status?  Will Santa bring the the TI Dollar Cove PMIC driver?

David, do you have any estimate?

> While I'm at it, I also have questions about S0ix support
> in Linux which I didn't find answers to by web search.
> Does S0ix depend on the PMIC driver?  And will it be
> used during run time or only in "sleep" state
> (which would mean "echo freeze >/sys/power/state"
> since ACPI S3 isn't supported)?

AFAIK it is dependent only on components on the SoC. If all goes well
freeze mode will enter S0ix (or it can be entered runtime as well if all
drivers support runtime PM and have moved devices into D3).

> Now all I know is it doesn't seem to be used so far (running 4.9.0-rc7+):
> 
> /sys/kernel/debug/pmc_atom/sleep_state:S0IR Residency:  0us
> /sys/kernel/debug/pmc_atom/sleep_state:S0I1 Residency:  0us
> /sys/kernel/debug/pmc_atom/sleep_state:S0I2 Residency:  0us
> /sys/kernel/debug/pmc_atom/sleep_state:S0I3 Residency:  0us
> /sys/kernel/debug/pmc_atom/sleep_state:S0   Residency: 160934496us

Yeah, seems that the system has not entered S0ix.
