From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: question about ACPI & Smart Batteries
Date: Fri, 13 Aug 2004 01:40:34 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.08.12.22.40.32.120142@yahoo.com>
References: <F760B14C9561B941B89469F59BA3A8470726AFF5@orsmsx401.amr.corp.intel.com> <20040812222936.GD30862@miramar.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi Cintia,

In CM case I think that when you look into /proc/acpi/battery/BAT0/state,
you get the instantaneous value.
So the state file is not updated unless you look in it, and then you get
the values at that moment, because the APCI code will just call _BST
method to tell you the actual values.
So, I think you can trust those values as being pretty accurate.

Paul


On Thu, 12 Aug 2004 15:29:36 -0700, Cintia B. Margi wrote:
>> For a CM battery, the OS can poll the battery state by calling _BST, or
>> set a trip point (via _BTP) and the OS will get an interrupt when the
>> battery crosses that trip.
> 
> I do not want to set a trip point, but I would like to monitor the
> battery discharge process... I want to characterize the battery
> discharge behavior under different tasks, so I intend to monitor the
> battery voltage and the discharge rate (which I can obtain from
> /proc/acpi/battery/BAT0/state). What I would like to know is how often
> the state file is updated and how accurate these values are. Any idea
> where I can get this info?
> 
> Thanks,
> 
> Cintia




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
