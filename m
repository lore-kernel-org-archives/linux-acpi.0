From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: delete CONFIG_ACPI_PROCFS_SLEEP (again)
Date: Wed, 1 Aug 2007 12:24:34 +0200
Message-ID: <200708011224.35917.rjw@sisk.pl>
References: <200707251238.50218.lenb@kernel.org> <alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org> <200707312327.10755.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34359 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547AbXHAKPr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Aug 2007 06:15:47 -0400
In-Reply-To: <200707312327.10755.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, david@lang.hm, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Adrian Bunk <bunk@stusta.de>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>

On Wednesday, 1 August 2007 05:27, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> CONFIG_ACPI_PROCFS_SLEEP is a NO-OP -- delete it (again).
> 
> Apparently 296699de6bdc717189a331ab6bbe90e05c94db06 creating CONFIG_SUSPEND
> and CONFIG_PM_SLEEP was based on an out-dated version of drivers/acpi/Kconfig,
> as it erroneously restored this recently deleted config option.

Some chunks of code in drivers/acpi/sleep/proc.c depend on
CONFIG_ACPI_PROCFS_SLEEP.  Do you also intend to remove that code?

Greetings,
Rafael
