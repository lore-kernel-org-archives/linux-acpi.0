From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 0/3] x86,idle: Enhance cpuidle prediction to handle
 its failure
Date: Mon, 17 Sep 2012 16:52:36 +0200
Message-ID: <50573934.4030102@linaro.org>
References: <1347933209-25939-1-git-send-email-youquan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49764 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab2IQOwk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Sep 2012 10:52:40 -0400
Received: by eaac11 with SMTP id c11so2486545eaa.19
        for <linux-acpi@vger.kernel.org>; Mon, 17 Sep 2012 07:52:39 -0700 (PDT)
In-Reply-To: <1347933209-25939-1-git-send-email-youquan.song@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, lenb@kernel.org, Rik van Riel <riel@redhat.com>, Youquan Song <youquan.song@linux.intel.com>

On 09/18/2012 03:53 AM, Youquan Song wrote:
> The prediction for future is difficult and when the cpuidle governor =
prediction=20
> fails and govenor possibly choose the shallower C-state than it shoul=
d. How to=20
> quickly notice and find the failure becomes important for power savin=
g.   =20
>=20
> cpuidle menu governor has a method to predict the repeat pattern if t=
here are 8
> C-states residency which are continuous and the same or very close, s=
o it will
> predict the next C-states residency will keep same residency time.
>=20
> This patchset adds a timer when menu governor choose a non-deepest C-=
state in
> order to wake up quickly from shallow C-state to avoid staying too lo=
ng at=20
> shallow C-state for prediction failure. The timer is set to a time ou=
t value=20
> that is greater than predicted time and if the timer with the value i=
s triggered=20
> , we can confidently conclude prediction is failure. When prediction
> succeeds, CPU is waken up from C-states in predicted time and the tim=
er is not=20
> triggered and will be cancelled right after CPU waken up. When predic=
tion fails,
> the timer is triggered to wake up CPU from shallow C-states, so menu =
governor=20
> will quickly notice that prediction fails and then re-evaluates deepe=
r C-states
>  possibility. This patchset can improves cpuidle prediction process f=
or both=20
> repeat mode and general mode.
>=20
> There are 2 cases will clear show this patchset benefit.
>=20
> One case is turbostat utility (tools/power/x86/turbostat) at kernel 3=
=2E3 or early
> . turbostat utility will read 10 registers one by one at Sandybridge,=
 so it will
> generate 10 IPIs to wake up idle CPUs. So cpuidle menu governor will =
predict it
>  is repeat mode and there is another IPI wake up idle CPU soon, so it=
 keeps idle
>  CPU stay at C1 state even though CPU is totally idle. However, in th=
e turbostat
> , following 10 registers reading is sleep 5 seconds by default, so th=
e idle CPU
>  will keep at C1 for a long time though it is idle until break event =
occurs.
> In a idle Sandybridge system, run "./turbostat -v", we will notice th=
at deep=20
> C-state dangles between "70% ~ 99%". After patched the kernel, we wil=
l notice
> deep C-state stays at >99.98%.

Is there an impact on performances ?



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
