From: Philipp Wollermann <phil_wo-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: High frequency sound when loading the processor module
 --   Please help
Date: Fri, 08 Apr 2005 22:20:19 +0200
Message-ID: <4256E783.9090607@gmx.net>
References: <200504081428.48477.gkanis@cems.umn.edu> <200504081447.02303.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504081447.02303.gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have this exact problem too with my Acer Extensa 4101 WLMi notebook. 
It's related to low-quality power switching components on the mainboard, 
I think. The cpu module activates support for the CPU power saving 
states (C1, C2, ..) and by switching between two of them very quickly 
(1000 Hz?) you hear the power switching components oscillate. The best 
solution would be to take the notebook back to the store - however this 
is no real option for me, as I want to keep it.. :-D
Some fix would be nice, preferably if it wouldn't affect power saving 
(so disabling C5 state for example seems to be a bad idea)

Philipp

Vasileios Gkanis wrote:
> I forgot to say that I am running 2.6.11.6 kernel
> 
> Also, I have noticed that every time I use the CPU (for example to compile a 
> program), the sound goes away and comes back when the CPU stops working
> 
> Vasilis


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
