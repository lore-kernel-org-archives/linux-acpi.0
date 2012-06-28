From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Date: Thu, 28 Jun 2012 02:45:49 +0100
Message-ID: <20120628014548.GA15994@srcf.ucam.org>
References: <4FEA4C10.2060904@googlemail.com>
 <20120627171505.GB12712@roeck-us.net>
 <4FEB90A8.8050901@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44736 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab2F1BqD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jun 2012 21:46:03 -0400
Content-Disposition: inline
In-Reply-To: <4FEB90A8.8050901@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Zintakis <michael.zintakis@googlemail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, Jun 28, 2012 at 12:00:56AM +0100, Michael Zintakis wrote:

> This is precisely what I stumbled upon when reading the
> documentation about the kernel acpi parameters today and tried it
> straight away (though, in all honesty, I didn't have a clue that it
> is actually a bad idea until I read the article above - thanks for
> posting!). Could any of the more knowledgeable on here explain why
> is it such a bad idea please?

Because there's no handshaking between the firmware and the OS driver, 
and accesses to hardware sensors are often indexed. Imagine this 
scenario:

ACPI                             lmsensors
----                             ---------
select temperature register
                                 select fan speed register
read value
                                 read value

ACPi will read the fan speed register instead of the temperature 
register, and the value may be far too high and cause a critical 
shutdown of the system.

That's the *good* outcome. The bad outcome involves these register 
accesses racing in a way that disables fan control or thermal trip 
points and risks causing hardware damage. It's not safe for two 
different codepaths to access the same hardware without having any kind 
of locking, so if your system firmware declares that ACPI is using the 
temperature device the hardware sensors framework will refuse to.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
