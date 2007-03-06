From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Fixing DSDT table for correct LID behavior
Date: Tue, 6 Mar 2007 15:17:13 -0800
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A40205FC35@orsmsx415.amr.corp.intel.com>
References: <45ECB866.6010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11502 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030679AbXCFXRR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Mar 2007 18:17:17 -0500
Content-class: urn:content-classes:message
In-Reply-To: <45ECB866.6010201@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Renato Alves <simpledark@gmail.com>, linux-acpi@vger.kernel.org

Probably, the intended statement was

And (0xFE, Local7, Local7)

This type of thing should certainly be reported to the vendor.

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Renato Alves
> Sent: Monday, March 05, 2007 4:40 PM
> To: linux-acpi@vger.kernel.org
> Subject: Fixing DSDT table for correct LID behavior
> 
> Hi guys.
> 
> This is my first message to the mailing list.
> I'm still new to the ACPI and DSDT mambo jumbo and not a programmer,
but
> anyway... I tried to debug the dsdt of my laptop (Acer Aspire 1694
LMi)
> to solve some of the typical problems (no BAT info, boot hangs...). So
> far, by using a mixture of the custom DSDTs at acpi.sf.net I managed
to
> solve the BAT issues and the boot hangs.
> Using iasl I got only one warning, that I don't know how to solve:
> 
> dsdt.custom.dsl  7598:                             And (0xFE, Local7)
> Warning  1104 -          Result is not used, operator has no effect ^
> 
> Past this, I now have the system with thermal support in passive mode
> (no throttling), no fan info (no rpm, no throttling, no nothing),
> ac_adapter is fine, button power and sleep are fine, lid works but I
> will get back to it later, processor is also fine (with throttling)
and
> battery is also fine except for present rate when charging.
> 
> Now the LID: the problem with this is the number of events generated.
> The ideal behavior would be 1 event on lid close and 1 on lid open.
But
> actually what happens is 5 events per second when the lid is closed.
> This causes high CPU loads when software like cpufreq parses the logs
> and huge logs by acpid.
> 
> I was hoping someone could tip me on how to reduce the number of
events
> generated to prevent this flooding. And enlighten about the
possibility
> of getting the fan and thermal parts working "non-passive".
> 
> Here is a copy of what I have been working on:
> http://apollo.dq.fct.unl.pt/~al1133/dsdt.tar.bz2
> 
> Thanks
> --
> Renato Alves
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
