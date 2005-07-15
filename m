From: Jorgen Bodde <solidstl-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: Embedded controller problems
Date: Fri, 15 Jul 2005 14:45:37 +0200
Message-ID: <42D7AFF1.4040908@xs4all.nl>
References: <42D69DE3.4010106@xs4all.nl> <200507150743.04089.o.jansen@orb-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507150743.04089.o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks Olaf and Oisin!

I had applied the spinlock patch before, but I also had a black screen 
and thought the kernel simply froze and became useless. After reading it 
could take up to 5 minutes to continue, I adjusted the patch as 
described in the sourceforge bug tracker, and low and behold! I have 
typed about 300 characters after achother without a single key missing! 
By tonight I will try to stress the system some more to see if this 
indeed did the trick and removed the key problem totally!

score 1:0 for Linux over Windows ;-) It rocks that you can change it 
yourself to make it working!

Regards,
- Jorgen

Olaf Jansen-Olliges wrote:
> Hi Jorgen, 
> 
> 
>>I own an Acer Travelmate 4001WMLi, and after getting the battery readout
>>fixed under linux by patching my DSDT file and appending it to initrd, I
>>am suffering from missing keys.
> 
> 
> I've an ACER Extensa 3002WLMI which is said to be the same machine. With the 
> information from 
> 
> - https://sourceforge.net/projects/sbs-linux/
> 
> especially the "acpi-ec-nospinlock" Patch I have no problems with missing 
> keys. Without the patch i've had the same problems. 
> 
> You should also read this:
> 
> https://sourceforge.net/tracker/index.php?func=detail&aid=1191536&group_id=129330&atid=714494
> 
> If you need more Information please let me know.
> 
> Regards
> 	Olaf
> 
> BTW: have you got suspend to disk / ram working on your machine?
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
