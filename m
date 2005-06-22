From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: Changeset "acpi: disable PCI links at boot again, fix ELCR" ->
 on-board nic adapter not working
Date: Wed, 22 Jun 2005 13:14:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221311200.2353@ppc970.osdl.org>
References: <42B7CF33.5090501@neoware.com> <Pine.LNX.4.58.0506210901230.2268@ppc970.osdl.org>
 <42B843F6.7040704@neoware.com> <Pine.LNX.4.58.0506221245370.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0506221245370.2353-gWtpgVMusWVb5UGfqNBoRg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Federa <norbert.federa-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Wed, 22 Jun 2005, Linus Torvalds wrote:
> 
> Len, ACPI people, any reason not to do this?

Apart from the obvious, ie that it's x86[-64] only, of course.

I guess one thing to do would be to call "acpi_register_gsi()" with the 
arguments set to the default PCI values of level/active-low. I don't know 
what the impact of that is, though - what all is "acpi_register_gsi()" 
supposed to do, and how confused migh it get by being called for an irq 
that isn't actually looked up using ACPI methods?

If calling acpi_register_gsi() is ok, then that's probably the preferred 
thing, and solves the architecture issue too..

		Linus


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
