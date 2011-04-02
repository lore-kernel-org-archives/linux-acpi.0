From: Mattia Dongili <malattia@linux.it>
Subject: Re: Regression 2.6.39-rc1 for sony-laptop
Date: Sun, 3 Apr 2011 00:55:50 +0900
Message-ID: <20110402155549.GA6724@kamineko.org>
References: <AANLkTi=1xtjEZc2C1=W-v2oYbvvcGH9k_DGGXvJ8=swq@mail.gmail.com>
 <20110401172241.GA26851@srcf.ucam.org>
 <BANLkTikPjwowBge82viT+Ma5UnP0fA-pew@mail.gmail.com>
 <20110402100043.GA5890@kamineko.org>
 <BANLkTikVGWM3T1y2XvwkHB+Yub5EhG1RPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTikVGWM3T1y2XvwkHB+Yub5EhG1RPA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, anssi.hannula@iki.fi, linux-acpi@vger.kernel.org, axel.lin@gmail.com, trenn@suse.de, len.brown@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 02, 2011 at 02:55:38PM +0300, Dan Carpenter wrote:
> On 4/2/11, Mattia Dongili <malattia@linux.it> wrote:
> > --- a/drivers/platform/x86/sony-laptop.c
> > +++ b/drivers/platform/x86/sony-laptop.c
> > @@ -810,6 +810,11 @@ static int sony_nc_handles_cleanup(struct
> > platform_device *pd)
> >  static int sony_find_snc_handle(int handle)
> >  {
> >  	int i;
> > +
> > +	/* not initialized yet, return early */
> > +	if (!handles)
> > +		return -1;
> 
> -1 is -EPERM.  That's not the right error code here.  Maybe -EINVAL?

this error is not propagated to userspace. If necessary I can review all
error codes in the sony-laptop internal functions (where -1 is a fairly
common return code for error conditions).

I remember a discussion on LKML recently about error codes but I'm not
sure what the outcome was (if any).

-- 
mattia
:wq!
