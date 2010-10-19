From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi: remove dead code
Date: Tue, 19 Oct 2010 00:07:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010190006100.2932@localhost.localdomain>
References: <20101018084248.23262ba6@nehalam>
 <alpine.LFD.2.00.1010181239110.2932@localhost.localdomain>
 <AANLkTinb_xkyy4Qyb9r2N+f1BizJZ_QmNveUg+L2jG2U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1041939539-1287461244=:2932"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:63017 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab0JSEH1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Oct 2010 00:07:27 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAI00ADLRGEXDD0@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 18 Oct 2010 23:07:27 -0500 (CDT)
In-reply-to: <AANLkTinb_xkyy4Qyb9r2N+f1BizJZ_QmNveUg+L2jG2U@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <lin@ming.vg>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1041939539-1287461244=:2932
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 19 Oct 2010, Lin Ming wrote:

> On Tue, Oct 19, 2010 at 12:49 AM, Len Brown <lenb@kernel.org> wrote:
> > On Mon, 18 Oct 2010, Stephen Hemminger wrote:
> >
> >> Found by running make namespacecheck on linux-next
> >>
> >> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> >>
> >> --- a/drivers/acpi/osl.c      2010-10-06 13:42:58.722974685 +0900
> > ...
> >>  /*
> >> - * Allocate the memory for a spinlock and initialize it.
> >> - */
> >> -acpi_status acpi_os_create_lock(acpi_spinlock * handle)
> >> -{
> >> -     spin_lock_init(*handle);
> >> -
> >> -     return AE_OK;
> >> -}
> >
> > ACPICA declares acpi_os_create_lock in acpiosxf.h,
> > but never calls it.  Bob, can we do away with it?
> 
> In ACPICA code (AcpiUtMutexInitialize),
> 
>     Status = AcpiOsCreateLock (&AcpiGbl_GpeLock);
>     if (ACPI_FAILURE (Status))
>     {
>         return_ACPI_STATUS (Status);
>     }
> 
>     Status = AcpiOsCreateLock (&AcpiGbl_HardwareLock);
>     if (ACPI_FAILURE (Status))
>     {
>         return_ACPI_STATUS (Status);
>     }
> 
> In Linux code (acpi_ut_mutex_initialize)
> 
>         spin_lock_init(acpi_gbl_gpe_lock);
>         spin_lock_init(acpi_gbl_hardware_lock);
> 
> This is another divergence between ACPICA and Linux code.

Lin-Ming,

Thanks for the explanation.

I've applied Stephen's patch, since it is correct.
If you later want to send me patches to reduce the divergence
between ACPICA and Linux/ACPICA, I'll be happy to accept them.

thanks,
Len Brown, Intel Open Source Technology Center
--8323328-1041939539-1287461244=:2932--
