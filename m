From: Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH] cpuidle: fix new C-states not functional after AC disconnect
Date: Wed, 30 Jan 2013 19:52:30 -0800
Message-ID: <CAODwPW9-dNRpKhhskbxU7Cva_1Y_dfCEN6cKt7pviWdeXoW7eg@mail.gmail.com>
References: <2099093.cPXO6Nhn9v@netbook>
	<50F2C79E.5000302@linaro.org>
	<11530988.U26HMGnFLa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34369 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab3AaDwb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2013 22:52:31 -0500
Received: by mail-ie0-f177.google.com with SMTP id 16so1966246iea.36
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jan 2013 19:52:31 -0800 (PST)
In-Reply-To: <11530988.U26HMGnFLa@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Schlichter <thomas.schlichter@web.de>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, =?ISO-8859-1?Q?Andreas_M=FCller?= <goo@stapelspeicher.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

>> Rafael, is possible to apply the patch [1/2] I previously sent ?
>>
>> https://patchwork.kernel.org/patch/1878691/
>
> I need to talk about this with Len.  That should happen tomorrow if everything
> goes well.

Hi Rafael,

Have you made a decision on picking up Daniel's first change yet? I
think it really is the cleanest way to solve this problem.
