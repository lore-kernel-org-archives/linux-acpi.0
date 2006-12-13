From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
	again after booting windows
Date: Wed, 13 Dec 2006 12:25:07 +0000
Message-ID: <1166012707.22903.4.camel@pcjc2lap>
References: <457F37C0.3090003@gmail.com>
	 <1165966936.29844.37.camel@pcjc2lap>  <457FB1A1.2030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:46526 "EHLO
	ppsw-3.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964914AbWLMMZP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Dec 2006 07:25:15 -0500
In-Reply-To: <457FB1A1.2030602@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Lincoln Baxter, III" <lincolnbaxter@gmail.com>

On Wed, 2006-12-13 at 02:54 -0500, Lincoln Baxter, III wrote:
> Wow. You're completely right... so this isn't an ACPI issue (directly.)
> 
> I don't seem to experience any of the other problems you describe, but I 
> do have a different model. I don't have an external lid-switch sensor. 
> Hm.. Suspend doesn't quite work for me either, I'll look into this 
> farther and get back to you.
> 
> The battery meters and other ACPI functionality is working now with your 
> workaround. Should this be a bug report? Which group should get the 
> report if this is the case?
> 
> Thanks so much!
> Lincoln

It was suggested to me to open a kernel bug (possibly starting under
ACPI), however I never got to it.. I don't know where kernel bugs are
reported officially, and was busy at the time. (still am). I do try and
reply to others with the same problems though... finding the webpage
which suggested that fix was not trivial!

My lid switch is just above the keyboard, on the right hand side of the
left hand screen hinge. It is just a tiny piece of plastic protruding
from the case. Push it, and the screen goes off. Hold it, and wiggle the
mouse (touchpad), and the naughty screen comes back on.

Most importantly for me, the workaround brings the max CPU speed
available with speed step back to what it is supposed to be on my
laptop, and the BIOS actually boots much faster.

Peter C.


