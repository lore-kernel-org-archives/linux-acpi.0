From: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Date: Tue, 24 May 2005 20:58:55 +0400
Message-ID: <20050524205855.A8367@jurassic.park.msu.ru>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com> <20050524120527.GB15326@wotan.suse.de> <20050524185856.A7639@jurassic.park.msu.ru> <20050524084533.A20567@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050524084533.A20567-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>; from rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Tue, May 24, 2005 at 08:45:36AM -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 24, 2005 at 08:45:36AM -0700, Rajesh Shah wrote:
> The concern here isn't just increasing the size of pci_bus. The
> resource pointers in pci_bus point to resource structures in the
> corresponding pci_dev structure for p2p bridges. If we want to
> maintain this scheme, we'd have to increase the number of resources
> in the pci_dev structure too, which increases it for every single
> pci device in the system.

No. The pci_bus resource pointers are just pointers to _some_ resources
and generally aren't tied to particular pci device. For example, the
root pci buses often don't even have corresponding bus->self structure,
and bus resources are pointers to global io[mem,port]_resource.
And definitely we must not touch resource layout in struct pci_dev -
it's defined by pci specs.

> Probably ok for big server machines, but
> would others (e.g. embedded folks) complain?

Increasing the size of pci_bus by 8 or 16 bytes shouldn't be a problem -
I don't think embedded machines have a lot of pci buses. :-)
Anyway, the default PCI_BUS_NUM_RESOURCES value can be overridden in 
arch specific headers.

Ivan.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
