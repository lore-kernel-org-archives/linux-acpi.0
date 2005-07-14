From: Jorgen Bodde <solidstl-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Embedded controller problems
Date: Thu, 14 Jul 2005 19:16:19 +0200
Message-ID: <42D69DE3.4010106@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi List,

I own an Acer Travelmate 4001WMLi, and after getting the battery readout 
fixed under linux by patching my DSDT file and appending it to initrd, I 
am suffering from missing keys.

Now, this phenomenon is not new to me, I knew my laptop has this under 
Windows as well. I have been trying to minimize this problem to no avail.

It just happens that every 20 characters or so, I miss out on one or 
two,. Very annoying when typing a password, and especially when SETTING 
passwords.

I have read it had to do with the embedded controller and lost 
interrupts when the battery status is polled. I also read somewhere the 
polling interval is rediculously high (every 1 second) when windows 
polls this with a less interval which can be the reason the missing keys 
are less frequent under windows.

Is there a way to lower the polling interval of the battery, or even 
better, fix this problem? My system info:

Suse 9.3
Kernel 2.6.11
Acter travelmate 4001WMLi
Panasonic battery

Any help is very much appreciated as I really would like to use Linux, 
but the missing keys make it hard to enjoy using it :-(

Regards,
- Jorgen


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
