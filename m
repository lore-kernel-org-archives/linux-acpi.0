From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Mon, 01 Nov 2004 14:43:54 +0000
Message-ID: <1099320234.31683.14.camel@elrond.flymine.org>
References: <OF38C223A3.5509B742-ON49256F36.00412958-49256F36.0041FAA1@jp.ibm.com>
	 <1098535488.3996.21.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1098535488.3996.21.camel@tyrosine>
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

On Sat, 2004-10-23 at 13:44 +0100, Matthew Garrett wrote:
> On Sat, 2004-10-23 at 21:05 +0900, Hiroshi 2 Itoh wrote:
> 
> > Yes, nothing is bad. Try to write the value in both etc...
> 
> Writing the value into both makes no difference. I also tried pushing
> the wakeup address higher up into lowmem (around 256K), but that makes
> no difference either.

Further playing:

Setting the wakeup vector to other values makes no difference - the
machine behaves identically regardless of whether it's pointing at the
wakeup code or at empty space (ie, it always reboots). The only two
things that spring to mind are:

1) Something is still going wrong in the suspend pathway, and some
machines are not being properly configured for suspend. Given that the
machine reboots without running any code when attempting to wake from
S3, is there any way to test this?

2) (This is somewhat far-fetched, but...) Could the machine be ignoring
the contents of the wakeup vector and always attempting to run code from
the same address? Does Windows put the wakeup code in a predictable
location?

Looking a bit more closely, the DSDT claims to be for a VIA Apollo-P.
The machine was made by Elite Computer Systems (www.ecs.com.tw ) and is
a rebadged G320. It's a very, very horrible piece of hardware, but S3
works under Windows.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
