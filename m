From: Jeroen Wijnhout <Jeroen.Wijnhout-sVbgdUKTYbrR7s880joybQ@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Wed, 19 Jan 2005 19:49:03 +0100
Message-ID: <200501191949.03558.Jeroen.Wijnhout@kdemail.net>
References: <41E81C2C.8010809@bartol.udel.edu> <41EC9316.80109@bartol.udel.edu>
 <41EDE2EA.7090404@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <41EDE2EA.7090404-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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

On Wednesday 19 January 2005 05:32, Rich Townsend wrote:
> OK, it seems like I've drifted toward doing a nightly build of the SBS
> driver -- and tonight is no different! The latest version of the code,
>
> http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050119.tar.gz
>
> contains some important changes, including:

I've tried the above driver on my Acer TM4001WLMi and it sort of doesn't work. 
The problem is that after modprobing i2c_acpi_ec and acpi_sbs I've got two 
battery and two ac_adapter directories in /proc (very weird if you ask me).

So before modprobing:
ls -l /proc/acpi
gives
total 0
dr-xr-xr-x   10 root root 0 2005-01-19 19:36 .
dr-xr-xr-x  103 root root 0 2005-01-19 20:36 ..
dr-xr-xr-x    2 root root 0 2005-01-19 19:44 ac_adapter
-rw-r--r--    1 root root 0 2005-01-19 19:44 alarm
dr-xr-xr-x    2 root root 0 2005-01-19 19:37 battery
dr-xr-xr-x    5 root root 0 2005-01-19 19:44 button
-rw-r--r--    1 root root 0 2005-01-19 19:44 debug_layer
-rw-r--r--    1 root root 0 2005-01-19 19:44 debug_level
-r--------    1 root root 0 2005-01-19 19:44 dsdt
dr-xr-xr-x    3 root root 0 2005-01-19 19:44 embedded_controller
-r--------    1 root root 0 2005-01-19 19:36 event
-r--------    1 root root 0 2005-01-19 19:44 fadt
dr-xr-xr-x    4 root root 0 2005-01-19 19:44 fan
-r--r--r--    1 root root 0 2005-01-19 19:44 info
dr-xr-xr-x    4 root root 0 2005-01-19 19:44 power_resource
dr-xr-xr-x    3 root root 0 2005-01-19 19:44 processor
-rw-r--r--    1 root root 0 2005-01-19 19:44 sleep
dr-xr-xr-x    3 root root 0 2005-01-19 19:44 thermal_zone
-rw-r--r--    1 root root 0 2005-01-19 19:44 wakeup

Then, after modprobing the modules
total 0
dr-xr-xr-x   10 root root 0 2005-01-19 19:36 .
dr-xr-xr-x  103 root root 0 2005-01-19 20:36 ..
dr-xr-xr-x    3 root root 0 2005-01-19 19:45 ac_adapter
dr-xr-xr-x    3 root root 0 2005-01-19 19:45 ac_adapter
-rw-r--r--    1 root root 0 2005-01-19 19:45 alarm
dr-xr-xr-x    2 root root 0 2005-01-19 19:37 battery
dr-xr-xr-x    2 root root 0 2005-01-19 19:37 battery
dr-xr-xr-x    5 root root 0 2005-01-19 19:45 button
-rw-r--r--    1 root root 0 2005-01-19 19:45 debug_layer
-rw-r--r--    1 root root 0 2005-01-19 19:45 debug_level
-r--------    1 root root 0 2005-01-19 19:45 dsdt
dr-xr-xr-x    3 root root 0 2005-01-19 19:45 embedded_controller
-r--------    1 root root 0 2005-01-19 19:36 event
-r--------    1 root root 0 2005-01-19 19:45 fadt
dr-xr-xr-x    4 root root 0 2005-01-19 19:45 fan
-r--r--r--    1 root root 0 2005-01-19 19:45 info
dr-xr-xr-x    4 root root 0 2005-01-19 19:45 power_resource
dr-xr-xr-x    3 root root 0 2005-01-19 19:45 processor
dr-xr-xr-x    3 root root 0 2005-01-19 19:45 sbs
-rw-r--r--    1 root root 0 2005-01-19 19:45 sleep
dr-xr-xr-x    3 root root 0 2005-01-19 19:45 thermal_zone
-rw-r--r--    1 root root 0 2005-01-19 19:45 wakeup

Something works:
cat ac_adapter/AC0/state
gives
state: off-line

However,
ls battery
gives nothing (empty dir).

There is an sbs dir, that has all the correct info. The only thing that seems 
to give problems is the battery directory. Also it would be nice if there was 
only one battery and ac_adapter dir.

best,
Jeroen
-- 
Kile - a LaTeX Environment for KDE
http://kile.sourceforge.net


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
