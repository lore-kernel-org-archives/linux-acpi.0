From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 12/20] ACPI: thinkpad-acpi: use bitfields for module flags
Date: Sun, 22 Apr 2007 15:56:32 -0300
Message-ID: <20070422185632.GB5424@khazad-dum.debian.net>
References: <11771645253042-git-send-email-hmh@hmh.eng.br> <1177164527570-git-send-email-hmh@hmh.eng.br> <200704212352.51983.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39961 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754386AbXDVS4h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Apr 2007 14:56:37 -0400
Content-Disposition: inline
In-Reply-To: <200704212352.51983.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sat, 21 Apr 2007, Len Brown wrote:
> On Saturday 21 April 2007 10:08, Henrique de Moraes Holschuh wrote:
> > Use a bitfield to hold boolean module-wide flags, to conserve some memory.
> > It is easy and it is clean, so we do it just for the heck of it even if it
> > saves very little space.
> 
> I think that is an under-statement.
> This plus the patch before it actually increase text size
> for a static size change of 0.
> 
> -Len
> 
> before:
>    text    data     bss     dec     hex filename
>   24002    3286     728   28016    6d70 drivers/misc/thinkpad_acpi.o
> 
> after
>    text    data     bss     dec     hex filename
>   24082    3270     664   28016    6d70 drivers/misc/thinkpad_acpi.o

Well, as module, same Debian gcc 4.1.2 pre-release I used before, and
objdump -w -h on the .ko file:

.bss:  decreases from 0x22c to 0x20c
.data: decreases from 0x7a4 to 0x5b4
.init.data: no change
.text: decreases from 0x3658 to 0x3628
.init.text: increases from 0x174a to 0x1763
.rodata*: no change

Same remark as before: maybe I am mistaken on how these things work when the
linking is done at insmod time.

I really did not even consider checking what happens in a static build, it
is quite possible that size increases with these patches.  One of the other
patches really causes an unamusing size increase due to data structure
alignment that I will address later (it is lower priority and would cause
too much rework on patches I did not submit yet).  It happened when some
arrays were broken up to components and arrays of pointers to them.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
