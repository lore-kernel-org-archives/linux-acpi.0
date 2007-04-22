From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 09/20] ACPI: thinkpad-acpi: uncouple subdriver init from ibms struct
Date: Sun, 22 Apr 2007 15:45:10 -0300
Message-ID: <20070422184510.GA5424@khazad-dum.debian.net>
References: <11771645253042-git-send-email-hmh@hmh.eng.br> <11771645271352-git-send-email-hmh@hmh.eng.br> <200704212340.51550.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58011 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754248AbXDVSpQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Apr 2007 14:45:16 -0400
Content-Disposition: inline
In-Reply-To: <200704212340.51550.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sat, 21 Apr 2007, Len Brown wrote:
> On Saturday 21 April 2007 10:08, Henrique de Moraes Holschuh wrote:
> > From: Henrique de Moraes Holschuh <hmh@debian.org>
> > 
> > Move the .init method from ibms struct to another struct, and use a list
> > head to control which subdrivers have been activated.
> > 
> > This allows us to have the subdriver init methods marked __init, saving
> > quite a lot of .text size, and even a bit of .data size as some data can
> > now be made __initdata.
> 
> does this save any space when the driver is compiled as a module?

Using gcc 4.1.2 20061115 pre-release (from Debian 4.1.1-21) and objdump -w
-h, I get the following changes:

bss: no change
text: decreases from 0x46d8 to 0x3658
data: decreases from 0x7b4 to 0x784
init.text: increases from 0x5ff to 0x171f
init.data: increases from 0 to 0x2b6

and now the usual issues with gcc and its .rodata handling even while inside
__init and __initdata:

rodata*: total increase of 0xbc bytes.

So yes, there are savings when used as a module, unless objdump is lying to
me or I failed to understand how these things play together when the kernel
links the module at runmtime.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
