From: ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org
Subject: Re: Re: ACPI Suspend on Inspiron 1100
Date: Mon, 4 Apr 2005 11:22:20 -0400
Message-ID: <20050404152220.GA24028@jose.lug.udel.edu>
References: <20050331191931.GA16450@jose.lug.udel.edu> <200504011602.06831.stefandoesinger@gmx.at> <20050403224042.GA30240@jose.lug.udel.edu> <1112569030.20939.93.camel@tyrosine> <20050404071524.GB8666@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050404071524.GB8666-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2005 at 09:15:24AM +0200, Stefan Seyfried wrote:
> Some of our X gurus told me, that it is actually illegal to simply restore
> vbestate without further knowledge and that "bad things may happen" when
> i asked them if they could not put "vbetool {save,restore}" functionality
> into vt-switch of all x servers. I have not enough knowledge about this stuff
> and could only tell them "but it works sometimes" :-)

Interestingly though, it locks up for me in text mode as well.  Now, X
has been started and is running on another VT, and I haven't tried
with it disabled - that could be related.

But at any rate, the laptop appears not to need it, since posting the
video hardware works well enough to restore text mode, and then
switching back to X11 works smoothly.
-- 
Ross Vandegrift
ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
