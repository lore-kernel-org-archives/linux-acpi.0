From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Patch needed for ASUS EEEPC 701 2.6.27 (perhaps a regession)
Date: Sat, 11 Oct 2008 18:46:36 +0200
Message-ID: <200810111846.36862.rjw@sisk.pl>
References: <48F09658.8060502@au-79.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58658 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858AbYJKQm2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Oct 2008 12:42:28 -0400
In-Reply-To: <48F09658.8060502@au-79.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Goldner <robert@au-79.de>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Saturday, 11 of October 2008, Robert Goldner wrote:
> Hi,
> 
> I am a happy user of an asus eeepc 701 with an self-made kernel 2.6.27. 
> Its working quite good, but there is one patch needed to avoid problems 
> related to ACPI and Hotkeys.
> After using a few hotkeys there comes a message in syslog like:
> ACPI: EC: GPE storm detected, disabling EC GPE
> and no hotkey event is recognized any more. This is quite bad on a nettop.
> 
> The needed patch and the bug description is available at:
> http://bugzilla.kernel.org/show_bug.cgi?id=10919
> The patch is called 'patch vs 2.6.27-rc7'
> 
> The patch fits also to 2.6.27 without any problems and works very fine. 
> Thanks to everyone who was involved.
> 
> I would suggest to include this patch in the mainline kernel very soon 
> (e.g. 2.6.28 or if possible in 2.6.27.1).

This patch is scheduled for 2.6.28 AFAICS and will be included into -stable if
it doesn't break anything in the mainline.

Thanks,
Rafael
