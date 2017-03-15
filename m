From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH 0/7] ACPICA: Tables: Cleanup table sanity checks
Date: Wed, 15 Mar 2017 14:33:40 +0100
Message-ID: <77ba7bff-d1e8-e430-c422-961eb07ff296@redhat.com>
References: <cover.1489558845.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbdCONdo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 09:33:44 -0400
In-Reply-To: <cover.1489558845.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Hi,

On 15-03-17 07:36, Lv Zheng wrote:
> Originally AML table sanity check is only done for Load opcode, as
> acpi_tb_compare_tables() is only invoked in
> acpi_tb_install_standard_table(). While LoadTable opcode cannot be covered
> as it directly invokes acpi_tb_load_table() without invoking
> acpi_tb_install_standard_table(). Furthermore, standard table load also
> cannot be covered as acpi_ns_load_table() is invoked instead of
> acpi_tb_install_standard_table() and acpi_tb_load_table().
>
> So it becomes a problem if a duplicate table is in RSDT/XSDT, there is no
> such check implemented for static load tables and LoadTable opcode.
>
> This patchset combines code paths (in return reduces some redundant code
> blocks and enhances checks/locks) so that duplicate table detection can be
> applied to all cases.

I can confirm that this series fixes the errors I was seeing on my
GPD win machine. Note as explained in my reply to Robert I believe that
the last patch from the series can be dropped:

"On 15-03-17 04:05, Moore, Robert wrote:
 > And I would suppose a refinement would be:
 >
 > Compare headers
 > If headers match, compare entire tables.

The existing memcmp already does that since the header is in the
front, and memcmp will stop on the first difference, so there
is no need to change anything."

As Robert mentions we really a should compare the entire table
if the checksums match since an 8 bit checksum is really weak and
if we want to do that a simple memcmp will suffice as that will
already exit directly if the checksum mismatches as the checksum
is before the actual data.

Regards,

Hans




>
> Lv Zheng (7):
>   ACPICA: Tables: Cleanup table handler invokers
>   ACPICA: Tables: Add sanity check for load_table opcode
>   ACPICA: Tables: Add sanity check for table install
>   ACPICA: Tables: Fix an unwanted exception for table reloading
>   ACPICA: Tables: Enable acpi_ut_is_aml_table() for all ACPICA modules
>   ACPICA: Tables: Add sanity check for static table load
>   ACPICA: Tables: Change table comparison using table header for static
>     load tables
>
>  drivers/acpi/acpica/actables.h |   7 +-
>  drivers/acpi/acpica/acutils.h  |   4 +-
>  drivers/acpi/acpica/exconfig.c |   2 +-
>  drivers/acpi/acpica/nsload.c   |  18 ---
>  drivers/acpi/acpica/tbdata.c   | 288 ++++++++++++++++++++++++++++++++++++-----
>  drivers/acpi/acpica/tbinstal.c | 197 ++++++----------------------
>  drivers/acpi/acpica/tbxfload.c |  46 +------
>  drivers/acpi/acpica/utmisc.c   |  27 ++--
>  include/acpi/actbl.h           |   1 +
>  9 files changed, 325 insertions(+), 265 deletions(-)
>
