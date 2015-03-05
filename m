From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v9 21/21] ARM64 / ACPI: additions of ACPI documentation
 for arm64
Date: Thu, 5 Mar 2015 10:54:18 -0800
Message-ID: <20150305185418.GG4932@quad.lixom.net>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-22-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424853601-6675-22-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>, Yi Li <phoenix.liyi@huawei.com>, Mark Langsdorf <mlangsdo@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 25, 2015 at 04:40:01PM +0800, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Two more documentation files are also being added:
> (1) A verbatim copy of the "Why ACPI on ARM?" blog posting by Grant Likely,
>     which is also summarized in arm-acpi.txt, and

This doesn't belong in the kernel tree.

> (2) A section by section review of the ACPI spec (acpi_object_usage.txt)
>     to note recommendations and prohibitions on the use of the numerous
>     ACPI tables and objects.  This sets out the current expectations of
>     the firmware by Linux very explicitly (or as explicitly as I can, for
>     now).

I'll follow up with any comments on this separately (I.e. haven't read it yet).


-Olof
