From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch] ACPI / CPPC: set an error code on probe error path
Date: Thu, 01 Dec 2016 15:14:55 +0100
Message-ID: <3515049.TAodqepTBT@aspire.rjw.lan>
References: <20161130192254.GE28180@mwanda> <20161130215819.GN28558@mwanda> <CAJZ5v0gNeD_gDKEBCoYcr52dFC=YFVZ7=ADF0WYUQt+hPhbNsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47808 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750738AbcLAOSb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 09:18:31 -0500
In-Reply-To: <CAJZ5v0gNeD_gDKEBCoYcr52dFC=YFVZ7=ADF0WYUQt+hPhbNsA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Wednesday, November 30, 2016 11:14:23 PM Rafael J. Wysocki wrote:
> On Wed, Nov 30, 2016 at 11:03 PM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
> > On Wed, Nov 30, 2016 at 10:53:55PM +0100, Rafael J. Wysocki wrote:
> >> On Wed, Nov 30, 2016 at 8:22 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >> > We should return -EINVAL if get_cpu_device() fails.
> >> >
> >> > Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
> >> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> >
> >> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> > index d0d0504..e0ea8f5 100644
> >> > --- a/drivers/acpi/cppc_acpi.c
> >> > +++ b/drivers/acpi/cppc_acpi.c
> >> > @@ -784,8 +784,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
> >> >
> >> >         /* Add per logical CPU nodes for reading its feedback counters. */
> >> >         cpu_dev = get_cpu_device(pr->id);
> >> > -       if (!cpu_dev)
> >> > +       if (!cpu_dev) {
> >> > +               ret = -EINVAL;
> >>
> >> ret is initialized here AFAICS.
> >>
> >> Do you that its value is not the right one?
> >
> > I'm looking at linux-next.  It's set to zero but we presumably want to
> > return an error code.
> 
> OK
> 
> It was slightly unclear what the bug was.

Applied now.

Thanks,
Rafael

