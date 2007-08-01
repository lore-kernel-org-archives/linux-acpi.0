From: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.21-rc1: T60 ACPI issues
Date: Wed, 1 Aug 2007 15:24:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011516540.15447@blonde.wat.veritas.com>
References: <20070801135820.GA8266@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:14248 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbXHAOZY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2007 10:25:24 -0400
Received: from [10.10.97.15]([10.10.97.15]) (1914 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1IGF8b-0005BJC@megami.veritas.com>
	for <linux-acpi@vger.kernel.org>; Wed, 1 Aug 2007 07:25:21 -0700 (PDT)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
In-Reply-To: <20070801135820.GA8266@mellanox.co.il>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, mingo@redhat.com, linux-pm@linux-foundation.org

On Wed, 1 Aug 2007, Michael S. Tsirkin wrote:

> Hi!
> ACPI appears to have been broken with 2.6.23-rc1 on my T60
> Userspace from ubuntu dapper.

(Whereas I'm using a T43p with openSUSE 10.2.)

> 
> 1. During boot, I see a lot of messages like this:
> [   41.034204] acpi LNXSYSTM:00: uevent: unsupported action-string; this will be ignored in a future kernel version

(I've not seen those.)

> 
> 2. Pressing Fn/F4 does not trigger suspend to ram
>    This normally triigers ACPI event which triggers suspend to RAM on Ubuntu
>    (echo mem > /sys/power/state works)

I'll bet this is your CONFIG_THINKPAD_ACPI_INPUT_ENABLED=y.
I got the same, see my "THINKPAD_ACPI_INPUT_ENABLED seems regressive"
mail to Henrique and lkml an hour ago.

> 
> 3. After suspend to RAM, system wakes up but laptop's screen is blank,
>    switching VTs etc does not help.
>    External screen wakes up OK though.
>    dmesg output from boot attached.

(I've not had that.)

Hugh
