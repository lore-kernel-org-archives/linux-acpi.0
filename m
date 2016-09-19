From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v2 5/5] PCI: Avoid unnecessary resume on shutdown
Date: Mon, 19 Sep 2016 11:12:23 +0200
Message-ID: <1474276343.2044.4.camel@suse.com>
References: <cover.1474130360.git.lukas@wunner.de>
         <760eb8c67a02e35938a4fbd3b31cbe9bb1414c5a.1474130360.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43719 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752338AbcISJRv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Sep 2016 05:17:51 -0400
In-Reply-To: <760eb8c67a02e35938a4fbd3b31cbe9bb1414c5a.1474130360.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Wu <peter@lekensteyn.nl>, Andreas Noever <andreas.noever@gmail.com>

On Sun, 2016-09-18 at 05:39 +0200, Lukas Wunner wrote:
> We currently perform a mandatory runtime resume of all PCI devices on
> ->shutdown.  However it is pointless to wake devices only to immediately
> power them down afterwards.  (Or have the firmware reset them, in case
> of a reboot.)
> 
> It seems there are only two cases when a runtime resume is actually
> necessary:  If the driver has declared a ->shutdown callback or if kexec
> is in progress.
> 
> Constrain resume of a device to these cases and let it slumber
> otherwise, thereby conserving energy and speeding up shutdown.

What happens if you get a wakeup event while going down?
Will it lead to a reboot when a shutdown has been requested?

	Regards
		Oliver


