From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/9] Check whether ACPI graphics device is physically present
Date: Mon, 14 Jul 2008 18:51:03 +0200
Message-ID: <200807141851.06003.trenn@suse.de>
References: <1215700265-24908-1-git-send-email-trenn@suse.de> <200807102106.27944.trenn@suse.de> <20080711090652.GC24714@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40526 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbYGNQvL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 12:51:11 -0400
In-Reply-To: <20080711090652.GC24714@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: andi@firstfloor.org, rui.zhang@intel.com, jwoithe@physics.adelaide.edu.au, malattia@linux.it, corentincj@iksaif.net, mzxreary@0pointer.de, hmh@hmh.eng.br, carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org

On Friday 11 July 2008 11:06:52 Matthew Garrett wrote:
> On Thu, Jul 10, 2008 at 09:06:24PM +0200, Thomas Renninger wrote:
> > This one is needed also.
> > Matthew made me a bit nervous about it,but to detect video capabilities
> > it is necessary to know whether the ACPI graphics device is really there.
> > The IGD problems should be solved now and this can be added, right? IMO
> > it could have been added before also because the other patches took care
> > about the reported regression.
>
> The patch is good, but the comment still indicates that you want to
> force control over to thinkpad_acpi. We're not going to do that, so
> either resend it without that inference or I can resend it when I get
> back home next week.

Yep, sorry for the long delay, something else seem to not work anymore since 
my last changes.

I will repost soon.

      Thomas
