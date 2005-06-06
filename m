From: Stefan =?utf-8?q?D=C3=B6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM)
Date: Mon, 6 Jun 2005 15:31:40 +0000
Message-ID: <200506061531.41132.stefandoesinger@gmx.at>
References: <200506051456.44810.hugelmopf@web.de> <1118053578.6648.142.camel@tyrosine> <1118056003.6648.148.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1118056003.6648.148.camel@tyrosine>
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
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Montag, 6. Juni 2005 11:06 schrieb Matthew Garrett:
> Whoops. May have been a bit too hasty there. I'm not sure why that
> doesn't reset it, but we've now got the following (really rather odd)
> serial output. Does anyone have any idea what might be triggering this?
> Shell builtins work fine, but anything else seems to explode very
> messily. Memory corruption of some description?

<snip>
So it does reach the kernel, right? I don't know if I remembered that call 
correctly, but "lcall $0xffff,$0" should call the real mode BIOS reset 
code...
Anyone else who can correct me here?

Perhaps the disk driver is going mad? Has anyone tried to boot a kernel 
without any disk drivers with a minimal root system on an initrd?

Cheers,
Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
