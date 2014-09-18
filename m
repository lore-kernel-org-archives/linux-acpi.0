From: Joe.C <srv_yingjoe.chen@mediatek.com>
Subject: Re: [RFC Part2 v1 01/21] irqdomain: Introduce new interfaces to
 support hierarchy irqdomains
Date: Thu, 18 Sep 2014 16:48:07 +0800
Message-ID: <1411030087.14746.2.camel@mtksdaap41>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <1410444228-3134-2-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410444228-3134-2-git-send-email-jiang.liu@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Zyngier <marc.zyngier@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joerg Roedel <joro@8bytes.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2014-09-11 at 22:03 +0800, Jiang Liu wrote:
> +#else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
> +static inline int irq_domain_activate_irq(struct irq_data *data) { return 0; }
> +static inline int irq_domain_deactivate_irq(struct irq_data *data) { return 0; }
> +#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
> +

I get the following build warnings on these lines:

../include/linux/irqdomain.h:75:47: warning: 'struct irq_data' declared
inside parameter list [enabled by default]
../include/linux/irqdomain.h:75:47: warning: its scope is only this
definition or declaration, which is probably not what you want [enabled
by default]
../include/linux/irqdomain.h:76:49: warning: 'struct irq_data' declared
inside parameter list [enabled by default

Joe.C
