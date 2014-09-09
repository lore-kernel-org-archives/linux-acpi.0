From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Tue, 09 Sep 2014 00:29:06 -0400
Message-ID: <540E8212.8090304@redhat.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org> <20140903172138.GG1824@e102568-lin.cambridge.arm.com> <5408854B.9010703@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5408854B.9010703@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Hanjun, Lorenzo,

Resending due to my mail client removing list CCs...sorry about that.

On 09/04/2014 11:29 AM, Hanjun Guo wrote:

>>> +	} else {
>>> +		/* Fist GICC entry must be BSP as ACPI spec said */
>> s/Fist/First/
>>
>>> +		if  (cpu_logical_map(0) != mpidr) {
>>> +			pr_err("First GICC entry is not BSP for MPIDR 0x%llx\n",
>>> +			       mpidr);
>>> +			return -EINVAL;
>>> +		}
>> Interesting, this means that if I want to change the boot CPU I have to
>> recompile the ACPI tables. Is that really true ?

Well, the ACPI5.1 specification does require that the PEs (cores) be
listed in a very specific order, with the boot CPU first, and then a
precisely defined sequence of interleaving of any possible SMT threads
with other cores. So I think you would in practice update your tables.

>>> +	/*
>>> +	 * ACPI 5.1 only has two explicit methods to boot up SMP,
>>> +	 * PSCI and Parking protocol, but the Parking protocol is
>>> +	 * only specified for ARMv7 now, so make PSCI as the only
>>> +	 * way for the SMP boot protocol before some updates for
>>> +	 * the ACPI spec or the Parking protocol spec.
>>> +	 */

The Parking Protocol may be updated for a (limited) number of platforms
that may use it in the early days. The preferred option (as described in
the SBBR) is to use PSCI when at all possible. Some implementations of
the architecture may not be able to use PSCI for MP-Boot. Thus while
there may be some limited early use of the parking protocol (including
while PSCI firmware is being finalized during bringup activities), it
will ultimately be completely replaced by PSCI based boot over time.

Jon.
