From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [Bug 5235] PCI devices not working correctly on 2.6.13+, b44
 network card causes freeze
Date: Tue, 13 Sep 2005 00:11:35 -0700
Message-ID: <20050913001135.15154c72.akpm@osdl.org>
References: <200509130547.j8D5l3Ct020204@fire-1.osdl.org>
	<20050912225933.287a6080.akpm@osdl.org>
	<20050913110015.A15709@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050913110015.A15709-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Cc: bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org, torvalds-3NddpPZAyC0@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org> wrote:
>
> On Mon, Sep 12, 2005 at 10:59:33PM -0700, Andrew Morton wrote:
> > especially this:
> > 
> > -   I/O behind bridge: 0000e000-0000dfff
> > +   I/O behind bridge: 0000f000-00000fff
> > 
> > a size of -1...  
> 
> This is perfectly fine - there are no IO ports behind the
> AGP bridge (video card has only MMIO registers), so IO window
> gets disabled.
> 
> I'd rather blame supposedly wrong IRQ assignment:
> 
> -PCI: Enabling device 0000:00:0a.0 (0000 -> 0001)
> -PCI: Found IRQ 11 for device 0000:00:0a.0
> -PCI: Sharing IRQ 11 with 0000:00:0d.0
> -PCI: Sharing IRQ 11 with 0000:01:00.0
> -eth1: RealTek RTL-8029 found at 0xd800, IRQ 11, 52:54:AB:4D:BC:C1.
> +PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
> +PCI: setting IRQ 9 as level-triggered
> +PCI: Assigned IRQ 9 for device 0000:00:0a.0
> +PCI: Sharing IRQ 9 with 0000:00:0d.0
> +eth1: RealTek RTL-8029 found at 0xd800, IRQ 9, 52:54:AB:4D:BC:C1.
> 

Crap.  Len, could you please take a look and if this is an APCI problem,
set the bug ownership appropriately?



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
