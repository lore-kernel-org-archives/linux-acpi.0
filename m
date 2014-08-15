From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC 0/3] Experimental patchset for CPPC
Date: Fri, 15 Aug 2014 18:22:10 -0400
Message-ID: <CAJvTdK=hYS87BKZ0NcX7U3RJRmUHWGhC6krSTTmN8O2MO9BK=A@mail.gmail.com>
References: <1408046230-16439-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1408046230-16439-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mike Turquette <mike.turquette@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.ne>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, cpufreq@vger.kernel.org, Patch Tracking <patches@linaro.org>
List-Id: linux-acpi@vger.kernel.org

> I verified that CPU freq requests were taken by reading out the PERF_STATUS register.

Don't use the x86 PERF_STATUS register -- it will not tell you what
you want to know.

If you want to see the actual frequency, you need to watch how many
cycles elapse per a known time interval,
which is how intel_pstate and the turbostat utility do it.

cheers,
Len Brown
Intel Open Source Technology Center
