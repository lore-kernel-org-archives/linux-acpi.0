From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH 1/9] ACPI: Implement the set_target() callback from pm_ops
Date: Thu, 19 Jul 2007 11:17:17 +0200
Message-ID: <200707191117.19367.rjw@sisk.pl>
References: <200707172236.28895.rjw@sisk.pl> <20070717170201.c301cd06.akpm@linux-foundation.org> <200707182205.13957.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58667 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbXGSJJT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2007 05:09:19 -0400
In-Reply-To: <200707182205.13957.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>

On Thursday, 19 July 2007 04:05, Len Brown wrote:
> Rafael,
> Please delete the instances of the string ACPI_STATE_S2 -- it doesn't exist in practice
> and we don't want to imply it exists by inventing it here.

OK, I will.

> otherwise:
> Acked-by: Len Brown <len.brown@intel.com>

Thanks!

Greetings,
Rafael
