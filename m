From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [RFC PATCH v4 3/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
Date: Fri, 11 May 2018 11:12:25 -0500
Message-ID: <45b7be09-c9b3-8006-6ea0-36b4ff38607c@gmail.com>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-3-mr.nuke.me@gmail.com> <20180511154039.GD12705@pd.tnic>
 <8e3c0cc6-9c5c-85ce-650c-8f498f5907da@gmail.com>
 <20180511160253.GF12705@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511160253.GF12705@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org



On 05/11/2018 11:02 AM, Borislav Petkov wrote:
> On Fri, May 11, 2018 at 10:54:09AM -0500, Alex G. wrote:
>> That being clarified, should I replace "crackmonkey" with "broken" in
>> the commit message?
> 
> Keep your opinion *outside* of commit messages - their goal is to
> explain *why* the change is being made in strictly technical language so
> that when someone looks at git history, someone can know *why*.
> 
>> Borislav, I sense some confusion. AER is not a "reporting" driver. It
>> handles the errors. You can't leave these errors unhandled. They
>> propagate to the root complex and can cause fatal MCEs when not handled.
>> The window to handle the error is pretty large, so it's not a concern
>> when you're handling it.
> 
> I think *you* didn't get it: IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER) is not
> enough of a check to confirm that there actually *is* an AER driver to
> handle the errors. If you really want to make sure the driver is loaded
> and functioning, then you need an explicit registering mechanism or some
> other way of checking it really is there and handling errors.

config ACPI_APEI_PCIEAER
	bool "APEI PCIe AER logging/recovering support"
	depends on ACPI_APEI && PCIEAER
	help
	  PCIe AER errors may be reported via APEI firmware first mode.
	  Turn on this option to enable the corresponding support.

PCIAER is not modularizable. QED

Alex
