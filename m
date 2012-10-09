From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Discussion on device's runtime wake capability
Date: Tue, 09 Oct 2012 22:48:58 +0200
Message-ID: <9718124.Sj45DoTPo2@vostro.rjw.lan>
References: <5073C2D0.1080900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:39245 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab2JIUpf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2012 16:45:35 -0400
In-Reply-To: <5073C2D0.1080900@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday 09 of October 2012 14:23:12 Aaron Lu wrote:
> Hi all,
> 
> We are using _PRW as a hint to see if a device supports wakeup, this is
> fine for device which is able to wake the system in a sleep state, but
> not to wake itself when system is at S0.

Why not?

> Moreover, when we are to arm the device runtime wake, I think there is
> no need to power on the power resources referenced in _PRW,

Why do you think so?  How can you be sure that those resources are not needed
to provide wakeup power to the device (or whatever generates the wakeup signal
on its behalf))?

> those power resources should be used to give the device ability to wake
> the system from a sleep state, not to wake itself when system is at S0,
> so powering thoses power resources on for run wake is a waste.

Where did you get this idea from?

> But I may miss something, so it would be very kind of you to point it
> out if things are not like what I've thought, thanks.

Yes, you do.  For example, _PRW gives us the number of the GPE to use for
signalling wakeup, right?

> BTW, _S0W seems to be a good hint whether the device supports run wake
> from ACPI's perspective.

Yes, it is a _hint_.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
