From: Len Brown <lenb@kernel.org>
Subject: Re: Fwd: FSC Esprimo Mobile V5505 - dmidecode
Date: Tue, 12 Feb 2008 15:32:00 -0500
Message-ID: <200802121532.00861.lenb@kernel.org>
References: <200710122357.46851.dl9pf@gmx.de> <200802121500.25986.lenb@kernel.org> <47B1FD87.8070801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46519 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178AbYBLUcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Feb 2008 15:32:17 -0500
In-Reply-To: <47B1FD87.8070801@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Jan-Simon =?iso-8859-1?q?M=F6ller?= <dl9pf@gmx.de>, linux-acpi@vger.kernel.org

On Tuesday 12 February 2008 15:11, Alexey Starikovskiy wrote:
> Len Brown wrote:
> > On Tuesday 12 February 2008 05:57, Jan-Simon M=F6ller wrote:
> >  =20
> >> Sorry for the late reply !
> >>
> >> Am Samstag 19 Januar 2008 05:29:49 schrieb Len Brown:
> >>    =20
> >>> On Saturday 13 October 2007 04:13, Jan-Simon M=F6ller wrote:
> >>>      =20
> >>>> System Information
> >>>>         Manufacturer: FUJITSU SIEMENS
> >>>>         Product Name: ESPRIMO Mobile V5505
> >>>>         Version: 20
> >>>>         Wake-up Type: Power Switch
> >>>>         SKU Number: Not Specified
> >>>>         Family: Not Specified
> >>>>
> >>>> Handle 0x0002, DMI type 2, 8 bytes
> >>>> Base Board Information
> >>>>         Manufacturer: FUJITSU SIEMENS
> >>>>         Product Name: ESPRIMO Mobile V5505
> >>>>        =20
> >>> Jan-Simon,
> >>> Thanks for the dmidecode output.
> >>>
> >>> Did the console dmesg ask you to send it because
> >>> of OSI(Linux)?
> >>>
> >>> Do you notice any functional difference when booting with
> >>>
> >>> "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> >>> vs.
> >>> "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
> >>>
> >>> Also, please send me the output from acpidump.
> >>>      =20
> >> Didn't notice any difference.
> >> acpidump here:
> >>
> >> http://bugzilla.kernel.org/show_bug.cgi?id=3D9939
> >>
> >>    =20
> >>> thanks,
> >>> -Len
> >>>
> >>>      =20
> >> Thanks!
> >>    =20
> >
> > thanks for the acpidump in http://bugzilla.kernel.org/show_bug.cgi?=
id=3D9939
> >
> > This BIOS makes heavy use of TRAP's into SMM, Windows version-speci=
fic hooks,
> > and WMI -- all bad news for Linux.
> >
> > But OSI(Linux) itself is a NOP on this box, since LINX is set and n=
ever referenced, per below.
=20

> LINX is not a variable, but a field in SystemMemory  region. Thus it=20
> could be accessed from SMM or EC firmware without us knowing that.
> IMHO it is too brave to call it NOP.

True, and some other BIOS have had it as a field as well.

However, I'm comfortable taking this risk because:
1. we've never noticed any difference with the field set.
2. there is approximately 0 chance that this vendor is writing Linux-aw=
are EC or SMM code.
3. we want to stamp out the use of OSI(Linux), not encourage it,
   so erring on the conservative side is to turn it off and be quiet by=
 default.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
