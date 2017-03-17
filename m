From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v21 00/13] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Fri, 17 Mar 2017 20:03:47 +0000
Message-ID: <20170317200346.GG15909@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <CADyBb7t_zrLetPQQ8=k8oN6iMHhuMHO8O3XTZqGYvTT9p0evKw@mail.gmail.com>
 <CADyBb7urVf87LTsyrtoaAExTeOZSBAvT91enGBK4cm6723q+1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7urVf87LTsyrtoaAExTeOZSBAvT91enGBK4cm6723q+1Q@mail.gmail.com>
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

On Thu, Mar 09, 2017 at 11:47:16PM +0100, Fu Wei wrote:
> Hi Mark, Marc,

Hi,

> I have tried to rebase all the 19(6+13) patches  on 4.11-rc1,
> all the patchse can directly apply on  4.11-rc1,
> 
> Could you help to review the patches, and see if there is anywhere I
> can improve ?

I'm sorry I have taken so long to review this posting.

This is generally looking much better. I'm not sure about a few details
relating to the watchdog, but I'm largely happy to pick up the rest of
the series, if you can address my comments.

Thanks,
Mark.
