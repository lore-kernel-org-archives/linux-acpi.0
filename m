From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 3/4] ipmi: Convert tracking of the
	ACPI device pointer	to a PNP device
Date: Fri, 05 Mar 2010 09:46:40 +0800
Message-ID: <1267753600.3613.128.camel@localhost.localdomain>
References: <20100304033146.30205.68689.stgit@bob.kio>
	<20100304034420.30205.7749.stgit@bob.kio>
	<1267694410.3613.96.camel@localhost.localdomain>
	<1267735701.2437.212.camel@zim>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <1267735701.2437.212.camel@zim>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Myron Stowe <myron.stowe@hp.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2010-03-05 at 04:48 +0800, Myron Stowe wrote:
> On Thu, 2010-03-04 at 17:20 +0800, ykzhao wrote:
> > On Thu, 2010-03-04 at 11:44 +0800, Myron Stowe wrote:
> > > Convert PNP patch (git 9e368fa011d4e0aa050db348d69514900520e40b) to
> > > maintain a pointer to a PNP device, 'pnp_dev', instead of the ACPI
> > > device, 'acpi_dev', that is currently being tracked with PNP based
> > > IPMI device discovery.
> > 
> > Hi, Myron
> > 	Now the IPMI interface defined in ACPI namespace is detected by using
> > PNP device driver. But it seems that this still belongs to ACPI
> > detection mechanism.
> 
> Hi Yakui:
> 
> The ACPI namespace enumerated IPMI interface is indeed detected via PNP.
> This definitely can be a little confusing, especially in light of the
> fact that ACPI detection mechanisms exist.  The reasoning for using PNP
> is based on the fact that within Linux, PNP subsumes ACPI (and ISA,
> EIAS, and also PNP BIOS).  Using a Venn diagram to model the situation
> produces something like:
>   --------------------
>   | PNP              |
>   |     -----------  |
>   |     | ACPI    |  |
>   |     -----------  |
>   |                  |
>   --------------------
> I left ISA, EISA, and PNP BIOS out of the Venn diagram since ascii based
> diagrams are so horrific already but each would also be a distinct,
> non-overlapping, component within PNP.
> 

Hi, Myron
    Thanks for the detailed explanation.
    It seems that the ACPI device is firstly added to the system. And
then we will add the corresponding PNP device based on detected ACPI
device so that most available PNP device drivers still can be used.
Although sometimes both the PNP device and ACPI device are added, they
will point to the same physical device. Right?
    Of course it will be clearer if the info->dev = pnp_dev->dev. It
indicates that it is tracked by PNP dev.

> >  At the same time IPMI device defined in ACPI
> > namespace is also used to enable the communication between ACPI and
> > IPMI device. In such case it will be better to know whether the IPMI
> > interface is discovered by using ACPI detection mechanism , which can
> > be realized by comparing the info->dev with acpi_dev->dev.
> 
> I'm thinking your concern here is related to the IPMI op-region patch
> you have produced that Corey has not yet taken in.

Yes. The ACPI IPMI opregion patch tries to enable the communication
between ACPI and IPMI device by comparing the info->dev and
acpi_dev->dev. Info->dev will be passed as the argument of
ipmi_smi_watcher callback function(new_smi), in which we create the
communication channel between ACPI and IPMI.

If we change the info->dev from acpi_dev->dev to pnp_dev->dev, then we
will use another mechanism to check whether the IPMI device is defined
in ACPI namespace. Of course it will be simpler.

> 
> One can still obtain an 'acpi_device' handle from the 'pnp_dev' handle
> that 'ipmi_pnp_probe()' is given.  The 'opregion_setup()' routine
> provides such.  I was going to provide an example but looking at
> 'ipmi_pnp_probe()' it is already being used at the very top of the
> routine so you should be able to use 'acpi_dev'; it is already provided
> and setup.  More so, one will not make it into the body of
> 'ipmi_pnp_probe()' unless the device was enumerated via ACPI namespace
> due to the check against the just mentioned 'acpi_dev' setup (in other
> words, if there were an IPMI device that was enumerated via PNP BIOS the
> check would have detected such and already bailed out).  This seems to
> provide the means for detection type checking that you are alluding to.

Very good explanation. And you are right. Now the ipmi pnp device driver
is only effective to the IPMI device defined in ACPI namespace. 

> 
> > 	Can we still use the acpi_dev->dev to track the IPMI device
> > discovery?
> 
> The existing 'acpi_dev' provides both a means for detection type
> checking and, seems much simpler than carrying forward and maintaining
> some type of info->dev acpi_dev->dev based comparison.
> 
> Myron
> > 
> > thanks.
> >      Yakui
> >         
> > > 
> > > Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> > > ---
> > > 
> > >  drivers/char/ipmi/ipmi_si_intf.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > > index 806ae83..37c6912 100644
> > > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > > @@ -1934,7 +1934,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
> > >  		info->irq_setup = std_irq_setup;
> > >  	}
> > >  
> > > -	info->dev = &acpi_dev->dev;
> > > +	info->dev = &dev->dev;
> > >  	pnp_set_drvdata(dev, info);
> > >  
> > >  	return try_smi_init(info);
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
