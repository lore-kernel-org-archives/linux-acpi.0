From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 3/4] ACPI / APEI: Drop uninformative messages during boot
Date: Thu, 20 Jul 2017 18:50:51 +0100
Message-ID: <87shhrknes.fsf@e105922-lin.cambridge.arm.com>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
        <20170720110402.15313-4-punit.agrawal@arm.com>
        <20170720111732.GC18515@nazgul.tnic>
        <87d18vmgv6.fsf@e105922-lin.cambridge.arm.com>
        <20170720135446.GA20641@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753881AbdGTRux (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jul 2017 13:50:53 -0400
In-Reply-To: <20170720135446.GA20641@nazgul.tnic> (Borislav Petkov's message
        of "Thu, 20 Jul 2017 15:54:46 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Borislav Petkov <bp@suse.de> writes:

> On Thu, Jul 20, 2017 at 01:29:17PM +0100, Punit Agrawal wrote:
>> I agree that where there is a genuine problem, relevant messages can
>> help to diagnose the problem. But what's printed now doesn't fit the
>> criteria.
>
> So make it fit the criteria. Change the code to not issue that message
> when the platform doesn't have those tables. But keep it in the
> remaining cases, when the tables are there.
>
> You can't be removing useful error messages just because your platform
> doesn't have the tables.

Fair point! I'll focus on quiescing the messages when the tables are not
present.

Inspired by your suggestion, I tried the following diff instead of
$SUBJECT.

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 456b488eb1df..f7784d9514e1 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -233,8 +233,9 @@ void __init acpi_hest_init(void)
        status = acpi_get_table(ACPI_SIG_HEST, 0,
                                (struct acpi_table_header **)&hest_tab);
        if (status == AE_NOT_FOUND)
-           goto err;
-   else if (ACPI_FAILURE(status)) {
+         return;
+
+ if (ACPI_FAILURE(status)) {
                const char *msg = acpi_format_exception(status);
                pr_err(HEST_PFX "Failed to get table, %s\n", msg);
                rc = -EINVAL;

This landed me a new message not seen before -

[    3.232940] GHES: Failed to enable APEI firmware first mode.

On further digging, this message is printed on platforms not supporting
the legacy WHEA stuff, when the APEI Support bit is not set in the
platform wide _OSC capabilities.

To make this message a bit less alarming, I can modify it to something
like -

"Firmware does not support APEI firmware first mode"

Thoughts?
