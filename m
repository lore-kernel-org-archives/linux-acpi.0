From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Wed, 20 Feb 2008 15:23:40 -0300
Message-ID: <20080220182339.GC17648@khazad-dum.debian.net>
References: <1203471860.3358.177.camel@linux-2bdv.site> <20080220173248.GA22709@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42577 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752094AbYBTSXt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 13:23:49 -0500
Content-Disposition: inline
In-Reply-To: <20080220173248.GA22709@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Wed, 20 Feb 2008, Matthew Garrett wrote:
> Let's look at this differently. Most hardware is produced by vendors who 
> don't care about Linux. We need to make that hardware work anyway. The 
> only way we can achieve that is to be bug-compatible with Windows. 
> Therefore, any way in which Linux behaviour varies from Windows 
> behaviour is a bug. The only reason to export any indication that the 
> kernel is Linux is because our behaviour is not identical to Windows. 
> But, given that that's a bug, the solution should be to fix Linux and 
> not to encourage vendors to put workarounds in their firmware.

That punishes vendors which actually care about Linux.  These are quite
rare in the laptop and desktop market, but they do exist.

And such vendors are quite *common* in the enterprise hardware market which
doesn't run Windows.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
