From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6/5] ACPI: DMI blacklist for OSI(Linux)
Date: Sat, 19 Jan 2008 23:18:56 -0500
Message-ID: <200801192318.56319.lenb@kernel.org>
References: <1200565490-29619-1-git-send-email-lenb@kernel.org> <200801190250.28250.lenb@kernel.org> <p73abn29qmj.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49093 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbYATETO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 23:19:14 -0500
In-Reply-To: <p73abn29qmj.fsf@bingen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 03:16, Andi Kleen wrote:
> Len Brown <lenb@kernel.org> writes:
> > --- a/drivers/acpi/blacklist.c
> > +++ b/drivers/acpi/blacklist.c
> > @@ -1,6 +1,8 @@
> >  /*
> >   *  blacklist.c
> >   *
> > + *  X86 specific ACPI blacklists.
> > + *
> >   *  Check to see if the given machine has a known bad ACPI BIOS
> >   *  or if the BIOS is too old.
> >   *
> > @@ -165,3 +167,578 @@ int __init acpi_blacklisted(void)
> >  
> >  	return blacklisted;
> >  }
> > +#ifdef CONFIG_DMI
> 
> IA64 sets CONFIG_DMI too. So it won't be x86 specific as written.
> Probably shoud check for CONFIG_X86 too.

drivers/acpi/Makefile causes blacklist.c to be X86 specific.

obj-$(CONFIG_X86)               += blacklist.o

that is what I wanted (and IA64 can add their own blacklist if
they need one).  but if IA64 defines CONFIG_DMI,
then I just broke their build b/c acpi_osl_dmi_table will be undefined...

> > +extern void dmi_osi_linux(int enable, const struct dmi_system_id *d);
> 
> That should be in some include, shouldn't it?

yes.

thanks,
-Len
