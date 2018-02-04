From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] ACPI / x86: boot: Not all platforms require
 acpi_reduced_hw_init()
Date: Sun, 04 Feb 2018 16:14:44 +0200
Message-ID: <1517753684.7000.1509.camel@linux.intel.com>
References: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
         <3139601.BsU5hxGGNu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50256 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeBDOOr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 4 Feb 2018 09:14:47 -0500
In-Reply-To: <3139601.BsU5hxGGNu@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2018-02-04 at 09:54 +0100, Rafael J. Wysocki wrote:
> OTOH, I guess you'll go for the new init callbacks rather.

Yep, just ignore these two for now. I will remake it later.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
