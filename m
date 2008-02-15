From: Len Brown <lenb@kernel.org>
Subject: Re: DMI Information - Dell Precision M4300
Date: Fri, 15 Feb 2008 00:40:56 -0500
Message-ID: <200802150040.57006.lenb@kernel.org>
References: <20080212235359.N50592@public.nfld.com> <200802132235.59396.lenb@kernel.org> <20080214015401.W86410@public.nfld.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60922 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbYBOFmb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 00:42:31 -0500
In-Reply-To: <20080214015401.W86410@public.nfld.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gerard Hynes <ghynes@nfld.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 14 February 2008 00:34, Gerard Hynes wrote:
> on Wed, 13 Feb 2008, Len Brown wrote:
> 
> Thank you for the detailed analysis.  Interestingly enough - this M4300 is
> sitting in a Dell docking station right now.  :-)
> 
> Perhaps on the weekend - I can put it thru some docking/un-docking cycles
> and note the behaviour if anything wierd happens - I'll definately forward any
> obvious/repeatable interactions to you.
> 
> In the meantime ... this machine is one smoking Linux box, (wicked fast) and
> everything is working extremely well (knock on wood).

Dell will be glad to hear that!

I'm pleased to notice that the "Tech Specs" for the Dell Precision M4300 & M6300
mention Linux.  (though it isn't immediately obvious how to order one w/o Windows)

Dell tells me off-list that they put the _OSI(Linux) hook into the M4300 BIOS
starting at version A05 specifically to handle Linux console-mode video restore
by invoking the video BIOS.

(what BIOS version do you have? -- unfortunately I neglected do dump that
 in the DMI printout...)

So, assuming that BIOS is shipping and you have that one or later,
then if you boot to console mode (eg init 3) w/o acpi_osi=Linux and suspend/resume
you may get no backlight restore and your screen will be black.
Boot with acpi_osi=Linux and the screen should restore properly.

Of course, you might not really care about restoring the LCD
if you never suspend in text mode...

It looks like the M4300/M6300 use nvidia graphics.
If that is the case, you'll need the nvidia kernel or X driver to restore video
after resume if the video BIOS hook above is not invoked.

If the SKU has Intel graphics, then 2.6.25's i915 driver can restore video,
even in console mode without running the BIOS.

thanks,
-Len
