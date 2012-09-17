From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 0/3] x86,idle: Enhance cpuidle prediction to handle
 its failure
Date: Mon, 17 Sep 2012 22:32:37 +0200
Message-ID: <505788E5.9080109@linaro.org>
References: <1347933209-25939-1-git-send-email-youquan.song@intel.com> <50573934.4030102@linaro.org> <20120918033020.GA20862@linux-youquan.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120918033020.GA20862@linux-youquan.bj.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Youquan Song <youquan.song@linux.intel.com>
Cc: Youquan Song <youquan.song@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, lenb@kernel.org, Rik van Riel <riel@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 09/18/2012 05:30 AM, Youquan Song wrote:
>>> One case is turbostat utility (tools/power/x86/turbostat) at kernel=
 3.3 or early
>>> . turbostat utility will read 10 registers one by one at Sandybridg=
e, so it will
>>> generate 10 IPIs to wake up idle CPUs. So cpuidle menu governor wil=
l predict it
>>>  is repeat mode and there is another IPI wake up idle CPU soon, so =
it keeps idle
>>>  CPU stay at C1 state even though CPU is totally idle. However, in =
the turbostat
>>> , following 10 registers reading is sleep 5 seconds by default, so =
the idle CPU
>>>  will keep at C1 for a long time though it is idle until break even=
t occurs.
>>> In a idle Sandybridge system, run "./turbostat -v", we will notice =
that deep=20
>>> C-state dangles between "70% ~ 99%". After patched the kernel, we w=
ill notice
>>> deep C-state stays at >99.98%.
>>
>> Is there an impact on performances ?
>=20
> In this case, turbostat is utility to measure cpu idle status and its=
elf
> also is a workload to system. Its purpose is that show cpu C-state
> information every 5 seconds. After patched the kernel, it also does
> the same thing as usual. So I think the performance has no/little imp=
act.
>=20
> I do not find performance impact in my tests. If you performance impa=
ct cases or
> suggestions, I will be very glad to try.=20

There is simple program [1] I wrote specifically for cpuidle.
It does not do benchmarking. Maybe you can reuse it or modify it to fit
your needs.

Hope that helps.

  -- Daniel

[1]
http://git.linaro.org/gitweb?p=3Dpeople/hongbozhang/pm-qa.git;a=3Dblob;=
f=3Dcpuidle/cpuidle_killer.c;h=3D5e7320f1e1679fdf4caa15d9b729534425b49b=
c6;hb=3D03e09b72a473032e434c811b2500f63fb65260c4

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
