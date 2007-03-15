From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 14:55:06 -0300
Message-ID: <20070315175505.GB6596@khazad-dum.debian.net>
References: <11736588493609-git-send-email-hmh@hmh.eng.br> <20070315031015.GA6292@khazad-dum.debian.net> <20070315031251.GB6292@khazad-dum.debian.net> <200703150206.05811.lenb@kernel.org> <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39935 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750773AbXCORzL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 13:55:11 -0400
Content-Disposition: inline
In-Reply-To: <20070315080644.c73db24a.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Thu, 15 Mar 2007, Kristen Carlson Accardi wrote:
> Doesn't this option enable support for controlling the bay device via ibm_acpi?

Yes, but the problem is that ACPI_BAY is not nearly good enough in
ThinkPads... yet.

> If so - if you compile this one, then the user who chooses to use bay.ko instead
> to control the bay can not use ibm_acpi at all to control the remaining
> functionality.  I feel this should be dependent on ACPI_BAY=n.

Please look at the patch I just sent.  It allows ibm-acpi to load if
ACPI_BAY is loaded.  It will, of course, cause ACPI_BAY to refuse to load if
ibm-acpi is already loaded, but that's probably fine as ACPI_BAY has just a
single function.

Note that these are all just stop-gap measures.  We either need to have
ACPI_BAY do everything needed in ThinkPads (like handling bay batteries), or
to make both drivers work together, or I'll just pull all the ACPI_BAY
functionality into ibm-acpi (and then I will definately conflict with
ACPI_BAY).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
