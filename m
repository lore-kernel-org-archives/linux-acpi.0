From: Renald Buter <buter-4r0WXg0DlYa9LbC4/O9sjvP6llvjuJOh@public.gmane.org>
Subject: Re: High pitched sound + OOPS with acpi/processor on DELL inspiron 8600
Date: Thu, 8 Jul 2004 16:10:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040708141045.GA32269@infinite.fsw.leidenuniv.nl>
References: <20040705070219.GA2242@infinite.fsw.leidenuniv.nl> <20040705145736.GD5054@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040705145736.GD5054-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 05, 2004 at 04:57:37PM +0200, Pavel Machek wrote:
> Hi!
> 
> > When I load the acpi/processor module (or compile it into the kernel),
> > a high-pitched sound will start to emit from under the keyboard. This
> > whine will lessen when the CPU has something to do, so I presume it has
> > something to do the the dummy calls? Would there be an easy fix?
> 
> 
> Sound while powersaving seems to be normal on many machines. See archives.

Ah. I must have tried the wrong keywords while searching. 

But thank you (and thanks to the other replies): I can stop worrying
about whether I am damaging the CPU in some way.

BTW, I changed (as suggested) the HZ in params.h and now the sound
almost disappeared. Haven't tested video-playback quality, so I don't
know if this will be affected in any way...

Thanks again!

Renald


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
