From: David Goodenough <david.goodenough-6b45v/Ft3lbby3iVrkZq2A@public.gmane.org>
Subject: Re: Re: [RFC] Reliable video POSTing on resume
Date: Fri, 4 Feb 2005 12:11:49 +0000
Message-ID: <200502041211.49789.david.goodenough@btconnect.com>
References: <20050122134205.GA9354@wsc-gmbh.de> <200502041126.14386.oliver@neukum.org> <42035D5A.2030703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <42035D5A.2030703-hi6Y0CQ0nG0@public.gmane.org>
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
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 04 February 2005 11:32, Carl-Daniel Hailfinger wrote:
> Oliver Neukum schrieb:
> > Am Freitag, 4. Februar 2005 08:48 schrieb Pavel Machek:
> >>What about simply blocking all video accesses before disk (etc) is
> >>resumed, so that "normal" (not locked in memory) application can be
> >>used?
> >
> > Very bad for debugging. Genuine serial ports are becoming rarer.
>
> As a bonus, even genuine serial ports may be in undefined state after
> resume. I'm unfortunate enough to have a brand new notebook with
> serial port, but the serial console code will print garbage after
> resume until I do a
> echo foo >/dev/ttyS0
>
> I've already sent mail to linux-serial for that problem, but the
> list appears to be dead. Any pointers to the right contact would
> be appreciated.
>
> Regards,
> Carl-Daniel

I wonder if this is related to a problem I have noted on some embedded
systems which only have a serial console (no video, and nothing to do with
ACPI).

If I set up the video console (through LILO), and talk to it using minicom
when the machine starts I am first talking to BIOS, that works fine, then to
LILO which also works, then the kernel starts and that works up to the point
where the proper serial console is loaded, when it picks some bizaar baud rate
and only corrects it when setserial is run.

I have recently noticed this on an SC1100 board, but it is not SC1100 specific
as another manufacturers SC1100 based board does not exhibit this behaviour.

Just a thought and probably no help in getting it solved.  Sorry I do not have
any good contacts, although once when I had a problem with serial ports being
misdetected on an IBM MCA machine Alan Cox fixed it for me so he obviously
knows his way around the code and might be able to fix it for us.

David


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
