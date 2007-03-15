From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH] ACPI: ibm-acpi: allow module to load
	when acpi notifiers can't be set
Date: Thu, 15 Mar 2007 16:57:32 -0300
Message-ID: <20070315195732.GG14394@khazad-dum.debian.net>
References: <20070315071019.GA22613@tuatara.stupidest.org>
	<20070315175113.GA6596@khazad-dum.debian.net>
	<20070315191721.GB2556@tuatara.stupidest.org>
	<20070315123732.2ac478a3.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070315123732.2ac478a3.kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chris Wedgwood <cw-LC2/xnR6T6k@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 15 Mar 2007, Kristen Carlson Accardi wrote:
> I haven't followed the ibm_acpi development lately, but when I first
> wrote the bay driver, it had a couple features that ibm_acpi didn't have,
> and then of course, is missing some it does have.  What used to be the
> case is that if bay was inserted after the laptop was booted, the ibm_acpi
> driver would not capture the events because it would only install it's 
> notifier at driver load time on bay devices that existed.  The second

This is still true, I didn't bother fixing it because I'd rather expend "bay
time" trying to get the generic driver to work OK in thinkpads, but I have
been otherwise distracted with other ibm-acpi things, like a sysfs
conversion.

> as the X60, you need to have undock events sent to the bay device so that
> it can alert user space to unmount cd's etc (since the bay is on the ultrabase).

This is also still true.

BTW, currently the bay driver seems to have lost a lot of functionality, I
remember older incarnations of it (before it went platform-driver) caused
unplugs to be clean instead of driving libata nuts...  Am I recalling this
incorrectly?

> I think for now this is a good idea - the ibm_acpi solution should be
> preferred over the generic bay driver till it is more fully developed.
> I don't know how to ensure this is done wrt load order though.

Nor do I, and sincerely, if one is doing what some rpm distros are and
loading every ACPI module in a for loop at boot time, I don't want to know.
It is their mess to fix.  I just have ibm-acpi in my /etc/modules, and
arranged it to be loaded BEFORE any such distro crap (not that Debian has
it, but still...).

What we *can* do is to have DMI-based coldplug capabilities added, and work
from there to get udev to autoload devices.  And that still won't be 100%
failure-proof, but nothing is.

> I think this is a good idea.  It would certainly be less confusing for users.
> too late for this release though, perhaps this can be targetted at 2.6.22/23?

That's something I'd like to happen.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
