From: Olaf Conradi <oohlaf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI Thermal Zones and unwanted reset of Trip Points
Date: Sun, 11 Dec 2005 13:05:14 +0100
Message-ID: <1c687cba0512110405k5671ff48h3dbb06bce35a31a3@mail.gmail.com>
References: <1c687cba0512041340r5641603ew8a30a10e480720bb@mail.gmail.com>
	 <20051208220521.GA3060@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051208220521.GA3060-+ZI9xUNit7I@public.gmane.org>
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

On 12/8/05, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> Olaf Conradi wrote:
> > But, for some reason, the trip points get reset every now and then
> > (usually within 30 mintes or so, don't know the exact interval).
> >
> > Does anyone know what causes the trip point setting to be reset?
>
> BIOS does it from time to time to provide hysteresis. Patch to
> optionaly make trip points read-only w.r.t. BIOS would be welcome.

I've been looking at the acpi spec but to me it's not clear how a user
can give their thermal management preferences.

Should it be through Set Cooling Policy (SCP) only?
Is a user still allowed to fiddle with trip points, or is it for
plugin devices only.

The spec says SCP is optional (and my DSDT has a very limited
implementation, it just stores the preference and does not act on it).
Looking at the disassembled AML it shouldn't be too hard to implement
it.

Is /proc/acpi/thermal_zone/THRM/cooling_mode the interface to set SCP?

Cheers,
 -Olaf


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
