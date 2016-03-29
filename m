From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] acpi: Use a more normal logging style for
 ACPI_<LEVEL> calls
Date: Tue, 29 Mar 2016 09:56:31 -0700
Message-ID: <1459270591.25110.83.camel@perches.com>
References: <1459222225.25110.58.camel@perches.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553D5@ORSMSX110.amr.corp.intel.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553F8@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:33681 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752976AbcC2Q4f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2016 12:56:35 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553F8@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, 2016-03-29 at 15:34 +0000, Moore, Robert wrote:
> On the other hand, we removed AE_INFO from ACPI_INFO a while back, an=
d
> this may remove the necessity for the double parens.

Hmm, maybe not. =A0It may be that MSVC's support for __VA_ARGS__ is
a bit unusual. =A0What's the minimum ACPICA msvc version required?

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
