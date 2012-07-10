From: Rajendra Nayak <rajendra.nayak@linaro.org>
Subject: Re: [PATCH 2/4] cpuidle: define the enter function in the driver
 structure
Date: Tue, 10 Jul 2012 18:08:46 +0530
Message-ID: <4FFC2256.5050305@linaro.org>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>	<1341494608-16591-2-git-send-email-daniel.lezcano@linaro.org>	<201207052238.44330.rjw@sisk.pl> <4FF6C4C1.7030004@linaro.org> <4FFBE7E3.8020809@linaro.org> <4FFC147C.4050508@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:32977 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab2GJMiw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jul 2012 08:38:52 -0400
Received: by obbuo13 with SMTP id uo13so22106890obb.19
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jul 2012 05:38:52 -0700 (PDT)
In-Reply-To: <4FFC147C.4050508@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, lenb@kernel.org

> As the architectures tend to add more cores [1][2], that means more
> memory consumption. In a very near future, we will have 100 cores in a
> cpu. Assuming we have 4 C-states, that is 100 * 4 * 8 = 3200 bytes of
> memory used for a single function. IMHO, the kernel shouldn't assume the
> user must add more memory on the system.

I completely agree.
>
> Anyway, I will post a patchset to use the cpuidle_state per cpu.

Maybe what you were doing wasn't clearly evident with the existing
cpuidle core, but once its scaled to add a per cpu state, it might
look more meaningful. So if you post your patches to add cpuidle
state per cpu, it should certainly give more insight into why this
cleanup makes sense.

>
> Thanks
>    -- Daniel
>
> [1] http://www.engadget.com/2007/02/11/intel-demonstrates-80-core-processor/
> [2] http://www.tilera.com/products/processors/TILE-Gx_Family
>

