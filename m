From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Thu, 18 Dec 2014 14:01:29 -0600
Message-ID: <54933299.9030902@amd.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, "Charles.Garcia-Tobin@arm.com" <Charles.Garcia-Tobin@arm.com>, "Kangkang.Shen@huawei.com" <Kangkang.Shen@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 10/17/2014 8:37 AM, Hanjun Guo wrote:

> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> Add documentation for the guidelines of how to use ACPI
> on ARM64.
>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>   Documentation/arm64/arm-acpi.txt |  323
> ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 323 insertions(+)
>   create mode 100644 Documentation/arm64/arm-acpi.txt
>[...]

AMD has reviewed this document, and currently implements ACPI table in 
the firmware for AMD Seattle platform based on the documentation 
published here:

http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Seattle_ACPI_Guide.pdf

Reviewed-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Thank you,

Suravee
