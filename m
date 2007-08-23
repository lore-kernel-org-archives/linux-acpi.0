From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: don't send netlink events for those that go into
	input layer
Date: Thu, 23 Aug 2007 18:22:55 -0300
Message-ID: <20070823212255.GB17191@khazad-dum.debian.net>
References: <1187803471.27227.7.camel@acpi-hp.sh.intel.com> <200708231430.16887.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35027 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758578AbXHWVW7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 17:22:59 -0400
Content-Disposition: inline
In-Reply-To: <200708231430.16887.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Hi Len!

On Thu, 23 Aug 2007, Len Brown wrote:

> I like it, Rui.
> 
> I think that upon this patch, we can start to deprecate acpi_bus_generate_event,
> as every user of it is now handled by the input layer or netlink.
> 
> applied.

This calls for (good!) changes in thinkpad-acpi and some issues I had with
exactly the same problem.

Len, to which tree is that change targeted?  I will have to target some
thinkpad-acpi changes that depend on it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
