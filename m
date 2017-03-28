From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v22 00/11] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Tue, 28 Mar 2017 15:53:26 +0100
Message-ID: <20170328145325.GD8643@leverpostej>
References: <20170321163122.9183-1-fu.wei@linaro.org>
 <1cc5a994-0af6-79ea-930d-44b3fc789427@jonmasters.org>
 <CADyBb7ujZKDF0aUJZRUN81jor04mZ-V5ESWScAjaxoHQUeVFSA@mail.gmail.com>
 <20170328130552.GA8643@leverpostej>
 <CADyBb7vddnQ4TZXaem3q=+v=vC41J7O4cVsokn04S2jGGU8veA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7vddnQ4TZXaem3q=+v=vC41J7O4cVsokn04S2jGGU8veA@mail.gmail.com>
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
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Jon Masters <jcm@jonmasters.org>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.in
List-Id: linux-acpi@vger.kernel.org

Hi,

On Tue, Mar 28, 2017 at 10:29:10PM +0800, Fu Wei wrote:
> On 28 March 2017 at 21:05, Mark Rutland <mark.rutland@arm.com> wrote:
> > Sorry for the delay; I have not had the time to focus on this as I would
> > like to. I'm happy with patches 1-4, but from patch 5 onwards, there's
> > one change I'd like to see.
> >
> > I'd prefer that mmio timer frame rame N was always stored at
> > arch_timer_mem::frame[N], rather than arch_timer_mem::frame[] being in
> > an arbitrary order. That will make arch_timer_mem_frame::frame_nr
> > redundant.
> >
> > To allow arch_timer_mem::frame[] this to be sparse, I'm happy to have a
> > bool arch_timer_mem_frame::valid field that we set when probing each
> > frame. Then we don't need arch_timer_mem::num_frames.
> >
> > This will make iterating over the frames far less confusing, and makes
> > it simple to detect when a frame number is erroneously reused.
> >
> > Otherwise, I'm largely happy to pick the rest and apply any fixups
> > myself.
> 
> Great thanks for your feedback!
> I will follow your suggestion to improve my patches, then post it in a day.

Thanks, that is much appreciated.

> So I will rebase my patchset on arch-timer/gtdt branch of your REPO
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arch-timer/gtdt

Yes please! The current HEAD should be:

ebbfe8889cffa12f ("clocksource: arm_arch_timer: move arch_timer_needs_of_probing into DT init call").

Thanks,
Mark.
