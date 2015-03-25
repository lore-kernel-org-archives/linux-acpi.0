From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch v11 02/23] ACPI: add arm64 to the platforms that use
 ioremap
Date: Wed, 25 Mar 2015 16:43:39 +0000
Message-ID: <20150325164339.GA14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-3-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427205776-5060-3-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Timur Tabi <timur@codeaurora.org>, linux-acpi@vger.kernel.org, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 10:02:35PM +0800, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Now with the base changes to the arm memory mapping it is safe
> to convert to using ioremap to map in the tables after
> acpi_gbl_permanent_mmap is set.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Another long flight, so I'm adding some acks (unless Will merged these
patches already).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
