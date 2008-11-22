From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code ordering
Date: Sat, 22 Nov 2008 11:11:49 +0000
Message-ID: <200811221111.50952.carlos@strangeworlds.co.uk>
References: <200810142254.07024.rjw@sisk.pl> <20081015141526.GA5633@srcf.ucam.org> <200810152320.06167.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:38051 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756880AbYKVL0e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Nov 2008 06:26:34 -0500
In-Reply-To: <200810152320.06167.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, John Brown <john.brown3@hp.com>

On Wednesday 15 October 2008 22:20:05 Rafael J. Wysocki wrote:
> > > IOW, we aren't doing anything wrong and the BIOS is buggy.
> >
> > So how does Windows cope with this?
>
> I don't know. :-(
>
> One possible explanation is that the device causing the trouble is not put
> into D3 at all during suspend, but I'm speculating here.

Do we know which device it is that causes the trouble on this HP box?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D

