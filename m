From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFH] Power Management mini-summit during the Kernel Summit 2011
Date: Sun, 16 Oct 2011 16:42:13 +0200
Message-ID: <201110161642.14109.rjw@sisk.pl>
References: <201110122211.21638.rjw@sisk.pl> <201110160035.34980.rjw@sisk.pl> <20111016042017.GA4901@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44004 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab1JPOjv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Oct 2011 10:39:51 -0400
In-Reply-To: <20111016042017.GA4901@ponder.secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg KH <gregkh@suse.de>, Linux PM list <linux-pm@vger.kernel.org>, Daniel Drake <dsd@laptop.org>, mark gross <markgross@thegnar.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Len Brown (Intel)" <len.brown@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, jean.pihet@newoldbits.com, Kevin Hilman <khilman@ti.com>, ming.lei@canonical.com, Mark Brown <broonie@sirena.org.uk>, John Stultz <john.stultz@linaro.org>, Chris Ball <cjb@laptop.org>

On Sunday, October 16, 2011, Grant Likely wrote:
> On Sun, Oct 16, 2011 at 12:35:34AM +0200, Rafael J. Wysocki wrote:
> > On Friday, October 14, 2011, Grant Likely wrote:
> > > On Thu, Oct 13, 2011 at 11:33:11PM +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, October 13, 2011, Greg KH wrote:
> > > > > On Thu, Oct 13, 2011 at 01:55:39PM -0600, Grant Likely wrote:
> > > > > > Is there a schedule available yet for the presentations on Tuesday for kernel summit?
> > > > > 
> > > > > We just finalized it yesterday, but I don't think anyone has made it
> > > > > public.  I'll go ask...
> > > > 
> > > > It looks like a key-signing party is scheduled at 16:30 and then there's
> > > > the evening event with buses leaving at 18:15 (most likely).  So there
> > > > seems to be some free time between 5 PM and 6 PM.  I wonder if that's
> > > > going to be sufficient?
> > > 
> > > Ugh; please don't do that.  There is no way it will be sufficient
> > > time, it will make everything rushed, and we'll all be mostly burnt
> > > out by then anyway.
> > 
> > In that case I don't think we can find any suitable time frame at all,
> > at least not right now.
> 
> Send me this list of topics that you have.  Some of them are relevant
> to the ARM community, and we can fit them into the ARM workshop which
> your are more than welcome to attend.

My topics are, more or less:

- Handling off-the-tree dependencies of devices.
- Per-device PM QoS (most importantly, how it is supposed to interact with user
  space).
- Universal platform drivers idea (common bus type for ACPI, PNP and "platform"
  devices).
- Suspend vs wakeup events.

Thanks,
Rafael
