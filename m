From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: Lenovo S10e, charge_full == 0 ?!?
Date: Mon, 01 Jun 2009 08:40:51 +0800
Message-ID: <1243816851.3558.14.camel@localhost.localdomain>
References: <20090531214220.GK27997@hezmatt.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22026 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbZFAAjf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 31 May 2009 20:39:35 -0400
In-Reply-To: <20090531214220.GK27997@hezmatt.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Palmer <mpalmer@hezmatt.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2009-06-01 at 05:42 +0800, Matthew Palmer wrote:
> [Please Cc me; I'm not subscribed to the list]
> 
> Hi,
Will you please check whether the output of "cat /proc/acpi/battery/*/*"
is normal?
Of course you can open a new bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the output of acpidump, "cat /proc/acpi/battery/*/*".
Thanks.

> 
> I've just bought a Lenovo S10e ideapad, and it's going nicely except that
> /sys/class/power_supply/BAT0/charge_full is 0, rather than something
> pleasantly large and reassuring.  This is causing battery monitors to
> produce all sorts of crazy results.  The rest of the battery parameters seem
> OK (nothing abnormally 0 in uevent), including charge_full_design.  I've
> charged and dischaged the battery a couple of times, just to make sure it's
> not some sort of "initialisation" problem.
> 
> I've tried with both 2.6.26-2 (out of Debian Lenny), and also 2.6.29-2 (from
> Debian Sid), and the results are the same.  I'd try a git tree kernel, but
> wihch one?  Linus' tree?  The Linux ACPI tree?  If anyone recognises this
> problem and can point me at a likely candidate for a fix, I'm happy to try
> it out, but randomly firing away at kernel trees, given the likely build
> speed on this little netbook, is likely to be an exercise in frustration.
> 
> Failing that, does anyone have any pointers as to where I could start in
> tracking this down?  It seems like it'll be a fairly straightforward bug --
> the driver's probably just looking in the wrong place for the value, and
> needs a re-education.  I'm completely unfamiliar with ACPI and the kernel
> code relating to ACPI, though, so perhaps it's a lot more complicated than
> that.  Worst case, if all else fails, I'm thinking that a "fix" might be to
> check if charge_full == 0, and if so use charge_full_design.  It's ugly, but
> better than the current (hah!) situation.
> 
> - Matt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

