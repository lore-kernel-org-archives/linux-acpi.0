From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] acpi: Use a more normal logging style for
 ACPI_<LEVEL> calls
Date: Tue, 29 Mar 2016 09:12:09 -0700
Message-ID: <1459267929.25110.80.camel@perches.com>
References: <1459222225.25110.58.camel@perches.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553D5@ORSMSX110.amr.corp.intel.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553F8@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:47076 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751729AbcC2QMY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2016 12:12:24 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4553F8@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, 2016-03-29 at 15:34 +0000, Moore, Robert wrote:
> On the other hand, we removed AE_INFO from ACPI_INFO a while back, an=
d
> this may remove the necessity for the double parens.

Does remove the necessity.

I suppose I could look through the ACPICA sources and generate
the same patch in the ACPICA style.

I didn't manage to run the script that does the style
conversion though.

$ git clone git://github.com/acpica/acpica.git
$ cd acpica
$ make
$

now what?

Removing AE_INFO from ACPI_(WARNING|ERROR) (it seems there
are only a few uses without it and those uses seem
equivalent) is doable too.

=46or instance:

$ git grep -w ACPI_ERROR|grep -v AE_INFO
[]
source/components/utilities/utobject.c:=A0=A0=A0=A0=A0=A0=A0=A0ACPI_ERR=
OR ((ModuleName, LineNumber,
source/components/utilities/uttrack.c:=A0=A0=A0=A0=A0=A0=A0=A0ACPI_ERRO=
R ((Module, Line,
source/components/utilities/uttrack.c:=A0=A0=A0=A0=A0=A0=A0=A0ACPI_ERRO=
R ((Module, Line,
source/components/utilities/uttrack.c:=A0=A0=A0=A0=A0=A0=A0=A0ACPI_ERRO=
R ((Module, Line,
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
