From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [patch 0/7] New misc/asus-laptop.c driver
Date: Tue, 30 Jan 2007 09:28:53 +0100
Message-ID: <200701300928.53852.corentincj@iksaif.net>
References: <200701251254.34491.corentincj@iksaif.net> <200701261404.23961.corentincj@iksaif.net> <200701300253.25321.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:40760 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965449AbXA3I24 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jan 2007 03:28:56 -0500
In-Reply-To: <200701300253.25321.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

>
> 1-7 applied to acpi-test
> I also ran scripts/Lindent over it to fix the whitespace.
> Then, after merging into acpi-test I also applied the patch below.
>
> Your choice if you want to make future updates with incremental patches
> on top of acpi-test or re-send the series.
incremental patches on top of acpi-test are fine :)

> Also, while I see that distros do set CONFIG_LEDS_CLASS,
> depending on it will make the driver vanish from menuconfig
> if somebody hasn't set it.  I don't know if this is a big deal or not.
> One possibility is to not depend on it in Kconfig, but via #ifdef's in the
> source. The other is to retreat to using select -- which I'm hopeful we can
> avoid. Or, maybe folks that don't get the driver via distro (who tend to
> enable everything) will not get stumped by this.
As the old asus_acpi doesn't work on new models, and still buggy, I think 
distros will enable asus-laptop (and LED/BACKLIGHT) by default ... Those that 
don't get the driver via distro will find it if they search (as the name 
asus-laptop is accepted, I will post a warning on acpi4asus.sf.net, to say 
that the driver have a new name, etc ...).
Thanks =) 

> thanks
> -Len

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
