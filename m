From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 12:42:01 +0930 (CST)
Message-ID: <200708240312.l7O3C1ww029937@turbo.physics.adelaide.edu.au>
References: <200708232213.19204.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:46645 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750943AbXHXDMT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 23:12:19 -0400
In-Reply-To: <200708232213.19204.lenb@kernel.org> from "Len Brown" at Aug 23, 2007 10:13:19 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

> I agree with everything Matthew wrote.

No problem - thanks to both of you for the feedback.

> Also, please move it to drivers/misc, to keep msi-laptop,
> sony-laptop, asus-laptop, and thinkpad-acpi company.

Will do.  I assume that this list would still be the most appropriate place
to submit such a driver?

> You might consider naming it fujitsu-laptop as well,
> since the driver depends on ACPI, but it really exists
> to provide laptop features, not to implement part of the ACPI spec...
> fuj02b1_acpi.c may be accurate, but nobody will know what it is.

I agree with this.

> Along those lines, it is generally a good idea to put
>         if (acpi_disabled)
>                 return -ENODEV;

Agreed.

> Also, the driver needs somebody to volunteer to be
> its maintainer before it can be merged.

At this stage I would be happy to maintain it.

> Finally, please run it through scripts/Lindent before the next edition.

Will do.

Thanks once again for your help and suggestions.  I shall rework the patch
in due course.

Regards
  jonathan
