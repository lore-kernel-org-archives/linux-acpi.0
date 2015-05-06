From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Detecting that a battery is inside a dock?
Date: Wed, 06 May 2015 16:20:17 +0200
Message-ID: <1430922017.2786.10.camel@hadess.net>
References: <1430320098.2525.105.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51961 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbbEFOUU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2015 10:20:20 -0400
Received: from mfilter9-d.gandi.net (mfilter9-d.gandi.net [217.70.178.138])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 5FC4941C1CB
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2015 16:20:19 +0200 (CEST)
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
	by mfilter9-d.gandi.net (mfilter9-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id Ag0M-6CJFW6n for <linux-acpi@vger.kernel.org>;
	Wed,  6 May 2015 16:20:16 +0200 (CEST)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 045BE41C1AA
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2015 16:20:17 +0200 (CEST)
In-Reply-To: <1430320098.2525.105.camel@hadess.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Wed, 2015-04-29 at 17:08 +0200, Bastien Nocera wrote:
> Hey,
> 
> I have access to a convertible Toshiba machine where the 2nd battery 
> is in detachable keyboard. This is the decompiled DSDT:
> https://hadess.fedorapeople.org/toshiba.dsl
> 
> There's no BAT0, BAT1 is in the screen, and BAT2 is in the keyboard.
> 
> BAT2 can be ejected (it has an _EJD method), but the dock code 
> doesn't 
> see it as having a battery:
> $ pwd
> /sys/devices/platform/dock.0
> $ cat flags
> 16
> $ cat type
> dock_station
> 
> Any ideas what might be missing here?
> 
> I'd eventually like to be able to say that, if I can detect that the 
> battery is inside the dock, to mark it as such in the UI[1] (even 
> better would be to say it's "in the keyboard" but I'm not sure we 
> can 
> easily detect that).

Anyone?

> [1]: https://bugzilla.gnome.org/show_bug.cgi?id=748592
