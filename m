From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull request] ACPI patches for Linux 2.6.36-rc6
Date: Fri, 01 Oct 2010 19:31:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010011930220.6869@localhost.localdomain>
References: <alpine.LFD.2.00.1010010142470.7033@localhost.localdomain>
 <201010012308.12897.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:46601 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab0JAXcS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2010 19:32:18 -0400
In-reply-to: <201010012308.12897.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, stable@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

> > commit 573b638158029898caf9470c8214b7ddd29751e3
> > Author: Colin Ian King <colin.king@canonical.com>
> > Date:   Mon Aug 2 15:14:43 2010 +0000
> 
> This one should go to -stable, shouldn't it?

yes, plus and a couple of the others.

FYI, I generally push to .stable when I go to delete the topic branches
that Linus has pulled and close applicable bug reports.

thanks,
Len Brown, Intel Open Source Technology Center
