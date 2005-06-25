From: Norbert Federa <norbert.federa-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re: Changeset "acpi: disable PCI links at boot again,
 fix ELCR" -> on-board nic adapter not working
Date: Sat, 25 Jun 2005 12:43:24 +0200
Message-ID: <42BD354C.1080704@neoware.com>
References: <42B7CF33.5090501@neoware.com> <42BA6639.9090402@neoware.com> <Pine.LNX.4.58.0506241100290.11175@ppc970.osdl.org> <200506241231.55760.bjorn.helgaas@hp.com> <Pine.LNX.4.58.0506241143520.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0506241143520.11175-gWtpgVMusWVb5UGfqNBoRg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 24 Jun 2005, Bjorn Helgaas wrote:
> 
>>My preference is to use acpi_register_gsi() rather than
>>calling eisa_set_level_irq() directly.
> 
> 
> Ok. Norbert, just because I'm anal, can you verify that that version also
> fixes it before I commit it?
> 
> 		Linus
> 

Verified. Calling acpi_register_gsi() does also fix the
problem with the on-board via-rhine nic.

Linus, one thing to note regarding your assumption about
the usb-controllers which I forgot to mention:

<LT>However, it would be interesting to know if you've tried the
<LT>USB controllers at all? It sounds like _none_ of those should
<LT>work either..

You were right with this assumption for kernel 2.6.10-rc2-bk8.
Without the above on-liner neither the usb controllers nor the
on-board-nic did work on 2.6.10-rc2-bk8. But they _did_ work on
2.6.12-vanilla _without_ having to call acpi_register_gsi() or
eisa_set_level_irq() directly.

-- Norbert



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
