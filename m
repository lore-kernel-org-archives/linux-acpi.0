From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 12/15] ACPICA: iasl: add ASL conversion tool
Date: Thu, 27 Apr 2017 17:07:17 +0200
Message-ID: <000a6dab-f00f-ad00-97bd-623dc1948cf5@intel.com>
References: <952e3354e4cbe4310e1037bc16820c70cc0fd8f6.1493194142.git.lv.zheng@intel.com>
 <201704270350.iclhVCVR%fengguang.wu@intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE995F0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28362 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755321AbdD0PHW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 11:07:22 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE995F0@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, lkp <lkp@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Moore, Robert" <robert.moore@intel.com>, "Brown, Len" <len.brown@intel.com>, "Box, David E" <david.e.box@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 4/27/2017 3:43 AM, Zheng, Lv wrote:
> Hi,
>
> It's fixed by PATCH 14 in the same series.
> I'll combine them in order not to break bisection processes.

OK, thanks!

>> From: lkp
>> Subject: Re: [PATCH 12/15] ACPICA: iasl: add ASL conversion tool
>>
>> Hi Bob,
>>
>> [auto build test ERROR on pm/linux-next]
>> [also build test ERROR on v4.11-rc8 next-20170426]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Lv-Zheng/ACPICA-Disassembler-Enhance-resource-
>> descriptor-detection/20170427-010527
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>> config: x86_64-acpi-redef (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> Note: the linux-review/Lv-Zheng/ACPICA-Disassembler-Enhance-resource-descriptor-detection/20170427-
>> 010527 HEAD 3e033e5bcdf2b5e89028d19030d8479ac5b855bf builds fine.
>>        It only hurts bisectibility.
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from drivers/acpi/acpica/accommon.h:56:0,
>>                      from drivers/acpi/acpica/utcopy.c:45:
>>>> drivers/acpi/acpica/aclocal.h:841:2: error: unknown type name 'FILE'
>>       FILE *file;
>>       ^~~~
>>
>> vim +/FILE +841 drivers/acpi/acpica/aclocal.h
>>
>>     835
>>     836	/*
>>     837	 * File node - used for "Include" operator file stack and
>>     838	 * depdendency tree for the -ca option
>>     839	 */
>>     840	struct acpi_file_node {
>>   > 841		FILE *file;
>>     842		char *filename;
>>     843		char *file_start;	/* Points to AML and indicates when the AML for this particular
>> file starts. */
>>     844		char *file_end;		/* Points to AML and indicates when the AML for this
>> particular file ends. */
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


