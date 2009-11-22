From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] ACPI/ACPICA: resume hang (battery related)
Date: Sun, 22 Nov 2009 15:15:18 +0100
Message-ID: <200911221515.18735.rjw@sisk.pl>
References: <1258664394.3611.8.camel@maxim-laptop> <1258892448.3231.23.camel@maxim-laptop> <1258896971.3432.6.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33422 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbZKVOPJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Nov 2009 09:15:09 -0500
In-Reply-To: <1258896971.3432.6.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sunday 22 November 2009, Maxim Levitsky wrote:
> I had just disabled the AC driver, yeah, got similar backtrace from acpi
> video driver.
> 
> Ok, enough, pattern is visible.
> The common point is that all backtraces lead to
> acpi_ex_acquire_global_lock
> 
> According to sources, it is only taken on access to ACPI hardware ranges
> that are marked as 'Lock'.
> 
> On my system only EC space is marked as such, thus this leads me to two
> conclusions.
> 
> Ether during suspend EC access isn't synced (this is, EC transaction is
> still pending),or that EC gets busted (suprise...) on resume or suspend,
> and first read/write cycle to/from it never finishes.
> 
> I am using hibernate cycles using 'reboot' mechanism.

OK, at this point I think it's better to file a bug report in the kernel
and assign it to ACPI (please add my address to the CC list in there).

Thanks,
Rafael
