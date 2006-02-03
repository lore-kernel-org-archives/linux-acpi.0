From: Pavel Troller <patrol@sinus.cz>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 10:33:35 +0100
Message-ID: <20060203093335.GA4403@tangens.sinus.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EC94C3@hdsmsx401.amr.corp.intel.com> <1138958502.18273.1.camel@localhost.localdomain>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:44763 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S932137AbWBCJdv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 04:33:51 -0500
Content-Disposition: inline
In-Reply-To: <1138958502.18273.1.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-acpi@vger.kernel.org

> On Wed, 2006-02-01 at 20:35 -0500, Brown, Len wrote:
> > Re: bad timing
> > If the BIOS advertises C2 latency > 100usec, then the BIOS
> > and the system do not support C2.
> > If the BIOS advertises C3 latency > 1000usec, then the BIOS
> > and the system do not support C3.
> > This isn't just a suggestion, it is the standard method
> > that the spec provides the BIOS to tell the OS to NOT USE these states.
> 
> Isn't there any other way to tell the operating system that the C2/C3
> states are unusable (e.g. by simply telling they're not there?). This
> looks so obfuscated...

Hi!
  The problem is that the table (RSDT) has a fixed format and the values have
reserved positions. Putting 0 there would mean zero (unmeasureble) latency,
which would be the best case, of course. So to disable the feature, "out of
range" method was selected. Yes, it would be nice to have some "special" value
there, like FFFF, but it is not a common practice.
                         With regards, Pavel Troller

