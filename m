From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: Toshiba Portege 4000 - keyboard is lost every second reboot
Date: Sun, 10 Jul 2005 01:48:31 -0500
Message-ID: <200507100148.31968.dtor_core@ameritech.net>
References: <200507062253.26575.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507062253.26575.arvidjaar-JGs/UdohzUI@public.gmane.org>
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
Cc: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 06 July 2005 13:53, Andrey Borzenkov wrote:
> I have old P4000 that I intended to install Linux on; I switched it on a 
> couple of times after I got it just see if it works at all. Then I booted Mdk 
> 10.2 (Mandriva LE2005) install CD to see how it would detect devices (the 
> point of interest was WiFi) and suddenly after reboot keyboard was dead (it 
> did not respond to any keypress even during normal "Press F12 for boot 
> menu"). I had to switch it off to reboot again.
> 
> Currently this has WinXP SP2. After playing around a bit I suddenly discovered 
> the same issue under Windows as well. Every second reboot keryboard is "lost" 
> - I can use mouse to reboot and keyboard is back again. After switching it 
> off keyboard was always present.
> 

How many serio ports does it detect? If more than 2 try booting with
i8042.nomux on the kernel command line.

-- 
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
