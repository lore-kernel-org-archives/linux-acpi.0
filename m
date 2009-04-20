From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/8] x86: oqo: depends on INPUT_POLLDEV
Date: Mon, 20 Apr 2009 00:27:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904200026490.10996@localhost.localdomain>
References: <200903041955.n24JtOKb027987@imap1.linux-foundation.org>
 <200904131916.40428.dmitry.torokhov@gmail.com> <49E4C700.6010309@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:42452 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZDTE1q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Apr 2009 00:27:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KID00GKATQ8FJXN@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 19 Apr 2009 23:27:45 -0500 (CDT)
In-reply-to: <49E4C700.6010309@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, hpa@zytor.com, mingo@elte.hu, mjg59@srcf.ucam.org, tglx@linutronix.de

> >>
> >>  drivers/platform/x86/Kconfig |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff -puN drivers/platform/x86/Kconfig~x86-oqo-depends-on-input_polldev
> >> drivers/platform/x86/Kconfig ---
> >> a/drivers/platform/x86/Kconfig~x86-oqo-depends-on-input_polldev +++
> >> a/drivers/platform/x86/Kconfig
> >> @@ -137,7 +137,7 @@ config MSI_LAPTOP
> >>  config OQO_WMI
> >>         tristate "OQO WMI extras"
> >>         depends on ACPI_WMI
> >> -       depends on INPUT
> >> +       depends on INPUT && INPUT_POLLDEV
> > 
> > Make it "select INPUT_POLLDEV". Input-polldev is just a library code, users
> > should not have to select it for some drivers to become available.
> 
> 
> Did the OQO_WMI stuff go away?  I can't seem to find it anywhere.

yeah, i droppped it from my test tree while distracted with the 2.6.30
merge.  it is back now.

-Len Brown, Intel Open Source Technology Center

