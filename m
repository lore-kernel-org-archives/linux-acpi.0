From: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Thu, 22 Dec 2005 13:04:13 +0100
Message-ID: <20051222120413.GA28743@suse.de>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051222110219.GB9838-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>
Cc: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 22, 2005 at 12:02:19PM +0100, Pavel Machek wrote:
> Hi
>=20
> > I'm having some trouble with suspend/resume on my Toshiba Satellite P=
10=20
> > and was wondering whether anybody would be able to assist.
> >=20
> > The omnibook module makes some functionality (like the multimedia key=
s,=20
> > temperature readings, LCD and FAN adjustments) available.  It however=
=20
> > does not help with suspend/resume at all.
> >=20
> > It seems like the notebook only supports standby and suspend to ram. =
 It=20
> > seems to come out of standby almost immediately and never come out of=
=20
> > suspend to ram.  Running hibernate-ram -n works fine, but when runnin=
g=20
> > it without -n it actually suspends to RAM, hdd spins down, network go=
es=20
> > down, CPU fans stop and the power led turns red (instead of the norma=
l=20
> > blue - this is in accordance with what I've seen with Windows).
> >=20
> > When it's time again to resume however, it just does nothing and I ne=
ed=20
> > to power-cycle the machine to get it usable again.
>=20
> P10... is it that beast with pentium4 and hyperthreading? Dual cpu
> fans?
>=20
> That worked for me. See Doc*/power/video.txt. Yep, that one works with
> right config. Get swsusp working, first. Then you can debug s2ram.

Holger, do you have any hints on recent kernels on the P10? I have not
touched this beast (the right noun for this brick :-) for a long time.
--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohe=
n


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
