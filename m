From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Tue, 06 Jan 2015 11:24:43 -0500
Message-ID: <54AC0C4B.1000907@redhat.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <54A28B22.7090305@linaro.org> <20150105131302.GB14967@e104818-lin.cambridge.arm.com> <1797489.PjmKzBFdQA@wuerfel> <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, graeme.gr
List-Id: linux-acpi@vger.kernel.org

On 01/06/2015 06:20 AM, Catalin Marinas wrote:

> Now, what's preventing a vendor firmware from providing only ACPI
> tables? Do we enforce it in some way (arm-acpi.txt, kernel warning etc.)
> that both DT and ACPI are supported, or at least that dts files are
> merged in the kernel first?

I know of some (server) firmware that will only provide ACPI in the
medium term, so this is coming.

Jon.
