From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [RFC PATCH v4 3/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
Date: Fri, 11 May 2018 12:01:52 -0500
Message-ID: <95bcbc2d-0f8c-e51a-f0fc-08ea8c5fca26@gmail.com>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-3-mr.nuke.me@gmail.com> <20180511154039.GD12705@pd.tnic>
 <8e3c0cc6-9c5c-85ce-650c-8f498f5907da@gmail.com>
 <20180511160253.GF12705@pd.tnic>
 <45b7be09-c9b3-8006-6ea0-36b4ff38607c@gmail.com>
 <20180511162951.GH12705@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511162951.GH12705@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 05/11/2018 11:29 AM, Borislav Petkov wrote:
> On Fri, May 11, 2018 at 11:12:25AM -0500, Alex G. wrote:
>>> I think *you* didn't get it: IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER) is not
>>> enough of a check to confirm that there actually *is* an AER driver to
>>> handle the errors. If you really want to make sure the driver is loaded
>>> and functioning, then you need an explicit registering mechanism or some
>>> other way of checking it really is there and handling errors.
>>
>> config ACPI_APEI_PCIEAER
>> 	bool "APEI PCIe AER logging/recovering support"
>> 	depends on ACPI_APEI && PCIEAER
>> 	help
>> 	  PCIe AER errors may be reported via APEI firmware first mode.
>> 	  Turn on this option to enable the corresponding support.
>>
>> PCIAER is not modularizable. QED
> 
> QED my ass.
> 
> Read the f*ck my email again: the presence of the *code* is
> not enough of a check to confirm the error has been handled.
> aer_recover_work_func() can fail as that kfifo_put() in
> aer_recover_queue() can too.
> 
> You need an *actual* confirmation that the error has been handled
> properly and *only* *then* not panic the system. Otherwise you are
> potentially leaving those errors unhandled.


"How is PCIe error severity dependent on whether the AER error reporting
 driver is enabled (and possibly not even loaded) on the system?"

Little about confirmation of error being handled was talked about either
in your **** email, or previous versions of this series.  And quite
frankly it's besides the scope of this patch.

The scope is to enable SURPRISE!!! removal of NVMe drives and PCIe
devices. For that purpose, we don't need confirmation that the error was
handled. Such a confirmation requires a rework of GHES handling, or at
least the interaction between GHES and AER, both of which I find to be
mostly satisfactory.

You can't at this point know if the error is going to be handled.
There's code further downstream to handle this. You also didn't like it
when I wanted to handle things downstream.

I understand your concern with unhandled AER errors evolving into MCE's.
That's extremely rare, but when it happens you still panic due to the
MCE. To give you an idea of the rarity, in several months of testing, I
was only able to reproduce MCEs once, and that was with a very defective
drive, and a very idiotic test case.

If you find this solution unacceptable, that's fine. We can fix it in
firmware. We can hide all the events from the OS, contain the downstream
ports, and simulate hot-remove interrupts. All in firmware, all the time.

Alex
