From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: ACPI + IO-APIC power off by button problems
Date: Mon, 3 Mar 2003 10:55:54 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030303105554.GA12170@clara.net>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E41B@cceexc19.americas.cpqcorp.net> <3E6286C3.1050504@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E6286C3.1050504-nc/lrvXPQ4s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: AnonimoVeneziano <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Cc: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

AnonimoVeneziano [voloterreno-nc/lrvXPQ4s@public.gmane.org] wrote:
> My machine at boot says , in a moment , No IRQ known for 00.11.1 
> Probably Buggy MP Table,   if I have ACPI disabled. 00.11.1 is the IDE 
> COntroller , and I've searched for help for this yet , and in the 
> linux-kernel ML they have said me that this "problem" is hidden by the 
> fact that the IDE Channels  (ide0, ide1) takes indipendent IRQs  (14, 15 
> if I remember well) .

I have this on my Sony VAIO.  Alan Cox said that it was the ACPI version
of a bug he recently squashed in the main kernel.  Basically nothing
should try to assign interrupts to devices which use Legacy IRQs (ie the
IDE controller in our case).

Hopefully the ACPI guys can work out some way of detecting if the device
is legacy or not and just ignore it if it is.  They didn't respond to
Alan Cox's message to acknowledge it.

It's a warning though, the IDE controller gets IRQ 14 and 15 anyway and
all seems to be ok.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

"I've seen the forgeries I've sent out."
-- John F. Haugh II (jfh-xUm3836SnjGloEwRBag+n8J6LWcAlBef@public.gmane.org), about forging net news articles


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
