From: "Wu, Cody" <cody.wu@intel.com>
Subject: RE: How ACPI is actually implemented?
Date: Tue, 28 Nov 2006 09:19:27 +0800
Message-ID: <3E68BD4534D7FC4995E20ECE949EA0C77EA34E@pdsmsx412.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57902 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1757224AbWK1BTe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 20:19:34 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yuan, Kein" <kein.yuan@intel.com>, Len Brown <lenb@kernel.org>, Eric Benton <benton71@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi Kein,

>The SCI handler, which will run a GPE handler as you said here,  Who is
>belongs to? I mean, is it part of OS? Or BIOS?  ACPI spec seems says if
>the OS is ACPI compatible and ACPI was enabled,  EC will trigger SCI,
>then handled by OS otherwise it will trigger SMI which handled by BIOS,
>is this true?

GPE handler is provided by Bios originally in the form of AML. Os's AcPI
driver will parse it and link it to SCI interrupt processing. Whether EC
will trigger SCI or SMI depends on how you want it to be done as well as
what OS you are working with. For OS supporting ACPI it will enable ACPI
controller on the chipset and SCI will take precedence over SMI.

>Does it means every time if need to verify the ASL is correct or not,
>you need to build the BIOS again and program the binary to FWH?   Is
>there any quicker way to do that? Or in another words, what's the
normal
>way/steps to debug ASL?

This is the rawest form of debugging ACPI. However, different OS may
provide different strategies to facilitate this process. I don't know
how Linux handles this but on Windows they can enable you to muck about
this with Registry and WinDbg.

Best regards,
Cody

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Yuan, Kein
Sent: Tuesday, November 28, 2006 9:08 AM
To: Len Brown; Eric Benton
Cc: linux-acpi@vger.kernel.org
Subject: RE: How ACPI is actually implemented?

> eg. the SCI handler might run a GPE handler, which will run the _Lxx
> method in AML, which might send a Notify() to an AML device object.
> The OS might have registered a driver on that object which
> will receive the event and do some action, such as sending an event
> to user-space.  see button.c for an even simpler example.

The SCI handler, which will run a GPE handler as you said here,  Who is
belongs to? I mean, is it part of OS? Or BIOS?  ACPI spec seems says if
the OS is ACPI compatible and ACPI was enabled,  EC will trigger SCI,
then handled by OS otherwise it will trigger SMI which handled by BIOS,
is this true?

>> I read that the BIOS supplies all the ACPI tables.
>> 3. Are they are being built in compile time (this is what I
understand
>> from the FAQ at Intel's website)?

> the ACPI tables are built by the OEM and with an ASL->AML compiler
> and are burned into the BIOS.

Does it means every time if need to verify the ASL is correct or not,
you need to build the BIOS again and program the binary to FWH?   Is
there any quicker way to do that? Or in another words, what's the normal
way/steps to debug ASL?

Thanks,

Kein
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
