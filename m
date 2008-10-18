From: "Moore, Robert" <robert.moore@intel.com>
Subject: ACPICA header files
Date: Sat, 18 Oct 2008 09:33:54 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858032E0739@orsmsx503.amr.corp.intel.com>
References: <200810171449.m9HEnoHM018514@los-vmm.sc.intel.com>
 <4911F71203A09E4D9981D27F9D830858032E0245@orsmsx503.amr.corp.intel.com>
 <alpine.LFD.1.10.0810171653510.3006@localhost.localdomain>
 <4911F71203A09E4D9981D27F9D830858032E0503@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44291 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbYJRQd6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Oct 2008 12:33:58 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858032E0503@orsmsx503.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Dugger, Donald D" <donald.d.dugger@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "astarikovskiy@suse.de" <astarikovskiy@suse.de>, "Lin, Ming M" <ming.m.lin@intel.com>

The actual "public" acpica headers are:

acexcep.h    // ACPICA exceptions
actypes.h    // ACPICA data types
actbl.h      // ACPI table definitions
acpixf.h     // Prototypes for ACPICA interfaces (host-to-ACPICA)
acpiosxf.h   // Prototypes for OSL interfaces (ACPICA-to-host)

And the entire contents of the include/platform directory

Would it make sense (would it be helpful) to leave these public headers in the current acpi include directory and to move everything else to a new directory?

How about include/internal.

We could keep the existing acpi.h file and have it only pull in the files above, so the disruption to existing acpica users would be minimal. The only code that would be affected would be code that is cheating by using ACPICA internal interfaces.

It may be the case that some internal functions are actually useful to the ACPI-related device drivers. I don't have any issue with making these interfaces public (and beefing up the parameter validation, etc.)

Comments?
Thanks,
Bob



-----Original Message-----
From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Moore, Robert
Sent: Friday, October 17, 2008 2:50 PM
To: Len Brown
Cc: Dugger, Donald D; linux-acpi@vger.kernel.org; bjorn.helgaas@hp.com; akpm@linux-foundation.org; astarikovskiy@suse.de; Lin, Ming M
Subject: RE: [PATCH] Fix possible null ptr dereference

It's on the TBD list.

Not true that everything includes everything, however. But everything is in the same directory.

How would you organize things?


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Len Brown
>Sent: Friday, October 17, 2008 1:55 PM
>To: Moore, Robert
>Cc: Dugger, Donald D; linux-acpi@vger.kernel.org; bjorn.helgaas@hp.com;
>akpm@linux-foundation.org; astarikovskiy@suse.de; Lin, Ming M
>Subject: RE: [PATCH] Fix possible null ptr dereference
>
>
>> In general, the internal ACPICA functions do not perform nearly as much
>parameter validation as the external functions. The Host OS should not be
>calling any of the ACPICA internal functions for this and a few other good
>reasons -- such as the fact that internal functions can disappear, be
>renamed, or have the parameters changed without warning at any time.
>>
>> It would probably be a good idea to audit Linux for the use of internal
>ACPICA functions and fix these bugs.
>
>I think the way to do this is to clean up the headers
>so that code outside of ACPICA doesn't even see
>the declarations of the internal ACPICA functions.
>
>Right now everything includes everything, so the headers can't help us.
>
>-Len
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
