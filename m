From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/2] asus-laptop add kill switch support
Date: Fri, 22 Feb 2008 11:03:10 +0100
Message-ID: <1203674590.4995.39.camel@queen.suse.de>
References: <200801161657.50967.corentincj@iksaif.net>
	<200802070040.20871.lenb@kernel.org>  <47AB4895.9090205@crespel.net>
	<1203349001.6019.85.camel@queen.suse.de> <47BB6863.7050208@crespel.net>
Reply-To: trenn-l3A5Bk7waGM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47BB6863.7050208-czgx1wgAc3rR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Fabien Crespel <fabien-czgx1wgAc3rR7s880joybQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2008-02-20 at 00:38 +0100, Fabien Crespel wrote:
> Thomas Renninger wrote :
> > Hi,
> >
> > On Thu, 2008-02-07 at 19:06 +0100, Fabien Crespel wrote:
> >> Basically:
> >> - there is now a killswitch file in /sys/devices/platform/asus-laptop/ to report 
> >> the KS status (read from HWRS)
> >>     
> > Not sure, but:
> > Shouldn't this one register against a general kill-switch interface?
> > E.g. include/linux/rfkill.h
> > instead of starting an own interface...
> >
> >    Thomas
> >   
> Hello,
Hi,

first, I don't know much about this interface and wlan/bluetooth
toggling..., I hope someone who is deeper involved kicks into this
discussion.

> after looking at the rfkill interface, it doesn't seem to have the same 
> purpose here : rfkill seems to be here to allow toggling radio frequency 
> of devices in response to a key or another *software* generated event, 
> while the "killswitch" sysfs file in my patch simply provides a way to 
> read whether the *hardware* kill switch is ON (and not write or toggle 
> anything, since it's completely out of software control).
The problem I see is that you may introduce a very
specific /sys/.../asus_killswitch userspace interface for which a
generic one already or should exist.
You created this for a very specific Lapsus userspace app..., imagine
there are other userspace progs: HAL, WLAN/Bluetooth performance test
programs, whatever wants to know whether Wlan/Bluetooth is on or off.
They now have to collect all this data from different, possibly existing
sysfs files.
Instead (this is what has been done for backlight control), every
specific implementation should register at the backlight driver, you
even find this in the asus driver.
Like that, userspace can operate machine, even architecture independent.

> My intention when adding this interface was to allow userspace tools 
> like Lapsus to know when WLAN/Bluetooth are completely *disabled* (and 
> not simply "off"). I don't think the rfkill interface provides a way to 
> know that, or I missed it..? if it doesn't, wouldn't it be interesting 
> to add it?
> 
> The rfkill interface seems interesting to support the Fn+F2 key though 
> (WLAN/Bluetooth toggle), since currently it doesn't work on all models.

I don't know the policy to provide read or read+write access to the same
thing for different HW.
It can be done:
  1) through file access rights
  2) Simply return -ENODEV (or another error) when userspace tries
     to write to the file in your case, it must handle this gracefully
  3) Provide a set_wlan_state and a get_wlan_state sysfs file
  4) ?

   Thomas


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
