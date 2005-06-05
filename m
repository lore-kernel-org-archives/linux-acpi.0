From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Resume from Suspend to RAM
Date: Sun, 5 Jun 2005 17:32:08 +0000
Message-ID: <200506051732.08854.stefandoesinger@gmx.at>
References: <200506051456.44810.hugelmopf@web.de> <1117978635.6648.136.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1117978635.6648.136.camel@tyrosine>
Content-Disposition: inline
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
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

> (1) and (2) are easily fixable. (3) is ridiculously hard. Does anyone
> have any ideas how it can be debugged? I've got one machine here that
> shows this behaviour (immediate reboot) and access to another (hangs on
> resume, never seems to run any kernel code)
I've no idea how to debug a reboot, but if the system hangs it's possible to 
add "lcall $0xffff,$0" early in the wakeup assembler code. If the system 
reboots immediatly then, the kernels wakeup code was reached and the kernel 
hangs later during resume.

Is it somehow possible to localize and debug the BIOS code?

Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
