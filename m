From: Christoph Tavan <chefturner-S0/GAf8tV78@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Wed, 24 Nov 2004 18:42:40 +0100
Message-ID: <200411241842.40296.chefturner@web.de>
References: <200411211600.01820.od@fet.uni-hannover.de> <200411241354.53598.stefandoesinger@gmx.at> <1101313716.7299.2.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1101313716.7299.2.camel@mhcln03>
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

On Wednesday 24 November 2004 17:28, Matthias Hentges wrote:
>
> Yeah, I tried that already. Thanks for mentioning it though :)
>
> If I call it before suspending my monitor goes black and can not be
> revived w/o rebooting. If I call it after S3 (when the monitor is dead
> anyways) it doesn't do anything. Would have been to easy :)

Hmm... Perhaps this is a general Samsung-Problem. I know about very similar 
issues with the X10 and X30 (even though the X-series have nvidia-chips and 
the p35 has a radeon-chip?!).
See bug: http://bugme.osdl.org/show_bug.cgi?id=3203
Unfortunately that bug hasn't been fixed yet...

Christoph


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
