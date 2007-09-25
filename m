From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 09:23:23 -0700
Message-ID: <20070925092323.17442600.akpm@linux-foundation.org>
References: <20070925065109.GA3080@localhost.localdomain>
	<200709251618.06064.rjw@sisk.pl>
	<46F918F8.1080808@suse.de>
	<200709251652.05589.rjw@sisk.pl>
	<46F91EFB.2050802@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45589 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754213AbXIYQXj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Sep 2007 12:23:39 -0400
In-Reply-To: <46F91EFB.2050802@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <aystarik@gmail.com>, Damien Wyart <damien.wyart@free.fr>, Torsten Kaiser <just.for.lkml@googlemail.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, linux-acpi@vger.kernel.org

On Tue, 25 Sep 2007 18:45:15 +0400 Alexey Starikovskiy <astarikovskiy@suse.de> wrote:

> [fix-ACPI_SLEEP_states.patch  text/x-patch (2.0KB)]
> ACPI: suspend: fix ACPI_SLEEP states
> 
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/sleep/Makefile |    2 +-
>  drivers/acpi/sleep/main.c   |    4 ++++
>  include/acpi/acpi_drivers.h |    4 ----
>  3 files changed, 5 insertions(+), 5 deletions(-)

I get a reject applying this to current mainline.  Easy enough to fix it,
but I worry that the fix might be incorrect when applied to some tree other
than that which you were working on.

