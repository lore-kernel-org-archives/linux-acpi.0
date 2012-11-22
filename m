From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 217/493] acpi: remove use of __devinit
Date: Thu, 22 Nov 2012 01:18:09 +0100
Message-ID: <11689359.E4tRqmmlBk@vostro.rjw.lan>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-217-git-send-email-wfp5p@virginia.edu> <3003032.3Hm8RaEcML@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:60336 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab2KVS4t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Nov 2012 13:56:49 -0500
In-Reply-To: <3003032.3Hm8RaEcML@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org

On Wednesday, November 21, 2012 01:46:36 AM Rafael J. Wysocki wrote:
> On Monday, November 19, 2012 01:22:46 PM Bill Pemberton wrote:
> > CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> > needed.
> 
> Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

And dropped, because it causes build problems to happen in
acpi_pci_root_add() in my tree.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
