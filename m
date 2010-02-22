From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: Be more liberal in validating _BQC
	behaviour
Date: Mon, 22 Feb 2010 02:06:47 +0000
Message-ID: <20100222020647.GA30278@srcf.ucam.org>
References: <1266357230-10602-1-git-send-email-mjg@redhat.com> <alpine.LFD.2.00.1002190140230.24628@localhost.localdomain> <20100219135431.GA29434@srcf.ucam.org> <1266803479.2608.1484.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56776 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab0BVCG6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Feb 2010 21:06:58 -0500
Content-Disposition: inline
In-Reply-To: <1266803479.2608.1484.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Feb 22, 2010 at 09:51:19AM +0800, Zhang Rui wrote:
> On Fri, 2010-02-19 at 21:54 +0800, Matthew Garrett wrote:
> > My system statically initialises the variable containing the current 
> > brightness to 100, but doesn't include 100 in the list of valid 
> > brightnesses.
> 
> sorry, I don't understand.
> does the video driver set the backlight to 100, which is not a valid
> value in the _BCL package?

No, the firmware does.

> >  Right now this causes us to stop believing _BQC. However, 
> > the enxt thing we do is set the brightness to maximum anyway - at this 
> > point _BQC will now return a correct value.
> 
> hmmm, could you attach the acpidump please?

The relevant bits are:

                    Name (BRIG, 0x64)
                    Method (_BQC, 0, Serialized)
                    {
                        Store (BRIG, Local0)
                        Return (Local0)
                    }
                    Method (_BCM, 1, Serialized)
                    {
			...
                        Store (Arg0, BRIG)

0x64 is an invalid value as far as _BCL goes. So, _BQC will give an 
invalid response until we set a value - after that, it'll be correct.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
