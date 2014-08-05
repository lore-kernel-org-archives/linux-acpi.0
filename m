From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v2 00/18] Introduce ACPI for ARM64 based
 on ACPI 5.1
Date: Tue, 05 Aug 2014 11:34:10 +0800
Message-ID: <53E050B2.2080609@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <CAJRNFK+UfJhGR65tOecy=X+YdHQHiNPZ4p_p8LUxhRL3GW5gFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJRNFK+UfJhGR65tOecy=X+YdHQHiNPZ4p_p8LUxhRL3GW5gFw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Spyridakis <a.spyridakis@virtualopensystems.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Robert Moore <robert.moore@intel.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On 2014-8-5 1:30, Alexander Spyridakis wrote:
> On 4 August 2014 17:28, Hanjun Guo <hanjun.guo@linaro.org
> <mailto:hanjun.guo@linaro.org>> wrote:
>>
>> ACPI 5.1 has been released and now be freely available for
>> download [1]. It fixed some major gaps to run ACPI on ARM,
>> this patch just follow the ACPI 5.1 spec and prepare the
>> code to run ACPI on ARM64.
> 
> Hello,

Hi,

> 
> Is this work still reproducible on Foundation and/or ARMv8 FVP models, as
> described in the following wiki page?
> https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI

Yes, I think so. If you meet any problem , please let us know, and we will
update the wiki.

> 
> Should I assume that UEFI is mandatory (alternative being the aarch64
> bootwrapper), as described in Documentation/arm64/arm-acpi.txt?

Yes, UEFI is mandatory if you want to use ACPI.

> 
> Thanks in advance.

You are welcome :)

Thanks
Hanjun
