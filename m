From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: [PATCH - 2.6.19 -0/2] Backport of psmouse suspend/shutdown cleanups
Date: Wed, 21 Feb 2007 23:22:57 +0300
Message-ID: <45DCAA21.4030900@linux.intel.com>
References: <1172077685.10619.101.camel@d36.suse.de> <20070221195203.GF3732@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24726 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423080AbXBUUXD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Feb 2007 15:23:03 -0500
In-Reply-To: <20070221195203.GF3732@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Renninger <trenn@suse.de>, Stable <Stable@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>

Pavel Machek wrote:
> 2) Fix is very disconnected from the problem. "Deinitialize mouse so
> that fans work after reboot". WTF?
>
>   
ACPI spec implies that EC controller and PS/2 mouse/keyboards controller 
are one entity.
So if mouse screws up "its" controller, it screws up EC as well, meaning 
fans will not work.

Regards,
    Alex.
