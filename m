From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: Information regarding C3 cpu state and bus mastering activity
Date: Mon, 12 Dec 2005 01:33:13 +0100
Message-ID: <439CC549.5060500@tzi.de>
References: <da5cd1900512111210k626ff691x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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



Marco Calviani wrote:
> Hi acpi-devel list,
>    I have a problem regarding C3 states and usb. When i'm plugging in a=
ny
> usb devices, the my busmaster activity starts couting preventing the
> cpu to go to C3 state. Obviously if i unload all usb-related modules,
> C3 state goes in, my battery lives longer and the laptop stays quiter;
> unfortunately i need an usb-mouse (and possibly also an external USB dr=
ive.
> I've read somewhere that this is a specific ACPI standard behaviuor
> but i'm asking if this can be modified in some way, i.d. is it
> possible, with some workarounds, to enter C3 state also with the usb
> modules?
No this is not Possibe. In C3 the processor disables his cache. If you=20
have busmaster activity, there are direct writes into the cache (if I=20
remeber right). So if you allow C3 and Busmaster, you will get into some=20
serious truble and loose data.
>=20
> PS: i'm using a Travelmate 8005 laptop with a 1.8GHz dothan centrino
> and debian sid. i'm running kernel 2.6.12.6
>=20
> Thank you very much for your interest,
> Marco Calviani
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_idv37&alloc_id=16865&op=CCk
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
