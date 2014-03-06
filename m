From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: [PATCH v2] ACPI / EC: Clear stale EC events on Samsung systems
Date: Thu, 06 Mar 2014 18:12:52 -0500
Message-ID: <531900F4.5090805@canonical.com>
References: <1393429360-4344-1-git-send-email-clancy.kieran@gmail.com> <1885040.WKp5oRmh5C@vostro.rjw.lan> <CAGf84QK-N+C6eHct4XDzOCHwfN649F2okJ1y2V70wWz-wHFKEA@mail.gmail.com> <3916368.BifXucqhsP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50901 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaCFXND (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Mar 2014 18:13:03 -0500
In-Reply-To: <3916368.BifXucqhsP@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kieran Clancy <clancy.kieran@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Li Guang <lig.fnst@cn.fujitsu.com>, Lan Tianyu <tianyu.lan@intel.com>, Juan Manuel Cabo <juanmanuel.cabo@gmail.com>, Dennis Jansen <dennis.jansen@web.de>

On 03/06/2014 07:32 AM, Rafael J. Wysocki wrote:
> On Thursday, March 06, 2014 11:54:28 AM Kieran Clancy wrote:
>> On Thu, Mar 6, 2014 at 11:22 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Thursday, March 06, 2014 11:04:14 AM Kieran Clancy wrote:
>>>> Rafael, is it a separate process to get this in the stable tree or
>>>> will it naturally happen after being merged into the mainline?
>>> I need to add a proper "CC stable" tag to your patch for this to happen.
>>>
>>> Which -stable kernels should it go to?
>> 3.2 and 3.10 seem like natural choices (3.4?), but I don't know the
>> norm for this kind of fix. Would there be any reason not to include it
>> in some particular stable kernels?
> In some cases patches are not needed in older -stable, because the
> changes are not relevant there etc.
>
> OK, I'll mark if for all applicable -stable series.
>
> Thanks!
>
Thanks, Rafael!
