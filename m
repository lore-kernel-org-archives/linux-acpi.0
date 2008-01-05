From: Michel Lespinasse <walken@zoy.org>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Sat, 5 Jan 2008 06:55:39 -0800
Message-ID: <20080105145539.GE16376@zoy.org>
References: <20080104144238.GA5176@zoy.org> <200801041756.33733.rjw@sisk.pl> <20080105072022.GA16376@zoy.org> <200801051107.14677.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:44190 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbYAEOzk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 09:55:40 -0500
Content-Disposition: inline
In-Reply-To: <200801051107.14677.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Sat, Jan 05, 2008 at 11:07:14AM +0000, Carlos Corbacho wrote:
> On Saturday 05 January 2008 07:20:22 Michel Lespinasse wrote:
> > No luck. The system still does not suspend after applying the patch set.
> > Still stuck at the same place, "Suspending console(s)"...
> 
> Can you try applying this patch on top of Rafael's patch series:
> 
> http://files.strangeworlds.co.uk/acpi-force-1.0-suspend-behaviour

Nice !

The patch did not work as you sent it, but doing the same in acpi_pm_open()
(i.e. forcing it to execute the revision<3 code) worked.
I'm now doing a happy dance :)

So what now, do you need some kind of signature for the system ?
(I realize that would probably be some kind of DMI string,
but I'm not sure where/how to obtain it)

-- 
Michel Lespinasse
