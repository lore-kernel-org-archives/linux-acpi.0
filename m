From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: battery: current a factor of 10 off? [fix confirmed]
Date: Mon, 24 Nov 2008 10:31:25 +0100
Message-ID: <87myfpii6q.fsf@tac.ki.iif.hu>
References: <87skplx6ho.fsf@szonett.ki.iif.hu>
	<8f8ff01d0811202009r2d1fedcct9a383f9362c5a064@mail.gmail.com>
	<4926C87D.20308@gmail.com> <878wr9j3v9.fsf_-_@szonett.ki.iif.hu>
	<492A5B64.1080306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:52114 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbYKXJb2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Nov 2008 04:31:28 -0500
In-Reply-To: <492A5B64.1080306@gmail.com> (Alexey Starikovskiy's message of
	"Mon, 24 Nov 2008 10:44:36 +0300")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy <aystarik@gmail.com> writes:

> Ferenc Wagner wrote:
>
>> Alexey Starikovskiy <aystarik@gmail.com> writes:
>>
>>> Alexey Starikovskiy wrote:
>>>
>>>> On Fri, Nov 21, 2008 at 3:33 AM, Ferenc Wagner <wferi@niif.hu> wrote:
>>>>
>>>>> on my ThinkPad R50e the current_now reading seems something like 10
>>>>> times the actual value.  [...]
>>>>
>>>> Good catch.  ACPI battery interface report its state either in mW
>>>> or in mA, and discharge rate in your case is reported in
>>>> mW. power_supply interface does not have such a parameter, so
>>>> current_now parameter is used for all cases. But in case of mW,
>>>> reported discharge should be converted into mA.
>>>>
>>>> Please test the attached patch.
>>>
>>> This patch should be better -- no integer overflow.
>>
>> Thanks, this patch really fixes the issue (tried on 2.6.28-rc6).
>> Hope to see it soon in Linus' tree!
>
> Great! Do you want to be memorized by "Tested-by:" line?

Feel free to quote me if you see fit.

>> Btw. that kernel gives me two ACPI warnings on boot:
>
> These issues are already known, and second even has a patch lurking
> somewhere in this list... So no action required.

Glad to hear.  Thanks for the good work!
-- 
Cheers,
Feri.
