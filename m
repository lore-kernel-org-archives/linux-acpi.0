From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v2 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Mon, 28 Sep 2015 13:39:40 -0600
Message-ID: <5609977C.6050701@linaro.org>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
 <2184252.JT4i34L2sb@vostro.rjw.lan> <5609123F.7020307@arm.com>
 <3513292.8DqxMl02v0@vostro.rjw.lan> <5609429B.6070604@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5609429B.6070604@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

On 09/28/2015 07:37 AM, Sudeep Holla wrote:
> 
> 
> On 28/09/15 14:50, Rafael J. Wysocki wrote:
>> On Monday, September 28, 2015 11:11:11 AM Sudeep Holla wrote:
>>>
>>> On 26/09/15 01:27, Rafael J. Wysocki wrote:
>>>> On Wednesday, September 16, 2015 01:58:06 PM Sudeep Holla wrote:
>>>>> acpi_parse_entries passes the table end pointer to the sub-table entry
>>>>> handler. acpi_parse_entries itself could validate the end of an entry
>>>>> against the table end using the length in the sub-table entry.
>>>>>
>>>>> This patch adds the validation of the sub-table entry end using the
>>>>> length field.This will help to eliminate the need to pass the table end
>>>>> to the handlers.
>>>>>
>>>>> It also moves the check for zero length entry early so that execution of
>>>>> the handler can be avoided.
>>>>>
>>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>>
>>>>> ---
>>>>>    drivers/acpi/tables.c | 31 +++++++++++++++----------------
>>>>>    1 file changed, 15 insertions(+), 16 deletions(-)
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> As I mentioned earlier, this needs to be applied after Al's MADT changes
>>>>> are merged. You might get simple conflicts in acpi_parse_entries.
>>>>
>>>> This needs to be rebased on top of some patches in my linux-next branch.
>>>>
>>>> It probably is better to rebase it on top of my bleeding-edge branch that
>>>> contains the Al's patches already, though.
>>>>
>>>
>>> I don't see Al's patches in your linux-next or bleeding-edge
>>
>> They were there, but I've dropped them due to a 0-day testing failure.
>>
> 
> Yes I guess we did see this last week, I had ask Al to fix it privately.
> It was some discrepancy with ACPIv1.0 specification between different
> sections that resulted in failures I saw.
> 
>> I think your patches depend on the Al's ones, is that correct?
>>
> 
> Correct, I think it's easier if I wait for his patches.
> 
> Regards,
> Sudeep

My apologies.  Was participating in family stuff all weekend
and Linaro Connect all last week.

This appears to be an incorrect reading of the 1.0 spec, and not
being able to find the 1.0b version, on my part.  Unfortunately,
http://www.acpi.info/DOWNLOADS/*spec*.pdf is not public so one has
to guess at files names for older versions of the spec -- and I
assumed 1.0B, the current naming practice.

Sorry about that...the patch is pretty simple, I think.  Rafael,
which tree do you want me to base the respin on?  Your bleeding-edge
branch?

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
