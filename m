From: Pavel Machek <pavel@suse.cz>
Subject: Re: Patch needed for ASUS EEEPC 701 2.6.27 (perhaps a regession)
Date: Mon, 13 Oct 2008 22:36:49 +0200
Message-ID: <20081013203648.GA3260@ucw.cz>
References: <48F0BD2D.8000001@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58834 "EHLO UNKNOWN"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755036AbYJMUjh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 16:39:37 -0400
Content-Disposition: inline
In-Reply-To: <48F0BD2D.8000001@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Robert Goldner <robert@au-79.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, linux-stable@vger.kernel.org

On Sat 2008-10-11 15:50:21, Alan Jenkins wrote:
> Robert Goldner wrote:
> 
> > Hi,
> >
> > I am a happy user of an asus eeepc 701 with an self-made kernel 2.6.27.
> > Its working quite good, but there is one patch needed to avoid problems
> > related to ACPI and Hotkeys.
> > After using a few hotkeys there comes a message in syslog like:
> > ACPI: EC: GPE storm detected, disabling EC GPE
> > and no hotkey event is recognized any more. This is quite bad on a nettop.
> 
> Hi, I reported the original bug.  It is a regression, though the issue
> has been present for a few kernel versions now.
> 
> I recommend that you avoid reproducing the problem.  I now have to add
> "noapic" to the boot options on my EeePC, otherwise it randomly hangs /
> reboots when I press hotkeys - I think it  damaged the hardware.

I guess your hw went bad for some other reason. Restore original
system and if it is still broken, RMA?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
