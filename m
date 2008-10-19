From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI support in Linux?
Date: Sun, 19 Oct 2008 10:59:08 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858032E07D1@orsmsx503.amr.corp.intel.com>
References: <f188924b0810190404j17e7cb7bo970c7f73ef54fc5a@mail.gmail.com>
 <48FB4953.2050809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19615 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbYJSR7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Oct 2008 13:59:14 -0400
In-Reply-To: <48FB4953.2050809@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>, "Fred ." <eldmannen@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Linux uses a very recent version of ACPICA, which supports ACPI 3.0b

The iASL compiler mostly supports 3.0b, although there are a few features that have yet to be implemented -- so the compiler only advertises that it supports 3.0a

Bob


-----Original Message-----
From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Alexey Starikovskiy
Sent: Sunday, October 19, 2008 7:51 AM
To: Fred .
Cc: linux-acpi@vger.kernel.org
Subject: Re: ACPI support in Linux?


Fred . wrote:
> Which version of the ACPI spec does Linux support?
> Is it true that it only supports 2.0?
>
>
Linux supported 3.0b well before it was published.
See include/acpi/acconfig.h:
/* Version of ACPI supported */
#define ACPI_CA_SUPPORT_LEVEL           3
> ACPI specification, 3.0b, been out since October 10, 2006.
> Linux still does not have support for it?
>
Do you see any feature not implemented of what?

Regards,
Alex.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
