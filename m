From: marvin niessner <marvin-2DDjtnKuWtNAfugRpC6u6w@public.gmane.org>
Subject: Embedded Controller initialized too late
Date: 23 Aug 2002 07:37:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1030081050.19551.38.camel@leeloo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

i tryed to get a laptop working with the latest acpi-20020815-patch. 

but there seems to be a problem with the embedded controller stuff:
My bios doesn't have an ECDT area, so the EC isn't available from
beginning. Later, while scanning the bus, the PNP0C09-EC device is
found, and everyting seems fine. (handlers get attached, and so on).

But till this point, all devices that need an working EC got lost with
following message: 'no handler for region(c14ed128) [Embedded_control]'.

Okay. I figured out the problem, but who's problem is it? Is this a bios
problem (has the EC-device to be listet before any device that needs
EC)? Or has the acpi-implementation to scan for ECs before it starts the
device-walk?

after scanning the net for information i only found out that this seems
to be a wide-spreaded problem... 

On request i'll provide all needed information like acpi-table-dump's,
log's, .... 

have a nice day,
	marvin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
