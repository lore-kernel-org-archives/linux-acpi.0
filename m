From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI S3 suspend and LCD backlight
Date: Mon, 14 Nov 2005 13:17:28 +0000
Message-ID: <20051114131728.GA22957@srcf.ucam.org>
References: <200511130639.jAD6d42Y011608@dragonslair.panasol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200511130639.jAD6d42Y011608-MVZ+8Rc8O2bWg2f883+pGFGJXeKZcw9A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: yauh-acpi-CDzBh2wLF5MAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 12, 2005 at 10:39:04PM -0700, yauh-acpi-CDzBh2wLF5MAvxtiuMwx3w@public.gmane.org wrote:

> 	It appears something in the ACPI suspend code turns on the
> LCD backlight to print out the diagnostic messages. Is there any 
> way to prevent this? Alternatively, is there a place in the drive
> I can add a sequence to turn off the display just before it goes
> to sleep?

No, the ACPI suspend code doesn't do this (as far as I can tell). If you 
suspend from X, the kernel will switch away from X and X will restore 
the console state - which probably includes switching the backlight back 
on.

> The xset turns off the backlight but as soon as it gets to the echo 3 line,
> the LCD comes on and displays the ACPI status messages. It then then 
> proceeds to blank the screen but does NOT turn off the backlight.
> If there is no way to disable the messages, I was hoping there is a
> place I can hook into to twiddle the bit needed to disable the backlight.
> Loading the video support module gives me an empty /proc/acpi/video directory.

Try grabbing vbetool and do something like

FGCONSOLE=`fgconsole`
chvt 12
vbetool dpms off
echo -n 3 >/proc/acpi/sleep
chvt $FGCONSOLE

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
