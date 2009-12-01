From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC PATCH] ACPI: support overriding an ACPI control method at runtime
Date: Tue, 1 Dec 2009 10:28:59 +0100
Message-ID: <200912011028.59752.trenn@suse.de>
References: <1259139678.10510.59.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52467 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbZLAJ2y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Dec 2009 04:28:54 -0500
In-Reply-To: <1259139678.10510.59.camel@rzhang1-desktop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

On Wednesday 25 November 2009 10:01:18 Zhang Rui wrote:
> 
> Introduce a new debugfs I/F (/sys/kernel/debug/acpi/custom_method)for ACPI,
> which can be used to override an ACPI control method at runtime.
Cool.
 
> We can use this to debug the AML code level bugs instead of overriding the
> whole DSDT table, without rebuilding/rebooting kernel any more.
One thing:
this should taint the kernel in the same way as done here?:
drivers/acpi/osl.c:             add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);

> Detailed description about how to use this debugfs I/F is stated in
> Documentation/acpi/method-override.txt
That nicely explains why it's urgent to provide easy methods to
the users to play with and test things without the need of recompiling
a kernel.

     Thomas
