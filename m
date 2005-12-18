From: Olaf Conradi <oohlaf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: regression between -rc4 and -rc5
Date: Sun, 18 Dec 2005 16:12:08 +0100
Message-ID: <1c687cba0512180712oc9579cbi96e97b5c89e424fd@mail.gmail.com>
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

On 12/9/05, Karasyov, Konstantin A <konstantin.a.karasyov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> It looks like your trip points are getting reset on thermal
> notifications.
> Your DSDT implements hysteresis for passive and active cooling (i.e.
> when the temperature raises above the trip point, the trip point value
> is decreased to avoid too frequent trip point crossing), so hardware
> sends the notification to the system to update the trip points, when the
> trip point is being crossed.
>
> So, it's not a bug, it is a firmware implementation, but your DSDT could
> be slightly modified to set higher trip points values:

I've started looking into the DSDT to fix various methods, so far just
tried to figure out what all methods do.

In the mean time I upgraded to kernel 2.6.15-rc4 and most problems
disappeared. Still using the original DSDT. During heavy usage cpu
temperature rises to 76-78, and never reaches 80.

Yesterday I upgraded to kernel 2.6.15-rc5, and during compilation of
ndiswrapper, while browsing the internet, it shutdown. If I compile
ndiswrapper and don't do anything else, the cpu temp touches 80
briefly, but does not shutdown. Under -rc4 this does not happen.

 -Olaf


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
