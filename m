From: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Thu, 22 Dec 2005 17:06:33 +0100
Message-ID: <20051222160633.GA3316@suse.de>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de> <43AAB13E.4080206@csstirisano.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AAB13E.4080206-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jacok-W7S27g77yncFbeUAN25fX/d9D2ou9A/h@public.gmane.org>
Cc: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 22, 2005 at 03:59:26PM +0200, Jaco Kroon wrote:
=20
> P4 - not HT though (not afaik anyway - or for a change I was blind -=20
> running without HT anyway).

it looks like you have a very different P10 than the one we have...

> I also assume it's at this time impossible to use fglrx with resume/sus=
pend?

...because ours has a NVidia graphics card.

> "The beast" specs and what I've done (and gotten working) so far is=20
> available at http://www.kroon.co.za/howto.php?howto=3Dtoshiba_p10.

This sounds similar to ours, but we definitely have an NVidia card and a
HT capable processor.

> With regards to the ACPI code though - I've managed to fix all the=20
> warnings and errors, except the one about the ResourceSource error,=20
> which according to the spec is optional but iasl insists it's required.=
=20
>  No idea what I'm going to do about that.  Also not sure whether fixing=
=20
> _WAK to always return a value will actually do something.

I do not remember that i would have to fix any DSDT bugs, everything work=
ed
with the original DSDT.

But it is some time ago that i did use this machine, and due to its=20
tremendously huge footprint and very heavy weight, i just used it
as a Workstation, so not very frequent. Also the dual turbines did their
share that it was turned off most of the time :-))
=20
> Notice: This message and any attachments are confidential and intended=20
> solely for the addressee. If you have received this message in error,=20
> please notify the sender by email or by phone to the listed number. Any=
=20
> unauthorised use, alteration or dissemination is prohibited. CSS=20
> Tirisano (Pty) Ltd accepts no liability for any direct, indirect or=20
> consequential loss or damages, arising from the contents of this messag=
e.

OMG! i hope i'm not going to jail now ;-)
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
