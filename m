From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Fix iort_get_platform_device_domain()
 uninitialized pointer value
Date: Thu, 29 Nov 2018 16:49:57 +0000
Message-ID: <20181129164957.GA637@e107981-ln.cambridge.arm.com>
References: <20181129095559.26007-1-lorenzo.pieralisi@arm.com>
 <c16634d2-b6b7-1251-8b31-82fef94da3e2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <c16634d2-b6b7-1251-8b31-82fef94da3e2@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 29, 2018 at 07:34:40PM +0800, Hanjun Guo wrote:
> On 2018/11/29 17:55, Lorenzo Pieralisi wrote:
> > Running the Clang static analyzer on IORT code detected the following
> > error:
> > 
> > Logic error: Branch condition evaluates to a garbage value
> > 
> > in
> > 
> > iort_get_platform_device_domain()
> > 
> > If the named component associated with a given device has no IORT
> > mappings, iort_get_platform_device_domain() exits its MSI mapping loop
> > with msi_parent pointer containing garbage, which can lead to erroneous
> > code path execution.
> 
> Not sure if we have such use cases that named component associated with
> a given device has no IORT mappings, but this patch still make sense to
> me,

Yes, it is to make the kernel more robust against questionable (but valid)
firmware bindings.

Thanks,
Lorenzo
