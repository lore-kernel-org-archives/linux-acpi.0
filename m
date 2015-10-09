From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] acpi: add a utility function for evaluating _FIT
Date: Fri, 09 Oct 2015 23:14:02 +0200
Message-ID: <4942697.KRBiiVQkxE@vostro.rjw.lan>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com> <1444413246.9638.7.camel@intel.com> <CAPcyv4ihZa4LRxwsgnWFDGwBcRGw-Jb5n29iMBVPcHKF5538yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41049 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751581AbbJIUp1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2015 16:45:27 -0400
In-Reply-To: <CAPcyv4ihZa4LRxwsgnWFDGwBcRGw-Jb5n29iMBVPcHKF5538yQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Verma, Vishal L" <vishal.l.verma@intel.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>

On Friday, October 09, 2015 10:56:26 AM Dan Williams wrote:
> On Fri, Oct 9, 2015 at 10:54 AM, Verma, Vishal L
> <vishal.l.verma@intel.com> wrote:
> > On Fri, 2015-10-09 at 13:28 -0400, Jeff Moyer wrote:
> >> Vishal Verma <vishal.l.verma@intel.com> writes:
> >>
> >> >  /**
> >> > + * acpi_evaluate_fit: Evaluate _FIT method to get an updated NFIT
> >> > + * @handle: ACPI device handle
> >> > + * @buf: buffer for the updated NFIT
> >> > + *
> >> > + * Evaluate device's _FIT method if present to get an updated NFIT
> >> > + */
> >> > +acpi_status acpi_evaluate_fit(acpi_handle handle, struct
> >> > acpi_buffer **buf)
> >> > +{
> >> > +   acpi_status status;
> >> > +   struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL
> >> > };
> >> > +
> >> > +   status = acpi_evaluate_object(handle, "_FIT", NULL,
> >> > &buffer);
> >> > +
> >> > +   if (ACPI_FAILURE(status))
> >> > +           return status;
> >> > +
> >> > +   *buf = &buffer;
> >>
> >> Umm, unless I'm missing something, you're returning a stack address.
> >
> > Good point, you're right. Dan/Rafael, is it OK to just remove this
> > patch entirely, and call acpi_evaluate_object directly from nfit.c? The
> > current way did feel a bit kludgey to me any way because I was
> > allocating a buffer here (above), but trying to free it in the caller,
> > which seems very ugly..
> 
> Open coding a call to acpi_evaluate_object() sounds good to me.

Agreed.

Thanks,
Rafael

