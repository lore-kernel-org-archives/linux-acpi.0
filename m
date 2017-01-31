From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Date: Tue, 31 Jan 2017 11:42:33 +0000
Message-ID: <20170131114233.GB11191@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-9-fu.wei@linaro.org>
 <20170124172400.GG7572@leverpostej>
 <CADyBb7sU6DVMk6px0963r8by--U-3k_XjESd88zZMkj7xbywgA@mail.gmail.com>
 <20170125172505.GB29027@leverpostej>
 <CADyBb7syNx+HJ6t5JKPMnLqvq-98kPi1knuXU=SSe6_Uz6Gg1A@mail.gmail.com>
 <20170130174958.GA3496@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170130174958.GA3496@leverpostej>
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
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julien Grall <julien.grall@arm.com>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2017 at 05:49:59PM +0000, Mark Rutland wrote:
> On Thu, Jan 26, 2017 at 01:49:03PM +0800, Fu Wei wrote:

> > And because Linux kernel is running on Non-secure EL1, so should we
> > skip "SECURE" timer in Linux?
> 
> I guess you mean by checking the GTx Common flags, to see if the timer
> is secure? Yes, we must skip those.
> 
> Looking further at this, the ACPI spec is sorely lacking any statement
> as to the configuration of CNTCTLBase.{CNTSAR,CNTTIDR,CNTACR}, so it's
> not clear if we can access anything in a frame, even if it is listed as
> being a non-secure timer.

Given CNTNSAR.NS<n> enables non-secure access to CNTACR<n>, I guess the
obvious interpretation is that for frames listed as non-secure, this has
been configured to permit non-secure access to the frame and associated
CNTACR<n>.

I will work to that assumption while reviewing, though I still believe
this needs to be clarified in the spec.

Thanks,
Mark.
