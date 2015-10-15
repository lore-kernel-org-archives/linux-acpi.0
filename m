From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/4] Fix regressions uncovered by bad_madt_entry() patches
Date: Wed, 14 Oct 2015 18:23:49 -0600
Message-ID: <561EF215.3070100@redhat.com>
References: <1444857985-28844-1-git-send-email-al.stone@linaro.org>
 <2129967.6jsKS4L8fa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50680 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbbJOAXu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Oct 2015 20:23:50 -0400
In-Reply-To: <2129967.6jsKS4L8fa@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On 10/14/2015 05:44 PM, Rafael J. Wysocki wrote:
> On Wednesday, October 14, 2015 03:26:21 PM Al Stone wrote:
>> Once the patch series "Provide better MADT subtable sanity checks" got
>> into linux-next (commit b9e11e92b9), several existing platforms were found
>> where the firmware was doing odd things that aren't exactly correct if
>> the ACPI specification is being followed precisely.  This patch series
>> relaxes some of the checks on MADT subtables so that these previously 
>> working systems (all x86-based) will continue to boot.  For arm64, since
>> ACPI usage is still relatively new, the stricter checking is left in place.
>>
>> Al Stone (4):
>>   ACPI: workaround x86 firmware using reserved MADT subtable IDs
>>   ACPI: workaround x86 firmware with mis-matched FADT/MADT revisions
>>   ACPI: workaround FADT always being revision 2
>>   ACPI: for bad_madt_entry(), the GIC ITS table is 20 bytes long, not 16
>>
>>  drivers/acpi/tables.c | 62 ++++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 51 insertions(+), 11 deletions(-)
> 
> Honestly, having reviewed this series I'm inclined to drop the original
> changes from my tree and ask you to start over.

Yeah, I'm leaning that way, too.  This is getting way too messy.

> It seems to have been a mistake to modify the existing behavior for x86 and
> goodness only knows about ia64.  The changes for these architectures don't make
> us better off in any way.

Right.  It is truly amazing to me how much kruft this has turned up, when the
idea was simply to make sure that the tables used contain proper content -- and
this is only for one table.  I understand why we don't want to break something
that's already working but I am just sort of amazed at how much improperly
written firmware is in use.  I wanted to believe things were better than that.

Oh, well.  I'll turn the optimism knob back down to 1 and the cynicism knob all
the way up to 11...

> I understand the motivation to keep ARM64 "fresh and clean", but there must be
> a way to do that without affecting the other architectures negatively.
> 
> Thanks,
> Rafael

Let me think on that; it can be done, I'm sure, but part of the motivation for
these patches was that all architectures should follow the same ACPI rules.  I
was honestly hoping to avoid a per architecture solution.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
