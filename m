From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 15:25:39 +0400
Message-ID: <46F8F033.2040402@gmail.com>
References: <20070925065109.GA3080@localhost.localdomain>	 <20070925003340.5d6dd7f4.akpm@linux-foundation.org>	 <46F8C880.1010006@suse.de> <64bb37e0709250208gcbdeb6do6026e138e746bde2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:29495 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbXIYLZr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Sep 2007 07:25:47 -0400
Received: by ug-out-1314.google.com with SMTP id z38so918646ugc
        for <linux-acpi@vger.kernel.org>; Tue, 25 Sep 2007 04:25:45 -0700 (PDT)
In-Reply-To: <64bb37e0709250208gcbdeb6do6026e138e746bde2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Damien Wyart <damien.wyart@free.fr>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

Torsten Kaiser wrote:
> On 9/25/07, Alexey Starikovskiy <astarikovskiy@suse.de> wrote:
>> Do you have CONFIG_ACPI_SLEEP enabled in your .config?
> 
> I'm answering that too, because I suspect that my "2.6.23-rc7-mm1 does
> not power off"-error might have the same cause.
> 
> No, I do not have CONFIG_ACPI_SLEEP set,
> because I do not have CONFIG_PM_SLEEP set,
> because I do not want SUSPEND and/or HIBERNATION.
This is not the reason. SUSPEND is controlled with CONFIG_SUSPEND and 
HIBERNATION is controlled with CONFIG_HIBERNATION.
But if you want S5 ACPI sleep state you might want to enable ACPI_SLEEP...
> 
> .config from 2.6.23-rc7-mm1 attached.
> 
> Torsten
> 

