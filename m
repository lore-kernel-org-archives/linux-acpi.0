From: Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: current ACPI status in 2.6.7 kernel
Date: Wed, 11 Aug 2004 10:10:24 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092233424.1977.21.camel@camel>
References: <411881B1.9000903@ti.com>
	 <1092132146.2666.3.camel@laptop.cunninghams> <4118D40D.5030404@ti.com>
	 <4118F918.7070909@optonline.net> <4119024B.5060602@optonline.net>
	 <4119CF6A.8020807@ti.com>  <411A1CC5.5030401@optonline.net>
Reply-To: herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <411A1CC5.5030401-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-08-11 at 09:19, Nathan Bryant wrote:
<snip>
> Oh, and there's that annoying little problem where acpid sees the button 
> press that I have to use to resume, as a shutdown event...
</snip>

I don't have this issue myself since hitting any button on my laptop
wakes it up but I think it would be possible to get around this problem
by putting something like this into your acpid script that handles the
button press:

if test ! -e /tmp/button_lock
then
	/sbin/shutdown
fi

Then in your suspend script add:

touch /tmp/button_lock
echo -n mem > /sys/power/state
rm /tmp/button_lock 

It would need to be tweaked a bit since the rm may get executed before
the suspend completes and maybe acpid will get the button event some
time after resume so there might need to be a sleep statement but in
general I think it would solve the problem.

-Herman
	



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
