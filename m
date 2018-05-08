From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
Date: Tue, 8 May 2018 09:33:51 +0530
Message-ID: <82d294fc-d108-a32a-1ada-2763f40dac01@amd.com>
References: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
 <1525688013-9928-2-git-send-email-akshu.agrawal@amd.com>
 <BN6PR12MB1809A66A78024F2E519A1A34F79B0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BN6PR12MB1809A66A78024F2E519A1A34F79B0@BN6PR12MB1809.namprd12.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "Koenig, Christian" <Christian.Koenig@amd.com>, "airlied@redhat.com" <airlied@redhat.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 5/8/2018 3:14 AM, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Agrawal, Akshu
>> Sent: Monday, May 7, 2018 6:14 AM
>> Cc: djkurtz@chromium.org; Agrawal, Akshu <Akshu.Agrawal@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>;
>> mturquette@baylibre.com; sboyd@kernel.org; Koenig, Christian
>> <Christian.Koenig@amd.com>; airlied@redhat.com; Liu, Shaoyun
>> <Shaoyun.Liu@amd.com>; linux-kernel@vger.kernel.org; linux-
>> clk@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; linux-
>> acpi@vger.kernel.org
>> Subject: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
>>
>> Stoney SoC provides oscout clock. This clock can support 25Mhz and 48Mhz
>> of frequency.
>> The clock is available for general system use.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>> v2: config change, added SPDX tag and used clk_hw_register_.
>> v3: Fix kbuild warning for checking of NULL pointer
>> v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
>>  drivers/clk/x86/Makefile             |  3 +-
>>  drivers/clk/x86/clk-st.c             | 85
>> ++++++++++++++++++++++++++++++++++++
>>  include/linux/platform_data/clk-st.h | 17 ++++++++
>>  3 files changed, 104 insertions(+), 1 deletion(-)  create mode 100644
>> drivers/clk/x86/clk-st.c  create mode 100644
>> include/linux/platform_data/clk-st.h
>>
>> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile index
>> 1367afb..00303bc 100644
>> --- a/drivers/clk/x86/Makefile
>> +++ b/drivers/clk/x86/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
>> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
>>  clk-x86-lpss-objs		:= clk-lpt.o
>>  obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
>> -obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
>> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c new file mode
>> 100644 index 0000000..8a7795c
>> --- /dev/null
>> +++ b/drivers/clk/x86/clk-st.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Should this be MIT?  The original license was MIT.
> 
> Alex
>

We are adding SPDX tag, while license remains same GPL-2.0

What I have read is this is "to provide license identifiers inside the
source code that could be easily parsed by machines and would allow
checking for license compliance of an open source project easier."

Thanks,
Akshu
