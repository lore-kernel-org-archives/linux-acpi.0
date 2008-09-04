From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FCAS table
Date: Thu, 4 Sep 2008 11:48:50 +0200
Message-ID: <200809041148.51401.rjw@sisk.pl>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <200809041010.07058.rjw@sisk.pl> <1220520475.4007.134.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52769 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbYIDJow (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 05:44:52 -0400
In-Reply-To: <1220520475.4007.134.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org

On Thursday, 4 of September 2008, Zhao Yakui wrote:
> On Thu, 2008-09-04 at 10:10 +0200, Rafael J. Wysocki wrote:
> > On Thursday, 4 of September 2008, Zhao Yakui wrote:
> > > Subject: ACPI : Set 32bit and 64bit waking vector in FCAS table
> > > From: Zhao Yakui <yakui.zhao@intel.com>
> > > 
> > >     On some laptops only the 64bit waking vecotr is set for ACPI 2.0 FACS.
> > > But when the system is resumed, BIOS will transfer control directly to 
> > > 32bit waking vector. In such case the system can't be resumed correctly.
> > >     Maybe it will be more appropriate that both the 32bit and 64bit waking 
> > > vector will be set for the ACPI 2.0 FACS when the system enters the S3 
> > > sleeping state.
> > > 
> > >  http://bugzilla.kernel.org/show_bug.cgi?id=11368
> > 
> > Well, the spec (2.0c) says we should use facs->firmware_waking_vector only
> > if facs->xfirmware_waking_vector is zero, so I'm afraid this change may cause
> > regressions to happen.
> The 32bit and 64bit waking vector are for BIOS. For the ACPI 2.0 FACS
> after the system is resumed, firmware will check whether the 64bit
> waking vector is zero. If not zero, it will transfer controls to 64 bit
> waking vector address. If zero, it will then check whether the 32bit is
> zero. If not zero, it will transfer controls to the 32bit waking vector
> address. 
> If bios can follow above check, it is ok to set only one. And another is
> set to zero. But if BIOS can't follow above check and only 64bit waking
> vector is set, maybe the system can't be resumed very well.

I understand that, but I'm not sure what happens if we set
facs->firmware_waking_vector even though the BIOS expects us not to set it
(probably nothing, but still).  In fact we should test that on all machines
known to work with the current code and that's impossible.  Let's just
add quirks for BIOSes that don't follow the spec (we can extend the
acpi_sleep= option for that too for the user's convenience).

> > Moreover, both 1.0b and 2.0c say that facs->length should be at least 64 bytes,
> > so the (facs->length >= 32) check is actually redundant (unless there is a
> > quirk setting this value below 32 for some broken systems I'm not aware of).
> What you said is right. In ACPI 1.0b FACS the length is also 64 Bytes. 
> We should use the facs->version to determine whether 64bit waking vector
> needs to be set.

Well, yes.  It's possible that some buggy BIOSes provide non-zero
facs->xfirmware_waking_vector although they shouldn't.  Still, there may be
broken BIOSes that set both facs->version and facs->xfirmware_waking_vector
although they shouldn't. :-)

In any case, I think we should add quirks for buggy BIOSes rather than slightly
depart from the spec in order to handle them.

Thanks,
Rafael
