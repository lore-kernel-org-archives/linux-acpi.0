From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] Add support for the generic backlight device to the IBM ACPI driver
Date: Tue, 24 Oct 2006 19:47:46 +0000
Message-ID: <20061024194746.GB4835@ucw.cz>
References: <20061013102345.GB4234@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28424 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030454AbWJXTr6
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Oct 2006 15:47:58 -0400
Content-Disposition: inline
In-Reply-To: <20061013102345.GB4234@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

Hi!

> Add support for the generic backlight interface below
> /sys/class/backlight.  The patch keeps the procfs brightness handling for
> backward compatibility.
> 
> For this to archive, the patch adds two generic functions brightness_get
> and brightness_set to be used both by the procfs related and the sysfs
> related methods.

Looks okay to me, thanks!

						Pavel
-- 
Thanks for all the (sleeping) penguins.
