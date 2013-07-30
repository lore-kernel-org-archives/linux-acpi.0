From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: Re: [PATCH v8.1] x86/tboot: Fail extended mode
	reduced hardware sleep
Date: Tue, 30 Jul 2013 09:26:38 -0400
Message-ID: <CAOvdn6WvEkBymkWAZTFBbjTYaVkmZZNyMLUBioPkap6FqFZ-ww@mail.gmail.com>
References: <1411346.4e01ECe1J5@vostro.rjw.lan>
	<1375190557-21474-1-git-send-email-benjamin.guthro@citrix.com>
	<2818910.x0MegAqoff@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4132084688881388402=="
Return-path: <tboot-devel-bounces@lists.sourceforge.net>
In-Reply-To: <2818910.x0MegAqoff@vostro.rjw.lan>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=tboot-devel>
List-Post: <mailto:tboot-devel@lists.sourceforge.net>
List-Help: <mailto:tboot-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: tboot-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ben Guthro <benjamin.guthro@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, linux-acpi@vger.kernel.org, tboot-devel@lists.sourceforge.net, Jan Beulich <jbeulich@suse.com>
List-Id: linux-acpi@vger.kernel.org

--===============4132084688881388402==
Content-Type: multipart/alternative; boundary=001a11c1e9800e161f04e2ba8f28

--001a11c1e9800e161f04e2ba8f28
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jul 30, 2013 at 9:34 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Tuesday, July 30, 2013 09:22:37 AM Ben Guthro wrote:
> > Register for the extended sleep callback from acpi.
> > As tboot currently does not support the reduced hardware sleep
> > interface, fail this extended call.
> >
> > Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
> > Cc: tboot-devel@lists.sourceforge.net
> > Cc: Gang Wei <gang.wei@intel.com>
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
> Looks OK, thanks!
>
> I'll queue up the patchset for 3.12.
>

Great!
Thanks for your patience on so many rounds of this.

Ben


>
> Thanks,
> Rafael
>
>
> > ---
> >  arch/x86/kernel/tboot.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> > index addf7b5..91a4496 100644
> > --- a/arch/x86/kernel/tboot.c
> > +++ b/arch/x86/kernel/tboot.c
> > @@ -301,6 +301,15 @@ static int tboot_sleep(u8 sleep_state, u32
> pm1a_control, u32 pm1b_control)
> >       return 0;
> >  }
> >
> > +static int tboot_extended_sleep(u8 sleep_state, u32 val_a, u32 val_b)
> > +{
> > +     if (!tboot_enabled())
> > +             return 0;
> > +
> > +     pr_warning("tboot is not able to suspend on platforms with reduced
> hardware sleep (ACPIv5)");
> > +     return -ENODEV;
> > +}
> > +
> >  static atomic_t ap_wfs_count;
> >
> >  static int tboot_wait_for_aps(int num_aps)
> > @@ -422,6 +431,7 @@ static __init int tboot_late_init(void)
> >  #endif
> >
> >       acpi_os_set_prepare_sleep(&tboot_sleep);
> > +     acpi_os_set_prepare_extended_sleep(&tboot_extended_sleep);
> >       return 0;
> >  }
> >
> >
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--001a11c1e9800e161f04e2ba8f28
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Jul 30, 2013 at 9:34 AM, Rafael =
J. Wysocki <span dir=3D"ltr">&lt;<a href=3D"mailto:rjw@sisk.pl" target=3D"_=
blank">rjw@sisk.pl</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Tuesday, July 30, 2013 09:22:37 AM Ben Guthro wrote:<b=
r>
&gt; Register for the extended sleep callback from acpi.<br>
&gt; As tboot currently does not support the reduced hardware sleep<br>
&gt; interface, fail this extended call.<br>
&gt;<br>
&gt; Signed-off-by: Jan Beulich &lt;<a href=3D"mailto:jbeulich@suse.com">jb=
eulich@suse.com</a>&gt;<br>
&gt; Signed-off-by: Ben Guthro &lt;<a href=3D"mailto:benjamin.guthro@citrix=
.com">benjamin.guthro@citrix.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:tboot-devel@lists.sourceforge.net">tboot-devel@l=
ists.sourceforge.net</a><br>
&gt; Cc: Gang Wei &lt;<a href=3D"mailto:gang.wei@intel.com">gang.wei@intel.=
com</a>&gt;<br>
&gt; Reviewed-by: Konrad Rzeszutek Wilk &lt;<a href=3D"mailto:konrad.wilk@o=
racle.com">konrad.wilk@oracle.com</a>&gt;<br>
<br>
</div>Looks OK, thanks!<br>
<br>
I&#39;ll queue up the patchset for 3.12.<br></blockquote><div><br></div><di=
v>Great!</div><div>Thanks for your patience on so many rounds of this.</div=
><div><br></div><div>Ben</div><div>=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<br>
Thanks,<br>
Rafael<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt; ---<br>
&gt; =A0arch/x86/kernel/tboot.c | =A0 10 ++++++++++<br>
&gt; =A01 file changed, 10 insertions(+)<br>
&gt;<br>
&gt; diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c<br>
&gt; index addf7b5..91a4496 100644<br>
&gt; --- a/arch/x86/kernel/tboot.c<br>
&gt; +++ b/arch/x86/kernel/tboot.c<br>
&gt; @@ -301,6 +301,15 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_c=
ontrol, u32 pm1b_control)<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static int tboot_extended_sleep(u8 sleep_state, u32 val_a, u32 val_b)=
<br>
&gt; +{<br>
&gt; + =A0 =A0 if (!tboot_enabled())<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
&gt; +<br>
&gt; + =A0 =A0 pr_warning(&quot;tboot is not able to suspend on platforms w=
ith reduced hardware sleep (ACPIv5)&quot;);<br>
&gt; + =A0 =A0 return -ENODEV;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static atomic_t ap_wfs_count;<br>
&gt;<br>
&gt; =A0static int tboot_wait_for_aps(int num_aps)<br>
&gt; @@ -422,6 +431,7 @@ static __init int tboot_late_init(void)<br>
&gt; =A0#endif<br>
&gt;<br>
&gt; =A0 =A0 =A0 acpi_os_set_prepare_sleep(&amp;tboot_sleep);<br>
&gt; + =A0 =A0 acpi_os_set_prepare_extended_sleep(&amp;tboot_extended_sleep=
);<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0}<br>
&gt;<br>
&gt;<br>
--<br>
</div></div><div class=3D"im HOEnZb">I speak only for myself.<br>
Rafael J. Wysocki, Intel Open Source Technology Center.<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br>

--001a11c1e9800e161f04e2ba8f28--


--===============4132084688881388402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
--===============4132084688881388402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
tboot-devel mailing list
tboot-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/tboot-devel

--===============4132084688881388402==--
