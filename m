From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC PATCH] acpi: Use a more normal logging style for
 ACPI_<LEVEL> calls
Date: Tue, 29 Mar 2016 17:50:00 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4554A9@ORSMSX110.amr.corp.intel.com>
References: <1459222225.25110.58.camel@perches.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553D5@ORSMSX110.amr.corp.intel.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553F8@ORSMSX110.amr.corp.intel.com>
 <1459270591.25110.83.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32595 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbcC2RuE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Mar 2016 13:50:04 -0400
In-Reply-To: <1459270591.25110.83.camel@perches.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>



> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Tuesday, March 29, 2016 9:57 AM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: linux-acpi@vger.kernel.org; linux-kernel; devel@acpica.org
> Subject: Re: [RFC PATCH] acpi: Use a more normal logging style for
> ACPI_<LEVEL> calls
>=20
> On Tue, 2016-03-29 at 15:34 +0000, Moore, Robert wrote:
> > On the other hand, we removed AE_INFO from ACPI_INFO a while back, =
and
> > this may remove the necessity for the double parens.
>=20
> Hmm, maybe not. =A0It may be that MSVC's support for __VA_ARGS__ is a=
 bit
> unusual. =A0What's the minimum ACPICA msvc version required?

6 I think.

The AE_INFO automatically injects the module name, line number, etc.

Compatibility across compilers is a major requirement for us.




--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
