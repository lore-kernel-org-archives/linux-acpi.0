From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v3 1/2] ACPI / tables: simplify acpi_parse_entries
Date: Thu, 15 Oct 2015 09:57:38 -0600
Message-ID: <561FCCF2.8010908@linaro.org>
References: <1442408287-10410-1-git-send-email-sudeep.holla@arm.com>
 <1443712312-9176-1-git-send-email-sudeep.holla@arm.com>
 <561FC9E9.20507@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561FC9E9.20507@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

On 10/15/2015 09:44 AM, Sudeep Holla wrote:
> Hi Rafael,
> 
> On 01/10/15 16:11, Sudeep Holla wrote:
>> acpi_parse_entries passes the table end pointer to the sub-table entry
>> handler. acpi_parse_entries itself could validate the end of an entry
>> against the table end using the length in the sub-table entry.
>>
>> This patch adds the validation of the sub-table entry end using the
>> length field.This will help to eliminate the need to pass the table end
>> to the handlers.
>>
>> It also moves the check for zero length entry early so that execution of
>> the handler can be avoided.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> Now that Al's MADT is queued, can you consider applying these ?
> 

I think we have to remove my patches from the queue until I can make
them arch-specific; doing these MADT checks breaks far too many existing
x86 systems where the firmware does things it should not; re-reading some
of the ia64 kernel code, there's a pathological case there where it could
break (but shouldn't if iasl is being used to compile tables).  I'll be
working on the new version today.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
