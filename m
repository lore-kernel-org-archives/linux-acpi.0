From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms
 using 'global_lock'
Date: Thu, 24 Sep 2015 17:03:02 -0700
Message-ID: <20150925000302.GD5951@linux>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
 <1801121.8kgxqyHjgV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33576 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbIYADI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2015 20:03:08 -0400
Received: by pacex6 with SMTP id ex6so86977891pac.0
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2015 17:03:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1801121.8kgxqyHjgV@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: gregkh@linuxfoundation.org, linaro-kernel@lists.linaro.org, sboyd@codeaurora.org, arnd@arndb.de, stable@vger.kernel.org, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 25-09-15, 02:17, Rafael J. Wysocki wrote:
> Actually, what about adding a local u32 variable, say val, here and doing
> 
> >  	if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
> >  		goto error;
> >  	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
> > -				 (u32 *)&first_ec->global_lock))
> > +				 &first_ec->global_lock))
> 
> 	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir, &val))
> 
> >  		goto error;
> 
> 	first_ec->global_lock = val;
> 
> And then you can turn val into bool just fine without changing the structure
> definition.

sure. Looks good.

-- 
viresh
