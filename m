From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RESEND PATCH] ACPI/IORT: Fix rc_dma_get_range()
Date: Fri, 11 Jan 2019 10:03:20 +0000
Message-ID: <20190111100320.GA19110@fuggles.cambridge.arm.com>
References: <20190110184151.27492-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190110184151.27492-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 10, 2019 at 06:41:51PM +0000, Lorenzo Pieralisi wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> When executed for a PCI_ROOT_COMPLEX type, iort_match_node_callback()
> expects the opaque pointer argument to be a PCI bus device. At the
> moment rc_dma_get_range() passes the PCI endpoint instead of the bus,
> and we've been lucky to have pci_domain_nr(ptr) return 0 instead of
> crashing. Pass the bus device to iort_scan_node().
> 
> Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Cc: stable@vger.kernel.org
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
> Will, Catalin,
> 
> resending a reformatted version of this fix previously posted in [1],
> please merge it for one of the upcoming -rc.

Thanks, I'll push this out later today.

Will
