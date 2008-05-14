From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi
	list to force rsdt
Date: Tue, 13 May 2008 22:55:16 -0300
Message-ID: <20080514015516.GA20663@khazad-dum.debian.net>
References: <1210259416.6710.13.camel@hammer1.suse.de> <1210346444.29724.49.camel@queen.suse.de> <20080510121754.GA18338@khazad-dum.debian.net> <200805132059.22031.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52608 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751815AbYENBzV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2008 21:55:21 -0400
Content-Disposition: inline
In-Reply-To: <200805132059.22031.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>

On Tue, 13 May 2008, Len Brown wrote:
> On Saturday 10 May 2008, Henrique de Moraes Holschuh wrote:
> > On Fri, 09 May 2008, Thomas Renninger wrote:
> > > IMO the whole [XTR][45]* models which came out at that time should be
> > > added also, this should be rather safe to do.
> > 
> > The X4x are rather different beasts. Better check.  The T40-2 are the
> > same BIOS, and it was the most updated BIOS in IBM's thinkpad history.
> > Better check that one too.  They might not need (or want) the "fix".
> > 
> > What do you need to compare between the tables? I have them.
> 
> please send me the acpidump for an r40e that need to use
> the RSDT instead of an XSDT.

It looks like I spoke too soon.  I have the DSDT only, most of them
already piped through the disassembler :(   These came from the old
ibm-acpi maintainer, and also from acpi.sf.net.  Neither Borislav nor
acpi.sf.net saw the value of storing the full set of ACPI data
structures.

I know better, but I have the full acpidump+dmidecode for just a few
thinkpads, and I have not organized it properly in one place, yet :(
I am sure the r40e and r50e were not on the set, though.

Well, since ltp is already CC'ed, they can help us get the data we need.
I will send a more attention-catching request as a reply to this.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
