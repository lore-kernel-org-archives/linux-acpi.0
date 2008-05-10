From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi
	list to force rsdt
Date: Sat, 10 May 2008 09:17:54 -0300
Message-ID: <20080510121754.GA18338@khazad-dum.debian.net>
References: <1210259416.6710.13.camel@hammer1.suse.de> <1210346444.29724.49.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43454 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756154AbYEJMR6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 May 2008 08:17:58 -0400
Content-Disposition: inline
In-Reply-To: <1210346444.29724.49.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>

On Fri, 09 May 2008, Thomas Renninger wrote:
> IMO the whole [XTR][45]* models which came out at that time should be
> added also, this should be rather safe to do.

The X4x are rather different beasts. Better check.  The T40-2 are the
same BIOS, and it was the most updated BIOS in IBM's thinkpad history.
Better check that one too.  They might not need (or want) the "fix".

What do you need to compare between the tables? I have them.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
