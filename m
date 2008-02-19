From: Fabien Crespel <fabien-czgx1wgAc3rR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] asus-laptop add kill switch support
Date: Wed, 20 Feb 2008 00:38:11 +0100
Message-ID: <47BB6863.7050208@crespel.net>
References: <200801161657.50967.corentincj@iksaif.net>	
	<200802070040.20871.lenb@kernel.org> <47AB4895.9090205@crespel.net>
	<1203349001.6019.85.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1203349001.6019.85.camel-X8wR35IVlAxolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thomas Renninger wrote :
> Hi,
>
> On Thu, 2008-02-07 at 19:06 +0100, Fabien Crespel wrote:
>> Basically:
>> - there is now a killswitch file in /sys/devices/platform/asus-laptop/ to report 
>> the KS status (read from HWRS)
>>     
> Not sure, but:
> Shouldn't this one register against a general kill-switch interface?
> E.g. include/linux/rfkill.h
> instead of starting an own interface...
>
>    Thomas
>   
Hello,

after looking at the rfkill interface, it doesn't seem to have the same 
purpose here : rfkill seems to be here to allow toggling radio frequency 
of devices in response to a key or another *software* generated event, 
while the "killswitch" sysfs file in my patch simply provides a way to 
read whether the *hardware* kill switch is ON (and not write or toggle 
anything, since it's completely out of software control).

My intention when adding this interface was to allow userspace tools 
like Lapsus to know when WLAN/Bluetooth are completely *disabled* (and 
not simply "off"). I don't think the rfkill interface provides a way to 
know that, or I missed it..? if it doesn't, wouldn't it be interesting 
to add it?

The rfkill interface seems interesting to support the Fn+F2 key though 
(WLAN/Bluetooth toggle), since currently it doesn't work on all models.

- Fabien.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
