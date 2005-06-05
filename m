From: Frank <hugelmopf-S0/GAf8tV78@public.gmane.org>
Subject: Re: Resume from Suspend to RAM
Date: Sun, 5 Jun 2005 17:56:06 +0200
Message-ID: <200506051756.07442.hugelmopf@web.de>
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
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> Three things spring to mind:
>
> 1) If it's using a libata based IDE driver, there's currently no suspend
> or resume support and so it won't work. See
> http://lkml.org/lkml/2005/5/23/116 .

How do I find out, whether my IDE driver is libata based? 
I have no module of this name loaded, the IDE interface is according to lspci 
SiS 5513 (which I have enabled in my kernel config).

> 2) If not, it could be that the machine requires the _GTM and _STM
> methods to be called. There's a patch floating around to do that - check
> the list archives.

OK, I found the patch you posted. I don't have the 2.6.12-rc4 here yet, will 
this patch be included in 2.6.12 when it is released?

Thanks a lot for your suggestions, at least something to hope for :-)

Frank


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
