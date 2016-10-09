From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add ARM64-specific ACPI maintainers entry
Date: Sun, 09 Oct 2016 11:58:20 +0800
Message-ID: <57F9C05C.9050700@linaro.org>
References: <20161005112540.22189-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161005112540.22189-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On 10/05/2016 07:25 PM, Lorenzo Pieralisi wrote:
> The ARM64 architecture defines ARM64 specific ACPI bindings to
> configure and set-up arch specific components. To simplify
> code reviews/updates and streamline the maintainership structure
> supporting the arch specific code, a new arm64 directory was created in
> /drivers/acpi, to contain ACPI code that is specific to ARM64
> architecture.
>
> Add the ARM64-specific ACPI maintainers entry in MAINTAINERS for
> the newly created subdirectory and respective code content.
>
> Lorenzo Pieralisi will be in charge of submitting and managing
> the pull requests on behalf of all maintainers listed.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Link: http://lkml.kernel.org/r/1603704.EGiVTcCxLR@vostro.rjw.lan

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
