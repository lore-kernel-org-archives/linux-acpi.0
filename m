From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Date: Mon, 4 Apr 2005 00:59:29 +0200
Message-ID: <20050403225929.GE13466@elf.ucw.cz>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz> <20050403224557.GB1015@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261944AbVDCXAC@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050403224557.GB1015@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> it is only suspend2ram which stopped working after 2.6.11-mm4 (at least
> in 2.6.12-rc1-mm3,4).
> 
> Concerning tests with minimal kernel config: I guess since it *was*
> working there should not be a change necessary -- but well, from
> 2.6.11-mm2 to 2.6.11-mm4 I had to stop hotplug/usb to get ot working, so
> maybe now I have to stop all the other things. Grrrr. This is not what I
> want!
> 
> Isn't there a different way?

I'd like to fix the problem, but first I need to know where the
problem is.  If it works with minimal config, I know that it is one of
drivers you deselected.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
