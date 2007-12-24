From: Stephane Ascoet <stephaneascoet@free.fr>
Subject: Re: do not stop/start devices in suspend/resume path: the SCSI case
Date: Mon, 24 Dec 2007 02:43:49 +0100
Message-ID: <476F0ED5.3090609@free.fr>
References: <4745F77C.7040402@gmail.com> <47511751.2010707@gmail.com> <47514CE2.3000600@gmail.com> <200712051124.18852.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp25.orange.fr ([193.252.22.23]:37420 "EHLO smtp25.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbXLWXjC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Dec 2007 18:39:02 -0500
In-Reply-To: <200712051124.18852.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, matthew@wil.cx, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, drzeus@drzeus.cx, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>

Bjorn Helgaas a =E9crit :
> Good.  It's not clear to me whether it is safe to leave devices
> enabled while we sleep.  I don't see an actual problem, but there
> might be something related to hotplug while we're asleep or something=
=2E
> So I'll cc: some additional people who might have some insight.
Hi, is there a chance for SCSI sleeping being managed by ACPI(it seems=20
to be the case for IDE)?

--=20
Bien cordialement, Stephane Ascoet, conseils pour que la technologie=20
soit un progres respectueux de la vie.
Album photo:<http://www.flickr.com/photos/stephaneascoet/>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
