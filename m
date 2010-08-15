From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ideapad-laptop: add new driver
Date: Sat, 14 Aug 2010 22:33:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008142229540.2294@localhost.localdomain>
References: <1281672482-10909-1-git-send-email-ike.pan@canonical.com>
 <1281690893.23680.475.camel@localhost>  <4C650FFB.7090602@canonical.com>
 <1281692078.23680.487.camel@localhost> <4C6605DF.8080605@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-reply-to: <4C6605DF.8080605@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: David Woodhouse <dwmw2@infradead.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Randy Dunlap <randy.dunlap@oracle.com>, Corentin Chary <corentincj@iksaif.net>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

If you merge the drivers, I'd sure prefer the name "ideapad-laptop"
over "ideapad-acpi".

While the maintainerless "toshiba-acpi" driver was a pioneer,
and thinkpad-acpi feared installed-base confusion when considering
a name change, we tend to reserve the "acpi" in drivers for things
that supply ACPI, rather than simply use ACPI.

Also, you may find that the platform driver ends up doing
more for the laptop than just using what is behind its
platform-specific ACPI extension.

thanks,
Len Brown, Intel Open Source Technology Center
