From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: AcpiGetSleepTypeData: Failure to find \_Sx
 should not result in a loud warning [v2]
Date: Sat, 10 Oct 2015 01:37:35 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC6C12@SHSMSX101.ccr.corp.intel.com>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37D36303A@ORSMSX112.amr.corp.intel.com>
 <1444243849-27929-1-git-send-email-prarit@redhat.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D970F57@ORSMSX111.amr.corp.intel.com>
 <56167C58.8000405@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E883BAC675E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BAC67EE@SHSMSX101.ccr.corp.intel.com>
 <5617A525.2070806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11240 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbbJJBh4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2015 21:37:56 -0400
In-Reply-To: <5617A525.2070806@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, "Moore, Robert" <robert.moore@intel.com>, "devel@acpica.org" <devel@acpica.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

Hi,

> From: Prarit Bhargava [mailto:prarit@redhat.com]
> Sent: Friday, October 09, 2015 7:30 PM
> 
> On 10/09/2015 01:26 AM, Zheng, Lv wrote:
> > Please ignore this.
> > The fix is against the caller.
> >
> > Thanks and best regards
> > -Lv
> >
> >> From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Zheng, Lv
> >> Sent: Friday, October 09, 2015 10:02 AM
> >>
> >> Why don't you fix this in the invoker side?
> >> For example:
> >> If (acpi_get_handle())
> >> 	acpi_evaluate_object()
> 
> That seems like a sloppy workaround an actual bug in ACPICA.

So let me ignore this which is a reply for a useless question.

> 
> >> So that the AE_NOT_FOUND warning can still be kept for the real troubles?
> 
> The code is warning 100% of the time on something that is optional.

Let me ignore this which is a reply for a useless question.

> 
> >> There are really scenarios that such warning is useful for catching bugs.
> >>
> 
> What scenario is possible where this causes a problem?  Issuing an error on
> something that is optional is not a good idea.

There are several scenarios, let me say some known stuffs about the module level code support.
In AML grammar, module level code (non-object-definition AML opcodes outside of a control method) is legal.
While it is supported in ACPICA in a split way:
1. In the early stage, table loading code only executes those object definition opcodes and links all "if/else/while" AML fragments together.
2. In the late stage, object initialization code will execute such AML fragments before invoking all _INI methods.

1. Since code is not executed in the Windows compliant order during the early table loading stage, some objects are not defined while they should.
2. Even worse, during the early stage, ACPICA may fail the whole table loading process due to AE_NOT_FOUND, leaving us partial initialized objects (the ACPICA AML interpreter implements 2 phases to parse a table to complete the table loading).
Such issue is worked around by deleting the namespace objects created during the early stage if an exception (AE_NOT_FOUND) is encountered.

So you can see, such kind of error is sometime useful for catching AML interpreter issues or BIOS bugs.

Thanks and best regards
-Lv
