From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: CF-30 ACPI (Core2Duo)
Date: Tue, 29 Apr 2008 09:00:18 +0800
Message-ID: <1209430818.4121.8.camel@rzhang-crestline.sh.intel.com>
References: <1209406735.3815.35.camel@ripley.weyland-yutani>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36326 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbYD2BDB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Apr 2008 21:03:01 -0400
In-Reply-To: <1209406735.3815.35.camel@ripley.weyland-yutani>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jeremy@emperorlinux.com
Cc: linux-acpi@vger.kernel.org


On Mon, 2008-04-28 at 14:18 -0400, Jeremy Moles wrote:
> We are having some ACPI problems with a second generation Panasonic
> CF-30 laptop, (by that I mean specifically the Core2Duo version, model
> number starts with CF-30F---, and not the mk1 version CoreDuo CF-30C---
> model).
> 
> While the CoreDuo CF-30C--- models are quite fine with ACPI, the mk2
> Core2Duo version will not boot without a custom DSDT, and even then the
> system contains many warnings and has been highly "unstable" (that is:
> random, non-deterministic lockups).
> 
> The BIOS and EC version are both V2.00L11.  Further, there are no BIOS
> options relating to how the SATA subsystem should be treated, as these
> kinds of tweaks to the BIOS often help system stability in our
> experience.
> 
> Seeing as these are newly-introduced as of Mar 2008, there are no BIOS
> upgrades available.  We have contacted Panasonic engineers, but are
> still waiting on a response--though it is unlikely they will be able to
> comment at all. Also, other Panasonic Core2Duo's, like the CF-19F---
> have thus far been fine with ACPI.
> 
> ----------------------------------------------------------------------
> 
> I have uploaded what I believe to be all the pertinent data for anyone
> who is interested in taking a look. The file names should be pretty
> self-explanatory:
> 
> 	http://downloads.emperorlinux.com/research/cf-30
> 
> The "MODE1" boot has the following kernel options:
> 
> 	acpi_osi=Linux noapic nolapic pci=nommconf
> 
> The "MODE2" boot is just a normal boot, without any fancy options. What
> we're really looking for is any advice on why we might be getting some
> of these kernel errors in dmesg. The DSDT I'm using is included in both
> directories (it's the same in both places), but the only change I made
> was:
> 
> 	OperationRegion (IGDM, SystemMemory, \ASLB, 0x2000)
> 
> ...to...
> 
> 	OperationRegion (IGDM, SystemMemory, ASLB, 0x2000)
This is a BIOS bug that we can't fix in kernel.
I guess there must be two variables named ASLB in your DSDT.

Please refer to:
http://bugzilla.kernel.org/show_bug.cgi?id=10119
http://bugzilla.kernel.org/show_bug.cgi?id=9915

thanks,
rui


