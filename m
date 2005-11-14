From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: vbetool on pure AMD64 system
Date: Mon, 14 Nov 2005 21:48:27 +0000
Message-ID: <1132004907.16148.32.camel@localhost.localdomain>
References: <200511092342.40477.hugelmopf@web.de>
	 <20051111103315.GB27805@elf.ucw.cz>  <4378C318.9090105@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4378C318.9090105-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Llu, 2005-11-14 at 12:02 -0500, Phillip Susi wrote:
> When you say that vm86 is not supported on x86-64, what do you mean 
> exactly?  I'm pretty sure that the hardware supports it, and I don't see 
> how the vesa frame buffer Xorg driver works without it.  If the hardware 
> supports v86 mode, why wouldn't the kernel?

The hardware supports vm86 mode only if the OS is in 32bit mode. Its
conceptually possible to support this in a 64bit OS but it would be very
very hairy code and very hard to make secure or correct. Feel free to
try it.

Xorg has a software x86 emulator that is very basic but sufficient to
boot most but not all video bioses on all sorts of systems. It uses that
on x86-64.

Alan



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
