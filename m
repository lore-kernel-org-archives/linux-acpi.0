From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: RE: 2.6.17-rc4-mm3 - kernel panic
Date: Thu, 25 May 2006 09:52:36 -0700
Message-ID: <1148575956.3070.15.camel@whizzy>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60525 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030260AbWEYQlo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 May 2006 12:41:44 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org


On Tue, 2006-05-23 at 22:03 -0700, Brown, Len wrote:
> Same panic with and without a docking station present?
> 
> Does the panic go away with CONFIG_ACPI_DOCK=n?
> 
> -Len
> 

Hi, I believe this is an issue with the docking station code, I have
another report of this panic as well from a different user.  I can't
duplicate it on my machine, however, I am looking into it today and will
send out some test patches that hopefully someone can try to see if they
fix the issue.

Thanks,
Kristen

> >-----Original Message-----
> >From: linux-acpi-owner@vger.kernel.org 
> >[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Andreas Saur
> >Sent: Tuesday, May 23, 2006 4:25 PM
> >To: linux-acpi@vger.kernel.org
> >Subject: 2.6.17-rc4-mm3 - kernel panic
> >
> >Hello,
> >
> >Still Kernel Panic in 2.6.17-rc4-mm3. Screen-shot here: 
> >http://as68.homeip.net/2.6.17-rc4-mm3/
> >Specs same as in here: http://as68.homeip.net/2.6.17-rc4-mm2/
> >Just config changed a bit:
> >#######
> >CONFIG_X86_UP_APIC=y
> >CONFIG_X86_UP_IOAPIC=y
> >#######
> >Again a namespacing thing with ACPI.
> >What do I do wrong ?
> >
> >Regards,
> >
> >Andreas
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe 
> >linux-acpi" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
