From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Fri, 27 Jul 2007 06:17:52 +0000
Message-ID: <20070727061751.GA11895@ucw.cz>
References: <20070716180019.GA5112@google.com> <200707171331.59414.ak@suse.de> <8f95bb250707170808u5afee515y592c0a0ccafa95b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2424 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753740AbXG0GSN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jul 2007 02:18:13 -0400
Content-Disposition: inline
In-Reply-To: <8f95bb250707170808u5afee515y592c0a0ccafa95b2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Durbin <adurbin@google.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

On Tue 2007-07-17 08:08:24, Aaron Durbin wrote:
> On 7/17/07, Andi Kleen <ak@suse.de> wrote:
> >On Monday 16 July 2007 20:00:19 Aaron Durbin wrote:
> >>
> >> Add the ability to reset the machine using the 
> >RESET_REG in ACPI's FADT table.
> >
> >Why? I had such a patch at some point as experiment, 
> >but it never
> >helped actually fix a box.
> 
> I have a box here that it fixes, but I also don't see 
> what it hurts. How much

What machine is it?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
