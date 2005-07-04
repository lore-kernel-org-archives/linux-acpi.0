From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: after resume usb mouse will allow input before unlocking
 screensaver
Date: Mon, 04 Jul 2005 14:53:37 +0200
Message-ID: <42C93151.5040107@gmx.net>
References: <200507020244.46843.johnelliottmartin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507020244.46843.johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Elliott Martin <johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Elliott Martin schrieb:
> When I restore my pc from suspend to disk and I'm using a USB mouse, I am able 
> to type and interact with my programs before being prompted for a password. I 
> normally have a root shell sitting open and I was able to run a couple of 
> commands before the screensaver popped up for a password asking me to unlock 
> my KDE session. If I resume with just my laptops touchpad going I get asked 
> for a password before I can doing anything else, so I think this might be a 
> problem with acpi, but I'm using suse linux so it could be a problem with 
> suseplugger.

The problem is that suspend does not wait for the screensaver to be active,
so there is a race condition between the screensaver and suspend. I have no
idea how to fix it, but as a temporary workaround making this *less* likely
change POWERSAVE_SCREENSAVER_SIMPLE in /etc/sysconfig/powersave/common to
POWERSAVE_SCREENSAVER_SIMPLE="yes"

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
