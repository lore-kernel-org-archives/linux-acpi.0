From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: iasl
Date: Fri, 9 May 2003 13:47:39 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3C62@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
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
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


In this case, we know that PCI_Config space is always accessed by 32-bit
reads/writes, so change the Op region definition to length 4.


> -----Original Message-----
> From: sjb [mailto:ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org]
> Sent: Friday, May 09, 2003 1:51 PM
> To: Moore, Robert
> Cc: Ducrot Bruno; ACPI List
> Subject: Re: [ACPI] iasl
> 
> Moore, Robert wrote:
> 
> >>                 OperationRegion (PIUC, PCI_Config, 0x74, 0x01)
> >
> >
> >
> > The problem is that the region is defined as 0x01 byte, and the
field
> > specifies a minimum access width of Dword (4 bytes).
> 
> So how would I go about fixing that? Bear in mind I have no idea how
> these things are supposed to work ;-)
> 
> Do I change the "Field" line to ByteAcc instead of DWordAcc, or the
> "OperationRegion" line somehow?
> 
> This should be the last dumb question BTW *8-)
> 
> sjb


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
