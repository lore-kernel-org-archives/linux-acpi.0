From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: Fwd: Re: [RFC] filling in ACPI files in sysfs
Date: Thu, 08 Apr 2004 18:26:50 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081438010.23176.64.camel@t40>
References: <20040408151905.22469.qmail@web80803.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040408151905.22469.qmail-BgaQW1HgEmiA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, alex.williamson-VXdhtT5mjnY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

I found this  
echo 0 > _DCK
echo 1 > _EJ0 
for undock and 
echo 1 > _DCK
for dock, just a couple of hours ago by reading the ACPI 2.0c spec.
Yes, you are right, is is more complete, like shutting off the LED, but
still does not electromechanicaly eject the button. But this is
something else, and I think it has to do with _Q50 on my system.
When I press the eject button, acpi executes _Q50, and
electromechaniclay ejects the eject button.

--- Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org> wrote:
> Subject: Re: [ACPI] [RFC] filling in ACPI files in
> sysfs
> From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
> To: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> CC: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Date: Thu, 08 Apr 2004 08:36:59 -0600
> 
> On Thu, 2004-04-08 at 02:14, Paul Ionescu wrote:
> > Hi Alex,
> > 
> > I attached a file containing what I have in
> > /sys/firmware/acpi with your second patch.
> 
>    Thanks, looks like your namespace is more
> complete than on my old
> omnibook.
> 
> > I also tried the docking station with:
> > echo 1  >
> >
>
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/PCI1/DOCK/_DCK
> > 
> > and 
> > 
> > echo 0 >
> >
>
/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/PCI1/DOCK/_DCK
> > 
> > with this commands I semi turned on/off the doking
> > station. I say semi because is not fully on/off.
> > When I turn it on (echo 1 > _DCK), the docking
> station
> > fan starts, and the LED indicating the usage of
> > docking station turns on, but I dont see the new
> > devices from the docking station (2 new usb, 2 new
> > cardbus, 1 new ide, 1 new pci etc). I suspect this
> is
> > not your patch fault, but the way ACPI handles
> this
> > event. It should add the new description tables of
> > ACPI devices on the fly not only at boot time.
> When it
> > boots without docking station ACPI has no way to
> know
> > what will be in my docking station, so it has to
> add
> > new devices after inserting and activating the
> > docking.
> 
>    Yes, as far as I'm aware, we don't try to
> re-parse acpi namespace
> after such events.  I'm not trying to solve that
> problem though.  This
> is also just a raw interface to the acpi methods, so
> undocking w/o
> handling the things that will get removed may be
> unsafe.  I envision it
> being an interface by which hotplug could evaluate,
> via the _EJD
> methods, what devices will go away and do smart
> things prior to the
> actual eject.  On my docking station, there's no
> obvious effect of
> calling the _DCK method, but calling _EJ0 pops it
> out.  Also, I see all
> 3 possible batteries under /proc/acpi/battery (even
> though only 1 is
> plugged in), so I doubt this patch is changing that
> behavior at all.
> 
> > Now, when I turn it off (with echo 0 > _DCK), the
> fan
> > stops, but the ACTIVE led is still on, and the
> > electromechanical eject was not activated.
> > 
> > Is this the way I was supposed to test docking ?
> 
> 
>    Try the _EJ0 method.  Assuming all device that
> you'll lose are
> quiesced and removed (probably everything that lists
> _SB.PCI0.PCI1.DOCK
> in their _EJD method), I believe you need to do the
> following sequence:
> 
> echo 0 > _DCK
> echo 1 > _EJ0 
> 
> And after you re-dock, you should probably echo 1 >
> _DCK.  Thanks,
> 
> 	Alex
> 
> -- 
> Alex Williamson                             HP Linux
> & Open Source Lab
> 


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
