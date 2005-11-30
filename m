From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Problem with address space handler
Date: Wed, 30 Nov 2005 23:05:26 +0100
Message-ID: <20051130220526.GA2056@elf.ucw.cz>
References: <20051129160440.GA27678@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051129160440.GA27678-hnb4XfjZrNkPPsleXtkwkkB+6BGkLq7r@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: marcus hall <marcus-sbVGQhmTrokdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On =DAt 29-11-05 09:04:40, marcus hall wrote:
> Hello..
>=20
> I am attempting to run a driver that listens to hardware buttons via th=
e
> ACPI system.  This driver works in the 2.4.20 kernel, but I am attempti=
ng
> to get it to run on 2.4.28.  There were a lot of ACPI changes between t=
hese
> two kernels, and I'm aparently missing something..

You should really go to 2.6... button drivers should be possible there
without hacking kernel.

--=20
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
