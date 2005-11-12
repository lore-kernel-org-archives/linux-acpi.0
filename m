From: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Subject: Re: vbetool on pure AMD64 system
Date: Sat, 12 Nov 2005 13:09:05 +0100
Message-ID: <200511121309.06084.hugelmopf@web.de>
References: <200511092342.40477.hugelmopf@web.de> <1131793377.5267.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1131793377.5267.6.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
Cc: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks for your replies. So I was right assuming that vbetool can not be used 
with a 64 bit kernel. I hope that you succeed porting it, Matthew. I was told 
that my laptop suspends and wakes fine on x86 (with the most recent Kubuntu). 
I suppose they are using vbetool to get the VGA back.

10. November 2005 17:07, Matthew Garrett:
| There's a video_post program that should also be mentioned in the docs.
| It uses x86emu, but I'm not convinced that it's entirely correct.
| Implementing the same functionality in vbetool shows different
| interrupts being called in lrmi mode and x86emu mode.

I tried that and it does not get my display back active after Suspend. 
Furthermore, if I run it on a normally working display (before Suspend) it 
makes the display go mad (the content scrolls by very rapidly, kind of 
flickering).

12. November 2005 12:02, Erik Slagter:
| What kind of video adapter does your laptop feature?

It is an SiS M760 chipset including VGA. Do you have any suggestions for that?


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
