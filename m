From: Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Tue, 7 Jun 2005 13:07:27 +0100
Message-ID: <20050607120727.GA6077@deprecation.cyrius.com>
References: <200506061531.41132.stefandoesinger@gmx.at> <1118125410.3828.12.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1118125410.3828.12.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

* Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [2005-06-07 14:23]:
> For those who suffer from strange S3 resume problem such as resume hang,
> could you please try this debug patch.

This works on a HP Compaq nc4000 which previously never comes back
from resume (except for one time in which case the kernel oopsed in a
strange way, as posted by Matthew the other day).  I see a yellow
'Linu' on the screen, then I hear the hard drive spinning up, the
screen comes back and I see 'Restarting tasks... done' on the serial
console.  (this is with init=/bin/bash console=ttyS0)
-- 
Martin Michlmayr
http://www.cyrius.com/


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
