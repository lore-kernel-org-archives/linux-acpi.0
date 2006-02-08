From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Add generic backlight support to toshiba_acpi driver
Date: Wed, 8 Feb 2006 10:07:57 +0100
Message-ID: <20060208090757.GB11895@elf.ucw.cz>
References: <20060207133456.GA2452@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18588 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161075AbWBHJKE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2006 04:10:04 -0500
Content-Disposition: inline
In-Reply-To: <20060207133456.GA2452@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: john@neggie.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi!

> The included patch adds support for interacting with the toshiba_acpi 
> backlight control through the generic backlight interface 
> (/sys/class/backlight).
> 
> ACPI folk: this gives us the benefit of a consistent interface to LCD 
> brightness. Is it worth me converting the other drivers over?

Not sure if I'm ACPI folk but yes, consistent interface would be nice.

								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
