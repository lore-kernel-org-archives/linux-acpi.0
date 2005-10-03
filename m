From: Rajat Jain <rajat.noida.india@gmail.com>
Subject: Re: [Pcihpd-discuss] Re: ACPI problem with PCI Express Native Hot-plug driver
Date: Mon, 3 Oct 2005 14:07:26 +0900
Message-ID: <b115cb5f0510022207k41df0380nfb8b4ee73149f7ea@mail.gmail.com>
References: <b115cb5f0509020057741365dc@mail.gmail.com>
	 <b115cb5f050902005877607db1@mail.gmail.com>
	 <1125683188.13185.5.camel@whizzy>
	 <b115cb5f05090418583abfc73@mail.gmail.com>
	 <b115cb5f0509292257j395d60f8j53d1afa967caa263@mail.gmail.com>
	 <20050930132440.C28328@unix-os.sc.intel.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750822AbVJCFH3@vger.kernel.org>
In-Reply-To: <20050930132440.C28328@unix-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>, Linux-newbie@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org, greg@kroah.com, dkumar@noida.hcltech.com, sanjayku@noida.hcltech.com
List-Id: linux-acpi@vger.kernel.org

On 10/1/05, Rajesh Shah <rajesh.shah@intel.com> wrote:
> On Fri, Sep 30, 2005 at 02:57:07PM +0900, Rajat Jain wrote:
> >
> > pciehp: pfar:cannot locate acpi bridge of PCI 0xb.
> > ......
> > pciehp: pfar:cannot locate acpi bridge of PCI 0xe.
>
> This is saying that the driver's probe function was called for
> these pciehp capable bridges, but it didn't find them in the
> ACPI namespace.
>
> >

Hi Rajesh,

Thanks for the insight. But my doubt is that the PCI Express devices
down the hot-pluggable slots are working fine. i.e. if we forget about
the hot-plugging / unplugging, the bridges and devices are working
fine, even with ACPI enabled.

So is the presence of bridges in ACPI namespace required only for
hot-plugging / unplugging and not for normal operation?

Thanks,

Rajat
