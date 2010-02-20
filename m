From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI thermal: Check for thermal zone requiremen
Date: Sat, 20 Feb 2010 10:50:27 +0100
Message-ID: <201002201050.28035.trenn@suse.de>
References: <1266357351-20224-1-git-send-email-trenn@suse.de> <201002191737.49957.trenn@suse.de> <alpine.LFD.2.00.1002192353591.4030@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48133 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755305Ab0BTJtg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Feb 2010 04:49:36 -0500
In-Reply-To: <alpine.LFD.2.00.1002192353591.4030@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Saturday 20 February 2010 05:57:30 am Len Brown wrote:
> On Fri, 19 Feb 2010, Thomas Renninger wrote:

> i agree with the 1st patch,
> as I said, if it built cleanly (hint hint) I'd apply it.
Coming soon.

> > Now you need at least one.
> >
> > My patch sticks to the spec and only discards the thermal zone if there
> > is no trip point at all. In this case you want to throw a (firmware bug)
> > message as something is obviously wrong.
>
> This is the non-obvious part.
> Yes, a thermal zone that has no trip point doesn't follow the spec.
> I don't know if any exist or not, but I don't see any harm if they do.
> I think it would be dandy for linuxfirmware test kit to look
> for this BIOS issue, but I don't see how the user is helped
> if the kernel looks for it.  All the get is an additional
> kernel message and perhaps the loss of the ability to
> tell the temperature when perhaps they could before.
> That doesn't sound like a step forward.

Thinking about this again:
I fully agree.
Just ignore the 2nd patch.

Thanks,

       Thomas
