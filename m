From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI : RSDT is forced to be used when 32/64X address
	mismatch in FADT
Date: Mon, 21 Apr 2008 12:07:53 +0200
Message-ID: <1208772473.1784.482.camel@queen.suse.de>
References: <1208515293.4072.3.camel@yakui_zhao.sh.intel.com>
	 <1208518162.1784.418.camel@queen.suse.de>
	 <1208525704.1784.435.camel@queen.suse.de>
	 <20080419042454.GC11635@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:48704 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823AbYDUKHz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Apr 2008 06:07:55 -0400
In-Reply-To: <20080419042454.GC11635@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Sat, 2008-04-19 at 01:24 -0300, Henrique de Moraes Holschuh wrote:
> On Fri, 18 Apr 2008, Thomas Renninger wrote:
> > I'd take DMI_MATCH(DMI_BIOS_VERSION,"1SET") to match for all.
> 
> Agreed, if 1SET70 has a bug, all other versions of that BIOS before 70
> probably have that bug too.
> 
> > These machines might be very similar (ThinkPad R40e is probably wrong as
> > not the name, but the BIOS version which could be the same than for e.g.
> > R50 is hit). I expect that C states are going to work if you take the
> 
> -EPARSE.  The 1S BIOS *is* the R40e BIOS, and don't understand what you
> mean with the R50?  The BIOS for the R50, T40, T41 and T42 as well as
> some R51 models is the same (BIOS 1R).

Sorry, I should have been more detailed...

  - IIRC the physical HW address to switch to C2/C3 is provided through
    the FADT table.
  - For "1SET*" ThinkPad BIOSes, C-states are blacklisted as they freeze
    if C-states are invoked (see drivers/acpi/processor_idle.c).
  - This patch chooses an alternate FADT table if the content of the
    other table differs (either the one pointed to by XSDT or RSDT).
  - The machine which shows different contents of FADTs is a R50e:
    http://bugzilla.kernel.org/show_bug.cgi?id=8246
  - While the bug was opened because of slow booting (due to wrong HW
    addresses accessed?), I could imagine Yakui has found the root cause
    why C-states didn't work on some older ThinkPads.

-> It should be tested whether ThinkPads which have C-states blacklisted
do work with the other FADT and the blacklist in
drivers/acpi/processor_idle.c can be removed or what I meant, it can be
moved/reused for a kind of force_rsdt flag...

All this is theory and needs testing...
I can try to find one of the older ThinkPad models...

   Thomas


