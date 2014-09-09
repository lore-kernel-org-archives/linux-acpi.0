From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
Date: Tue, 09 Sep 2014 18:14:58 -0400
Message-ID: <540F7BE2.8060403@redhat.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org> <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-arm-kerne
List-Id: linux-acpi@vger.kernel.org

On 09/09/2014 01:17 PM, Bjorn Helgaas wrote:
> On Mon, Sep 1, 2014 at 8:57 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Introduce one early parameters "off" for "acpi" to disable ACPI on
>> ARM64.
> 
> It might be worth mentioning the purpose of this in the changelog (and
> maybe the documentation).  I don't think this parameter is supported
> on ia64, and on x86 it seems like it's mostly used as a "fix" by
> Ubuntu users who consider the problem resolved when they find this
> parameter.  That just means we don't get a chance to fix the real
> underlying problem, so I'm not sure it's a real benefit to have the
> parameter.

>> -       acpi=           [HW,ACPI,X86]
>> +       acpi=           [HW,ACPI,X86,ARM]
>>                         Advanced Configuration and Power Interface
>>                         Format: { force | off | strict | noirq | rsdt }
>>                         force -- enable ACPI if default was off
>> @@ -175,6 +175,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>                                 strictly ACPI specification compliant.
>>                         rsdt -- prefer RSDT over (default) XSDT
>>                         copy_dsdt -- copy DSDT to memory
>> +                       For ARM64, ONLY "acpi=off" is available.

Something along the lines of:

"The purpose of disabling ACPI on 64-bit ARM server platforms is to
allow for an orderly adoption of ACPI on early systems that may also
provide a DeviceTree based boot option initially. The acpi= option
disables both parsing of any tables passed in through the EFI System
Table RSDP and also disables the runtime ACPI interpreter on arm64".

On our internal systems, we've both ACPI and DeviceTree working with a
simple switch (acpi=) to determine the behavior, which is facilitating
an orderly total migration to ACPI that is in currently in flight.

Jon.
