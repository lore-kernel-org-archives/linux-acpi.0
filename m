From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: ACPI Suspend on Inspiron 1100
Date: Mon, 4 Apr 2005 09:15:24 +0200
Message-ID: <20050404071524.GB8666@message-id.gmane0305.slipkontur.de>
References: <20050331191931.GA16450@jose.lug.udel.edu> <200504011602.06831.stefandoesinger@gmx.at> <20050403224042.GA30240@jose.lug.udel.edu> <1112569030.20939.93.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1112569030.20939.93.camel@tyrosine>
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

On Sun, Apr 03, 2005 at 11:57:10PM +0100, Matthew Garrett wrote:
> On Sun, 2005-04-03 at 18:40 -0400, ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org wrote:
> 
> > Oddly, vbetool vbestate restore seems to lock the terminal up.
> 
> It happens on some machines. I haven't been able to figure out why. I'd
> tend to blame crappy video BIOSes, but it's possible that there's some
> issue in the emulation.

Some of our X gurus told me, that it is actually illegal to simply restore
vbestate without further knowledge and that "bad things may happen" when
i asked them if they could not put "vbetool {save,restore}" functionality
into vt-switch of all x servers. I have not enough knowledge about this stuff
and could only tell them "but it works sometimes" :-)
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
