From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Jul 9 (acpi_pad.ko)
Date: Thu, 09 Jul 2015 11:56:49 -0700
Message-ID: <559EC3F1.1070003@infradead.org>
References: <20150709140925.4586cd10@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35976 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbbGIS45 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2015 14:56:57 -0400
In-Reply-To: <20150709140925.4586cd10@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Shaohua L <shaohua.li@intel.com>

On 07/08/15 21:09, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20150708:
> 

on x86_64:

ERROR: "tick_broadcast_oneshot_control" [drivers/acpi/acpi_pad.ko] undefined!

when CONFIG_TICK_ONESHOT is not enabled.



-- 
~Randy
