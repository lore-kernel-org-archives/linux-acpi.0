From: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Fri, 6 Aug 2004 14:32:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <e796392204080605327588e5ac@mail.gmail.com>
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

On 06 Aug 2004 12:42:25 +0200, ole.rohne |at| cern.ch <ole.rohne at
cern.ch> wrote:
> Please, what it your system?

Acer Aspire 1406LC, radeon mobility m6, intel agp bridge

> I've had another report like that but I don't see it on my system
> (P2120). It looks like some resume driver is stuck waiting for an
> interrupt, it's not necessarily connected to the graphics.

But it works when I do not apply your patch and no fb and use Xorg to
get the screen back.
> 
> Schweizer> It still is no solution for the intel-agp not working for me.
> 
> My system is PCI only so I don't know anything about AGP. However, it
> seems that agp_intel_resume writes a bunch of default values to the
> pci config space, is it possible that XFree plays directly with those
> and expect them to stay across suspend/resume?
> 
> Ole
> 
how can I avoid this?


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
