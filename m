From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: final set of EC init patches
Date: Wed, 07 Mar 2007 11:04:46 +0300
Message-ID: <45EE721E.50909@linux.intel.com>
References: <45E6050D.2060908@linux.intel.com> <200703070034.06530.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41129 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbXCGIEu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Mar 2007 03:04:50 -0500
In-Reply-To: <200703070034.06530.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Len Brown wrote:
> why is fake_ecdt no longer necessary -- because ec initializes first now?
>
>   
right
> while I'm glad to see the ec_burst_enable exported -- it is currently
> not called and we continue to always operate in normal mode, yes?
>
>   
yes
> it seems that burst mode is intended for when we want to push
> a series of commands to the ec, so we'd
> 1. enable burst mode
> 2. do a bunch of ec transactions
> 2. disable burst mode
> right?
>
>   
right
> Anybody got any candidates for a series of transactions that would
> benefit from this mode?  If yes, is it possible to detect an efficiency
> benefit from enabling burst mode for that series?
>
>   
the one obvious candidate is smart battery, it reads all of its data as 
separate read/writes through EC.
> yes, i like "boot_ec" better than "ec_ecdt".
>
>   
glad to hear that :)
> as usual, they patch series is "light" on check-in comments --
> in particular, there are none at all explaining why these
> changes are necessary.
>
>   
make code cleaner...
> thanks,
> -Len
>
> ps. mbox applies better if "From" is not replaced by ">From"
>   
