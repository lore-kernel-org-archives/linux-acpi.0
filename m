From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Resume from Suspend to RAM
Date: Sun, 05 Jun 2005 14:37:14 +0100
Message-ID: <1117978635.6648.136.camel@tyrosine>
References: <200506051456.44810.hugelmopf@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506051456.44810.hugelmopf-S0/GAf8tV78@public.gmane.org>
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

On Sun, 2005-06-05 at 14:56 +0200, Frank wrote:

> The system: Maxdata Eco 4500A notebook, Debian Sarge AMD64 with vanilla kernel 2.6.11.9

Three things spring to mind:

1) If it's using a libata based IDE driver, there's currently no suspend
or resume support and so it won't work. See
http://lkml.org/lkml/2005/5/23/116 .

2) If not, it could be that the machine requires the _GTM and _STM
methods to be called. There's a patch floating around to do that - check
the list archives.

3) It could be the weirdness that seems to affect several machines with
non-Intel chipsets, where the system either immediately reboots or comes
back up but never runs any kernel code.

(1) and (2) are easily fixable. (3) is ridiculously hard. Does anyone
have any ideas how it can be debugged? I've got one machine here that
shows this behaviour (immediate reboot) and access to another (hangs on
resume, never seems to run any kernel code)
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
