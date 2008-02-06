From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 5/5] ACPI: WMI: Add initial documentation
Date: Wed, 6 Feb 2008 10:51:04 +0000
Message-ID: <200802061051.05776.carlos@strangeworlds.co.uk>
References: <20080205021658.4422.83165.stgit@pacifica> <200802050225.58727.carlos@strangeworlds.co.uk> <20080205191226.9248e1e8.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cyberslack.slackadelic.com ([216.23.240.152]:40432 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1759280AbYBFLAe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 06:00:34 -0500
In-Reply-To: <20080205191226.9248e1e8.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wednesday 06 February 2008 03:12:26 Randy Dunlap wrote:
> Please tell what WMI stands for.

Will do.

> > +ACPI-WMI has no knowledge of the size of the data blocks passed to/ from
>
>                                                                    to/from

I was always taught that the correct way was to leave a space.

However, I will fix this.

> Are there netlink-aware apps that already know how to use this
> interface?  If so, where?

There is currently no userspace application that can handle this (netlink is 
also only used for event passing, as stated).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
