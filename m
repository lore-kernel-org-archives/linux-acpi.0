From: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Thu, 12 Aug 2004 16:30:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <e7963922040812073062a7784a@mail.gmail.com>
References: <88056F38E9E48644A0F562A38C64FB600289AE7C@scsmsx403.amr.corp.intel.com>
	<yzooelohj8j.fsf@pb-d-128-141-40-189.cern.ch>
	<e796392204080601016e29a349@mail.gmail.com> <yzo4qngh7ji.fsf@pb-d-128-141-40-189.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <yzo4qngh7ji.fsf-1zyhLZfD728Z/JH0GhYu5ApX6sy8U9uuH79+75y5D5U@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "ole.rohne-vJEk5272eHo@public.gmane.org" <ole.rohne-vJEk5272eHo@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello ole,

Your patch has another problem: it even "works" on s4 (suspend-to-disk)

That means 2 times a blacklight and a return and the need for a keypress.

But it is absolutely not necessary on suspend-to-disk we only need it
on suspend to ram.

Do you still work on the patch? Is there a newer version to test?

Stefan


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
