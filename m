From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 0/5] arm64: SPE ACPI enablement
Date: Wed, 1 May 2019 15:15:06 +0100
Message-ID: <20190501141506.GC27353@fuggles.cambridge.arm.com>
References: <20190426220309.55654-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190426220309.55654-1-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, john.garry@huawei.com, rjw@rjwysocki.net, linuxarm@huawei.com, linux-acpi@vger.kernel.org, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Jeremy,

On Fri, Apr 26, 2019 at 05:03:04PM -0500, Jeremy Linton wrote:
> This patch series enables the Arm Statistical Profiling
> Extension (SPE) on ACPI platforms.
> 
> This is possible because ACPI 6.3 uses a previously
> reserved field in the MADT to store the SPE interrupt
> number, similarly to how the normal PMU is described.
> If a consistent valid interrupt exists across all the
> cores in the system, a platform device is registered.
> That then triggers the SPE module, which runs as normal.
> 
> This version also adds the ability to parse the PPTT for
> IDENTICAL cores. We then use this to sanity check the
> single SPE device we create. This creates a bit of a
> problem with respect to the specification though. The
> specification says that its legal for multiple tree's
> to exist in the PPTT. We handle this fine, but what
> happens in the case of multiple tree's is that the lack
> of a common node with IDENTICAL set forces us to assume
> that there are multiple non IDENTICAL cores in the
> machine.

This looks good to me. Please can you respin, addressing Raphael's
outstanding concerns on the third patch?

Will
