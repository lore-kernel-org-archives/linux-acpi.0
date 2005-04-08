From: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Subject: Re: High frequency sound when loading the processor module --   Please help
Date: Fri, 8 Apr 2005 14:28:51 -0600
Message-ID: <200504081528.51796.gkanis@cems.umn.edu>
References: <200504081428.48477.gkanis@cems.umn.edu> <200504081447.02303.gkanis@cems.umn.edu> <4256E783.9090607@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4256E783.9090607-hi6Y0CQ0nG0@public.gmane.org>
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
Cc: Philipp Wollermann <phil_wo-hi6Y0CQ0nG0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I have two objections to what you said:
If what you are saying is correct (I am not arguing with you on the quality of 
the switches ....you might be right ...)
1) I should hear this sound in Windows, but I do not
2) I should hear the sound only when the system switches between the states, 
and not all the time. 

I think it is a driver issue.

Vasilis


On Friday 08 April 2005 03:20 pm, Philipp Wollermann wrote:
> Hi,
>
> I have this exact problem too with my Acer Extensa 4101 WLMi notebook.
> It's related to low-quality power switching components on the mainboard,
> I think. The cpu module activates support for the CPU power saving
> states (C1, C2, ..) and by switching between two of them very quickly
> (1000 Hz?) you hear the power switching components oscillate. The best
> solution would be to take the notebook back to the store - however this
> is no real option for me, as I want to keep it.. :-D
> Some fix would be nice, preferably if it wouldn't affect power saving
> (so disabling C5 state for example seems to be a bad idea)
>
> Philipp
>
> Vasileios Gkanis wrote:
> > I forgot to say that I am running 2.6.11.6 kernel
> >
> > Also, I have noticed that every time I use the CPU (for example to
> > compile a program), the sound goes away and comes back when the CPU stops
> > working
> >
> > Vasilis
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
