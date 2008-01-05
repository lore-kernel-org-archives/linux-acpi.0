From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Sat, 5 Jan 2008 11:07:14 +0000
Message-ID: <200801051107.14677.carlos@strangeworlds.co.uk>
References: <20080104144238.GA5176@zoy.org> <200801041756.33733.rjw@sisk.pl> <20080105072022.GA16376@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:60808 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbYAELHU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 06:07:20 -0500
In-Reply-To: <20080105072022.GA16376@zoy.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michel Lespinasse <walken@zoy.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Saturday 05 January 2008 07:20:22 Michel Lespinasse wrote:
> On Fri, Jan 04, 2008 at 05:56:33PM +0100, Rafael J. Wysocki wrote:
> > Please try the patch series from:
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.24-rc6/patches/
> > on top of 2.6.24-rc6 (patches 28-34 are relevant in particular) and
> > see if that helps.
>
> No luck. The system still does not suspend after applying the patch set.
> Still stuck at the same place, "Suspending console(s)"...

Can you try applying this patch on top of Rafael's patch series:

http://files.strangeworlds.co.uk/acpi-force-1.0-suspend-behaviour

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
