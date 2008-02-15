From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] Suspend-related cleanups
Date: Fri, 15 Feb 2008 15:22:46 -0500
Message-ID: <200802151522.46847.lenb@kernel.org>
References: <200802032252.04852.rjw@sisk.pl> <20080203222027.GB2799@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48459 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756380AbYBOUXr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 15:23:47 -0500
In-Reply-To: <20080203222027.GB2799@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sunday 03 February 2008 17:20, Pavel Machek wrote:
> Hi!
> 
> > Three suspend-related fixes that IMO can go into 2.6.25 follow.
> 
> ACK on all three. Yes, these seem easy enough for 2.6.25.
> 									Pavel

1 & 2 applied.
lets re-send #3 after the big feature-removal patch goes in,
since it conflicts with top of tree and will conflict with that too.

thanks,
-Len
