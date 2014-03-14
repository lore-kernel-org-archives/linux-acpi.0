From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.14-rc: /proc/acpi/battery gone?
Date: Fri, 14 Mar 2014 23:11:43 +0100
Message-ID: <20140314221143.GA26621@amd.pavel.ucw.cz>
References: <20140314211456.GA23213@amd.pavel.ucw.cz>
 <CAKb7Uvi-GfOu3_3BMU_Cu4qYS8PQRWzxVm1XETY7y_TJjGPs_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46494 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbaCNWLp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Mar 2014 18:11:45 -0400
Content-Disposition: inline
In-Reply-To: <CAKb7Uvi-GfOu3_3BMU_Cu4qYS8PQRWzxVm1XETY7y_TJjGPs_A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: rjw@rjwysocki.net, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

On Fri 2014-03-14 17:29:41, Ilia Mirkin wrote:
> On Fri, Mar 14, 2014 at 5:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > It seems /proc/acpi/battery interface is gone, and I don't see any
> > option to reintroduce it... what is going on?
> 
> The interface went away in a semi-recent kernel release (3.13 or
> 3.12), breaking pretty much every battery app. (Admittedly the
> interface was marked as deprecated for quite some time, but that
> didn't stop everyone from using it and not caring about the new
> thing.) I've yet to find a windowmaker dock app that works with the
> current sysfs API :(

Name one application it broke, and we'll get it reverted. It broke my
by-hand journalling, at the very least.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
