From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] ACPICA: Tables: Add deferred verification
 support
Date: Thu, 18 May 2017 16:01:30 +0200
Message-ID: <71329223-dbb4-2845-a14e-3db579ca552b@redhat.com>
References: <20170227093432.3308-1-hdegoede@redhat.com>
 <cover.1494916766.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753786AbdEROBd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 May 2017 10:01:33 -0400
In-Reply-To: <cover.1494916766.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Hi,

On 16-05-17 09:13, Lv Zheng wrote:
> On linux, we can not verify ACPI tables before installing them into the
> global table list in early stage due to the number of slot limitations for
> early ioremap. This leaves a problem that we cannot detect duplicated
> tables in early stage, causing unwanted error messages seen when the
> duplicated tables are failed to be loaded [link #1].
> 
> This patchset as ACPICA PR [link #2] adds support to verify tables in
> acpi_reallocate_root_tables() which is invoked after installing tables in
> early stage, being ready for late ioremap and beofre loading table in late
> stage. If duplicated tables are detected, acpi_reallocate_root_tables()
> stops installing them to the final reallocated global table list.
> 
> In v1 patchset [link #3], problems can be seen for dynamic loading tables
> which are allocated as virtuall allocated tables. Such tables are
> incremented in the global table list as the sanity check done in install
> step only compares the table addresses while the virtual allocated
> addresses are not stable.
> In v2 patchset, we follow original design discussion made in ACPICA devel
> mailing list, implements deferred table verification so that duplicate
> tables are still can be detected in install step rather than in load step.
> Also we removed table signature check according to verified windows
> behavior [link #4] and reported issues [link #5].
> 
> Link: http://www.spinics.net/lists/linux-acpi/msg72215.html [#1]
> Link: https://github.com//acpica/acpica/pull/265            [#2]
> Link: http://www.spinics.net/lists/linux-acpi/msg72589.html [#3]
> Link: https://github.com//acpica/acpica/pull/121            [#4]
>        https://bugzilla.kernel.org/show_bug.cgi?id=118601    [#5]
> 
> Lv Zheng (5):
>    ACPICA: Tables: Cleanup table handler invokers
>    ACPICA: Tables: Do not validate signature for dynamic table load
>    ACPICA: Tables: Change table duplication check to be related to
>      acpi_gbl_verify_table_checksum
>    ACPICA: Tables: Combine checksum/duplication verification together
>    ACPICA: Tables: Add deferred table verification support

I've tested these patches and can confirm that they fix the ACPI
errors on the system which started this all.

Note I've tested "v2" of the patch-set, I was on the Cc for the
cover letter for v3, but I did not receive the actual patches,
if you want me test v3 please send me the patches (or point
me to a git branch with them).

Regards,

Hans
