From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for amilo m1425
Date: Sun, 3 Feb 2008 17:19:13 -0500
Message-ID: <200802031719.13893.lenb@kernel.org>
References: <1eca66a80711041110r6ae7ad12wb20c118839ad1767@mail.gmail.com> <200801190009.24509.lenb@kernel.org> <1eca66a80801301625t1d3e15ebl2f6e748faadad410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51383 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbYBCWT2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Feb 2008 17:19:28 -0500
In-Reply-To: <1eca66a80801301625t1d3e15ebl2f6e748faadad410@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Iacopo Masi <iacopo.masi.list@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 30 January 2008 19:25, Iacopo Masi wrote:
> On Jan 19, 2008 6:09 AM, Len Brown <lenb@kernel.org> wrote:
> > On Sunday 04 November 2007 14:10, Iacopo Masi wrote:
> > > System Information
> > >         Manufacturer: FUJITSU SIEMENS
> > >         Product Name: Amilo M1425
> > >         Version: To Be Filled By O.E.M.
> > >         Serial Number: To Be Filled By O.E.M.
> > >         UUID: 4082AA1C-BEB9-D911-ADD3-D6DC313E4FEF
> > >         Wake-up Type: Power Switch
> > >
> > > Handle 0x0002, DMI type 2, 8 bytes
> > > Base Board Information
> > >         Manufacturer: To be filled by O.E.M.
> >
> > (is this a production BIOS?)
> >
> 
> If you mean a BIOS by FUJITSU SIEMENS yes it is. I have no updated it.
> I don't know the right meaning of production bios.
> 
> >
> > Thanks for the dmidecode output.
> >
> > Do you notice any functional difference when booting with...
> >
> > "acpi_osi=Linux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=!Linux"       (default for 2.6.23 and later)
> >
> > ...in particular, please check sound, wifi, and hibernate.
> 
> Mhh I will try.
> 
> I have to say that I cannot try hibernate because I'm using
> user-suspend that is suspend in user level.[1]
> 
> >
> > Also, please send me the output from acpidump.
...
> 
> >
> > ps
> > If you don't have acpidump, you can get it from pmtools here:
> > http://www.lesswatts.org/projects/acpi/utilities.php
> 
> I installed in ubuntu with
> 
> sudo apt-get install acpidump
> [1] http://suspend.sourceforge.net/

Thanks for the acpidump, but why did you send us the dmidecode?
The DSDT doesn't query OSI(Linux) at all,
so I would not expect the dmesg to have asked for it.

thanks,
-Len
