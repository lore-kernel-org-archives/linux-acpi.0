From: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] EDAC, skx_edac: Detect non-volatile DIMMs
Date: Tue, 13 Mar 2018 08:59:56 -0700
Message-ID: <20180313155956.zapcx3l5bb72w4yz@agluck-desk>
References: <CAPcyv4iHr9nUAS0SiFeqqDkU8NXZ_x=rkD3YS010Dy-nbHJXmA@mail.gmail.com>
 <20180312182430.10335-1-tony.luck@intel.com>
 <20180312182430.10335-6-tony.luck@intel.com>
 <20180313105901.0f18d027@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180313105901.0f18d027@endymion>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 13, 2018 at 10:59:01AM +0100, Jean Delvare wrote:
> > +	edac_dbg(0, "mc#%d: channel %d, dimm %d, %llu Mb (%u pages)\n",
> 
> I did not notice on previous review, but I think "b" in general means
> bit not byte, so "MB" would be better.

Heh! We've been cut & pasting that line from EDAC drivers since the i7core_edac.c
I think the origin is in 2.6.35. So you are far from the only person to not
notice it in a review :-)

> 
> > +		 imc->mc, chan, dimmno, size >> 20, dimm->nr_pages);
> > +
> > +	snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
> > +		 imc->src_id, imc->lmc, chan, dimmno);
> > +
> > +	return 1;
> > +}
> 
> Now this function always return 1, that doesn't make a lot of sense?

I could fix the return to be:


diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
index 84c18bb1e0cd..1a66e145c0bd 100644
--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -429,7 +429,7 @@ static int get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 	snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
 		 imc->src_id, imc->lmc, chan, dimmno);
 
-	return 1;
+	return (size == 0 || size == ~0ull) ? 0 : 1;
 }
 
 #define SKX_GET_MTMTR(dev, reg) \



> Other than these details, the dmi-related code looks good to me now.
> 
> Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> # for DMI

Thanks.  Boris ... ready to go now? Or do you have some other comments?

-Tony
