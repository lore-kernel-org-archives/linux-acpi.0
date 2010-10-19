From: Lin Ming <lin@ming.vg>
Subject: Re: [PATCH] acpi: remove dead code
Date: Tue, 19 Oct 2010 08:42:36 +0800
Message-ID: <AANLkTinb_xkyy4Qyb9r2N+f1BizJZ_QmNveUg+L2jG2U@mail.gmail.com>
References: <20101018084248.23262ba6@nehalam>
	<alpine.LFD.2.00.1010181239110.2932@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62447 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab0JSAmh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Oct 2010 20:42:37 -0400
Received: by wwj40 with SMTP id 40so498866wwj.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Oct 2010 17:42:36 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010181239110.2932@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-acpi@vger.kernel.org

On Tue, Oct 19, 2010 at 12:49 AM, Len Brown <lenb@kernel.org> wrote:
> On Mon, 18 Oct 2010, Stephen Hemminger wrote:
>
>> Found by running make namespacecheck on linux-next
>>
>> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
>>
>> --- a/drivers/acpi/osl.c =A0 =A0 =A02010-10-06 13:42:58.722974685 +0=
900
> ...
>> =A0/*
>> - * Allocate the memory for a spinlock and initialize it.
>> - */
>> -acpi_status acpi_os_create_lock(acpi_spinlock * handle)
>> -{
>> - =A0 =A0 spin_lock_init(*handle);
>> -
>> - =A0 =A0 return AE_OK;
>> -}
>
> ACPICA declares acpi_os_create_lock in acpiosxf.h,
> but never calls it. =A0Bob, can we do away with it?

In ACPICA code (AcpiUtMutexInitialize),

    Status =3D AcpiOsCreateLock (&AcpiGbl_GpeLock);
    if (ACPI_FAILURE (Status))
    {
        return_ACPI_STATUS (Status);
    }

    Status =3D AcpiOsCreateLock (&AcpiGbl_HardwareLock);
    if (ACPI_FAILURE (Status))
    {
        return_ACPI_STATUS (Status);
    }

In Linux code (acpi_ut_mutex_initialize)

        spin_lock_init(acpi_gbl_gpe_lock);
        spin_lock_init(acpi_gbl_hardware_lock);

This is another divergence between ACPICA and Linux code.

Lin Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
