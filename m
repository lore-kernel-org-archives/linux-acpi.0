From: Kamil Iskra <kamil@iskra.name>
Subject: Re: Patch to correct battery capacity values on Thinkpads (repost)
Date: Wed, 14 Nov 2012 10:54:34 -0600
Message-ID: <20121114165434.GA31375@scooby.iskra.name>
References: <20121112050935.GA25110@scooby.iskra.name>
 <20121114074113.GA32091@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scooby.iskra.name ([184.171.245.232]:41321 "EHLO
	mail.iskra.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422826Ab2KNQyg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2012 11:54:36 -0500
Content-Disposition: inline
In-Reply-To: <20121114074113.GA32091@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Wed, Nov 14, 2012 at 07:41:13 +0000, Matthew Garrett wrote:

> On Sun, Nov 11, 2012 at 11:09:35PM -0600, Kamil Iskra wrote:
> > My guess is that this problem has been around ever since those machines
> > have been released, but because the most common Thinkpad batteries are
> > rated at 10.8V, the error (8%) is small enough that it simply hasn't been
> > noticed or at least nobody could be bothered to look into it.
> Yeah, the DSDT simply multiples the values by 10 when it's in this 
> state. But the issue is purely cosmetic, right? I can't see any reason 
> anything would be using the design voltage in calculations.

Well, when the capacity unit is mAh, the correct way of translating it to
mWh is to multiply by the design voltage, AFAIK, and not the current
voltage (which seems to fluctuate a lot and is often higher than the design
voltage for whatever weird reason).  That's what upower does, for example.

I validated that with the Thinkpad-specific tp_smapi out-of-tree driver,
e.g., right now on my x201 (with my patch; values without the patch are in
parentheses):

/proc/acpi/battery/BAT0/info:
design capacity:         5200 mAh (5616 mAh)
design voltage:          10800 mV
/proc/acpi/battery/BAT0/state:
remaining capacity:      3418 mAh (3691 mAh)
present voltage:         12249 mV

/sys/devices/platform/smapi/BAT0 (capacities are always in mWh here):
design_capacity:         56160
design_voltage:          10800
remaining_capacity:      36920
voltage:                 12249

Few tools need to do the translation from mAh to mWh, though -- remaining
battery capacity monitors on the desktop just display percentages, so they
don't need to care about the units so long as capacity_now/design_capacity
is sane (which it is, with or without the patch).  One tool that certainly
does care though is PowerTOP, although, curiously, it seems to use current
voltage for calculations, resulting in incorrect values (with or without
the patch -- worse without).

Kamil

-- 
Kamil Iskra  kamil@iskra.name
