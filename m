From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: iasl
Date: Mon, 12 May 2003 10:03:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3C66@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Just as well then.  I can maintain that the AML interpreter cannot
simply "guess" at which is wrong -- the length of the operation region,
or the access width of the field definition.

Bob


> -----Original Message-----
> From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org]
> Sent: Monday, May 12, 2003 3:17 AM
> To: Moore, Robert
> Cc: sjb; Ducrot Bruno; ACPI List
> Subject: Re: [ACPI] iasl
> 
> On Fri, May 09, 2003 at 01:47:39PM -0700, Moore, Robert wrote:
> >
> > In this case, we know that PCI_Config space is always accessed by
32-bit
> > reads/writes, so change the Op region definition to length 4.
> 
> You know nothing about that the fact that PCI_Config space have
> to be accessed as 32-bit reads/write.  It may be the
> Field(PIUC, DWordAcc,...) to be bogus.  A better look of this field
> is needed.
> 
> Imagine it look like
> Field(PIUC, DWordAcc, ...)
> {
> 	FOO, 16
> }
> 
> then a better fix is:
> OperationRegion (PIUC, PCI_Config, 0x74, 0x02)
> Field(PIUC, WordAcc, ...)
> {
> 	FOO, 16
> }
> 
> Or FOO may be 8 bit long.
> In that case, a possible fix is:
> OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
> Field(PIUC, ByteAcc, ...)
> {
> 	FOO, 8
> }
> 
> 
> Unless sjb give us more info, we can not tell anything at this
> stage.
> 
> --
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
