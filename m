From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH 2.6.13-rc4 1/2] fix possible null pointer access
 - acpi_pci_irq_enable
Date: Sun, 7 Aug 2005 22:07:36 -0700
Message-ID: <20050807220736.4aef15ee.akpm@osdl.org>
References: <42ED97C2.7060409@jp.fujitsu.com>
	<42ED9830.7060808@jp.fujitsu.com>
	<20050803113637.GB4038@elf.ucw.cz>
	<42F2C20F.4050807@jp.fujitsu.com>
	<20050805071918.GG1780@elf.ucw.cz>
	<42F6DE69.5090101@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42F6DE69.5090101-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: pavel-+ZI9xUNit7I@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
>
> Hi,
> 
> >>>Should people be passing NULLs here, anyway? Is not the right fix to
> >>>remove the check, and remove the (!dev) check, too, and just fix the
> >>>callers? People are going to fix the oops, but noone is going to see
> >>>that ACPI_DEBUG_PRINT...
> >>
> >>As you said, I think people should not pass NULLs here, and we should
> >>fix the caller. But I think it is not bad to check (!dev) and (!dev->bus)
> >>in these functions instead of panic. How about using WARN_ON here to
> >>notify people of badness?
> > 
> > 
> > No, just read l-k archives. Just dereference it. It wil oops in a nice
> > way, and developer *will* see and fix it.
> 
> OK. I'll make a new patch that removes the check.
> 
> Andrew, could you please drop the following two patches from -mm tree?
> 
>     o fix-possible-null-pointer-access-acpi_pci_irq_enable.patch
>     o fix-possible-null-pointer-access-acpi_pci_irq_disable.patch
> 

They're not in -mm any more.  Either they've been merged into Len's tree or
I accidentally dropped them, assuming they were in Len's tree due to them
throwing rejects.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
