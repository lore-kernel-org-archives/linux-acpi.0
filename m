From: Markus Demleitner <m@tfiu.de>
Subject: Re: [Bug 197863] Thinkpad X240 resume dramatically slower on kernels
 4.13+
Date: Fri, 9 Feb 2018 14:43:09 +0100
Message-ID: <20180209134309.cvhst6x24chx4adz@victor>
References: <bug-197863-190391@https.bugzilla.kernel.org/>
 <a662d85c-e226-223e-3467-90b651dd291b@intel.com>
 <CAJZ5v0jN2cQUmwWRQ=Rvb+dQpMg+Q+GuaDtt-X-tXWNThUx-NQ@mail.gmail.com>
 <4333304.2V78SBapX3@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.xeneris.net ([88.198.30.130]:41629 "EHLO mx2.xeneris.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932206AbeBINqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Feb 2018 08:46:39 -0500
Received: from sosa.tfiu.de (sosa.tfiu.de [188.40.159.238])
        by mx2.xeneris.net (Postfix) with ESMTPSA id 99726C58CAA7
        for <linux-acpi@vger.kernel.org>; Fri,  9 Feb 2018 14:41:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4333304.2V78SBapX3@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, Feb 08, 2018 at 08:12:06PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 7, 2018 11:44:15 PM CET Rafael J. Wysocki wrote:
> > On Mon, Feb 5, 2018 at 6:06 PM, Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com> wrote:
> > > On 2/5/2018 3:14 PM, Bjørn Mork wrote:
> > >>
> > >> "Rafael J. Wysocki" <rafael.j.wysocki@intel.com> writes:
> > >>>
> > >>> On 2/4/2018 9:28 PM, Bjørn Mork wrote:
> > >>>
> > >>>> But I do wonder if the attached (completely untested!!) patch makes
> > >>>> things any better?
> > >>>
> > >>> I don't think so, the macro is needed too.
> > >>
> > >> Doh! Obviously.  Don't know how I managed to miss that.
> > >>
> > >>> I'll queue up a full revert of 662591461c4b9a1e3b.
> > >>
> > >> Still with the additional exception for "ec == first_ec"?
> > >>
> > >
> > > No, just a full revert for now.
> > 
> > That doesn't work, because we made some changes on top of this commit.
> > 
> > I'll send a patch to try tomorrow.
> 
> Below is a patch for the mainline (should be applicable to 4.15.y) to test.
> Please let me know if it improves things for you.

It pretty certainly does (patch applied on top of 4.15.0 from
tarball).  Five out of five wakeup cycles were fast, and the cell
modem is still properly initialised -- the message went out via the
resumed modem.

Thanks!

     -- Markus

[patch retained for reference:]

> 
> The corresponding fix for -stable would still be a full revert of
> 662591461c4b9a1e3b, but it needs to be fixed in the mainline first.
> 
> ---
>  drivers/acpi/ec.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1927,6 +1927,9 @@ static int acpi_ec_suspend_noirq(struct
>  	    ec->reference_count >= 1)
>  		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
>  
> +	if (acpi_sleep_no_ec_events())
> +		acpi_ec_enter_noirq(ec);
> +
>  	return 0;
>  }
>  
> @@ -1934,6 +1937,9 @@ static int acpi_ec_resume_noirq(struct d
>  {
>  	struct acpi_ec *ec = acpi_driver_data(to_acpi_device(dev));
>  
> +	if (acpi_sleep_no_ec_events())
> +		acpi_ec_leave_noirq(ec);
> +
>  	if (ec_no_wakeup && test_bit(EC_FLAGS_STARTED, &ec->flags) &&
>  	    ec->reference_count >= 1)
>  		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
> 

-- 
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

