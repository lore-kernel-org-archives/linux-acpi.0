From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [ACPI] No APIC interrupts after ACPI suspend
Date: Mon, 28 Jun 2004 09:35:55 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <B44D37711ED29844BEA67908EAF36F032D5361@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264625AbUF1BgN@vger.kernel.org>
Content-class: urn:content-classes:message
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Currently we have no suspend/resume code for IOAPIC, we should add it.
For PIC mode, current 8259 resume code ignored IRQ level/edge trigger,
and it should be added.

Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
>admin@lists.sourceforge.net] On Behalf Of Matthew Garrett
>Sent: Monday, June 28, 2004 12:28 AM
>To: David Eriksson
>Cc: linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
>Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
>
>On Sat, 2004-06-26 at 18:42 +0200, David Eriksson wrote:
>
>> Maybe you've found this bug?
>>
>> http://bugme.osdl.org/show_bug.cgi?id=2643
>
>Yeah, that one was biting me, but it's not the one causing this bug.
>cat /proc/interrupts shows that the ACPI interrupt is correctly set to
>level triggered, but the ioapic isn't set up correctly so no interrupts
>make it through. The same seems to be true for all other
level-triggered
>interrupts.
>
>--
>Matthew Garrett | mjg59@srcf.ucam.org
>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by Black Hat Briefings & Training.
>Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
>digital self defense, top technical experts, no vendor pitches,
>unmatched networking opportunities. Visit www.blackhat.com
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
