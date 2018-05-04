From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 00/13] Support PPTT for ARM64
Date: Fri, 4 May 2018 12:44:59 +0100
Message-ID: <493de8bf-b59e-cfac-6e34-f4c1443ee0fe@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <050a01d3e37f$57678470$06368d50$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <050a01d3e37f$57678470$06368d50$@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: vkilari@codeaurora.org, 'Jeremy Linton' <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com, Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, ahs3@redhat.com, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com, ard.biesheuvel@linaro.org
List-Id: linux-acpi@vger.kernel.org

Hi Vijaya Kumar,

On 04/05/18 09:10, vkilari@codeaurora.org wrote:
> 
[...]

CPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to
>> describe the processor and cache topology. Ideally it is used to
> extend/override

FYI, these messages go no where to the git commit log. Only individual
patch logs/messages will go and not the cover letter ones. Check if you
are happy with those.

-- 
Regards,
Sudeep
