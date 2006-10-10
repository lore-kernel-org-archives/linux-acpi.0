From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 11/12] Fix up a multitude of ACPI compiler warnings on
 x86_64
Date: Tue, 10 Oct 2006 18:13:20 -0400
Message-ID: <452C1B00.7050305@garzik.org>
References: <200610102120.k9ALKjNc024296@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46808 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030573AbWJJWN0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 18:13:26 -0400
In-Reply-To: <200610102120.k9ALKjNc024296@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, mbligh@google.com

akpm@osdl.org wrote:
> From: Martin Bligh <mbligh@google.com>
> 
> 32bit vs 64 bit issues.  sizeof(sizeof) and sizeof(pointer) is variable,
> but we're trying to shove it into unsigned int or u32.
> 
> Casts to unsigned long are used because type acpi_thread_id can be any one of
> 
> typedef u64 acpi_native_uint;
> typedef u32 acpi_native_uint;
> typedef u16 acpi_native_uint;
> #define acpi_thread_id struct task_struct *
> 
> Signed-off-by: Martin J. Bligh <mbligh@google.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/executer/exmutex.c  |    6 +++---
>  drivers/acpi/utilities/utdebug.c |    5 +++--
>  drivers/acpi/utilities/utmutex.c |   16 +++++++++-------
>  3 files changed, 15 insertions(+), 12 deletions(-)

ACK


