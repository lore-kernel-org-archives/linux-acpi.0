From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] acpi: video: fix reversed indexed BQC
Date: Fri, 02 Aug 2013 12:59:08 +0800
Message-ID: <51FB3C9C.6070002@intel.com>
References: <1375400042-989-1-git-send-email-felipe.contreras@gmail.com> <51FB137D.7070000@gmail.com> <CAMP44s1A+z4=DGJLK1qf5LPc1vbYvtJwjFiMt17vzyZFRU0qmg@mail.gmail.com> <51FB35CD.7040709@intel.com> <CAMP44s1honSdnoMnmpEcsXtdkJuPYgQgnLwcN+oxs5f=a+3Stg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37402 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab3HBE6V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Aug 2013 00:58:21 -0400
In-Reply-To: <CAMP44s1honSdnoMnmpEcsXtdkJuPYgQgnLwcN+oxs5f=a+3Stg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>

On 08/02/2013 12:50 PM, Felipe Contreras wrote:
> On Thu, Aug 1, 2013 at 11:30 PM, Aaron Lu <aaron.lu@intel.com> wrote:
>> On 08/02/2013 12:11 PM, Felipe Contreras wrote:
>>> On Thu, Aug 1, 2013 at 9:03 PM, Aaron Lu <aaron.lwe@gmail.com> wrote:
>>>> On 08/02/2013 07:34 AM, Felipe Contreras wrote:
>>>>> Commit 1a7c618 (ACPI video: support _BQC/_BCL/_BCM methods that use
>>>>> index values) assumed that bl->levels were not reverted, but at this
>>>>> point they already are, so there's no need to revert them yet again.
>>>>
>>>> When acpi_video_bqc_value_to_level is called, bl->levels is not
>>>> reverted.
>>>
>>> This is the code that turns br->flags._BCL_reversed on:
>>>
>>>       if (max_level == br->levels[2]) {
>>>               br->flags._BCL_reversed = 1;
>>>               sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
>>>                       acpi_video_cmp_level, NULL);
>>>       }
>>>
>>> Now tell me how br->flags._BCL_reversed can be on, and the br->levels
>>> *not* reverted.
>>
>> Oh yes, it is reverted to be in increase order, so it is not in reverse
>> order. I'm a little confused by these words.
> 
> br->levels is always ascending, but that doesn't mean _BCL is.

Right.

> 
>> Please see acpi_video_bqc_quirk, we set _BQC_use_index by revert the
>> level on a reversed _BCL, so we will need to revert level here too.
> 
> I cannot parse that sentence, but nothing needs to change there; to
> find out if _BQC is using an index, we need to see if the returned
> value is the index of the level we are looking for, and to find that
> out we need the original list of levels, which can be found by
> reverting the already reverted list. If this wasn't the case there

Yes, but instead of reverting the already reverted list, we revert the
returned value to get the correct index in the reverted list. But your
patch removes the revert, is it correct?

> would not be any need for the _BCL_reversed flag.
> 
-Aaron
