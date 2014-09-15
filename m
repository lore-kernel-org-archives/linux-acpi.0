From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v4 06/18] ARM64 / ACPI: Introduce early_param for "acpi"
Date: Tue, 16 Sep 2014 06:55:49 +0800
Message-ID: <54176E75.1000803@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org> <1410530416-30200-7-git-send-email-hanjun.guo@linaro.org> <20140915062824.GB26649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140915062824.GB26649@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B409=E6=9C=8815=E6=97=A5 14:28, Olof Johansson wrote:
> On Fri, Sep 12, 2014 at 10:00:04PM +0800, Hanjun Guo wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Introduce one early parameters "off" for "acpi" to disable ACPI on
>> ARM64.
>>
>> This ensures the kernel uses the DT on a platform that provides both
>> ACPI tables and DT.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  Documentation/kernel-parameters.txt |    3 ++-
>>  arch/arm64/kernel/acpi.c            |   15 +++++++++++++++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/ker=
nel-parameters.txt
>> index 5ae8608..9dfb1d8 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -165,7 +165,7 @@ multipliers 'Kilo', 'Mega', and 'Giga', equallin=
g 2^10, 2^20, and 2^30
>>  bytes respectively. Such letter suffixes can also be entirely omitt=
ed.
>> =20
>> =20
>> -	acpi=3D		[HW,ACPI,X86]
>> +	acpi=3D		[HW,ACPI,X86,ARM]
> ARM64, not ARM.

I will update it.

Thanks
Hanjun
