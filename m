From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -next] panasonic-laptop: depends on ACPI
Date: Wed, 22 Oct 2008 18:26:10 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810221825590.3010@localhost.localdomain>
References: <48F8F990.1060807@oracle.com>
 <20081018070430.GO1048@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:60063 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbYJVW11 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2008 18:27:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9500EIAVNOQ496@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 22 Oct 2008 17:26:13 -0500 (CDT)
In-reply-to: <20081018070430.GO1048@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-acpi@vger.kernel.org, akpm <akpm@osdl.org>

applied.

thanks,
-Len


On Sat, 18 Oct 2008, Harald Welte wrote:

> On Fri, Oct 17, 2008 at 01:46:08PM -0700, Randy Dunlap wrote:
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > panasonic-laptop uses many acpi_*() functions so it should
> > depend on ACPI; otherwise there are approximately 70
> > warnings/errors generated.
> > 
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Acked-by: Harald Welte <laforge@gnumonks.org>
