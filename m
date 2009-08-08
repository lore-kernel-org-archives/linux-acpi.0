From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 0/4] introduce device async actions mechanism
Date: Fri, 7 Aug 2009 17:29:05 -0700
Message-ID: <20090808005922.110A3526EA5@mailhub.coreip.homeip.net>
References: <1248404514.2670.107.camel@rzhang-dt> <1249439048.2670.454.camel@rzhang-dt> <200908080222.03172.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:44235 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbZHHA3Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Aug 2009 20:29:16 -0400
In-Reply-To: <200908080222.03172.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>

On Friday 07 August 2009 17:22:03 Rafael J. Wysocki wrote:
> +       device_enable_async_pm(&i8042_platform_device->dev, true);
> +

Please don't do that, at least not right now. i8042 being the fine
piece of {soft,hard}ware as it is will not like when you start banging
on all its ports at the same time.

-- 
Dmitry
