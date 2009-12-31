From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: [2.6.33{rc2-git1,2}]: hp-wmi again broken
Date: Thu, 31 Dec 2009 17:44:59 +0100
Message-ID: <2d0a357f0912310844j7b46b593vc6f6c944248f3014@mail.gmail.com>
References: <2d0a357f0912310817p3b828239qc81994973fca1274@mail.gmail.com>
	 <20091231173719.6fee3a68@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:17632 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZLaQpA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Dec 2009 11:45:00 -0500
In-Reply-To: <20091231173719.6fee3a68@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, len.brown@intel.com

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

On Thu, Dec 31, 2009 at 5:37 PM, Anisse Astier <anisse@astier.eu> wrote:
> Hi Sedat,
>
> On Thu, 31 Dec 2009 17:17:43 +0100, Sedat Dilek <sedat.dilek@googlemail.com> wrote :
>
>> Hi,
>>
>> I am not sure why this bug has re-entered from linux-acpi-2.6 to
>> linux-kernel, but I just wanted to report Anisse has re-send a fix for
>> hp-wmi [1].
>> The original bug was reported with appended patch in [2].
>> From 2.6.33-rc2 to 2.6.32-git2 hp-wmi is still broken.
>> Please, fix that cleanly in upstream, now.
>> Thanks.
>>
>> Kind Regards,
>> - Sedat -
>>
>> [1] ACPI & driver patches for 2.6.33-rc2
>> http://patchwork.kernel.org/patch/70398/
>> [2] [2.6.33-rc2] ACPI problems on HP nc6400 notebook
>> http://patchwork.kernel.org/patch/69745/
>
> It would be nice if you could test the patch I sent, so that we had a
> confirmation it's working. It's a (trivial)one-liner, but it was also a
> one-liner that introduced the regression.
>
> Thanks in advance.
>
> Anisse
>
>
