From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: WARNING: at drivers/base/sys.c:183 sysdev_driver_register+0x75/0x12e()
Date: Tue, 22 Apr 2008 21:56:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804222155070.12972@jikos.suse.cz>
References: <Pine.LNX.4.64.0804221609130.12972@jikos.suse.cz>
 <6453C3CB8E2B3646B0D020C112613273093908@sausexmb4.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:39078 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756386AbYDVT4x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Apr 2008 15:56:53 -0400
In-Reply-To: <6453C3CB8E2B3646B0D020C112613273093908@sausexmb4.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: davej@codemonkey.org.uk, lenb@kernel.org, linux-acpi@vger.kernel.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk

On Tue, 22 Apr 2008, Langsdorf, Mark wrote:

> PowerNow! failed to load because the BIOS wasn't set up correctly.  But 
> the acpi-cpufreq driver shouldn't have loaded at all.

I'd guess that it is because acpi_cpufreq_init() doesn't contain any check 
at all that will make sure that the CPU supports needed features (as 
opposed to powernow/speedstep/etc modules, which perform such checks), 
right?

-- 
Jiri Kosina
SUSE Labs
