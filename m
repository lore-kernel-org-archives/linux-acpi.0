From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: fix fan module removal when ACPI_PROCFS is disabled
Date: Tue, 27 Apr 2010 13:12:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004271309190.4006@localhost.localdomain>
References: <1272385158-4080-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:14184 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab0D0RNP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Apr 2010 13:13:15 -0400
In-reply-to: <1272385158-4080-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com, linux-kernel@vger.kernel.org

> When ACPI_PROCFS is disabled, /proc/acpi/fan/ directory is not created.
> So, it should not be removed during the module removal either.

Yes, this patch would make the #ifdefs consistent.
But it looks like remove_proc_entry() just silently does nothing
if the directory is not there, yes?

What I'd really like to see is a patch removing fan.c's proc code 
completely.  It was scheduld for removal in July 2008.

thanks,
Len Brown, Intel Open Source Technology Center
