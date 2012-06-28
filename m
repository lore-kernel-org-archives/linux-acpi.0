From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Date: Thu, 28 Jun 2012 14:40:35 +0200
Message-ID: <20120628144035.36ac75a0@endymion.delvare>
References: <4FEA4C10.2060904@googlemail.com>
	<20120627171505.GB12712@roeck-us.net>
	<4FEB90A8.8050901@googlemail.com>
	<20120628014548.GA15994@srcf.ucam.org>
	<4FEC3CDF.7050901@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:4700 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab2F1Mkq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 08:40:46 -0400
In-Reply-To: <4FEC3CDF.7050901@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Zintakis <michael.zintakis@googlemail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org

On Thu, 28 Jun 2012 12:15:43 +0100, Michael Zintakis wrote:
> > That's the *good* outcome. The bad outcome involves these register 
> > accesses racing in a way that disables fan control or thermal trip 
> > points and risks causing hardware damage. It's not safe for two 
> > different codepaths to access the same hardware without having any kind 
> > of locking, so if your system firmware declares that ACPI is using the 
> > temperature device the hardware sensors framework will refuse to.
>
> All noted, thanks for the explanation - pretty hairy stuff! The tragic 
> thing is, I have no way of telling ACPI to *not* use or "implement" its 
> own fan, voltage, temperature management and let a more capable piece of 
> software (the f71882fg driver in this case) do that job!

This has been my very claim for several years now. My next step is to
find someone involved in the ACPI specification that would be willing
to discuss the problem with me and implement a solution in the next
ACPI specification.

Don't hold your breath though, it will take years before the problem
actually gets solved for the end user - if that ever happens.

-- 
Jean Delvare
