From: Marco Calviani <marco.calviani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Information regarding C3 cpu state and bus mastering activity
Date: Sun, 11 Dec 2005 21:10:53 +0100
Message-ID: <da5cd1900512111210k626ff691x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi acpi-devel list,
   I have a problem regarding C3 states and usb. When i'm plugging in any
usb devices, the my busmaster activity starts couting preventing the
cpu to go to C3 state. Obviously if i unload all usb-related modules,
C3 state goes in, my battery lives longer and the laptop stays quiter;
unfortunately i need an usb-mouse (and possibly also an external USB drive.
I've read somewhere that this is a specific ACPI standard behaviuor
but i'm asking if this can be modified in some way, i.d. is it
possible, with some workarounds, to enter C3 state also with the usb
modules?

PS: i'm using a Travelmate 8005 laptop with a 1.8GHz dothan centrino
and debian sid. i'm running kernel 2.6.12.6

Thank you very much for your interest,
Marco Calviani


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
