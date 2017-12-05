From: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 4/4] EDAC, skx_edac: Detect non-volatile DIMMs
Date: Tue, 5 Dec 2017 12:03:37 -0800
Message-ID: <20171205200336.tbx7oypjuca3g6vn@agluck-desk>
References: <cover.1512070562.git.tony.luck@intel.com>
 <da4c989314e82ec29195804ba5349ac3136f74c0.1512070562.git.tony.luck@intel.com>
 <20171205105451.ob23asixm726hysb@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171205105451.ob23asixm726hysb-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-edac-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 05, 2017 at 11:54:51AM +0100, Borislav Petkov wrote:
> On Thu, Nov 30, 2017 at 12:40:42PM -0800, Tony Luck wrote:
> >  config EDAC_SKX
> >  	tristate "Intel Skylake server Integrated MC"
> >  	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
> > +	select DMI
> > +	select ACPI_NFIT
> 
> Hmm, that ACPI_NFIT depends on a bunch of stuff and enabling EDAC_SKX
> would pull in all that. Should we make this a user choice instead?
> 
> I mean, there could be boxes which don't have nvdimms so all that code
> would be dead weight there...

I could. But what happens when someone ends up on a system with
an edac driver configured without ACPI_NFIT that does have NVDIMMs?

I can make a stub version of nfit_get_smbios_id() that returns some
error code ... and have the EDAC driver report size==0.

Would that be OK?


> <---- newline here.
> 
> > +	size = dmi_memdev_size(smbios_handle);
> > +	if (size == ~0ul) {
> > +		skx_printk(KERN_ERR, "Can't find size for NVDIMM ADR=%x/SMBIOS=%x\n",
> > +			   dev_handle, smbios_handle);
> > +		return 0;
> > +	}
> 
> Ditto.
> 
> > +	edac_dbg(0, "mc#%d: channel %d, dimm %d, %lld Mb (%lld pages)\n",
> > +		 imc->mc, chan, dimmno, size >> 20, size >> PAGE_SHIFT);
> > +
> > +	dimm->nr_pages = size >> PAGE_SHIFT;
> > +	dimm->grain = 32;
> > +	dimm->dtype = DEV_UNKNOWN;
> > +	dimm->mtype = MEM_NVDIMM;
> > +	dimm->edac_mode = EDAC_SECDED; /* likely better than this */
> 
> Ditto.
> 
> /me hands aegl a bunch of newlines - seems he's all out of \n's

/me finds that the "Enter" key on his keyboard will put in a newline.
Hurrah! now I don't have to copy/paste them from Boris.

-Tony
