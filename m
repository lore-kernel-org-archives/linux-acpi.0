From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Thu, 04 Nov 2004 14:49:58 +0100
Message-ID: <yzok6t14tbt.fsf@cern.ch>
References: <88056F38E9E48644A0F562A38C64FB60033E4DDC@scsmsx403.amr.corp.intel.com> <20041103155217.GH24195@wotan.suse.de>
 <yzosm7q97q2.fsf@cern.ch> <20041103172120.GB18092@wotan.suse.de>
 <1099504898.31687.31.camel@elrond.flymine.org>
 <20041104041525.GE21211@wotan.suse.de>
 <1099564754.10723.24.camel@tyrosine>
 <20041104105848.GB27533@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi> I heard other people use LED on parport hacks, which probably works.

Modern laptops don't have parports either...

Anyway, my real objections to purely userspace POSTing are:

(1) it is hard to get it to work reliably (some method work with X11
    but not with text mode console, other methods work without DRM etc)
(2) the previous point goes to show that hardware sourcery belongs in
    kernel space (or before), as this is the only way to ensure proper
    ordering, bus mastering disable etc

Andi> Anyways, this thread doesn't seem to serve any useful purpose
Andi> anymore so I won't post to it anymore.

???

Ole




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
