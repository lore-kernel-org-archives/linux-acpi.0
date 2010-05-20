From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] [RESUBMIT] Fix mute key on older Lenovo made Thinkpads
 by OSI blacklisting
Date: Thu, 20 May 2010 16:14:39 -0300
Message-ID: <20100520191439.GA7595@khazad-dum.debian.net>
References: <1272770432.15493.49.camel@laptop>
 <alpine.LFD.2.00.1005192325470.2921@localhost.localdomain>
 <1274329374.4479.403.camel@laptop>
 <alpine.LFD.2.00.1005200136220.2921@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34246 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752614Ab0ETTOo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 May 2010 15:14:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005200136220.2921@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jerone Young <jerone.young@canonical.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, 20 May 2010, Len Brown wrote:
> and this _INI-time check is the only effect of LNUX:
> 
>             If (\LNUX)
>             {
>                 \_SB.PCI0.LPC.EC.SAUM (0x02)
>                 \UCMS (0x1C)
>             }
> 
> Of course SAUM pokes the EC and UCMS is an SMI wrapper,
> so we don't really know all they may do; but at least

SAUM tells the EC to change the keyboard/event filter (at the very
least, one would have to ask Lenovo to know for sure).  UCMS (0x1C)
tells the BIOS to change operating mode as well, probably to match
whatever SAUM asked of the EC.

As far as anyone knows, it is indeed restricted to the behaviour of the
audio keys.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
