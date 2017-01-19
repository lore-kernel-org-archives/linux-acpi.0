From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v20 13/17] acpi/arm64: Add GTDT table parse driver
Date: Thu, 19 Jan 2017 11:16:28 +0000
Message-ID: <20170119111628.GC11176@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-14-fu.wei@linaro.org>
 <e69d80d1-0954-b1be-817e-c0be6fc24b77@linaro.org>
 <CADyBb7tdfw+wbTZbcnsaHRa=aG6i9acLp7rzMpfMs-vOHXL6pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7tdfw+wbTZbcnsaHRa=aG6i9acLp7rzMpfMs-vOHXL6pQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fu Wei <fu.wei@linaro.org>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, G Gregory <graeme.gre>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 19, 2017 at 06:32:55PM +0800, Fu Wei wrote:
> On 19 January 2017 at 17:11, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > On 2017/1/18 21:25, fu.wei@linaro.org wrote:
> >> From: Fu Wei <fu.wei@linaro.org>

> >> +       else if (!gtdt->platform_timer_count)
> >> +               pr_debug("No Platform Timer.\n");
> >> +       else
> >> +               timer_count = gtdt->platform_timer_count;
> >> +
> >> +       if (timer_count) {
> >> +               platform_timer = (void *)gtdt +
> >> gtdt->platform_timer_offset;
> >> +               if (platform_timer < (void *)table +
> >> +                                    sizeof(struct acpi_table_gtdt)) {
> >> +                       pr_err(FW_BUG "invalid timer data.\n");
> >
> >
> > It's ok but I didn't see other ACPI tables parsing did this check,
> > maybe we can just remove it :)
> 
> here, I want to make sure the FW is valid.
> Once there is a FW bug, we could just return with error.  :-)

Yes, please keep the check!

If anything, it would be nicer for the other ACPI code to verify things
a little more stringently.

Thanks,
Mark.
