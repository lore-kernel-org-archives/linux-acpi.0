From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2] Change ACPI IPMI support to "default y"
Date: Thu, 13 Mar 2014 08:22:04 +0100
Message-ID: <20140313072204.GA7181@amd.pavel.ucw.cz>
References: <1392740909-2079-1-git-send-email-matthew.garrett@nebula.com>
 <1511662.Ly2fOjCGKz@vostro.rjw.lan>
 <1392765307.3488.1.camel@x230.lan>
 <20140312230007.GA1817@amd.pavel.ucw.cz>
 <1394666568.25122.1.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53017 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbaCMHWG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Mar 2014 03:22:06 -0400
Content-Disposition: inline
In-Reply-To: <1394666568.25122.1.camel@x230>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed 2014-03-12 23:22:49, Matthew Garrett wrote:
> On Thu, 2014-03-13 at 00:00 +0100, Pavel Machek wrote:
> > On Tue 2014-02-18 23:15:08, Matthew Garrett wrote:
> > > For example, if you load the ACPI power meter driver before you've
> > > installed the ACPI IPMI driver you'll typically get failures (most
> > > vendors implement it via IPMI).
> > 
> > Would the right solution be to implement dependency between power
> > meter and IMPI?
> 
> No. The power meter driver knows nothing about IPMI. It makes no IPMI
> calls. There's no requirement that a vendor implement it via IPMI.

Yet you claim that IMPI is needed for that, and that's why you made
IMPI default.

So ... do we need dmi-based blacklist?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
