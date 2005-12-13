From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Information regarding C3 cpu state and bus mastering activity
Date: Tue, 13 Dec 2005 15:06:24 +0100
Message-ID: <20051213140624.GA13694@elf.ucw.cz>
References: <da5cd1900512111210k626ff691x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <da5cd1900512111210k626ff691x-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marco Calviani <marco.calviani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Ne 11-12-05 21:10:53, Marco Calviani wrote:
> Hi acpi-devel list,
>    I have a problem regarding C3 states and usb. When i'm plugging in any
> usb devices, the my busmaster activity starts couting preventing the
> cpu to go to C3 state. Obviously if i unload all usb-related modules,
> C3 state goes in, my battery lives longer and the laptop stays quiter;
> unfortunately i need an usb-mouse (and possibly also an external USB drive.
> I've read somewhere that this is a specific ACPI standard behaviuor
> but i'm asking if this can be modified in some way, i.d. is it
> possible, with some workarounds, to enter C3 state also with the usb
> modules?

Fix USB to send mouse into runtime-sleep state. That will allow C3 to
be used as long as you are not actively moving the mouse.
								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
