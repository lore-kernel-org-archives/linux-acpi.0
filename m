From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: system does not wake up sometimes
Date: Tue, 01 Feb 2005 08:44:14 +0800
Message-ID: <1107218653.26227.3.camel@sli10-desk.sh.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD3057501168084@pdsmsx402.ccr.corp.intel.com>
	 <Pine.LNX.4.58.0501312317420.31879@gaston.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Pine.LNX.4.58.0501312317420.31879-iBKnCo7tEuSksujEA26zIQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Peter =?ISO-8859-1?Q?M=FCnster?= <pmlists-GANU6spQydw@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
On Tue, 2005-02-01 at 06:21, Peter M=C3=BCnster wrote:
> On Mon, 31 Jan 2005, Li, Shaohua wrote:
>=20
> > >very often, my system does not wake up at the specified time. I need t=
o
> > >press a key to resume.
> > >The system goes to sleep the day before at about 22h30 with the follow=
ing
> > >commands:
> > >modprobe genrtc
> > >sleep 5
> > >echo 2005-01-28 11:10:00 >/proc/acpi/alarm
> > >sleep 5
> > >echo 1 >/proc/acpi/sleep
> > >
> > >What could be wrong?
> > >I'm using Linux-2.6.10 and ASUS A7N8X-X ACPI BIOS Rev 1006.
> > >
> > >Thanks in advance for any help! Please tell me, if you need more
> > >information.
> >=20
> > did you mean alarm can't work only the specific time? Is there any rule=
?
>=20
> No, I didn't find any rule. Sometimes the system really wakes up the righ=
t
> time (Jan 22 11:10:00 gaston kernel: Back to C!), but very often it does
> not. And this is not so good, because some cron-jobs don't get started at
> the right time...
Just try to set an alarm in system run time (doesn't do suspend/resume)
and see if ACPI interrupt increased (see /proc/interrupts). Please try
several times and report back. How about S3?

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
