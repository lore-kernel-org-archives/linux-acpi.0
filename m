From: Tin Huynh <tnhuynh@apm.com>
Subject: Re: [PATCH V1] leds: pca963x: Add ACPI support
Date: Tue, 29 Nov 2016 17:09:11 +0700
Message-ID: <CANQ9TuDtaGeBO+nTvTEqE9jegSf7q81hKKxPZX=STC5+wGkmWw@mail.gmail.com>
References: <1480393100-1397-1-git-send-email-tnhuynh@apm.com>
 <CGME20161129091640epcas5p41c7b2953a079bd3b67bafd8b222df76b@epcas5p4.samsung.com>
 <20161129091536.GO1459@lahna.fi.intel.com> <8d800666-28b9-fa4e-8897-e689e9e644c4@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36728 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933530AbcK2KJO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Nov 2016 05:09:14 -0500
Received: by mail-wm0-f44.google.com with SMTP id g23so232434929wme.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Nov 2016 02:09:13 -0800 (PST)
In-Reply-To: <8d800666-28b9-fa4e-8897-e689e9e644c4@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches <patches@apm.com>

Hi
I got a small bug when compiling without CONFIG_ACPI
I will send out the patch to fix the problem later.

On Tue, Nov 29, 2016 at 5:04 PM, Jacek Anaszewski
<j.anaszewski@samsung.com> wrote:
> Hi Tin,
>
> Thanks for the update.
>
> On 11/29/2016 10:15 AM, Mika Westerberg wrote:
>>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
>
> Mika, thanks for the review.
>
> Patch applied to the for-next branch of linux-leds.git.
>
> --
> Best regards,
> Jacek Anaszewski



-- 
Sr SW Eng
