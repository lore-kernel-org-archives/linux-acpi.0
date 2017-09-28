From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: linux-4.14-rc2/drivers/acpi/acpica/utmath.c: 2 * suspicious
 expression ?
Date: Thu, 28 Sep 2017 02:58:40 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF6DECD@SHSMSX101.ccr.corp.intel.com>
References: <VI1PR0802MB2336780579C44CE8DA2DD5CF9C7A0@VI1PR0802MB2336.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44686 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbdI1C6p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Sep 2017 22:58:45 -0400
In-Reply-To: <VI1PR0802MB2336780579C44CE8DA2DD5CF9C7A0@VI1PR0802MB2336.eurprd08.prod.outlook.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Binderman <dcb314@hotmail.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, David

Not a fancy way, but just a bit clearing.
OK, style is changed here:
https://github.com/acpica/acpica/pull/321
And bug is recorded here:
https://bugs.acpica.org/show_bug.cgi?id=1422

Thanks for the report.

Best regards
Lv

> From: David Binderman [mailto:dcb314@hotmail.com]
> Subject: linux-4.14-rc2/drivers/acpi/acpica/utmath.c: 2 * suspicious expression ?
> 
> Hello there,
> 
> [linux-4.14-rc2/drivers/acpi/acpica/utmath.c:137] -> [linux-4.14-rc2/drivers/acpi/acpica/utmath.c:137]:
> (style) Same expression on both sides of '^='.
> [linux-4.14-rc2/drivers/acpi/acpica/utmath.c:174] -> [linux-4.14-rc2/drivers/acpi/acpica/utmath.c:174]:
> (style) Same expression on both sides of '^='.
> 
>     operand_ovl.part.lo ^= operand_ovl.part.lo;
> 
> Is this just a fancy way to zero the field or should something more clever
> be happening ?
> 
> Regards
> 
> David Binderman
> 
