From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module, take 3
Date: Thu, 30 Aug 2007 08:49:50 +0930 (CST)
Message-ID: <200708292319.l7TNJoPu003671@turbo.physics.adelaide.edu.au>
References: <200708290329.33824.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:47193 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753638AbXH2XUP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Aug 2007 19:20:15 -0400
In-Reply-To: <200708290329.33824.lenb@kernel.org> from "Len Brown" at Aug 29, 2007 03:29:33 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

> > diff -ruN linux-2.6.23-rc4-old/drivers/misc/fujitsu-laptop.c~ linux-2.6.23-rc4-new/drivers/misc/fujitsu-laptop.c~
> 
> probably you didn't mean to create this file

Ah no.  I posted a follow-up patch to rectify this.

> must be getting late in Australia?:-)

Not exactly - it was mid-afternoon - but I was extremely busy with other
things and was just a little too hasty in doing the diff.

> anyway, the other file looks good, and I've dropped it into acpi-test.

Thanks.  Any idea as to when it might show up in mainline?  I expect 2.6.24
at the earliest given where we are in 2.6.23's release cycle.

Regards
  jonathan
