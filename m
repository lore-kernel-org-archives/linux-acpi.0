From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Battery: Allow extract string from integer
Date: Mon, 29 Oct 2007 23:37:05 +0100
Message-ID: <200710292337.06021.rjw@sisk.pl>
References: <20071029202938.16515.24421.stgit@samsung> <200710291657.12962.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37503 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbXJ2WUU (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 29 Oct 2007 18:20:20 -0400
In-Reply-To: <200710291657.12962.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Frans Pop <elendil@planet.nl>, Andrey Borzenkov <arvidjaar@mail.ru>, Linux-acpi@vger.kernel.org

Hi,

On Monday, 29 October 2007 21:57, Len Brown wrote:
> Applied.
> 
> Andrey, Frans,
> thanks for helping with Alexey's patch this weekend.

Please let me know when it goes to Linus.

Thanks,
Rafael

 
> On Monday 29 October 2007 16:29, Alexey Starikovskiy wrote:
> > Some machines return integer instead of expected string.
> > 
> > Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> > ---
> > 
> >  drivers/acpi/battery.c |   25 +++++++++++++++----------
> >  1 files changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 02a396d..6c06879 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -260,7 +260,7 @@ static int extract_package(struct acpi_battery *battery,
> >  			   union acpi_object *package,
> >  			   struct acpi_offsets *offsets, int num)
> >  {
> > -	int i, *x;
> > +	int i;
> >  	union acpi_object *element;
> >  	if (package->type != ACPI_TYPE_PACKAGE)
> >  		return -EFAULT;
> > @@ -269,16 +269,21 @@ static int extract_package(struct acpi_battery *battery,
> >  			return -EFAULT;
> >  		element = &package->package.elements[i];
> >  		if (offsets[i].mode) {
> > -			if (element->type != ACPI_TYPE_STRING &&
> > -			    element->type != ACPI_TYPE_BUFFER)
> > -				return -EFAULT;
> > -			strncpy((u8 *)battery + offsets[i].offset,
> > -				element->string.pointer, 32);
> > +			u8 *ptr = (u8 *)battery + offsets[i].offset;
> > +			if (element->type == ACPI_TYPE_STRING ||
> > +			    element->type == ACPI_TYPE_BUFFER)
> > +				strncpy(ptr, element->string.pointer, 32);
> > +			else if (element->type == ACPI_TYPE_INTEGER) {
> > +				strncpy(ptr, (u8 *)&element->integer.value,
> > +					sizeof(acpi_integer));
> > +				ptr[sizeof(acpi_integer)] = 0;
> > +			} else return -EFAULT;
> >  		} else {
> > -			if (element->type != ACPI_TYPE_INTEGER)
> > -				return -EFAULT;
> > -			x = (int *)((u8 *)battery + offsets[i].offset);
> > -			*x = element->integer.value;
> > +			if (element->type == ACPI_TYPE_INTEGER) {
> > +				int *x = (int *)((u8 *)battery +
> > +						offsets[i].offset);
> > +				*x = element->integer.value;
> > +			} else return -EFAULT;
> >  		}
> >  	}
> >  	return 0;
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
