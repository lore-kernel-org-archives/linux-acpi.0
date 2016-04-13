From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH v2 3/3] ACPI / tables: Convert the initrd table override
 mechanisms to the table upgrade mechanism
Date: Wed, 13 Apr 2016 19:01:36 +0300
Message-ID: <CAMoF9u2rwWF5ZguMHPti70C=vS33phUGWJGNbH-5ASp5CK58bg@mail.gmail.com>
References: <cover.1460340514.git.lv.zheng@intel.com>
	<b4bd2cb8102b66c034f94abae2969797d004f039.1460340514.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36520 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbcDMQBq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2016 12:01:46 -0400
Received: by mail-ig0-f179.google.com with SMTP id f1so124168816igr.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Apr 2016 09:01:41 -0700 (PDT)
In-Reply-To: <b4bd2cb8102b66c034f94abae2969797d004f039.1460340514.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Mon, Apr 11, 2016 at 5:13 AM, Lv Zheng <lv.zheng@intel.com> wrote:
>
> This patch converts the initrd table override mechanism to the table
> upgrade mechanism by restricting its usage to the tables released with
> compatibility and more recent revision.
>
> This use case has been encouraged by the ACPI specification:
> 1. OEMID:
>    An OEM-supplied string that identifies the OEM.
> 2. OEM Table ID:
>    An OEM-supplied string that the OEM uses to identify the particular data
>    table. This field is particularly useful when defining a definition
>    block to distinguish definition block functions. OEM assigns each
>    dissimilar table a new OEM Table Id.
> 3. OEM Revision:
>    An OEM-supplied revision number. Larger numbers are assumed to be newer
>    revisions.
> For OEMs, good practices will ensure consistency when assigning OEMID and
> OEM Table ID fields in any table. The intent of these fields is to allow
> for a binary control system that support services can use. Because many
> support function can be automated, it is useful when a tool can
> programatically determine which table release is a compatible and more
> recent revision of a prior table on the same OEMID and OEM Table ID.
>
> The facility can now be used by the vendors to upgrade wrong tables for bug
> fixing purpose, thus lockdep disabling taint is not suitable for it and it
> should be a default 'y' option to implement the spec encouraged use case.
>

I agree that we should not force lockdep disabling. I wonder if we
should add a new taint (like the one I proposed in the overlay patch
set) to see in bug reports that the ACPI tables have been modified.

Also, do we need a new config option? IMO it would be better if we can
keep the existing config option and do the following:

* if CONFIG_ACPI_INITRD_TABLE_OVERRIDE is set: allow arbitrary
overrides (preserve the current behavior)

* if CONFIG_ACPI_INITRD_TABLE_OVERRIDE is not set: allow upgrades
based on the revision number

* allow adding new tables regardless of CONFIG_ACPI_INITRD_TABLE_OVERRIDE
