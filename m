From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: vbetool on pure AMD64 system
Date: Thu, 10 Nov 2005 16:07:23 +0000
Message-ID: <20051110160723.GA8725@srcf.ucam.org>
References: <200511092342.40477.hugelmopf@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200511092342.40477.hugelmopf-S0/GAf8tV78@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 09, 2005 at 11:42:39PM +0100, Frank wrote:

> Here is the problem: I didn't find an AMD64 version of vbetool (using Debian 
> testing AMD64), so I forced the i386 package and manually met its 32bit 
> dependencies. It does run, and the "vgastate off" option does disable the 
> LCD. But saving and restoring the state, I get the following error:

If you're running a 64-bit kernel, you can't make vm86 calls. At the 
moment, vbetool requires that. I'm looking at porting it to use x86emu 
on non-x86 systems, but haven't been able to get it to work properly 
yet.

There's a video_post program that should also be mentioned in the docs. 
It uses x86emu, but I'm not convinced that it's entirely correct. 
Implementing the same functionality in vbetool shows different 
interrupts being called in lrmi mode and x86emu mode.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
