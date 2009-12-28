From: Jerone Young <jerone.young-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH 3/5] thinkpad-acpi: make volume
 subdriver optional
Date: Mon, 28 Dec 2009 15:30:36 -0600
Message-ID: <1262035836.6686.0.camel@laptop>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
	<1261875137-27565-4-git-send-email-hmh@hmh.eng.br>
	<s5hr5qgvjsa.wl%tiwai@suse.de>
	<20091227183220.GB3027@khazad-dum.debian.net>
	<4B37E1AF.6030105@collabora.co.uk>
	<20091228131744.GC19362@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091228131744.GC19362-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Ian Molton <ian.molton-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Helight Xu <helight.xu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2009-12-28 at 11:17 -0200, Henrique de Moraes Holschuh wrote:
> On Sun, 27 Dec 2009, Ian Molton wrote:
> > Not directly related to your patch but I thought I'd mention...
> > 
> > I've noticed issues with my X200 re: routing audio before / after docking.
> 
> ThinkPads used to route line-out to the dock, with a fixed 1.1dB amplifier
> (0.1dB increase) in the audio path, and had the volume control for
> headphones and speakers done in a different audio path, extracted before the
> line-out amplifier.  The PeeCee beeper channel was routed to the headphones
> and speakers, only.
> 
> If Lenovo tried to reproduce that with the HDA mixer but without the "Laptop
> Apudio Controller" the IBM thinkpads had, I wouldn't be surprised if it
> causes massive ALSA disruption should the firmware screw with the HDA mixer
> registers behind ALSA's back.  Try asking the kernel to enable OSI(Linux) in
> ACPI...  I always forget the kernel command line parameter to do that, but
> it is documented in the usual place.

"acpi_osi=Linux" is the kernel command line param your looking for.

> 



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
