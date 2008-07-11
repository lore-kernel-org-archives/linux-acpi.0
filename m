From: Zhang Rui <rui.zhang@intel.com>
Subject: [linux-next] [PATCH V2 0/4] ACPI: save/restore ACPI NVS memory
	during hiberntion
Date: Fri, 11 Jul 2008 13:29:05 +0800
Message-ID: <1215754145.1617.57.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31383 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbYGKF3z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jul 2008 01:29:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

=EF=BB=BFHi,

This is the second version of patches which save/restore ACPI NVS memor=
y
during hibernation.

According to the ACPI spec, ACPI NVS memory region is required to
be saved/restored by OS during hibernation.

Section 15.3.2 ACPI Spec 3.0b,
"OSPM will call the _PTS control method some time before entering
a sleeping state, to allow the platform=E2=80=99s AML code to update
this memory image before entering the sleeping state.
After the system awakes from an S4 state, OSPM will restore this
memory area and call the _WAK control method to enable the BIOS
to reclaim its memory image."

This patch set add the mechanism to save/restore ACPI NVS memory
during hibernation.

Patch 01: call platform_begin before swsusp_shrink_memory.
        So that we can allocate enough pages for ACPI NVS memory
        before shrink the memory.

Patch 02: introduce the mechanism to save/restore ACPI NVS memory.
       =20
Patch 03: mark the ACPI NVS memory region during startup.

Patch 04: introduce kernel parameter acpi_sleep=3Ds4_nvs_nosave
	  which prevents OS from saving/restoring ACPI NVS memory.

As patch 01 changes the generic code, I don't know if there are
any side effects introduced by this patch, and I'm not able to
test on other platforms.
But with Rafael's suggestion, patch 01 can be optionally dropped
because we can use the the I/O and spare pages reserved, which is
5MB at present and the NVS memory is usually tens of pages during
my test.

Any comments are welcome. :)

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
