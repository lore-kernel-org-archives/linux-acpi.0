From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: OT: Best practices for indenting ASL files
Date: Wed, 12 Jun 2013 00:53:45 +0200
Message-ID: <228515949.LdhQTLUpvh@vostro.rjw.lan>
References: <1370595194.21257.9.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34511 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab3FKWof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Jun 2013 18:44:35 -0400
In-Reply-To: <1370595194.21257.9.camel@mattotaupa>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: linux-acpi@vger.kernel.org

On Friday, June 07, 2013 10:53:14 AM Paul Menzel wrote:
> Dear Linux ACPI folks,
> 
> 
> we have a lot of ASL files in coreboot [1], a free firmware for hardware
> initialization.
> 
> As you can see in [2] for example, we struggle with whitespace issues.
> 
> Could you recommend best practices how to indent ASL files?

Well, why don't you adopt the convention used by 'iasl -d'?  People are
quite accustomed to that.

Thanks,
Rafael


> 
> 
> [1] http://www.coreboot.org/
> [2] http://review.coreboot.org/#/c/3403/2/src/ec/lenovo/h8/acpi/ec.asl
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
