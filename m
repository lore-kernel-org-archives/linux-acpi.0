From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v19 10/15] clocksource/drivers/arm_arch_timer: Refactor
 the timer init code to prepare for GTDT
Date: Tue, 17 Jan 2017 12:29:21 +0000
Message-ID: <20170117122921.GE11939@leverpostej>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-11-fu.wei@linaro.org>
 <20170116183032.GL5908@leverpostej>
 <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
 <b977f47b-a85e-d4d5-666c-b8c9cd21c25e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b977f47b-a85e-d4d5-666c-b8c9cd21c25e@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Fu Wei <fu.wei@linaro.org>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, G Gregory <graeme.gregory@li>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2017 at 06:18:12AM -0600, Timur Tabi wrote:
> Fu Wei wrote:
> >if (i >= ARCH_TIMER_MEM_MAX_FRAMES) {
> >        pr_err(FW_BUG "too many frames, ARMv8 spec only allows 8.\n");
> 
> pr_err(FW_BUG "too many frames, ARMv8 spec only allows %u.\n",
> 	ARCH_TIMER_MEM_MAX_FRAMES);

While I don't see ARCH_TIMER_MEM_MAX_FRAMES changing, this would be
nicer to ensure the result obviously matches.

As for wording, I'd perfer:

	pr_err(FW_BUG "too many frames, only %u are permitted.\n",
	       ARCH_TIMER_MEM_MAX_FRAMES);

... so as to avoid any confusion between spec versions and so on. We can
reconsider the message if/when that changes.

Thanks,
Mark.
