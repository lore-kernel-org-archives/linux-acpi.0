From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: Fri, 18 Mar 2005 09:09:10 +0800
Message-ID: <1111108150.22239.6.camel@sli10-desk.sh.intel.com>
References: <1110989436.8378.19.camel@eeyore>
	 <1111023217.15278.7.camel@sli10-desk.sh.intel.com>
	 <1111082914.11380.30.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111082914.11380.30.camel@eeyore>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Grzegorz Kulewski <kangur@polcom.net>, Andrew Morton <akpm@osdl.org>, ACPI List <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-03-18 at 02:08, Bjorn Helgaas wrote:
> On Thu, 2005-03-17 at 09:33 +0800, Li Shaohua wrote:
> > The comments in previous quirk said it's required only in PIC mode.
> ...
> > I feel we concerned too much. Changing the interrupt line isn't harmful,
> > right? Linux actually ignored interrupt line. Maybe just a
> > PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq) is
> > sufficient.
> 
> I think it's good to limit the scope of the quirk as much as
> possible because that makes it easier to do future restructuring,
> such as device-specific interrupt routers.
> 
> The comment (before quirk_via_acpi(), nowhere near quirk_via_irqpic())
> says *on-chip devices* have this unusual behavior when the interrupt
> line is written.  That makes sense to me.
> 
> Writing the interrupt line on random plug-in Via PCI devices does
> not make sense to me, because for that to have any effect, an
> upstream bridge would have to be snooping the traffic going through
> it.  That doesn't sound plausible to me.
> 
> What about this:
Hmm, this looks like previous solution. We removed the specific via
quirk is because we don't know how many devices have such issue. Every
time we encounter an IRQ issue in a VIA PCI device, we will suspect it
requires quirk and keep try. This is a big overhead. 

Thanks,
Shaohua
