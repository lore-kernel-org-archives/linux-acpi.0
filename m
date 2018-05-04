From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
Date: Fri, 4 May 2018 12:15:50 +0200
Message-ID: <CAJZ5v0iERzne0WNsEPVKN_PT1vwNfyqpoE_YiF33RmqLMryvhw@mail.gmail.com>
References: <1525422930-27826-1-git-send-email-akshu.agrawal@amd.com>
 <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com> <3734664.7VekyYX7C7@aspire.rjw.lan>
 <0afd036f-9526-f5c8-4bd6-87d145319370@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0afd036f-9526-f5c8-4bd6-87d145319370@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Kurtz <djkurtz@chromium.org>, Alex Deucher <Alexander.Deucher@amd.com>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 4, 2018 at 12:09 PM, Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>
>
> On 5/4/2018 3:36 PM, Rafael J. Wysocki wrote:
>> On Friday, May 4, 2018 10:34:44 AM CEST Akshu Agrawal wrote:
>>> AMD SoC exposes clock for general purpose use. The clock registration
>>> is done in clk-st driver. The MMIO mapping are passed on to the
>>> clock driver for accessing the registers.
>>> The misc clock handler will create MMIO mappings to access the
>>> clock registers and enable the clock driver to expose the clock
>>> for use of drivers which will connect to it.
>>>
>>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>> ---
>>> v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc
>>
>> Well, where's patch [1/2]?
>>
>
> It's here:
> https://patchwork.kernel.org/patch/10380207/

So can you please send them both as a series with the same CC list,
add all of the relevant maintainers to that CC list and indicate whom
you expect to take care of these patches?

I think that they should go in together as they are clearly related to
each other.

Thanks,
Rafael
