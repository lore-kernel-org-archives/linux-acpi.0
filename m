From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 20:25:46 +0400
Message-ID: <46F9368A.40604@gmail.com>
References: <20070925065109.GA3080@localhost.localdomain>	<200709251618.06064.rjw@sisk.pl>	<46F918F8.1080808@suse.de>	<200709251652.05589.rjw@sisk.pl>	<46F91EFB.2050802@suse.de> <20070925092323.17442600.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:12485 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbXIYQZz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Sep 2007 12:25:55 -0400
Received: by ug-out-1314.google.com with SMTP id z38so970048ugc
        for <linux-acpi@vger.kernel.org>; Tue, 25 Sep 2007 09:25:53 -0700 (PDT)
In-Reply-To: <20070925092323.17442600.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Damien Wyart <damien.wyart@free.fr>, Torsten Kaiser <just.for.lkml@googlemail.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, linux-acpi@vger.kernel.org

Andrew,

There are 2 patches, this is the second.
Above, Rafael gave link to first. Here it is again:
http://marc.info/?l=linux-kernel&m=119052978117735&w=4

Sorry for confusion,
Alex.

Andrew Morton wrote:
> On Tue, 25 Sep 2007 18:45:15 +0400 Alexey Starikovskiy <astarikovskiy@suse.de> wrote:
> 
>> [fix-ACPI_SLEEP_states.patch  text/x-patch (2.0KB)]
>> ACPI: suspend: fix ACPI_SLEEP states
>>
>> From: Alexey Starikovskiy <astarikovskiy@suse.de>
>>
>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>> ---
>>
>>  drivers/acpi/sleep/Makefile |    2 +-
>>  drivers/acpi/sleep/main.c   |    4 ++++
>>  include/acpi/acpi_drivers.h |    4 ----
>>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> I get a reject applying this to current mainline.  Easy enough to fix it,
> but I worry that the fix might be incorrect when applied to some tree other
> than that which you were working on.
> 
> 

