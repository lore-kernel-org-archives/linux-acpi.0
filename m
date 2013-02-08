From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [linux-pm] linux-next: Tree for Feb 8 [ smp|cpufreq: WARNING: at
 kernel/smp.c:245 smp_call_function_single ]
Date: Fri, 8 Feb 2013 22:25:03 +0530
Message-ID: <CAKohpo=6PDxFvmwQvb2V3Qpq2ZVtxQo-8kLwqnJpvwOjtUa7yA@mail.gmail.com>
References: <CA+icZUX-hh+RjEOrKABBtecmb4C-5azSmdTx6D7SLuSpcQE+kQ@mail.gmail.com>
	<CAJd=RBDwdO+n3H4M=5W5q75q3yUVL7L2RonWnCE7sfsfW1K5ig@mail.gmail.com>
	<CA+icZUUaFb8zvdkY2JLz5h_7CBgaTzyyTphGid+GkigV+NfVKA@mail.gmail.com>
	<2612804.Hcyse1lRVO@vostro.rjw.lan>
	<CAKohpom0yjSyU+OhK4vdi5R=+JsmAEw2nOsvupDOiWMYsdz3Pg@mail.gmail.com>
	<CA+icZUUedcLAo1OkDSD7K_zgZoLvUAPNYOWAJxSPLp9J3hCKNw@mail.gmail.com>
	<CAOh2x=nn24DC-jpD_UsZ2z6=5d9GmZqwowKF8X0zQQX=vZmbqQ@mail.gmail.com>
	<CA+icZUV=813qjoTMUQzHvUD2AChgKO60ffRtrJ2OG0uSqZf3Mw@mail.gmail.com>
	<CA+icZUXHD9kQ0JUZ-31Oc3OWaKr7zpWfBG7L_n5kG7QQW+aUDg@mail.gmail.com>
	<CA+icZUWo4um9s-FhF5HoN5-WbkbNDTjnGkMMRHc60GWohcrPvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CA+icZUWo4um9s-FhF5HoN5-WbkbNDTjnGkMMRHc60GWohcrPvA@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, x86@kernel.org, linux-kernel@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Hillf Danton <dhillf@gmail.com>, linux-next@vger.kernel.org, Linux PM List <linux-pm@lists.linux-foundation.org>, Chuansheng Liu <chuansheng.liu@intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 8 February 2013 22:21, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> No, it did NOT apply cleanly and I merged your tree like this.

Patch looks fine to me.

>> To me it does not look like your changes from the patch you sent me
>> are included?

Yes they do. Check most of the changes from cpufreq.c which remove
locks around init/exit.

> Looks like I did it correct - no WARNINGs.
>
> So, suspend-resume is good here.

Great!!
