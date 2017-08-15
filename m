From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] ACPI/APEI: Add BERT data driver
Date: Tue, 15 Aug 2017 11:22:06 +0100
Message-ID: <87k225p1v5.fsf@e105922-lin.cambridge.arm.com>
References: <20170814165613.25561-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753419AbdHOKWJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Aug 2017 06:22:09 -0400
In-Reply-To: <20170814165613.25561-1-tony.luck@intel.com> (Tony Luck's message
        of "Mon, 14 Aug 2017 09:56:13 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tony,

"Luck, Tony" <tony.luck@intel.com> writes:

> From: Tony Luck <tony.luck@intel.com>
>
> The ACPI Boot Error Record Table provides a method for platform
> firmware to give information to the operating system about error
> that occurred prior to boot (of particular interest are problems
> that caused the previous OS instance to crash).
>
> The BERT table simply provides the size and address of the error
> record in BIOS reserved memory. In an earlier age we might have
> used /dev/mem to retrieve this error record, but many systems
> disable /dev/mem for security reasons.
>
> This driver provides read-only access to the data via a character
> special device "/dev/bert-data".

There is already a bert driver which prints the error record. Would it
make sense to integrate the character device there instead of creating a
new driver?

[...]

