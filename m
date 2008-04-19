From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI : RSDT is forced to be used when 32/64X address
	mismatch in FADT
Date: Sat, 19 Apr 2008 01:24:54 -0300
Message-ID: <20080419042454.GC11635@khazad-dum.debian.net>
References: <1208515293.4072.3.camel@yakui_zhao.sh.intel.com> <1208518162.1784.418.camel@queen.suse.de> <1208525704.1784.435.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50242 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447AbYDSEY4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Apr 2008 00:24:56 -0400
Content-Disposition: inline
In-Reply-To: <1208525704.1784.435.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Fri, 18 Apr 2008, Thomas Renninger wrote:
> I'd take DMI_MATCH(DMI_BIOS_VERSION,"1SET") to match for all.

Agreed, if 1SET70 has a bug, all other versions of that BIOS before 70
probably have that bug too.

> These machines might be very similar (ThinkPad R40e is probably wrong as
> not the name, but the BIOS version which could be the same than for e.g.
> R50 is hit). I expect that C states are going to work if you take the

-EPARSE.  The 1S BIOS *is* the R40e BIOS, and don't understand what you
mean with the R50?  The BIOS for the R50, T40, T41 and T42 as well as
some R51 models is the same (BIOS 1R).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
