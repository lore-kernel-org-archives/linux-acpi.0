From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [Pcihpd-discuss] Re: ACPI problem with PCI Express Native Hot-plug driver
Date: Fri, 30 Sep 2005 13:24:41 -0700
Message-ID: <20050930132440.C28328@unix-os.sc.intel.com>
References: <b115cb5f0509020057741365dc@mail.gmail.com> <b115cb5f050902005877607db1@mail.gmail.com> <1125683188.13185.5.camel@whizzy> <b115cb5f05090418583abfc73@mail.gmail.com> <b115cb5f0509292257j395d60f8j53d1afa967caa263@mail.gmail.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-newbie-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b115cb5f0509292257j395d60f8j53d1afa967caa263@mail.gmail.com>; from rajat.noida.india@gmail.com on Fri, Sep 30, 2005 at 02:57:07PM +0900
Sender: linux-newbie-owner@vger.kernel.org
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>, Linux-newbie@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org, greg@kroah.com, dkumar@noida.hcltech.com, sanjayku@noida.hcltech.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 30, 2005 at 02:57:07PM +0900, Rajat Jain wrote:
> 
> pciehp: pfar:cannot locate acpi bridge of PCI 0xb.
> ......
> pciehp: pfar:cannot locate acpi bridge of PCI 0xe.

This is saying that the driver's probe function was called for
these pciehp capable bridges, but it didn't find them in the
ACPI namespace. 

> 
> I am not sure where the problem lies. But the fact that the entries
> are appearing correctly when I disable ACPI, combined with above error
> messages, I suspect that there is a problem with ACPI namespace
> (probably the resources cannot be found using ACPI).
> 
At init time, the pciehp driver scans the ACPI namespace and tries
to collect resources for all bridges - host as well as PCI. It's
pretty rare for BIOS to describe PCI bridge resources in ACPI
namespace, so that's not unusual. What's unexpected is that these
pciehp bridges weren't even listed in the namespace.

With the pciehp version that has acpi disabled, it's not going to
try to get bridge resources and other information from acpi. In
that case, it simply reads the bridge config space to determine
resource ranges it is decoding. This is what the acpi version of
pciehp also defaults to for PCI bridges that are listed without
resource descriptions in the acpi namespace. So, the error you
are running into is somewhat bogus. The proper long term fix
is to change pciehp to not depend so much on acpi and just use
the pci core for resource management. In the meantime, you should
just use the non-acpi version of pciehp. 

Rajesh

-
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
