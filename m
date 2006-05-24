From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.17-rc4-mm3 - kernel panic
Date: Wed, 24 May 2006 01:03:52 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42767 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932577AbWEXFD4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2006 01:03:56 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org
Cc: "Accardi, Kristen C" <kristen.c.accardi@intel.com>

Same panic with and without a docking station present?

Does the panic go away with CONFIG_ACPI_DOCK=n?

-Len

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Andreas Saur
>Sent: Tuesday, May 23, 2006 4:25 PM
>To: linux-acpi@vger.kernel.org
>Subject: 2.6.17-rc4-mm3 - kernel panic
>
>Hello,
>
>Still Kernel Panic in 2.6.17-rc4-mm3. Screen-shot here: 
>http://as68.homeip.net/2.6.17-rc4-mm3/
>Specs same as in here: http://as68.homeip.net/2.6.17-rc4-mm2/
>Just config changed a bit:
>#######
>CONFIG_X86_UP_APIC=y
>CONFIG_X86_UP_IOAPIC=y
>#######
>Again a namespacing thing with ACPI.
>What do I do wrong ?
>
>Regards,
>
>Andreas
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
