From: marcus hall <marcus-sbVGQhmTrokdnm+yROfE0A@public.gmane.org>
Subject: Re: Problem with address space handler
Date: Thu, 1 Dec 2005 10:03:42 -0700
Message-ID: <20051201170342.GB22812@bastille.tuells.org>
References: <20051129160440.GA27678@bastille.tuells.org> <20051130220526.GA2056@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051130220526.GA2056-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 30, 2005 at 11:05:26PM +0100, Pavel Machek wrote:
> You should really go to 2.6... button drivers should be possible there
> without hacking kernel.

Well, my driver is a loadable module, the only kernel hacking I'm doing is
trying to figure out why it isn't working...  It works just fine on this
hardware under 2.4.20.  But the ACPI system underwent big changes between
2.4.20 -> 2.4.28.

I have now become convinced that ACPI is not seeing the button presses, so
the AML code never runs to "write" into the address space, so my driver
never sees the address space activated.  That all makes reasonable sense
and is supported by the fact that IRQ 9 (which is the only ACPI handled
interrupt) has zero hits recorded, regardless of repeatedly pressing buttons.
Also, with full debugging turned on, I see no output as a result of button
presses.

So, the problem seems to be something in the setup.  Many of the ACPI
functions *are* working..  I can adjust screen brightness, I can see the
battery status, I can see the AC status change when I plug in or remove
the charger.

One other thing that appears to be non-functional is the power switch:

<4>evxfevnt-0196 [26] acpi_enable_event     : Could not enable power_button even
t
<4> evxface-0107 [25] acpi_install_fixed_eve: Could not enable fixed event.
<4>acpi_button-0437 [24] acpi_button_add       : Error installing notify handler

My driver also attempts to call
acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,buttons_acpi_power,0)
which fails with code 0x19 (AE_NO_HARDWARE_RESPONSE).  I don't know if this
is clearly related to the button issue, but it seems likely at least.

Is there any additional setup required with the newer ACPI code that might
wake things up?  I am not running acpid, if that might be significant..

I do want to take things to the 2.6 kernel eventually, but there are still
enough ties to the 2.4 kernel elsewhere that I can't do it just yet...

Thanks in advance!

Marcus Hall


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
