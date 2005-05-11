From: Sergio Monteiro Basto <sergio-qOf5bGQp09kptuEoxK/DLR2eb7JE58TQ@public.gmane.org>
Subject: Re: Re: [PATCH] PCI: do VIA IRQ fixup always, not just in
 PIC mode
Date: Wed, 11 May 2005 02:23:57 +0100
Message-ID: <42815EAD.6000207@sergiomb.no-ip.org>
References: <200505101044.15654.bjorn.helgaas@hp.com> <20050510210755.GA3967@kroah.com> <200505101628.00548.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200505101628.00548.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

The first part on the patch has been reported on
http://bugme.osdl.org/show_bug.cgi?id=3D3319

This patches, has you may know,  can be backported to kernel 2.4, since=20
the code is actually the same.
In meanwhile I have made the patch for kernel 2.4.30
and will the reported on bugzilla bug 3319=20
(http://bugme.osdl.org/show_bug.cgi?id=3D3319).

Thanks ,
S=E9rgio M. B.

Bjorn Helgaas wrote:

>On Tuesday 10 May 2005 3:07 pm, Greg KH wrote:
> =20
>
>>On Tue, May 10, 2005 at 10:44:15AM -0600, Bjorn Helgaas wrote:
>>   =20
>>
>>>At least some VIA chipsets require the fixup even in IO-APIC mode.
>>>
>>>This was found and debugged with the patient assistance of Stian
>>>Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org> on an Asus CUV266-DLS motherboard.
>>>
>>>Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
>>>     =20
>>>
>>This is already present in the 2.6.12-rc4 kernel, right?
>>   =20
>>
>
>No, I reworked the VIA IRQ patch a while ago, but that rework
>is in the ACPI BK tree:
>
>    http://linux-acpi.bkbits.net:8080/26-stable-test/cset%404244603cD6Kf=
NrnIjyYDqv0xzdI8cQ
>
>So it's been in -mm for a while, but it's not in 2.6.12-rc4.
>(I suggested a while ago that we consider it for 2.6.12, but
>since it's intertwingled in the ACPI tree that might not be
>easy.)
>
>This current patch is incremental and applies to -mm.
> =20
>



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
