From: Len Brown <lenb@kernel.org>
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Date: Thu, 7 Feb 2008 02:01:35 -0500
Message-ID: <200802070201.36016.lenb@kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <20080205135725.GO20687@jupiter.solarsys.private> <20080205145550.GA24128@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58199 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929AbYBGHDZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 02:03:25 -0500
In-Reply-To: <20080205145550.GA24128@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, "Thomas, Sujith" <sujith.thomas@intel.com>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

On Tuesday 05 February 2008 09:55, Henrique de Moraes Holschuh wrote:

> > > The only duplication which I can see of is in the "reporting of
> > > temperature", which is quite reasonable for a thermal management module
> > > to have.
> > 
> > Well, HdMH and I apparently disagree about this.  All I really care
> > about is that the temp info should be available through /sys/class/hwmon.
> > Many people just want to check their temps, without diving into the fine
> > details of a "thermal management solution".
> 
> Well, I strongly care for not having to duplicate the entire sysfs code of
> the thinkpad-acpi thermal management subdrivers (fan control, thermal
> readings) to a new interface AND maybe even finding myself in need to add a
> *third* platform device and driver to thinkpad-acpi just because the new
> interface didn't even try to be as compatible with hwmon as possible :-(

I expect that Thinpads will continue to be optimized primarily for
Windows via ACPI.  I don't expect thinkpads to suddenly switch over
to OSPM user-space thermal control -- because Windows doesn't do that.
So I don't think any bad things will happen if thinkpad-acpi
doesn't respond to this.

I do agree that we should make the I/F the same, where possible,
(that was my original proposal)
I'm delighted to hear that the hwmon community is open minded
about expanding the capabilities of hwmon.  We should definately
look into that.  While Menlo will likely start shipping with
the current solution, there is no reason we can't evolve it over time --
for we know the guys writing the software that will use this I/F...

thanks,
-Len

