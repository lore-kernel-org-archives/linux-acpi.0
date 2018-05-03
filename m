From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
Date: Thu, 3 May 2018 16:15:13 +0100
Message-ID: <20180503151513.GD28409@work-enc>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180425233121.13270-12-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, Sudeep.Holla@arm.com, linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com, Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com, palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com, ard.biesheuvel@linaro.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 25, 2018 at 06:31:19PM -0500, Jeremy Linton wrote:
> Propagate the topology information from the PPTT tree to the
> cpu_topology array. We can get the thread id and core_id by assuming
> certain levels of the PPTT tree correspond to those concepts.
> The package_id is flagged in the tree and can be found by calling
> find_acpi_cpu_topology_package() which terminates
> its search when it finds an ACPI node flagged as the physical
> package. If the tree doesn't contain enough levels to represent
> all of the requested levels then the root node will be returned
> for all subsequent levels.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
