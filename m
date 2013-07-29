From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: Re: [PATCH v7 2/3] x86/tboot: Fail extended mode
 reduced hardware sleep
Date: Mon, 29 Jul 2013 16:22:04 -0400
Message-ID: <CAOvdn6X=c_4aQpmBWHqOGi6aZVPRMxkKfQvFU1xXnsUBJgXnDQ@mail.gmail.com>
References: <1375118055-15942-1-git-send-email-benjamin.guthro@citrix.com>
	<8791139.q8n07ejQ71@vostro.rjw.lan> <51F6CE0E.3080807@citrix.com>
	<1982892.4uOzLBL3Sx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1778684370181832582=="
Return-path: <tboot-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1982892.4uOzLBL3Sx@vostro.rjw.lan>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=tboot-devel>
List-Post: <mailto:tboot-devel@lists.sourceforge.net>
List-Help: <mailto:tboot-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/tboot-devel>,
	<mailto:tboot-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: tboot-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ben Guthro <Benjamin.Guthro@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, linux-acpi@vger.kernel.org, tboot-devel@lists.sourceforge.net, Jan Beulich <jbeulich@suse.com>
List-Id: linux-acpi@vger.kernel.org

--===============1778684370181832582==
Content-Type: multipart/alternative; boundary=001a11c1e980ee010d04e2ac3e79

--001a11c1e980ee010d04e2ac3e79
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jul 29, 2013 at 4:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Monday, July 29, 2013 04:18:22 PM Ben Guthro wrote:
> >
> > On 07/29/2013 04:21 PM, Rafael J. Wysocki wrote:
> > > On Monday, July 29, 2013 01:14:14 PM Ben Guthro wrote:
> > >> Register for the extended sleep callback from acpi.
> > >> As tboot currently does not support the reduced hardware sleep
> > >> interface, fail this extended call.
> > >>
> > >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > >> Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
> > >> Cc: tboot-devel@lists.sourceforge.net
> > >> Cc: Gang Wei <gang.wei@intel.com>
> > >> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > >> ---
> > >>  arch/x86/kernel/tboot.c |   12 ++++++++++++
> > >>  1 file changed, 12 insertions(+)
> > >>
> > >> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> > >> index addf7b5..760f431 100644
> > >> --- a/arch/x86/kernel/tboot.c
> > >> +++ b/arch/x86/kernel/tboot.c
> > >> @@ -301,6 +301,17 @@ static int tboot_sleep(u8 sleep_state, u32
> pm1a_control, u32 pm1b_control)
> > >>    return 0;
> > >>  }
> > >>
> > >> +static int tboot_extended_sleep(u8 sleep_state, u32 val_a, u32 val_b)
> > >> +{
> > >> +  if (!tboot_enabled())
> > >> +          return 0;
> > >> +
> > >> +  pr_warning("tboot is not able to suspend on platforms with"
> > >> +             " reduced hardware sleep (ACPIv5). Please contact"
> > >> +             " tboot-devel@lists.sourceforge.net mailing list.");
> > >> +  return -1;
> > >
> > > Please use a meaningful error code here.  For example -ENODEV.
> >
> > Would AE_NOT_IMPLEMENTED be more appropriate?
> >
> > include/acpi/acexcep.h:
> > #define AE_NOT_IMPLEMENTED              EXCEP_ENV (0x000E)
>
> This is not an ACPI error. :-)
>

Good point.
-ENODEV it is, then.

I'll respin tomorrow morning, to allow for anyone else who wishes to
comment on the series.

Thanks for the review

Ben


>
> Rafael
>
>
>
> ------------------------------------------------------------------------------
> Get your SQL database under version control now!
> Version control is standard for application code, but databases havent
> caught up. So what steps can you take to put your SQL databases under
> version control? Why should you start doing it? Read more to find out.
> http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
> _______________________________________________
> tboot-devel mailing list
> tboot-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/tboot-devel
>

--001a11c1e980ee010d04e2ac3e79
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jul 29, 2013 at 4:29 PM, Rafael =
J. Wysocki <span dir=3D"ltr">&lt;<a href=3D"mailto:rjw@sisk.pl" target=3D"_=
blank">rjw@sisk.pl</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Monday, July 29, 2013 04:18:22 P=
M Ben Guthro wrote:<br>
&gt;<br>
&gt; On 07/29/2013 04:21 PM, Rafael J. Wysocki wrote:<br>
&gt; &gt; On Monday, July 29, 2013 01:14:14 PM Ben Guthro wrote:<br>
&gt; &gt;&gt; Register for the extended sleep callback from acpi.<br>
&gt; &gt;&gt; As tboot currently does not support the reduced hardware slee=
p<br>
&gt; &gt;&gt; interface, fail this extended call.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Jan Beulich &lt;<a href=3D"mailto:jbeulich@sus=
e.com">jbeulich@suse.com</a>&gt;<br>
&gt; &gt;&gt; Signed-off-by: Ben Guthro &lt;<a href=3D"mailto:benjamin.guth=
ro@citrix.com">benjamin.guthro@citrix.com</a>&gt;<br>
&gt; &gt;&gt; Cc: <a href=3D"mailto:tboot-devel@lists.sourceforge.net">tboo=
t-devel@lists.sourceforge.net</a><br>
&gt; &gt;&gt; Cc: Gang Wei &lt;<a href=3D"mailto:gang.wei@intel.com">gang.w=
ei@intel.com</a>&gt;<br>
&gt; &gt;&gt; Reviewed-by: Konrad Rzeszutek Wilk &lt;<a href=3D"mailto:konr=
ad.wilk@oracle.com">konrad.wilk@oracle.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt; =A0arch/x86/kernel/tboot.c | =A0 12 ++++++++++++<br>
&gt; &gt;&gt; =A01 file changed, 12 insertions(+)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.=
c<br>
&gt; &gt;&gt; index addf7b5..760f431 100644<br>
&gt; &gt;&gt; --- a/arch/x86/kernel/tboot.c<br>
&gt; &gt;&gt; +++ b/arch/x86/kernel/tboot.c<br>
&gt; &gt;&gt; @@ -301,6 +301,17 @@ static int tboot_sleep(u8 sleep_state, u=
32 pm1a_control, u32 pm1b_control)<br>
&gt; &gt;&gt; =A0 =A0return 0;<br>
&gt; &gt;&gt; =A0}<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; +static int tboot_extended_sleep(u8 sleep_state, u32 val_a, u=
32 val_b)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; + =A0if (!tboot_enabled())<br>
&gt; &gt;&gt; + =A0 =A0 =A0 =A0 =A0return 0;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; + =A0pr_warning(&quot;tboot is not able to suspend on platfor=
ms with&quot;<br>
&gt; &gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 &quot; reduced hardware sleep (ACPI=
v5). Please contact&quot;<br>
&gt; &gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 &quot; <a href=3D"mailto:tboot-deve=
l@lists.sourceforge.net">tboot-devel@lists.sourceforge.net</a> mailing list=
.&quot;);<br>
&gt; &gt;&gt; + =A0return -1;<br>
&gt; &gt;<br>
&gt; &gt; Please use a meaningful error code here. =A0For example -ENODEV.<=
br>
&gt;<br>
&gt; Would AE_NOT_IMPLEMENTED be more appropriate?<br>
&gt;<br>
&gt; include/acpi/acexcep.h:<br>
&gt; #define AE_NOT_IMPLEMENTED =A0 =A0 =A0 =A0 =A0 =A0 =A0EXCEP_ENV (0x000=
E)<br>
<br>
</div></div>This is not an ACPI error. :-)<br></blockquote><div><br></div><=
div>Good point.=A0</div><div>-ENODEV it is, then.</div><div><br></div><div>=
I&#39;ll respin tomorrow morning, to allow for anyone else who wishes to co=
mment on the series.</div>
<div><br></div><div>Thanks for the review</div><div><br></div><div>Ben</div=
><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Rafael<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
---------------------------------------------------------------------------=
---<br>
Get your SQL database under version control now!<br>
Version control is standard for application code, but databases havent<br>
caught up. So what steps can you take to put your SQL databases under<br>
version control? Why should you start doing it? Read more to find out.<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D49501711&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D49501711&amp;iu=3D/4140/ostg.clktrk</a><br>
_______________________________________________<br>
tboot-devel mailing list<br>
<a href=3D"mailto:tboot-devel@lists.sourceforge.net">tboot-devel@lists.sour=
ceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/tboot-devel" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/tboot-devel</a><br=
>
</div></div></blockquote></div><br>

--001a11c1e980ee010d04e2ac3e79--


--===============1778684370181832582==
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
--===============1778684370181832582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
tboot-devel mailing list
tboot-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/tboot-devel

--===============1778684370181832582==--
