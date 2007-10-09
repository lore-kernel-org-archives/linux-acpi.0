From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if
	ACPI generic could do it
Date: Tue, 9 Oct 2007 08:14:45 -0300
Message-ID: <20071009111445.GB24946@khazad-dum.debian.net>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br> <1191849179-24087-4-git-send-email-hmh@hmh.eng.br> <1191910875.9847.79.camel@queen.suse.de> <20071009075914.GA790@srcf.ucam.org> <1191918351.9847.132.camel@queen.suse.de> <20071009083336.GA1099@srcf.ucam.org> <1191923208.9847.169.camel@queen.suse.de> <20071009100418.GA2472@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54851 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752520AbXJILOx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2007 07:14:53 -0400
Content-Disposition: inline
In-Reply-To: <20071009100418.GA2472@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 09 Oct 2007, Matthew Garrett wrote:
> On Tue, Oct 09, 2007 at 11:46:48AM +0200, Thomas Renninger wrote:
> 
> > More important: CONFIG_THINKPAD_ACPI_BACKLIGHT_DESIRED variable is error
> > prone and should not get introduced, right?

Error prone how?  Please expand, because right now I am not inclined to
remove that variable.  It is optional, and disabled by default.  Distros are
not going to enable it unless they have a damn good reason to, and it is not
even something that one can enable at runtime.

Should I make the help text stronger against enabling the option? Is it not
clear enough?

If you look at the patch, you will notice that the backlight changes are
small, and the biggest part of them affects __init code, which I make
exactly *zero* effort to optimize for size: it is basically "free" for the
scenarios I have to bother with (thinkpads).

> backlight functionality if it can be controlled through the standard 
> mechanism instead.

Well, it is a simple matter of removing the Kconfig option and making that
code non-optional.  But I am not adding a remove-video-support Kconfig
option at this time.  It will wait until I break the driver down into
multiple modules.

I still want a stronger reason to remove the backlight functionality
possibility on newer thinkpads, though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
