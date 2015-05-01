From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 15/17] ACPICA/ARM: ACPI 5.1: Update for GTDT table changes.
Date: Fri, 1 May 2015 17:43:39 -0500
Message-ID: <CAOZdJXU6vENaPJdwt6VBOwWrZ5tcjqk4k4uxBX2T5QPUDCgo7A@mail.gmail.com>
References: <cover.1406689493.git.lv.zheng@intel.com>
	<a3f86a5075c565002cd4bed0befb7d167fa0f105.1406689494.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48831 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbbEAWnn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 May 2015 18:43:43 -0400
In-Reply-To: <a3f86a5075c565002cd4bed0befb7d167fa0f105.1406689494.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Bob Moore <robert.moore@intel.com>

On Tue, Jul 29, 2014 at 11:21 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> New fields and new subtables. Tomasz Nowicki.
> tomasz.nowicki@linaro.org
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Hi, I know this patch is old, but something confuses me about it:

> +/* Common GTDT subtable header */
> +
> +struct acpi_gtdt_header {
> +       u8 type;
> +       u16 length;
> +};

I'm trying to write a function that parses the watchdog structure
(acpi_gtdt_watchdog).  The first entry in that structure is
acpi_gtdt_header.  Looking at the ACPI specification, I see that this
is correct: the type is one byte, and the length is two bytes.

However, this means that I cannot use acpi_parse_entries() to parse
the watchdog subtable:

int __init
acpi_parse_entries(char *id, unsigned long table_size,
        acpi_tbl_entry_handler handler,
        struct acpi_table_header *table_header,
        int entry_id, unsigned int max_entries)

acpi_tbl_entry_handler takes an acpi_subtable_header as its first
parameter.  However, that structure looks like this:

struct acpi_subtable_header {
    u8 type;
    u8 length;
};

This is not compatible, so I'm confused now.  How do I properly parse
the watchdog subtable, if I cannot use acpi_parse_entries?

For context, here is my patch:

http://www.spinics.net/lists/linux-watchdog/msg06240.html

Scroll down to function arm_sbsa_wdt_parse_gtdt().  The typecast in
first line is invalid:

+    struct acpi_gtdt_watchdog *wdg = (struct acpi_gtdt_watchdog *)header;

because of the mismatch.  I don't know how to fix this.
