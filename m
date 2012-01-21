From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 0/3] ACPI: Re-factor and remove
 ./drivers/acpi/atomicio.[ch]
Date: Sat, 21 Jan 2012 11:15:58 +0800
Message-ID: <1327115758.7922.30.camel@yhuang-dev>
References: <20120121021318.14723.45698.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49382 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715Ab2AUDQQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2012 22:16:16 -0500
In-Reply-To: <20120121021318.14723.45698.stgit@amt.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@redhat.com>, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, bhelgaas@google.com, trenn@suse.de, linux-kernel@vger.kernel.org

On Fri, 2012-01-20 at 19:13 -0700, Myron Stowe wrote:
> I recently submitted a patch series that re-factored some existing
> work that Huang Ying introduced adding support for accessing ACPI
> generic registers, backed by Memory Mapped I/O (MMIO), while within
> interrupt context:
>   Original series: http://marc.info/?l=linux-acpi&m=128769263327206&w=2
>   Follow on series: http://marc.info/?l=linux-kernel&m=132070825520957&w=2
> 
> An underlying goal has been to re-factor ./drivers/acpi/atomicio.c into
> ./drivers/acpi/osl.c, providing equivalent functionality but in a more
> generalized manner, to allow usage in non-specific (i.e. APEI) contexts
> and remove atomicio.c.
> 
> In the most recent follow on series, there ended up being additions to
> atomicio.c that coincided with the attempt to remove it and as such, the
> series final removal patch could not be taken without first pulling the
> additions into osl.c.  The fact that the follow on series conversion
> patch - commit 700130b41f4 - was taken has inadvertently created
> regressions with respect to the recent atomicio.c additions due to the
> conversion patch effectively making atomicio.c obsolete.
> 
> The additions were commit 04c25997c97 "ACPI, Add 64bit read/write
> support to atomicio on i386" and commit 76da3fb3575 "ACPI, Add RAM
> mapping support to ACPI atomic IO support".
> 
> This patch series addresses both of these issues, bringing in the
> additional functionality into the re-factored files (apei-base.c and
> osl.c) and then again, reintroduces the patch to remove
> ./drivers/acpi/atomicio.[ch].
> ---
> 
> Myron Stowe (3):
>       ACPI: Remove ./drivers/acpi/atomicio.[ch]

It appears there is no one uses atomicio.[ch] now.  So I think it is
safe to push this into 3.3.

>       ACPI, APEI: Add RAM mapping support to ACPI
>       ACPI, APEI: Add 64-bit read/write support for APEI on i386

These two patches are just fixes.  So I think we should push these two
patches into 3.3.

Len, Do you agree?

Best Regards,
Huang Ying


