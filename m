From: Michael Sedkowski <sedmich@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 21:23:38 +0200
Message-ID: <1186514618.5622.9.camel@nx6310>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>
	 <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no>
	 <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no>
	 <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no>
	 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>
	 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no> <46B7AF53.1040307@shaw.ca>
	 <46B8140E.3000509@gmail.com>  <1186497925.8780.78.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:63692 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbXHGTXo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Aug 2007 15:23:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so115592ugf
        for <linux-acpi@vger.kernel.org>; Tue, 07 Aug 2007 12:23:42 -0700 (PDT)
In-Reply-To: <1186497925.8780.78.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Tejun Heo <htejun@gmail.com>, Robert Hancock <hancockr@shaw.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

I did some additional checking today...
On kernels prior to 2.6.22 line, the bug exists and manifests itself
exactly the same way. However, when I removed the "-h" flag
from /etc/init.d/halt, the drive spins down only once on "Power down"
message and there is no sign of the bug and the emergency unload count
remains constant. I've verified this on kernels 2.6.21.6; 2.6.20.4;
2.6.18-4-686-Etch.
The obvious conclusion is that something must have changed it the 2.6.22
kernels, so that removing the "-h" has no effect.
I dunno if my observations are of any value, but I thought You should
know...

Regards,
Michael

