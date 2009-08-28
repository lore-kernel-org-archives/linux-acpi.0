From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7 updated] PM: Add a switch for disabling/enabling
	asynchronous suspend/resume
Date: Thu, 27 Aug 2009 22:22:57 -0700
Message-ID: <20090828055520.E561A526EC9@mailhub.coreip.homeip.net>
References: <200908262217.19609.rjw@sisk.pl> <200908272119.47053.rjw@sisk.pl> <20090827203948.9CD25526EC9@mailhub.coreip.homeip.net> <200908280022.40522.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:63189 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbZH1FXI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 01:23:08 -0400
Content-Disposition: inline
In-Reply-To: <200908280022.40522.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Linux PCI <linux-pci@vger.kernel.org>

On Fri, Aug 28, 2009 at 12:22:40AM +0200, Rafael J. Wysocki wrote:
> +/* kernel/power/main.c */
> +extern int pm_async_enabled;
>  

Sorry, forgot about this in the first mail - why don't we make it a
bool?

-- 
Dmitry
