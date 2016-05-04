From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 08/15] ACPICA: Dispatcher: Update thread ID for recursive
 method calls
Date: Wed, 4 May 2016 21:22:42 +0200
Message-ID: <CAJZ5v0j=4pGH-0guSQnVYTFo=zZ66duS8MrYmjxBtEy55Do=8Q@mail.gmail.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
	<b1748e389752c1f7d499770dea3fe5f4950aaecc.1462331121.git.lv.zheng@intel.com>
	<572A10CE.20106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <572A10CE.20106@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bob Moore <robert.moore@intel.com>, Mario Limonciello <Mario_Limonciello@dell.com>, stable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, May 4, 2016 at 5:10 PM, Prarit Bhargava <prarit@redhat.com> wrote:
>
>
> On 05/04/2016 01:48 AM, Lv Zheng wrote:
>> From: Prarit Bhargava <prarit@redhat.com>
>>
>> ACPICA commit 7a3bd2d962f221809f25ddb826c9e551b916eb25
>>
>> Set the mutex owner thread ID.
>> Original patch from: Prarit Bhargava <prarit@redhat.com>
>>
>> Link: https://github.com/acpica/acpica/commit/7a3bd2d9
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>
> cc'ing Mario @ Dell and stable.

It won't help if you CC stable at this point.

What stable series should this go into?
