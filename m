From: David Goodenough <david.goodenough-6b45v/Ft3lbby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH] Sanitize ACPI Kconfig
Date: Wed, 19 Jan 2005 21:55:48 +0000
Message-ID: <200501192155.48623.david.goodenough@btconnect.com>
References: <20050107212259.GA13026@wotan.suse.de> <200501171158.51388.david.goodenough@btconnect.com> <20050119121516.GA22856@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050119121516.GA22856-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 19 January 2005 12:15, Pavel Machek wrote:
> Hi!
>
> > > > > neccessary if you want to go 2GHz with your athlon64 laptop (or it
> > > > > is 800MHz), so I'd say enable it.
> > > >
> > > > My desktop boxes and servers all don't care about battery or AC.
> > > >
> > > > But I'm not opposed to turning it on, just the "m" default is quite
> > > > useless.
> > >
> > > I'd say that 'y' there makes sense, but anything is better than 'm'.
> >
> > I really do not understand this.  Having is as a module wastes a bit of
> > disk space (usually not a problem) but means that they can be loaded if
> > wanted either by loading them manually or by using acpid.  Having them as
> > y forces them to be there and some systems with dodgy ACPI
> > implementations will have problems, and having them not there means that
> > Joe User has to
>
> We want to get maximum testing. If there's some dodgy machine, we want
> to have it fixed. [I do not believe I seen such dodgy machines in
> recent history.]
>         Pavel
I think you will find that many people are still using APM because they do not
trust ACPI on their machines.  This may be misplaced but forcing ACPI to be
built always may be misunderstood by those people.

David


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
