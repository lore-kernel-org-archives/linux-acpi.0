From: Emmanuel Thome <Emmanuel.Thome+acpi-/zGXu1G9BXs@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Wed, 19 Nov 2003 20:51:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031119205129.A19364@loria2.loria.fr>
References: <20031119180119.GB22307@tate.loria.fr> <20031119194303.GA16571@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031119194303.GA16571-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>; from sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org on Wed, Nov 19, 2003 at 08:43:03PM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 19, 2003 at 08:43:03PM +0100, Karol Kozimor wrote:
> Thus wrote Emmanuel Thomé:
> > S3 works halfway. Meaning the ``going to sleep'' part works ;).  USB is
> > completely dead on bootup (megabytes of ``host controller halted''
> > messages), but that's not my #1 concern. My #1 concern is the radeon
> > 9000 (M9) graphics card, which doesn't come up (fortunately, network is
> > relatively polite, and enables me to investigate). I'm not even talking
> > graphic mode.
> 
> I thought framebuffer was considered "graphic mode", wasn't it? Anyway,

Granted. I meant ``I'm not yet trying to handle the case where X comes to
play''.

The fact that radeonfb is loaded or not does not make a big difference
anyway. It would, if eventually the radeonfb driver were able to talk the
right language to the device. Which is something I'm not going to expect
from vesafb. Proper acpi power management would be a dramatic feature to
add to radeonfb...

> contact Benjamin Herrenschmidt (lkml arschives), he's the one doing a major
> rework of radeonfb for 2.6, so he might be able to help.

yup, done that a few moments ago. I'll be glad if he answers email.


E.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
