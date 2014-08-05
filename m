From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 18/18] Documentation: ACPI for ARM64
Date: Tue, 05 Aug 2014 11:36:05 +0800
Message-ID: <53E05125.1030007@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-19-git-send-email-hanjun.guo@linaro.org>
 <53DFF18B.5080509@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53DFF18B.5080509@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>
Cc: linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, linux-kernel@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On 2014-8-5 4:48, Randy Dunlap wrote:
> On 08/04/14 08:28, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> Add documentation for the guidelines of how to use ACPI
>> on ARM64.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  Documentation/arm64/arm-acpi.txt |  215 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 215 insertions(+)
>>  create mode 100644 Documentation/arm64/arm-acpi.txt
>>
>> diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
>> new file mode 100644
>> index 0000000..a6e14a2
>> --- /dev/null
>> +++ b/Documentation/arm64/arm-acpi.txt
>> @@ -0,0 +1,215 @@
>> +ACPI on ARMv8 Servers
>> +---------------------
>> +
> 
> ...
> 
>> +
>> +ACPI Detection
>> +--------------
>> +
>> +Drivers should determine their probe() type by checking for ACPI_HANDLE,
>> +or .of_node, or other information in the device structure. This is
>> +detailed further in the "Driver Recommendations" section.
>> +
>> +In non-driver code If the presence of ACPI needs to be detected at runtime,
>> +then check the value of acpi_disabled. If CONFIG_ACPI not being set,
> 
>                                           If CONFIG_ACPI is not set,

Good catch, We will update it.

Thanks
Hanjun
