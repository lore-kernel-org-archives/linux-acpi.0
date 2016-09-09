From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 09 Sep 2016 11:55:44 -0700
Message-ID: <1473447344.10509.3.camel@perches.com>
References: <20160909161253.30952-1-bp@alien8.de>
         <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
         <20160909184042.srv6jrio6s5umear@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:38120 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752015AbcIISzt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2016 14:55:49 -0400
In-Reply-To: <20160909184042.srv6jrio6s5umear@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Moore, Robert" <robert.moore@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Fri, 2016-09-09 at 20:40 +0200, Borislav Petkov wrote:
> On Fri, Sep 09, 2016 at 06:26:17PM +0000, Moore, Robert wrote:
> > Is this a big deal?
> > We do this on purpose for AcpiExec, to make the screen output more readable.
[]
> What do you mean "big deal"? All other ACPI_INFO calls don't have a "\n"
> at the end except this one. How does one "\n" make some output more
> readable?

Blank lines in logging/dmesg generally don't add value.

I would prefer if the unnecessary double parentheses also
were removed in these macro uses and ##__VA_ARGS__ was
used instead.

/*
 * Error reporting. Callers module and line number are inserted by AE_INFO,
 * the plist contains a set of parens to allow variable-length lists.
 * These macros are used for both the debug and non-debug versions of the code.
 */
#define ACPI_INFO(plist)                acpi_info plist
#define ACPI_WARNING(plist)             acpi_warning plist
#define ACPI_EXCEPTION(plist)           acpi_exception plist
#define ACPI_ERROR(plist)               acpi_error plist
#define ACPI_BIOS_WARNING(plist)        acpi_bios_warning plist
#define ACPI_BIOS_ERROR(plist)          acpi_bios_error plist

It would also be good if format/argument verification
was done here and in the non-debug macro variants.

#define ACPI_INFO(plist)
#define ACPI_WARNING(plist)
#define ACPI_EXCEPTION(plist)
#define ACPI_ERROR(plist)
#define ACPI_BIOS_WARNING(plist)
#define ACPI_BIOS_ERROR(plist)

