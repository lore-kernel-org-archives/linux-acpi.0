From: "Yuan, Kein" <kein.yuan@intel.com>
Subject: RE: How ACPI is actually implemented?
Date: Tue, 28 Nov 2006 09:07:47 +0800
Message-ID: <0E6B8CEB89DCFE40A52F80EB8F97D99D0B6104@pdsmsx413.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11572 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S935033AbWK1BH4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 20:07:56 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Eric Benton <benton71@gmail.com>
Cc: linux-acpi@vger.kernel.org

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
