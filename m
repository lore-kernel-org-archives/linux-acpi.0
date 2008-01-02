From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: kpowersave stuck at battery charging
Date: Wed, 02 Jan 2008 13:42:45 +0300
Message-ID: <477B6AA5.5020803@gmail.com>
References: <200801021248.55844.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:26306 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbYABKm5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 05:42:57 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6062699fkz.5
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jan 2008 02:42:56 -0800 (PST)
In-Reply-To: <200801021248.55844.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: hal@lists.freedesktop.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> This is did not happen before; I am not sure right now what caused this (i.e. 
> battery aging or some software change) nor whether this is kernel/HAL/kpowersave 
> issue.
>
> kpowersave is stuck at assuming battery is loading and at 94%. Sysfs displays 
> battery state as Full:
>
>   
Frequent battery charging shortens lifetime of the battery, so some (may 
be all now)
notebook manufacturers do not start charging  battery until it discharge 
to some degree (~90%).
It could be your case. Please try to discharge battery to, say, 89% and 
then check if it charges to the
100%.
> - does ACPI battery code misuse POWER_SUPPLY_PROP_ENERGY_FULL?
> - does HAL misuse .../energy_full?
> - does kpowersave misuse battery.charge_level.last_full?
>   

