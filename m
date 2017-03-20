From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v21 01/13] clocksource: arm_arch_timer: introduce two
 functions to get the frequency from mmio and sysreg.
Date: Mon, 20 Mar 2017 10:41:54 +0000
Message-ID: <20170320104153.GA18585@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-2-fu.wei@linaro.org>
 <20170317180513.GB15909@leverpostej>
 <CADyBb7vZ4G+q1y6w6OVQ7i-ZiTtcdx_w2BOSWqy=2jWhAV6Hmw@mail.gmail.com>
 <CADyBb7vawnjnL6Phxc_owTnEK0qf95cYAUWPga9axGqEWc46Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7vawnjnL6Phxc_owTnEK0qf95cYAUWPga9axGqEWc46Ww@mail.gmail.com>
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

On Mon, Mar 20, 2017 at 05:43:29PM +0800, Fu Wei wrote:
> On 20 March 2017 at 15:36, Fu Wei <fu.wei@linaro.org> wrote:
> > On 18 March 2017 at 02:05, Mark Rutland <mark.rutland@arm.com> wrote:
> >> On Tue, Feb 07, 2017 at 02:50:03AM +0800, fu.wei@linaro.org wrote:

> >>> +static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
> >>> +{
> >>> +     /*
> >>> +      * Try to get the frequency from the CNTFRQ of timer frame registers.
> >>> +      * Note: please verify cntbase in caller.
> >>> +      */
> >>> +     return readl_relaxed(cntbase + CNTFRQ);
> >>> +}
> >>
> >> Wrapping the MMIO read makes sense if we're going to do this in more
> >> than one place, so I'm happy with this wrapper.
> >>
> >> If you can s/arch_timer_get_mmio_freq/arch_timer_get_cntfrq/, and drop
> >
> > sorry, May I guess that is
> > "s/arch_timer_get_mmio_freq/arch_timer_get_mmio_cntfrq/"
> > or
> > "s/arch_timer_get_mmio_freq/arch_timer_mem_get_cntfrq/"
> >
> > which one do you prefer? :-)
> 
> keeping using arch_timer_get_cntfrq();  for per-CPU arch timer, then
> 
> +static u32 arch_timer_mem_get_cntfrq(void __iomem *cntbase)
> +{
> +       return readl_relaxed(cntbase + CNTFRQ);
> +}
> +

That looks perfect to me.

Sorry for the confusion above!

Mark.
