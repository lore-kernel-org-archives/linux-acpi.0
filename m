From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH 0/3] ACPI autoload (v2)
Date: Mon, 23 Jul 2007 15:34:06 +0200
Message-ID: <1185197646.1897.22.camel@lov.localdomain>
References: <1185194600.14451.43.camel@fanta4.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50359 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759166AbXGWNc2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jul 2007 09:32:28 -0400
In-Reply-To: <1185194600.14451.43.camel@fanta4.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2007-07-23 at 14:43 +0200, Thomas Renninger wrote:

> I rebased my patches against your recent commits.
> Changes to previous patch(es):
>   - forgot fixed button hids in button.c
>   - adjusted linux specific hids to your suggestions (e.g. LNXVIDEO)
>   - renamed acpi_device_id to acpica_device_id
>     (instead __acpi_device_id)
>   - removed some unneeded comments
> 
> It would be great to still see this in 2.6.23.
> If you have concerns about this, please let me know soon, as we then
> need more ugly workarounds in userspace to get all ACPI modules loaded.
> 
> Kay: On the second patch I added your signed-off. IIRC you said this is
> ok. Thanks a lot for your testing, review, suggestions, enhancements and
> cleanups here.

Sure, that's fine.

I would really like to see the broken stuff currently in the kernel
getting replaced by this before anybody tries to start using it.
The current acpi event environment carries multiple entries of COMPTID= keys.
This can obviously not work as long as environment keys must have unique names. :)

Thanks,
Kay

