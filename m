From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PNP: do not stop/start devices in suspend/resume path
Date: Wed, 12 Dec 2007 00:16:10 -0800
Message-ID: <20071212001610.6506c6d2.akpm@linux-foundation.org>
References: <4745F77C.7040402@gmail.com>
	<47514CE2.3000600@gmail.com>
	<200712051124.18852.bjorn.helgaas@hp.com>
	<200712061625.57660.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42218 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754903AbXLLIQz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Dec 2007 03:16:55 -0500
In-Reply-To: <200712061625.57660.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, matthew@wil.cx, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, drzeus@drzeus.cx, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, 6 Dec 2007 16:25:57 -0700 Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Andrew, can you add this before
> pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch?
> 
> ...
>
> PNP: do not stop/start devices in suspend/resume path

I did, but I also temporarily dropped
pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch.

Is it expected that this patch will fix
pnp-request-ioport-and-iomem-resources-used-by-active-devices.patch? 
Should I bring it back?
