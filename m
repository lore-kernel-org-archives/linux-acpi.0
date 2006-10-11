From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Add support for the generic backlight device to the IBM ACPI driver
Date: Wed, 11 Oct 2006 11:30:42 +0000
Message-ID: <20061011113042.GA4725@ucw.cz>
References: <20061009113235.GA4444@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54033 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030349AbWJKLaz
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 07:30:55 -0400
Content-Disposition: inline
In-Reply-To: <20061009113235.GA4444@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com

Hi!

> Add support for the generic backlight interface below
> /sys/class/backlight. The patch keeps the procfs brightness handling for
> backward compatibility. For this to archive, the patch adds two generic
> functions brightness_get and brightness_set to be used both by the procfs
> related and the sysfs related methods.
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>

Looks okay to me. It would be nice to get this in, so that we teach
people to use generic interface, and so that we can remove crappy
interfaces in future...

-- 
Thanks for all the (sleeping) penguins.
