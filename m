From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC v2 3/5] hmem: add heterogeneous memory sysfs support
Date: Fri, 7 Jul 2017 10:32:13 -0600
Message-ID: <20170707163213.GC22856@linux.intel.com>
References: <20170706215233.11329-1-ross.zwisler@linux.intel.com>
 <20170706215233.11329-4-ross.zwisler@linux.intel.com>
 <9ea40a37-3549-2294-8605-036b37aec023@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9ea40a37-3549-2294-8605-036b37aec023-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Box, David E" <david.e.box-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Anaczkowski,
 Lukasz" <lukasz.anaczkowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Odzioba,
 Lukasz" <lukasz.odzioba-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Schmauss, Erik" <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, "Kogut, Jaroslaw" <Jaroslaw.Kogut-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Lahtinen, Joonas" <joonas.lahtinen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2017 at 10:53:39PM -0700, John Hubbard wrote:
> On 07/06/2017 02:52 PM, Ross Zwisler wrote:
> [...]
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index b1aacfc..31e3f20 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -72,6 +72,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
> >  obj-$(CONFIG_ACPI)		+= container.o
> >  obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
> >  obj-$(CONFIG_ACPI_NFIT)		+= nfit/
> > +obj-$(CONFIG_ACPI_HMEM)		+= hmem/
> >  obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
> >  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
> >  obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
> 
> Hi Ross,
> 
> Following are a series of suggestions, intended to clarify naming just
> enough so that, when Jerome's HMM patchset lands, we'll be able to
> tell the difference between the two types of Heterogeneous Memory.

Sure, these all seem sane to me, thanks.  I'll fix this up in v3.
