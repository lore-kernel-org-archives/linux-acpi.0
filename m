From: Richard Jelinek <rj-SPYDw57wZyZBDgjK7y7TUQ@public.gmane.org>
Subject: Multiple problems on Thinkpad A31p
Date: Sat, 4 Dec 2004 12:47:34 +0100
Message-ID: <20041204124734.A22065@petamem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

I recently installed a 2.6-kernel based distro on my Notebook, an IBM
Thinkpad A31p. More precisely the kernel calls itself
2.6.8-24.5-default which translates to

rj@sol:~> cat /proc/acpi/info
version:                 20040715

Now one should know, that the previous 2.4.26 kernel, with APM worked
good for my needs which was to be able to send the machine to some
suspend-to-ram mode when closing the lid and bringing it safely back
again opening the lid.

Now well - ACPI is default in the distro so I went for some
configuration. The good news:

I finally managed to get the machine to go to S3 when closing the lid
and it also comes up relatively safe again (after garbling the screen
a little bit and some slowness for the first 10-20 seconds after
resume).

Also, S5(?) seems to work when pressing the suspend-to-disk button it
purges unnecessary blocks and saves the content to swap. On boot it
recognizes there is something in swap and restores the saved state.

End of good news.

* S1 doesn't do anything. Well ok - let's look at the others.

* Closing the lid, the machine goes down and the "moon"-led goes on
  indicating the suspend state. All is quiet, however, the machine
  generates significant heat. Examining the situation, all fans, the
  HD etc. are switched off, even the display, but some second after
  the display has been switched off completely, THE BACKLIGHT GOES ON
  AGAIN! Uhhh... So after 2hours in this "suspend" mode, the battery
  is just 70% charged. (Took 8hours with APM)

  Even worse, the external (USB Radio) mouse doesn't work
  anymore. Neither did the ethernet (e100), but somehow I managed to
  configure it (mungled the PCI latencies of the ethernet controller),
  so that ethernet is not lost after S3 resume. And there's no way to
  bring the mouse back to life again but reboot. The internal PS/2
  mouse (trackpoint) works fine.

* S5 works as described, unfortunately after resume, the clock shows
  exactly the time, when the shutdown did happen.

--------




-- 
best regards,

     Dipl.-Inf. Richard Jelinek

     - The PetaMem Group - Prague/Nuremberg - www.petamem.com -
		       -= 3394928 Mind Units =-


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
