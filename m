From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v4 11/18] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Fri, 12 Sep 2014 15:47:00 -0400
Message-ID: <54134DB4.6010705@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-12-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410530416-30200-12-git-send-email-hanjun.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Robert Moore <robert.moore@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Lv Zheng <lv.zheng@intel.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Graeme Gregory <graeme.gregory@linaro.org>, linux-arm-kernel@lists.infradead.org, Charles.Garcia-Tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

On 09/12/2014 10:00 AM, Hanjun Guo wrote:
> MADT contains the information for MPIDR which is essential for
> SMP initialization, parse the GIC cpu interface structures to
> get the MPIDR value and map it to cpu_logical_map(), and add
> enabled cpu with valid MPIDR into cpu_possible_map.
> 
> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
> Parking protocol, but the Parking protocol is only specified for
> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
> before some updates for the ACPI spec or the Parking protocol spec.

As an aside, initial support for the Parking Protocol is working on test
systems within Red Hat at this time. Additional patches for that will be
posted separately, however Parking Protocol is not the preferred option
on ARMv8 (PSCI should be the default). Consequently, support for those
limited number of systems doing Parking Protocol can follow after the
initial support for longer term PSCI is enabled.

Jon.
