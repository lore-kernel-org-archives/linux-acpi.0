From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: freqency scaling on compaq nx9010
Date: Sun, 9 Jan 2005 23:56:55 +0100
Message-ID: <20050109225655.GA27910@dominikbrodowski.de>
References: <41E1B46D.1070107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41E1B46D.1070107-Mmb7MZpHnFY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Eschenbacher <Thomas.Eschenbacher-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Please post the contents of all files in
/sys/devices/system/cpu/cpu0/cpufreq/ 

On Sun, Jan 09, 2005 at 07:47:09PM -0300, Thomas Eschenbacher wrote:
> Hi,
> 
> I have a compaq nx9010 laptop, running on kernel 2.4.9-gentoo-r13, with 
> ACPI enabled and speedstep for frequency scaling.
Which variant of speedstep?

> ...and this is also what speedstep does - it switches between these two 
> frequencies, 96% and 100% speed. Isn't this absolutely nonsense? Only 4% 
> speed difference !?

It most likely is nonsense...

> On the other hand my dsdt contains two entries in the _PSS section, one 
> for 3059MHz (100%) and one for 1596MHz (~50%) - but those two 
> frequencies appear nowhere in /proc or /sys/devices/... !?

What does using the acpi-cpufreq driver lead to?

> Is speedstep independend from ACPI ?

It depends on the driver and sometimes on driver settings whether it is
independend from ACPI or not.

	Dominik


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
