From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Re: [RFC] Reliable video POSTing on resume
Date: Sun, 6 Feb 2005 12:05:13 +0100
Message-ID: <200502061205.14131.stefandoesinger@gmx.at>
References: <20050122134205.GA9354@wsc-gmbh.de> <200502051748.43547.stefandoesinger@gmx.at> <9e47339105020509382adbbf39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9e47339105020509382adbbf39-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Samstag, 5. Februar 2005 18:38 schrieb Jon Smirl:
> On Sat, 5 Feb 2005 17:48:43 +0100, Stefan D=F6singer
>
> <stefandoesinger-RbZlAiThDcE@public.gmane.org> wrote:
> > The reset code of radeon card seems to be easy to reverse engineer. I
> > have started an attempt and I have 50-60% of my radeon M9 reset code
> > implemented in a 32 bit C program. I had to stop due to school reasons.
>
> The problem with the radeon reset code is that there are many, many
> variations of the radeon chips, including different steppings of the
> same part. The ROM is matched to the paticular bugs of the chip. From
> what I know ATI doesn't even have a universal radeon reset program.
I don't think they differ a lot. Does anybody know how the Win32 driver res=
ets=20
the card? If it calls 0xc000:3 it will also have the problem with overwritt=
en=20
reset code, and if it has it's own reset routine the cards can't differ a=20
lot.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
