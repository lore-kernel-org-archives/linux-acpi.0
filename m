From: "Vedran Rodic" <vrodic@gmail.com>
Subject: Re: Thinkpad X60s power usage on battery - Windows/Linux comparison
Date: Thu, 21 Aug 2008 02:05:43 +0200
Message-ID: <8ccf2e9c0808201705v7d4edc81kde5b6b8e7090e335@mail.gmail.com>
References: <8ccf2e9c0808181554o930f235maa79bdb365cd808d@mail.gmail.com>
	 <87bpzp231z.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:20651 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYHUAFn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Aug 2008 20:05:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so851650wfd.4
        for <linux-acpi@vger.kernel.org>; Wed, 20 Aug 2008 17:05:43 -0700 (PDT)
In-Reply-To: <87bpzp231z.fsf@basil.nowhere.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org

On Tue, Aug 19, 2008 at 3:42 AM, Andi Kleen <andi@firstfloor.org> wrote:
> "Vedran Rodic" <vrodic@gmail.com> writes:
>>
>> Windows power monitoring tool from Lenovo reports power usage of 6.5 W under
>> the same LCD brightness level and with wireless disabled.
>
> It would be better if you compared using the same "neutral" method.
>
> Most cheap power measurements tend to quite inaccurate and who
> knows in which direction this Windows power monitoring tool is wrong.
> It might be wrong in a different direction than what you used
> under Linux.

Yeah, or they might not be wrong and my eyes could be :( It turns out
that Windows can get the LCD brightness down more than thinkpad-acpi,
or whatever is turning down the brightnes when I press the Fn-End
combination (both in X and in the console - I guess it's the BIOS).

>
> A reasonable accurate method might be to just measure the time how
> long the battery lasts in both cases using a similar workload
> (e.g. keeping it completely idle)

Difference between lowest Windows LCD brightness levels and Linux
brightness levels:

3:40h on Windows (it hibernated the laptop when the battery was
arround 5% percent, did arround 10 more minutes sitting on the grub
screen).
2:36 on Linux.

Now the question is how do I get the LCD brightness down even more on
X, but this may already be solved in the latest Xorg intel driver,
just not with the Fn keys.

If I see any more surprising battery life differences when I manage to
get the same low brightness level on both OS-es, I'll let you know.

Vedran
