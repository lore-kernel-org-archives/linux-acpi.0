From: Thomas Renninger <trenn@suse.de>
Subject: Re: mmotm 2010-07-27 - WARNING in ec_parse_io_ports()
Date: Wed, 28 Jul 2010 13:17:28 +0200
Message-ID: <201007281317.29129.trenn@suse.de>
References: <201007272226.o6RMQRBm008735@imap1.linux-foundation.org> <10677.1280295051@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59146 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab0G1LPI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jul 2010 07:15:08 -0400
In-Reply-To: <10677.1280295051@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Alexey Starikovskiy <astarikovskiy@novell.com>

On Wednesday 28 July 2010 07:30:51 Valdis.Kletnieks@vt.edu wrote:
> On Tue, 27 Jul 2010 14:56:50 PDT, akpm@linux-foundation.org said:
> > The mm-of-the-moment snapshot 2010-07-27-14-56 has been uploaded to
> > 
> >    http://userweb.kernel.org/~akpm/mmotm/
> 
> Seen during very early boot:
Yep, that's my fault.
I'll post a fix to Matthew's platform drivers list asap.
For now just ignore it. The warning is a false positive one and
is harmless.
Thanks for bringing this up!

         Thomas

> 
> [    0.302450] ------------[ cut here ]------------
> [    0.302458] WARNING: at drivers/acpi/ec.c:864 
ec_parse_io_ports+0x7d/0x110()
> [    0.302460] Hardware name: Latitude E6500
> [    0.302462] Could not request EC data io port 2352
Interesting io port 0x930..., definitely not default.
You might want to double check with a fixed kernel if it
is registered correctly in /proc/ioports and the WARNING
vanishes. But no need to explicitly check, just have a look
when you try a newer one anyway. Thanks.
