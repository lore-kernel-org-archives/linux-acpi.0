From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v2] acpi: Use kstrtoul() instead of
 strtoul()/simple_strtoul()
Date: Wed, 29 Jul 2015 19:33:37 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D3294E8@ORSMSX112.amr.corp.intel.com>
References: <1438043542-2960-1-git-send-email-linux@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D329493@ORSMSX112.amr.corp.intel.com>
 <55B91DAF.3060605@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B91DAF.3060605@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Wednesday, July 29, 2015 11:39 AM
> To: Moore, Robert; rjw@rjwysocki.net
> Cc: lenb@kernel.org; Zheng, Lv; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; devel@acpica.org
> Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of
> strtoul()/simple_strtoul()
> 
> On 07/29/2015 10:51 AM, Moore, Robert wrote:
> >
> >
> >> -----Original Message-----
> >> From: Guenter Roeck [mailto:linux@roeck-us.net]
> >> Sent: Monday, July 27, 2015 5:32 PM
> >> To: rjw@rjwysocki.net
> >> Cc: lenb@kernel.org; Moore, Robert; Zheng, Lv;
> >> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> devel@acpica.org; Guenter Roeck
> >> Subject: [PATCH v2] acpi: Use kstrtoul() instead of
> >> strtoul()/simple_strtoul()
> >>
> >> simple_strtoul() is deprecated; replace with kstrtoul() and
> kstrtouint().
> >
> > The ACPICA code is os-independent and cannot use these functions (at
> least not directly).
> >
> >
> Odd argument, given that kstrtoul() is used already in the acpi code.

They are not in the os-independent ACPICA code. The ACPI-related drivers are another story, since they are OS-dendent.




> 
> Guenter
