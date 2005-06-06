From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Resume from Suspend to RAM
Date: Mon, 6 Jun 2005 16:43:34 +0200
Message-ID: <20050606144334.GA2243@elf.ucw.cz>
References: <200506051456.44810.hugelmopf@web.de> <1117978635.6648.136.camel@tyrosine> <200506051732.08854.stefandoesinger@gmx.at> <1118053578.6648.142.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1118053578.6648.142.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I've no idea how to debug a reboot, but if the system hangs it's possible to 
> > add "lcall $0xffff,$0" early in the wakeup assembler code. If the system 
> > reboots immediatly then, the kernels wakeup code was reached and the kernel 
> > hangs later during resume.
> 
> Ok, I've just tried that. The system still just freezes.
> 
> > Is it somehow possible to localize and debug the BIOS code?
> 
> Hmm. It's certainly possible for me to get a dump of the BIOS - is any
> BIOS code actually executed on resume? If so, checking through that may
> well be helpful.

Yes, parts of BIOS definitely are ran during resume. You have your
DRAM initialized when Linux attempts to wake up :-).

									Pavel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
