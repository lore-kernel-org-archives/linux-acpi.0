From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: Re: ACPI on hp Tablet TC1100
Date: Fri, 25 Mar 2005 16:14:57 -0500
Message-ID: <42447F51.2030000@joshuawise.com>
References: <Pine.LNX.4.58.0503241657510.4376@dashnine>	 <1111704587.11677.27.camel@tyrosine>	 <Pine.LNX.4.58.0503241901440.4867@dashnine> <1111723887.11677.33.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111723887.11677.33.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Unload USB modules before suspend, and reload them after resume. You
> probably want to write a script to do this.
Ok, I'll do that. It still seems like Bad Behavior, though. Is this list 
the right place, or should I mail linux-usb-devel? Or is this a known issue?

> Seriously, give up on the nvidia driver if you want working ACPI. It
> just doesn't work properly. If I had the source code I'd try to debug
> it, but, well...
I see where you're coming from with that, but it's not solely the nvidia 
driver's fault. If I kill off X entirely before suspending, then resume, 
and restart X, X hangs before the nvidia driver even gets loaded.

joshua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
