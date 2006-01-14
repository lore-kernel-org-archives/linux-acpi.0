From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] fix pnpacpi regression resulting from ACPICA 20051117
Date: Fri, 13 Jan 2006 17:14:56 -0700
Message-ID: <200601131714.56847.bjorn.helgaas@hp.com>
References: <971FCB6690CD0E4898387DBF7552B90E03EE6513@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E03EE6513-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 09 January 2006 11:53, Moore, Robert wrote:
> The callback should be able to handle resource descriptors that it
> doesn't know about, new ones can be added at any time.

I agree; pnpacpi should just ignore tags it doesn't understand.

> This change was made during the resource manager update. I think that I
> would like to have WalkResources return the EndTag to the callback since
> it is a valid resource descriptor and it does impart information to the
> callback.

I don't have a use (yet) for EndTags in callbacks, but this argument
makes sense to me.  So I think the patch below is the wrong solution
to the problem.

> > In ACPICA 20051117, acpi_walk_resources() started
> > sending ACPI_RESOURCE_TYPE_END_TAG to the callback
> > routine which wasn't prepared for it, causing
> > _CRS to fail and PnPACPI to not recognize any devices:
> > 
> > pnp: ACPI device : hid PNP0C02
> > pnp: PnPACPI: unknown resource type 7
> > pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
> > 
> > Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > ---
> > 
> >  drivers/acpi/resources/rsxface.c |   12 ++++++------
> >  1 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > ed349a8a0a780ed27e2a765f16cee54d9b63bfee
> > diff --git a/drivers/acpi/resources/rsxface.c
> > b/drivers/acpi/resources/rsxface.c
> > index 50a956b..5408e5d 100644
> > --- a/drivers/acpi/resources/rsxface.c
> > +++ b/drivers/acpi/resources/rsxface.c
> > @@ -286,6 +286,12 @@ acpi_walk_resources(acpi_handle device_h
> >  			break;
> >  		}
> > 
> > +		/* end_tag indicates end-of-list */
> > +
> > +		if (resource->type == ACPI_RESOURCE_TYPE_END_TAG) {
> > +			break;
> > +		}
> > +
> >  		/* Invoke the user function, abort on any error returned
> */
> > 
> >  		status = user_function(resource, context);
> > @@ -298,12 +304,6 @@ acpi_walk_resources(acpi_handle device_h
> >  			break;
> >  		}
> > 
> > -		/* end_tag indicates end-of-list */
> > -
> > -		if (resource->type == ACPI_RESOURCE_TYPE_END_TAG) {
> > -			break;
> > -		}
> > -
> >  		/* Get the next resource descriptor */
> > 
> >  		resource =
> > --
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
