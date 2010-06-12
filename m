From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 5/5] ACPI: introduce module parameter acpi.aml_debug
Date: Sat, 12 Jun 2010 11:05:44 +0800
Message-ID: <1276311944.19052.17254.camel@rzhang1-desktop>
References: <1276235286.19052.15875.camel@rzhang1-desktop>
	 <alpine.LFD.2.00.1006111209180.4096@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33252 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982Ab0FLDFd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 23:05:33 -0400
In-Reply-To: <alpine.LFD.2.00.1006111209180.4096@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On Sat, 2010-06-12 at 00:11 +0800, Len Brown wrote:
> On Fri, 11 Jun 2010, Zhang Rui wrote:
> 
> > Introduce module parameter acpi.aml_debug.
> > 
> > With acpi.aml_debug set, we can get AML debug object
> > output (Store (AAA, Debug)), even with CONFIG_ACPI_DEBUG
> > cleared.
> > 
> > Together with the runtime custom method,
> > we can debug AML code problems without rebuilding the kernel.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/acpica/acglobal.h |    2 +-
> >  drivers/acpi/sysfs.c           |    4 ++++
> >  include/acpi/acpixf.h          |    2 +-
> >  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> Is there an update to Documentation/acpi/ ?
> 
Oh, I'll update the documentation in patch V2.

thanks,
rui


