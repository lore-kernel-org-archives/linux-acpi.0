From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Fri, 4 Feb 2005 20:08:57 -0500
Message-ID: <9e47339105020417081d5a82e4@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
	 <9e473391050204093837bc50d3@mail.gmail.com> <420418C7.5010309@gmx.net>
Reply-To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <420418C7.5010309-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 05 Feb 2005 01:52:23 +0100, Carl-Daniel Hailfinger
<c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org> wrote:
> My problem (Samsung P35) is that the BIOS wants to call code which
> is no longer mapped because the BIOS is too big to fit into the
> standard area. Since that additional area has been overwritten, we
> are out of luck. Maybe if we did something like backing up all

Look at the scitech source code. There are a limited number of system
BIOS calls that need to be implemented. It is a fairly small number.
wakeup.S could supply implementations for these and patch them into
the right interrupt vectors while the VBIOS is being run. There is no
requirement that VBIOS run the actual system BIOS, it only has to
think that it is running on the system BIOS. This is the same scheme
used for running the ROMs in user space.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
