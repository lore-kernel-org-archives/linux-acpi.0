From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: do not stop/start devices in suspend/resume path: the SCSI case
Date: Sun, 23 Dec 2007 20:21:35 -0700
Message-ID: <200712232021.36835.bjorn.helgaas@hp.com>
References: <4745F77C.7040402@gmail.com> <200712051124.18852.bjorn.helgaas@hp.com> <476F0ED5.3090609@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:30383 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbXLXDXa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Dec 2007 22:23:30 -0500
In-Reply-To: <476F0ED5.3090609@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephane Ascoet <stephaneascoet@free.fr>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, matthew@wil.cx, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, drzeus@drzeus.cx, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>

On Sunday 23 December 2007 6:43:49 pm Stephane Ascoet wrote:
> Bjorn Helgaas a =E9crit :
> > Good.  It's not clear to me whether it is safe to leave devices
> > enabled while we sleep.  I don't see an actual problem, but there
> > might be something related to hotplug while we're asleep or somethi=
ng.
> > So I'll cc: some additional people who might have some insight.
>
> Hi, is there a chance for SCSI sleeping being managed by ACPI(it seem=
s
> to be the case for IDE)?

I'm sorry, I don't know the answer to this.

Bjorn

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
