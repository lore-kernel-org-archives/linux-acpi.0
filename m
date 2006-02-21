From: Andrew Morton <akpm@osdl.org>
Subject: Fw: x86_64 ACPI Error in 2.6.16-rc4-mm1
Date: Mon, 20 Feb 2006 22:03:01 -0800
Message-ID: <20060220220301.69996123.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:31195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161387AbWBUGEk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 01:04:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kevin Winchester <kwin@ns.sympatico.ca>



Begin forwarded message:

Date: Mon, 20 Feb 2006 20:13:59 -0400
From: Kevin Winchester <kwin@ns.sympatico.ca>
To: linux-kernel@vger.kernel.org
Subject: x86_64 ACPI Error in 2.6.16-rc4-mm1



I have the following little message in my log with rc4-mm1 that I don't 
have with vanilla rc4, running on a single processor athlon 64 box:

ACPI Error (acpi_processor-0488): Getting cpuindex for acpiid 0x1 [20060210]

It apparently gets printed here (in drivers/acpi/processor_core.c):

        /*
         *  Extra Processor objects may be enumerated on MP systems with
         *  less than the max # of CPUs. They should be ignored _iff
         *  they are physically not present.
         */
        if (cpu_index >= NR_CPUS) {
                if (ACPI_FAILURE
                    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
                        ACPI_ERROR((AE_INFO,
                                    "Getting cpuindex for acpiid 0x%x",
                                    pr->acpi_id));
                        return_VALUE(-ENODEV);
                }
        }

It doesn't seem to cause anything not to work, but I thought I'd mention 
it anyway.  If it is obvious to anyone why I get the message, I won't 
have to try to bisect the patches.

I can send my config if anyone wants to see it, and I can also test 
patches.  I'm not subscribed to the list, so please CC me.

Thanks,
Kevin Winchester


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
