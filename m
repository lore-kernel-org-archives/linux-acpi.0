From: Pavel Machek <pavel@ucw.cz>
Subject: 4.1-rc7, thinkpad X60: platform mode hibernation does very wrong
 thing
Date: Wed, 17 Jun 2015 14:13:52 +0200
Message-ID: <20150617121352.GA20553@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi!

On thinkpad X60, if I hibernate in platform mode, it does not power
down, but I get black screen, moon icon blinking, and CPU fan running
(CPU probably too).

I can hold the power button down to force powerdown... if I notice
what is going on before the battery is empty.

Any ideas what could be wrong there?

platform mode hibernation works ok on thinkpad T40p, and shutdown mode
hibernation works ok on thinkpad X60 with the same kernel.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
