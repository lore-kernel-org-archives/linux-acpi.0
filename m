From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM
	(was: Re: Resume from Suspend to RAM))
Date: Fri, 17 Jun 2005 14:16:03 +0100
Message-ID: <1119014163.12492.178.camel@elrond.flymine.org>
References: <200506061531.41132.stefandoesinger@gmx.at>
	 <1118125410.3828.12.camel@linux-hp.sh.intel.com>
	 <87ll5diemh.fsf@www.codersbase.com> <1118738841.6648.514.camel@tyrosine>
	 <877jgw9a9c.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <877jgw9a9c.fsf-mMfbam+mt929kzlf/Hu3QdBPR1lH4CV8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-06-14 at 09:24 -0700, dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org wrote:
> Sure thing, (a) is called lspci-coldboot.txt and the other is
> lspci-warmboot.txt.  I've attached them so that you can see the whole
> thing, it doesn't look very helpful to me and the diff was even more
> cryptic, so good luck ;)

Ok, this is probably a long shot, but try:

setpci -s 00:00.0 67.b=11
setpci -s 00:00.0 68.b=4f
setpci -s 00:00.0 6d.b=47
setpci -s 00:00.0 9a.b=0a
setpci -s 00:00.0 9b.b=1d

after a cold boot, and then see if that changes the behaviour. My
suspicion is that Windows enables some northbridge features that affect
the behaviour of the system in suspend. Working out /what/ would be much
easier with datasheets, but ATI and VIA don't seem willing to provide
them (if anyone could provide me with northbridge PCI configuration
register specs for any non-Intel chipsets, that would be astonishingly
helpful)

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
