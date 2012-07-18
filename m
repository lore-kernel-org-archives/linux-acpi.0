From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 1/4] ACPI: Add acpi_pr_<level>() interfaces
Date: Wed, 18 Jul 2012 15:41:56 -0600
Message-ID: <1342647716.3010.40.camel@misato.fc.hp.com>
References: <1342644027-19559-1-git-send-email-toshi.kani@hp.com>
	 <1342644027-19559-2-git-send-email-toshi.kani@hp.com>
	 <1342646876.2215.6.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:14715 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab2GRVqk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2012 17:46:40 -0400
In-Reply-To: <1342646876.2215.6.camel@joe2Laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com

On Wed, 2012-07-18 at 14:27 -0700, Joe Perches wrote:
> On Wed, 2012-07-18 at 14:40 -0600, Toshi Kani wrote:
> > This patch introduces acpi_pr_<level>(), where <level> is a message
> > level such as err/warn/info, to support improved logging messages
> > for ACPI, esp. in hotplug operations.
> 
> One more note:
> 
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> []
> > @@ -454,3 +454,35 @@ acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
> []
> > +void
> > +acpi_printk(const char *level, acpi_handle handle, const char *fmt, ...)
> []
> > +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER};
> []
> > +	ret = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> []
> > +	kfree(buffer.pointer);
> 
> There's a failure mode here because buffer.pointer
> isn't guaranteed to be initialized or set to NULL.

Hi Joe,

Yes, I thought that check was necessary as well.  However, to my
surprise, such check caused the following warning message from
patchcheck.pl.  So, I deleted the check...

# check for needless kfree() checks
                if ($prevline =~ /\bif\s*\(([^\)]*)\)/) {
                        my $expr = $1;
                        if ($line =~ /\bkfree\(\Q$expr\E\);/) {
                                WARN("NEEDLESS_KFREE",
                                     "kfree(NULL) is safe this check is
probably not required\n" . $hereprev);
                        }
                }

Thanks,
-Toshi

