From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Mon, 12 Dec 2011 10:37:26 +0100
Message-ID: <20111212103726.56422cbb@endymion.delvare>
References: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
	<1322531323.1467.10.camel@minggr>
	<CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
	<1323396109.27764.44.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:32297 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1LLJhl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2011 04:37:41 -0500
In-Reply-To: <1323396109.27764.44.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, linux-acpi@vger.kernel.org, lenb <lenb@kernel.org>

Hi Lin,

On Fri, 09 Dec 2011 10:01:49 +0800, Lin Ming wrote:
> On Tue, 2011-11-29 at 21:18 +0800, Luca Tettamanti wrote:
> > On Tue, Nov 29, 2011 at 2:48 AM, Lin Ming <ming.m.lin@intel.com> wrote:
> > > Yes, we should put the call back.
> > 
> > Great, are you going to push this patch yourself?
> 
> We have investigated this issue more and think that it's better to move
> the resource validation code into ACPICA core.
> 
> Here is the new patch.
> 
> The major changes include:
> - Remove acpi_os_validate_address/acpi_os_invalidate_address from osl.c.
>   They are reimplemented in ACPICA core: 
>   acpi_ut_add_address_range/acpi_ut_remove_address_range.
> 
> - Add new interface for drivers to check resource conflict:
>   acpi_check_address_range
> 
> Could you help to test it?

I have no objection for an upstream patch, but the main problem we have
at the moment is with already released kernels. Versions 2.6.39, 3.0
and 3.1 currently have a regression as the ACPI resource conflict
checks are inefficient, and this allows conflicting drivers to be
loaded together. So you are free to reimplement things differently in
version 3.2 and later, but for these 3 older versions we need the
smallest possible patch, so that it is accepted in stable branches.

In other words, I would like two patches, one just adding back the code
that was accidentally dropped, and a second one moving things around if
you think it makes sense (and I tend to agree.) That way we can easily
backport only the first patch to kernel versions 2.6.39 to 3.1.

Thanks,
Jean

> Thanks,
> Lin Ming
> ---
>  drivers/acpi/acpica/Makefile    |    2 +-
>  drivers/acpi/acpica/acconfig.h  |    4 +
>  drivers/acpi/acpica/acglobal.h  |    2 +
>  drivers/acpi/acpica/aclocal.h   |    9 ++
>  drivers/acpi/acpica/acutils.h   |   18 +++
>  drivers/acpi/acpica/dsargs.c    |    7 +
>  drivers/acpi/acpica/utaddress.c |  295 +++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/acpica/utdelete.c  |   13 +-
>  drivers/acpi/acpica/utglobal.c  |    6 +
>  drivers/acpi/acpica/utinit.c    |    1 +
>  drivers/acpi/acpica/utxface.c   |   38 +++++
>  drivers/acpi/osl.c              |  202 ++-------------------------
>  include/acpi/acpixf.h           |    5 +
>  13 files changed, 406 insertions(+), 196 deletions(-)
> (...)

-- 
Jean Delvare
