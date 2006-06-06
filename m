From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.17-rc5-mm3: oops when ejecting dock
Date: Mon, 05 Jun 2006 17:54:28 -0700
Message-ID: <4484D244.3010905@goop.org>
References: <4483EB38.30609@goop.org> <1149554579.6006.10.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:10702 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750742AbWFFAyf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2006 20:54:35 -0400
In-Reply-To: <1149554579.6006.10.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Kristen Accardi wrote:
> I was able to reproduce this issue on an x40 - I found a bug in the
> code, however, when I fixed that bug I seem to have uncovered another
> one.  I'll send you a patch hopefully in the next day or so.
>   
Great, looking forward to it.  Do you know if this will properly 
disconnect the optical drive, or does that need some more ata/ide support?

Thanks,
    J

