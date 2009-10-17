From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 4/4] ACPI: Battery: Add support for _BIX extended info
 method
Date: Sat, 17 Oct 2009 12:41:24 -0300
Message-ID: <20091017154124.GA31182@khazad-dum.debian.net>
References: <20091015103122.3853.34760.stgit@thinkpad>
 <20091015103144.3853.9717.stgit@thinkpad>
 <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49235 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751988AbZJQPlX (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>);
	Sat, 17 Oct 2009 11:41:23 -0400
Content-Disposition: inline
In-Reply-To: <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Fri, 16 Oct 2009, Alan Jenkins wrote:
> So userspace is supposed to realise that "0" means "this attribute is
> not supported", as opposed to "I am a brand new battery and don't
> remember being factory-tested".
> 
> How about returning -1 for batteries without _BIX?

How about NOT registering attributes that don't exist?  That's the proper
way of doing things in sysfs.

When that's not possible, I'd suggest doing the right thing and returning an
error of some sort (ENXIO, ENOTSUP, etc)...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
