From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: PATCH: Call acpi_leave_sleep_state before resuming devices
Date: Wed, 26 Jan 2005 15:11:24 +0100
Message-ID: <200501261511.26203.stefandoesinger@gmx.at>
References: <200501252036.32045.stefandoesinger@gmx.at> <1106718353.4157.17.camel@nigelcunningham>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106718353.4157.17.camel@nigelcunningham>
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
To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Mittwoch, 26. Januar 2005 06:45 schrieb Nigel Cunningham:
> Hi.
>
> On Wed, 2005-01-26 at 06:36, Stefan D=F6singer wrote:
> > Hello,
> > The attached patch introduces 2 new suspend/resume functions,
> > pm_ops->setup and pm_ops->leave. These are used to correct the order of
> > suspending/resuming devices and calling acpi functions.
>
> Just so I have it clear, this is a separate patch to Li Shaohua's set,
> isn't it? Sorry if it's a lame question - too many patches floating
> around.
Yes, this is a seperate patch. I just had a look at Lo Shaohua's patches an=
d=20
they do not cover this one.

Stefan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
