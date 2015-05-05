From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 3/7] ACPI / processor: Introduce invalid_logical_cpuid()
Date: Tue, 05 May 2015 11:12:52 -0400
Message-ID: <5548DDF4.2020404@oracle.com>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org> <1430793998-21631-4-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430793998-21631-4-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 05/04/2015 10:46 PM, Hanjun Guo wrote:
> In ACPI processor drivers, we use direct comparisons of cpu logical
> id with -1 which are error prone in case logical cpuid is accidentally
> assinged an error code and prevents us from returning an error-encoding
> cpuid directly in some cases.


Which is exactly what Xen code does (xen_pcpu_id() and 
xen_hotadd_cpu()). And patch 4/7 fixes this.


-boris

>
> So introduce invalid_logical_cpuid() to identify cpu with invalid
> logical cpu num, then it will be used to replace the direct comparisons
> with -1.
