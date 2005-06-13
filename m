From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: tg3 ethernet not coming back properly after S3 suspendon Dell M70
Date: Mon, 13 Jun 2005 13:13:32 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750243E650@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Nguyen, Tom L" <tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vladimir Vukicevic <vladimirv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Long,
>
>On Thursday, June 09, 2005 7:00 PM Shaohua Li wrote:
>> Long, is this patch ok to you? PCIE bridge itself requires to
>> save/restore config space.
>
>Great! Would you please also add saving/restoring MSI capability
structure
>if supported?
Ideally, we should call pci_enable/disable_msi/msix for suspend/resume,
but I have some troubles to save/restore the MSIx configs. The driver
doesn't record the msix_entries. Anyway, you are the expert, so it might
be up to you to add the MSI support.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
