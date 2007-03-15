From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 16:33:17 -0300
Message-ID: <20070315193317.GC14394@khazad-dum.debian.net>
References: <11736588493609-git-send-email-hmh@hmh.eng.br> <20070315031015.GA6292@khazad-dum.debian.net> <20070315031251.GB6292@khazad-dum.debian.net> <200703150206.05811.lenb@kernel.org> <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315112219.3b9dca54.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36613 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932848AbXCOTdV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 15:33:21 -0400
Content-Disposition: inline
In-Reply-To: <20070315112219.3b9dca54.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Thu, 15 Mar 2007, Kristen Carlson Accardi wrote:
> On Thu, 15 Mar 2007 14:55:06 -0300
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> 
> > Please look at the patch I just sent.  It allows ibm-acpi to load if
> > ACPI_BAY is loaded.  It will, of course, cause ACPI_BAY to refuse to load if
> > ibm-acpi is already loaded, but that's probably fine as ACPI_BAY has just a
> > single function.
> 
> The patch you sent seems fine - however, the bay driver will need a patch
> to correctly refuse to load when ibm_acpi is loaded and handling the bay.
> I'm testing this out now - will check it with your patch.

Will it? On 2.6.20 (I backported it) it bangs out with an error and refuses
to load just fine...  The only reason that's not quite acceptable in
ibm-acpi is because ibm-acpi can do a lot more than just handle bay
devices.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
