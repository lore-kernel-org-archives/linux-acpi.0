From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] long freezes on thinkpad t60
Date: Fri, 25 May 2007 08:58:58 +0200
Message-ID: <20070525065858.GA4257@elte.hu>
References: <E1HrC3W-0005SZ-00@dorka.pomaz.szeredi.hu> <20070524220816.GC23214@khazad-dum.debian.net> <46560E04.2090500@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:51754 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbXEYG7I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 May 2007 02:59:08 -0400
Content-Disposition: inline
In-Reply-To: <46560E04.2090500@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


* Kok, Auke <auke-jan.h.kok@intel.com> wrote:

> Henrique de Moraes Holschuh wrote:
> >On Thu, 24 May 2007, Miklos Szeredi wrote:
> >>Tried nmi_watchdog=1, but then the machine locks up hard shortly after
> >>boot.
> >
> >NMIs in some thinkpads are bad trouble, they lock up the blasted IBM/Lenovo
> >SMBIOS if they happen to hit it while it is servicing a SMI, and thinkpads
> >do SMIs like crazy.
> 
> there's also a L1 ASPM issue with the e1000 chipset in the way (for 
> T60/X60 only). Make sure you are using 2.6.21 or newer. See netdev 
> archives for more on that.

Miklos is using latest -git and he has nmi_watchdog disabled - still the 
long pauses persist. (i've never seen that on my t60)

	Ingo
