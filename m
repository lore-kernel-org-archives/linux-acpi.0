From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables via initrd
Date: Fri, 23 Mar 2012 16:51:07 +0100
Message-ID: <201203231651.08143.trenn@suse.de>
References: <1332512984-79664-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332512984-79664-1-git-send-email-trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.piel@tremplin-utc.net
Cc: vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, hpa@zytor.com
List-Id: linux-acpi@vger.kernel.org

Hi,

On Friday, March 23, 2012 03:29:44 PM Thomas Renninger wrote:
> Details can be found in:
> Documentation/acpi/initrd_table_override.txt
...

I should have mentioned that this work depends on ACPICA changes
which have been applied in Len's ACPI next tree only/recently.
For example:
commit f7b004a17c9183f023796dea0d70284684ec000d
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Feb 14 18:31:56 2012 +0800

    ACPICA: Add acpi_os_physical_table_override interface

Thus this patch is intended to get merged through the ACPI
tree.

The patch is (in similar form, before some additional ACPICA
enhancements by Lin and Bob) in productive 12.1 openSUSE kernel.

Thanks,

   Thomas
