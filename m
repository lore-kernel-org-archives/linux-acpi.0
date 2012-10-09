From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Discussion on device's runtime wake capability
Date: Tue, 09 Oct 2012 22:51:20 +0200
Message-ID: <1983524.TKJB4R5trY@vostro.rjw.lan>
References: <5073C2D0.1080900@intel.com> <744357E9AAD1214791ACBA4B0B90926322FF88@SHSMSX101.ccr.corp.intel.com> <20121009144407.GA1426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:39258 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794Ab2JIUrq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2012 16:47:46 -0400
In-Reply-To: <20121009144407.GA1426@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday 09 of October 2012 22:44:10 Aaron Lu wrote:
> On Tue, Oct 09, 2012 at 06:39:08AM +0000, Zhang, Rui wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > owner@vger.kernel.org] On Behalf Of Aaron Lu
> > > Sent: Tuesday, October 09, 2012 2:23 PM
> > > To: Rafael J. Wysocki; Len Brown
> > > Cc: Huang, Ying; Zhang, Rui; linux-acpi@vger.kernel.org
> > > Subject: Discussion on device's runtime wake capability
> > > Importance: High
> > > 
> > > Hi all,
> > > 
> > > We are using _PRW as a hint to see if a device supports wakeup, this is
> > > fine for device which is able to wake the system in a sleep state, but
> > > not to wake itself when system is at S0.
> > > 
> > > Moreover, when we are to arm the device runtime wake, I think there is
> > > no need to power on the power resources referenced in _PRW, those power
> > > resources should be used to give the device ability to wake the system
> > > from a sleep state, not to wake itself when system is at S0, so
> > > powering thoses power resources on for run wake is a waste.
> > > 
> > Sounds reasonable to me.
> > To do runtime wake, we only need to power on the resources in _PR0.
> 
> That would keep the device in D0 state :-)
> We can put the device into a lower power state which _S0W permits for
> run wake.

Precisely.

Which may or may not have anything to do with the _PRW resources, however.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
