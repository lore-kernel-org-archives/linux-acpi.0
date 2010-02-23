From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI video: Be more liberal in validating _BQC
	behaviour
Date: Tue, 23 Feb 2010 14:29:46 +0800
Message-ID: <1266906586.2608.2876.camel@rzhang1-desktop>
References: <1266357230-10602-1-git-send-email-mjg@redhat.com>
	 <alpine.LFD.2.00.1002190140230.24628@localhost.localdomain>
	 <20100219135431.GA29434@srcf.ucam.org>
	 <1266803479.2608.1484.camel@rzhang1-desktop>
	 <20100222020647.GA30278@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32784 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab0BWGaW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Feb 2010 01:30:22 -0500
In-Reply-To: <20100222020647.GA30278@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2010-02-22 at 10:06 +0800, Matthew Garrett wrote:
> On Mon, Feb 22, 2010 at 09:51:19AM +0800, Zhang Rui wrote:
> > On Fri, 2010-02-19 at 21:54 +0800, Matthew Garrett wrote:
> > > My system statically initialises the variable containing the current 
> > > brightness to 100, but doesn't include 100 in the list of valid 
> > > brightnesses.
> > 
> > sorry, I don't understand.
> > does the video driver set the backlight to 100, which is not a valid
> > value in the _BCL package?
> 
> No, the firmware does.
> 
> > >  Right now this causes us to stop believing _BQC. However, 
> > > the enxt thing we do is set the brightness to maximum anyway - at this 
> > > point _BQC will now return a correct value.
> > 
> > hmmm, could you attach the acpidump please?
> 
> The relevant bits are:
> 
>                     Name (BRIG, 0x64)
>                     Method (_BQC, 0, Serialized)
>                     {
>                         Store (BRIG, Local0)
>                         Return (Local0)
>                     }
>                     Method (_BCM, 1, Serialized)
>                     {
> 			...
>                         Store (Arg0, BRIG)
> 
> 0x64 is an invalid value as far as _BCL goes. So, _BQC will give an 
> invalid response until we set a value - after that, it'll be correct.
> 
hmmm, then this seems reasonable.
Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui


