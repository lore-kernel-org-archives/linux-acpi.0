From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: RFC: Output ACPI info via sysfs
Date: Thu, 11 May 2006 13:41:02 -0400
Message-ID: <4463772E.20206@redhat.com>
References: <446350DE.9010900@redhat.com> <200605110945.17187.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:22152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030392AbWEKRlM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 May 2006 13:41:12 -0400
In-Reply-To: <200605110945.17187.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>


>   
> Does this (from a 4-CPU Intel Tiger) have some of the information
> you need?
>
>   
Yes, the lsapics are listed, which at least gives me an idea of the # of 
CPUs in the system ...

P.
> # ./acpidump -b -t APIC | ../madt/madt 
> ACPI: APIC (v001 INTEL  SR870BN4 0x01072002 MSFT 0x00010013) @ 0x(nil)
> ACPI: LSAPIC (acpi_id[0x00] lsapic_id[0xc6] lsapic_eid[0x18] enabled)
> ACPI: LSAPIC (acpi_id[0x01] lsapic_id[0xc2] lsapic_eid[0x18] enabled)
> ACPI: LSAPIC (acpi_id[0x02] lsapic_id[0xc4] lsapic_eid[0x18] enabled)
> ACPI: LSAPIC (acpi_id[0x03] lsapic_id[0xc0] lsapic_eid[0x18] enabled)
>   

