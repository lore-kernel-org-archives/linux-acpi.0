From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 18/19] ACPICA: ACPI 6.0: Add support for NFIT table.
Date: Fri, 22 May 2015 23:53:22 +0200
Message-ID: <12469206.tLADqhMg71@vostro.rjw.lan>
References: <cover.1432175162.git.lv.zheng@intel.com> <555F4884.4090805@hp.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EED6B@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EED6B@ORSMSX112.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Linda Knippers <linda.knippers@hp.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, May 22, 2015 03:28:04 PM Moore, Robert wrote:
> Yes, you are correct, the NFIT strings are wrong. For example, the first string for UUID_VOLATILE_MEMORY should be:
> 
> 
> "7305944F-FDDA-44E3-B16C-3F22D252E5D0"
> 
> You might want to verify this.
> 
> We will fix the original patch ASAP.

I'm guessing I should receive the fix from Lv early next week then.

Is that correct?

Rafael
