From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [0/12] acpi: make ACPI use driver model
Date: Fri, 24 Nov 2006 12:33:49 -0200
Message-ID: <20061124143349.GC2287@khazad-dum.debian.net>
References: <1158916460.11985.45.camel@localhost.localdomain> <200611222307.26536.len.brown@intel.com> <1164257655.5461.96.camel@localhost.localdomain> <200611232338.06895.len.brown@intel.com> <1164348080.5768.32.camel@localhost.localdomain> <20061124110701.GA2287@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:21470 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S934623AbWKXOdx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 09:33:53 -0500
Content-Disposition: inline
In-Reply-To: <20061124110701.GA2287@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Fri, 24 Nov 2006, Henrique de Moraes Holschuh wrote:
> On Fri, 24 Nov 2006, Zhang Rui wrote:
> > The problem is the driver name "ibm/hotkey".
> > '/' and "\0" can not exist in an kobject->name.
> > In driver/acpi/ibm_acpi.c line 1828, please replace the '/' with '-' or
> > any other character and try again :)
> 
> ACK.  Patch to fix this throughout ibm-acpi being written right now.

I spoke too soon, line 1828 must *NOT* be changed or it will change
userspace ABI, instantly breaking every ibm-acpi acpid hotkey scripts out
there.

The ibm-acpi hotkey events are named "ibm/hotkey" (to follow the convention
"button/power", etc. I suppose).  Changing line 1828 changes them to
something else.

Are you sure what you need isn't to change line 1857, which deals with
acpi_bus_register_driver?

I will reply with a patch.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
