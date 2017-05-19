From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] ACPICA: Tables: Add deferred verification
 support
Date: Fri, 19 May 2017 11:49:06 +0200
Message-ID: <27b2f588-e7a8-7597-a4d3-b7dcd90686ab@redhat.com>
References: <20170227093432.3308-1-hdegoede@redhat.com>
 <cover.1494916766.git.lv.zheng@intel.com>
 <71329223-dbb4-2845-a14e-3db579ca552b@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA5F31@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbdESJtJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 May 2017 05:49:09 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA5F31@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Box, David E" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi,

On 19-05-17 09:59, Zheng, Lv wrote:
> Hi, Hans
> 
>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>> Subject: Re: [RFC PATCH v2 0/5] ACPICA: Tables: Add deferred verification support
>>
>> Hi,
>>
>> On 16-05-17 09:13, Lv Zheng wrote:
>>> On linux, we can not verify ACPI tables before installing them into the
>>> global table list in early stage due to the number of slot limitations for
>>> early ioremap. This leaves a problem that we cannot detect duplicated
>>> tables in early stage, causing unwanted error messages seen when the
>>> duplicated tables are failed to be loaded [link #1].
>>>
>>> This patchset as ACPICA PR [link #2] adds support to verify tables in
>>> acpi_reallocate_root_tables() which is invoked after installing tables in
>>> early stage, being ready for late ioremap and beofre loading table in late
>>> stage. If duplicated tables are detected, acpi_reallocate_root_tables()
>>> stops installing them to the final reallocated global table list.
>>>
>>> In v1 patchset [link #3], problems can be seen for dynamic loading tables
>>> which are allocated as virtuall allocated tables. Such tables are
>>> incremented in the global table list as the sanity check done in install
>>> step only compares the table addresses while the virtual allocated
>>> addresses are not stable.
>>> In v2 patchset, we follow original design discussion made in ACPICA devel
>>> mailing list, implements deferred table verification so that duplicate
>>> tables are still can be detected in install step rather than in load step.
>>> Also we removed table signature check according to verified windows
>>> behavior [link #4] and reported issues [link #5].
>>>
>>> Link: http://www.spinics.net/lists/linux-acpi/msg72215.html [#1]
>>> Link: https://github.com//acpica/acpica/pull/265            [#2]
>>> Link: http://www.spinics.net/lists/linux-acpi/msg72589.html [#3]
>>> Link: https://github.com//acpica/acpica/pull/121            [#4]
>>>         https://bugzilla.kernel.org/show_bug.cgi?id=118601    [#5]
>>>
>>> Lv Zheng (5):
>>>     ACPICA: Tables: Cleanup table handler invokers
>>>     ACPICA: Tables: Do not validate signature for dynamic table load
>>>     ACPICA: Tables: Change table duplication check to be related to
>>>       acpi_gbl_verify_table_checksum
>>>     ACPICA: Tables: Combine checksum/duplication verification together
>>>     ACPICA: Tables: Add deferred table verification support
>>
>> I've tested these patches and can confirm that they fix the ACPI
>> errors on the system which started this all.
>>
>> Note I've tested "v2" of the patch-set, I was on the Cc for the
>> cover letter for v3, but I did not receive the actual patches,
>> if you want me test v3 please send me the patches (or point
>> me to a git branch with them).
> 
> What I added is:
> 		*table_index = i;
> In acpi_tb_install_standard_table().
> Without this line, Load a table 2nd time after the 1st time Load/Unload will fail.
> Other changes are not functional. I'm sorry for that mistake.
> 
> Testing v2 can be sufficient as what v3 improves is not strictly related to your issue.
> And we can ensure the v3 improvement's quality locally while for your issue I cannot.
> 
> So it's OK if you don't do any further testing, but if you want to try:
> You can reach the code via the following git repository:
> https://github.com/zetalog/linux/
> They are top 5 commits in acpica-tables2 branch:
> https://github.com/zetalog/linux/commits/acpica-tables2
> 
> # git remote add linux-acpica https://github.com/zetalog/linux/
> # git fetch linux-acpica
> # git checkout acpica-tables2

Thank you for the info. I've added the missing *table_index = i; statement
to my local tree. I will let you know if I hit any issues with this
patch-set.

Regards,

Hans
