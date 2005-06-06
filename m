From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Resume from Suspend to RAM
Date: Mon, 06 Jun 2005 11:26:18 +0100
Message-ID: <1118053578.6648.142.camel@tyrosine>
References: <200506051456.44810.hugelmopf@web.de>
	 <1117978635.6648.136.camel@tyrosine>
	 <200506051732.08854.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506051732.08854.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?ISO-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2005-06-05 at 17:32 +0000, Stefan D=C3=B6singer wrote:

> I've no idea how to debug a reboot, but if the system hangs it's possible=
 to=20
> add "lcall $0xffff,$0" early in the wakeup assembler code. If the system=20
> reboots immediatly then, the kernels wakeup code was reached and the kern=
el=20
> hangs later during resume.

Ok, I've just tried that. The system still just freezes.

> Is it somehow possible to localize and debug the BIOS code?

Hmm. It's certainly possible for me to get a dump of the BIOS - is any
BIOS code actually executed on resume? If so, checking through that may
well be helpful.

--=20
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
