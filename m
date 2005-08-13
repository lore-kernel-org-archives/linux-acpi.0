From: Dmitrij Bogush <dmitrij.bogush-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Touchpad problem on 15XX Acer Aspire laptops.
Date: Sat, 13 Aug 2005 06:03:52 +0400
Message-ID: <2ac89c7005081219032e131fd4@mail.gmail.com>
References: <2ac89c700508021812208f23d6@mail.gmail.com>
	 <20050812075251.GA14465@linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050812075251.GA14465-qYCAlGQNbcFrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
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
To: Dmitrij Bogush <dmitrij.bogush-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi.

Patch that I find at "
http://bugzilla.kernel.org/attachment.cgi?id=3D5599&action=3Dview " does
not make any good thing. With this patch I still see log messages like
"Many lost ticks. Cheking if cpu frequency changed.." and "Touchpad
lost sync at byte N". And one strange thing against this patch:
keyboard lags too (I mean if for example "Q" is pressed and battery
state checked at same time I get
"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq" in console)
With patch " http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patche=
s/release/2.6.13/acpi-20050729-2.6.13-rc6.diff.bz2
" I don't more see any messages at all, only one-second-freezes like
with clean rc6.

2005/8/12, Yu, Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> On 2005.08.03 05:12:35 +0400, Dmitrij Bogush wrote:
> > Hi.
> >
> > Someone Dmitry Torokhov on LKML told me to contact ACPI mailing list
> > with this problem.
> >
> > Touchpad goes crazy then programs like Kpowersave or Gkrellm check
> > battery state or current cpu frequency.
> >
> >  With 2.6.11.4 in dmesg I see this:
> >
> > psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
> > psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
> >
> > With latest 2.6.13-rc5 kernel I get this:
> >
> > warning: many lost ticks.
> > Your time source seems to be instable or some driver is hogging interup=
ts
> > rip handler_IRQ_event+0x20/0x60
> >
> > With 2.6.13-rc5 touchpad freezes for a second, do not goese crazy like
> > with 2.6.11.
> >
> > Thanks.
> >
> Please test linux-2.6.13-rc6 with patch filed at bug 3851 , Please try bo=
th
> ec_burst=3D0 and ec_burst=3D1.
> Thanks,
> Luming
>=20


--=20
Best Regards,
Dmitrij A Bogush.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
