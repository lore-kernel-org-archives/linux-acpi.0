From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ACPI / CPPC: set an error code on probe error path
Date: Thu, 1 Dec 2016 01:03:56 +0300
Message-ID: <20161130215819.GN28558@mwanda>
References: <20161130192254.GE28180@mwanda>
 <CAJZ5v0h06CXGzdAt=ZmB+pnWRumDGiic-eEpyLAojKVUVrJnnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h06CXGzdAt=ZmB+pnWRumDGiic-eEpyLAojKVUVrJnnw@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 30, 2016 at 10:53:55PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 30, 2016 at 8:22 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > We should return -EINVAL if get_cpu_device() fails.
> >
> > Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index d0d0504..e0ea8f5 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -784,8 +784,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
> >
> >         /* Add per logical CPU nodes for reading its feedback counters. */
> >         cpu_dev = get_cpu_device(pr->id);
> > -       if (!cpu_dev)
> > +       if (!cpu_dev) {
> > +               ret = -EINVAL;
> 
> ret is initialized here AFAICS.
> 
> Do you that its value is not the right one?

I'm looking at linux-next.  It's set to zero but we presumably want to
return an error code.

regards,
dan carpenter

