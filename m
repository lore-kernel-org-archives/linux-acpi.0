From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: I have some problems with acpi on my laptops:
Date: Fri, 30 Sep 2011 02:58:25 +0100
Message-ID: <20110930015825.GA6359@srcf.ucam.org>
References: <loom.20110930T000656-380@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54953 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab1I3B63 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2011 21:58:29 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110930T000656-380@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Silvio Caggia <silvio.caggia@tiscali.it>
Cc: linux-acpi@vger.kernel.org

On Thu, Sep 29, 2011 at 10:13:59PM +0000, Silvio Caggia wrote:

> if I run acpitool -s it suspends correctly, but when I press power on all 
> the laptop awakes except video display.
> So the screen is black, if I press caps-lock the led works, if I press 
> ctrl-alt-F1 and then ctrl-C I am still able to (blindly) type reboot...
> It seems that the video adapter is not able to awake.

Sounds like a bug with the radeon driver. Are you using kernel 
modesetting?

> powersave governor with a fixed 222Mhz speed, so slow that the system is 
> not usable.
> the cpu is a Celeron
> note: on the first laptop, a Compaq Evo N800v, driver acpi-cpufreq works 
> fine with ondemand governor, driver p4-clockmod have same problems.
> How to activate a working driver with ondemand governor?

Older Celerons didn't support speedstep. There's no way to use ondemand 
with them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
