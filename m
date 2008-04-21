From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI : RSDT is forced to be used when 32/64X address
	mismatch in FADT
Date: Mon, 21 Apr 2008 11:39:35 -0300
Message-ID: <20080421143935.GA18932@khazad-dum.debian.net>
References: <1208515293.4072.3.camel@yakui_zhao.sh.intel.com> <1208518162.1784.418.camel@queen.suse.de> <1208525704.1784.435.camel@queen.suse.de> <20080419042454.GC11635@khazad-dum.debian.net> <1208772473.1784.482.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60975 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751486AbYDUOji (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Apr 2008 10:39:38 -0400
Content-Disposition: inline
In-Reply-To: <1208772473.1784.482.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org

On Mon, 21 Apr 2008, Thomas Renninger wrote:
>   - IIRC the physical HW address to switch to C2/C3 is provided through
>     the FADT table.
>   - For "1SET*" ThinkPad BIOSes, C-states are blacklisted as they freeze
>     if C-states are invoked (see drivers/acpi/processor_idle.c).
>   - This patch chooses an alternate FADT table if the content of the
>     other table differs (either the one pointed to by XSDT or RSDT).
>   - The machine which shows different contents of FADTs is a R50e:
>     http://bugzilla.kernel.org/show_bug.cgi?id=8246
>   - While the bug was opened because of slow booting (due to wrong HW
>     addresses accessed?), I could imagine Yakui has found the root cause
>     why C-states didn't work on some older ThinkPads.
> 
> -> It should be tested whether ThinkPads which have C-states blacklisted
> do work with the other FADT and the blacklist in
> drivers/acpi/processor_idle.c can be removed or what I meant, it can be
> moved/reused for a kind of force_rsdt flag...
> 
> All this is theory and needs testing...
> I can try to find one of the older ThinkPad models...

This is really interesting, and I am sure that should you provide
patches and instructions that users can easily apply to, say, 2.6.24.y,
in an email to the linux-thinkpad ML describing what benefits should
testing could have, you'll get some good testers.

I've easily gotten a lot of the testing I needed done in the past by
asking for help there.

I have added linux-thinkpad to the CC, but I seriously recommend that
you start a new thread there with a much more clear subject if you
decide to ask for testers.

It'd be good to also have a list of the thinkpad models currently
blacklisted for functions that depend on the FADT, and thus which could
get these functions back if the select-the-proper-FADT patch works on
them.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
