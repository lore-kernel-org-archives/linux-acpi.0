From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] dell-wmi - properly handle errors returned by
 wmi_install_notify_handler()
Date: Tue, 29 Dec 2009 01:21:57 -0800
Message-ID: <20091229092157.GB7805@core.coreip.homeip.net>
References: <20091229083226.13097.22110.stgit@localhost.localdomain>
 <20091229095706.392debfb@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:59149 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbZL2JWE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2009 04:22:04 -0500
Received: by pwj9 with SMTP id 9so6704941pwj.21
        for <linux-acpi@vger.kernel.org>; Tue, 29 Dec 2009 01:22:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091229095706.392debfb@tux.DEF.witbe.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Rolland <rol@as2917.net>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Tue, Dec 29, 2009 at 09:57:06AM +0100, Paul Rolland wrote:
> Hello,
> 
> On Tue, 29 Dec 2009 00:34:14 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > wmi_install_notify_handler() retruns ACPI error codes instead of standard
> > Exxxx error codes and they should not be propagated unchanged to the upper
> > layers.
> > 
> > Reported-by: Paul Rolland <rol@as2917.net>
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> Tested-by: Paul Rolland <rol@as2917.net>
> 
> This is causing :
> [root@tux ~]# modprobe dell-wmi
> FATAL: Error inserting dell_wmi (/lib/modules/2.6.33-rc2/kernel/drivers/platform/x86/dell-wmi.ko): Input/output error
> 
> and
> 
> Dec 29 09:54:54 tux kernel: ACPI: WMI: Mapper loaded
> Dec 29 09:54:54 tux kernel: input: Dell WMI hotkeys as /devices/virtual/input/input13
> Dec 29 09:54:54 tux kernel: dell-wmi: Unable to register notify handler - 6
> 
> which looks Ok as my machine doesn't seem to have the corresponding stuff.
> 
> Anyway, this still needs the changes I sent for wmi.c to avoid the Oops.
> 

Yes, Len already has similar patches lined up in acpi-test branch.

-- 
Dmitry
