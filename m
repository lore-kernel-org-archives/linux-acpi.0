From: Shuduo Sang <shuduo.sang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH V3] support Thinkpad X1 Carbon 2nd
	generation's adaptive keyboard
Date: Wed, 5 Mar 2014 12:20:32 +0800
Message-ID: <CA+BAWBQMP7QRcejLFYTG_PFbM+m_j+07LS520tG4PeD-L4b18A@mail.gmail.com>
References: <5314AE4C.4090502@canonical.com> <20140304091916.GE1883@distanz.ch>
	<5315B572.1000403@canonical.com> <20140304135120.GF1883@distanz.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8964964807534364731=="
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20140304135120.GF1883-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bruce Ma <bruce.ma-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, matthew.garrett-+LlxwbBB2+6sTnJN9+BGXg@public.gmane.org, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn-yOkvZcmFvRU@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--===============8964964807534364731==
Content-Type: multipart/alternative; boundary=001a1133eb38cf45a004f3d459db

--001a1133eb38cf45a004f3d459db
Content-Type: text/plain; charset=ISO-8859-1

OK. I will modify them in V4. :)


On Tue, Mar 4, 2014 at 9:51 PM, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org> wrote:

> On 2014-03-04 at 12:13:54 +0100, Shuduo Sang <shuduo.sang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> wrote:
> >
> > Submit patch V3 to support Adaptive Keyboard on Thinkpad X1 Carbon 2nd
> > generation according to Tobias's comments.
>
> It seems like I missed one in the previous comment, sorry. Also one
> of the previous comments was only partially addressed in this updated
> patch. See below for the comments...
>
> > Thanks,
> > Shuduo
> >
> > From 2b8175e69deee661d97d371b2422a9c192fefd52 Mon Sep 17 00:00:00 2001
> > From: Shuduo Sang <sangshuduo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Date: Mon, 3 Mar 2014 14:29:32 +0800
> > Subject: [PATCH] support thinkpad X1 Carbon's adaptive keyboard
> >
> > Thinkpad X1 Carbon's adaptive keyboard has five modes including Home
> > mode, Web browser mode, Web conference mode, Function mode and Lay-flat
> > mode. We support Home mode and Function mode currently.
> >
> > Signed-off-by: Bruce Ma <bruce.ma-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> > Signed-off-by: Shuduo Sang <shuduo.sang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 102
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c
> > b/drivers/platform/x86/thinkpad_acpi.c
> > index defb6af..6664dcd 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -3437,6 +3437,106 @@ err_exit:
> >       return (res < 0)? res : 1;
> >  }
> >
> > +/* Thinkpad X1 Carbon support 5 modes including Home mode, Web browser
> > + * mode, Web conference mode, Function mode and Lay-flat mode.
> > + * We support Home mode and Function mode currently.
> > + *
> > + * Will consider support rest of modes in future.
> > + *
> > + */
> > +enum ADAPTIVE_KEY_MODE {
> > +     HOME_MODE,
> > +     WEB_BROWSER_MODE,
> > +     WEB_CONFERENCE_MODE,
> > +     FUNCTION_MODE,
> > +     LAYFLAT_MODE
> > +};
> > +
> > +int adaptive_keyboard_modes[] = {
> > +     HOME_MODE,
> > +/*   WEB_BROWSER_MODE = 2,
> > +     WEB_CONFERENCE_MODE = 3, */
> > +     FUNCTION_MODE
> > +};
>
> This array can be made be static const.
>
> > +
> > +#define DFR_CHANGE_ROW                       0x101
> > +#define DFR_SHOW_QUICKVIEW_ROW               0x102
> > +
> > +/* press Fn key a while second, it will switch to Function Mode. Then
> > + * release Fn key, previous mode be restored.
> > + */
> > +static bool adaptive_keyboard_mode_is_saved;
> > +static int adaptive_keyboard_prev_mode;
> > +
> > +static int adaptive_keyboard_get_next_mode(int mode)
> > +{
> > +     int i;
>
> This should be size_t as well, as mentioned in the previous comment.
>
> > +     size_t max_mode = ARRAY_SIZE(adaptive_keyboard_modes) - 1;
> > +
> > +     for (i = 0; i <= max_mode; i++) {
> > +             if (adaptive_keyboard_modes[i] == mode)
> > +                     break;
> > +     }
> > +
> > +     if (i >= max_mode)
> > +             i = 0;
> > +     else
> > +             i++;
> > +
> > +     return adaptive_keyboard_modes[i];
> > +}
> > +
> > +static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int
> scancode)
> > +{
> > +     u32 current_mode = 0;
> > +     int new_mode = 0;
> > +
> > +     switch (scancode) {
> > +     case DFR_CHANGE_ROW:
> > +             if (adaptive_keyboard_mode_is_saved) {
> > +                     new_mode = adaptive_keyboard_prev_mode;
> > +                     adaptive_keyboard_mode_is_saved = false;
> > +             } else {
> > +                     if (!acpi_evalf(
> > +                                     hkey_handle, &current_mode,
> > +                                     "GTRW", "dd", 0)) {
> > +                             pr_err("Cannot read adaptive keyboard
> mode\n");
> > +                             return false;
> > +                     } else {
> > +                             new_mode = adaptive_keyboard_get_next_mode(
> > +                                             current_mode);
> > +                     }
> > +             }
> > +
> > +             if (!acpi_evalf(hkey_handle, NULL, "STRW", "vd",
> new_mode)) {
> > +                     pr_err("Cannot set adaptive keyboard mode\n");
> > +                     return false;
> > +             }
> > +
> > +             return true;
> > +
> > +     case DFR_SHOW_QUICKVIEW_ROW:
> > +             if (!acpi_evalf(hkey_handle,
> > +                             &adaptive_keyboard_prev_mode,
> > +                             "GTRW", "dd", 0)) {
> > +                     pr_err("Cannot read adaptive keyboard mode\n");
> > +                     return false;
> > +             } else {
> > +                     adaptive_keyboard_mode_is_saved = true;
> > +
> > +                     if (!acpi_evalf(hkey_handle,
> > +                                     NULL, "STRW", "vd",
> FUNCTION_MODE)) {
> > +                             pr_err("Cannot set adaptive keyboard
> mode\n");
> > +                             return false;
> > +                     }
> > +             }
> > +             return true;
> > +
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> >  static bool hotkey_notify_hotkey(const u32 hkey,
> >                                bool *send_acpi_ev,
> >                                bool *ignore_acpi_ev)
> > @@ -3456,6 +3556,8 @@ static bool hotkey_notify_hotkey(const u32 hkey,
> >                       *ignore_acpi_ev = true;
> >               }
> >               return true;
> > +     } else {
> > +             return adaptive_keyboard_hotkey_notify_hotkey(scancode);
> >       }
> >       return false;
> >  }
> > --
> > 1.9.0
> >
>

--001a1133eb38cf45a004f3d459db
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK. I will modify them in V4. :)</div><div class=3D"gmail_=
extra"><br><br><div class=3D"gmail_quote">On Tue, Mar 4, 2014 at 9:51 PM, T=
obias Klauser <span dir=3D"ltr">&lt;<a href=3D"mailto:tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org" =
target=3D"_blank">tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On 2014-03-04 at 12:13:54 +0=
100, Shuduo Sang &lt;<a href=3D"mailto:shuduo.sang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org">shuduo.sa=
ng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org</a>&gt; wrote:<br>


&gt;<br>
&gt; Submit patch V3 to support Adaptive Keyboard on Thinkpad X1 Carbon 2nd=
<br>
&gt; generation according to Tobias&#39;s comments.<br>
<br>
</div>It seems like I missed one in the previous comment, sorry. Also one<b=
r>
of the previous comments was only partially addressed in this updated<br>
patch. See below for the comments...<br>
<div><div class=3D"h5"><br>
&gt; Thanks,<br>
&gt; Shuduo<br>
&gt;<br>
&gt; From 2b8175e69deee661d97d371b2422a9c192fefd52 Mon Sep 17 00:00:00 2001=
<br>
&gt; From: Shuduo Sang &lt;<a href=3D"mailto:sangshuduo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">sangshud=
uo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; Date: Mon, 3 Mar 2014 14:29:32 +0800<br>
&gt; Subject: [PATCH] support thinkpad X1 Carbon&#39;s adaptive keyboard<br=
>
&gt;<br>
&gt; Thinkpad X1 Carbon&#39;s adaptive keyboard has five modes including Ho=
me<br>
&gt; mode, Web browser mode, Web conference mode, Function mode and Lay-fla=
t<br>
&gt; mode. We support Home mode and Function mode currently.<br>
&gt;<br>
&gt; Signed-off-by: Bruce Ma &lt;<a href=3D"mailto:bruce.ma-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org">=
bruce.ma-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org</a>&gt;<br>
&gt; Signed-off-by: Shuduo Sang &lt;<a href=3D"mailto:shuduo.sang@canonical=
.com">shuduo.sang-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/platform/x86/thinkpad_acpi.c | 102<br>
&gt; +++++++++++++++++++++++++++++++++++<br>
&gt; =A01 file changed, 102 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/platform/x86/thinkpad_acpi.c<br>
&gt; b/drivers/platform/x86/thinkpad_acpi.c<br>
&gt; index defb6af..6664dcd 100644<br>
&gt; --- a/drivers/platform/x86/thinkpad_acpi.c<br>
&gt; +++ b/drivers/platform/x86/thinkpad_acpi.c<br>
&gt; @@ -3437,6 +3437,106 @@ err_exit:<br>
&gt; =A0 =A0 =A0 return (res &lt; 0)? res : 1;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +/* Thinkpad X1 Carbon support 5 modes including Home mode, Web browse=
r<br>
&gt; + * mode, Web conference mode, Function mode and Lay-flat mode.<br>
&gt; + * We support Home mode and Function mode currently.<br>
&gt; + *<br>
&gt; + * Will consider support rest of modes in future.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +enum ADAPTIVE_KEY_MODE {<br>
&gt; + =A0 =A0 HOME_MODE,<br>
&gt; + =A0 =A0 WEB_BROWSER_MODE,<br>
&gt; + =A0 =A0 WEB_CONFERENCE_MODE,<br>
&gt; + =A0 =A0 FUNCTION_MODE,<br>
&gt; + =A0 =A0 LAYFLAT_MODE<br>
&gt; +};<br>
&gt; +<br>
&gt; +int adaptive_keyboard_modes[] =3D {<br>
&gt; + =A0 =A0 HOME_MODE,<br>
&gt; +/* =A0 WEB_BROWSER_MODE =3D 2,<br>
&gt; + =A0 =A0 WEB_CONFERENCE_MODE =3D 3, */<br>
&gt; + =A0 =A0 FUNCTION_MODE<br>
&gt; +};<br>
<br>
</div></div>This array can be made be static const.<br>
<div class=3D""><br>
&gt; +<br>
&gt; +#define DFR_CHANGE_ROW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x=
101<br>
&gt; +#define DFR_SHOW_QUICKVIEW_ROW =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x102<br>
&gt; +<br>
&gt; +/* press Fn key a while second, it will switch to Function Mode. Then=
<br>
&gt; + * release Fn key, previous mode be restored.<br>
&gt; + */<br>
&gt; +static bool adaptive_keyboard_mode_is_saved;<br>
&gt; +static int adaptive_keyboard_prev_mode;<br>
&gt; +<br>
&gt; +static int adaptive_keyboard_get_next_mode(int mode)<br>
&gt; +{<br>
&gt; + =A0 =A0 int i;<br>
<br>
</div>This should be size_t as well, as mentioned in the previous comment.<=
br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; + =A0 =A0 size_t max_mode =3D ARRAY_SIZE(adaptive_keyboard_modes) - 1;=
<br>
&gt; +<br>
&gt; + =A0 =A0 for (i =3D 0; i &lt;=3D max_mode; i++) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (adaptive_keyboard_modes[i] =3D=3D mode)<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 if (i &gt;=3D max_mode)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;<br>
&gt; + =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 i++;<br>
&gt; +<br>
&gt; + =A0 =A0 return adaptive_keyboard_modes[i];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool adaptive_keyboard_hotkey_notify_hotkey(unsigned int scanc=
ode)<br>
&gt; +{<br>
&gt; + =A0 =A0 u32 current_mode =3D 0;<br>
&gt; + =A0 =A0 int new_mode =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 switch (scancode) {<br>
&gt; + =A0 =A0 case DFR_CHANGE_ROW:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (adaptive_keyboard_mode_is_saved) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_mode =3D adaptive_keyboa=
rd_prev_mode;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adaptive_keyboard_mode_is_sa=
ved =3D false;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!acpi_evalf(<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 hkey_handle, &amp;current_mode,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &quot;GTRW&quot;, &quot;dd&quot;, 0)) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot=
;Cannot read adaptive keyboard mode\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false=
;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_mode =3D=
 adaptive_keyboard_get_next_mode(<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 current_mode);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (!acpi_evalf(hkey_handle, NULL, &quot;STR=
W&quot;, &quot;vd&quot;, new_mode)) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;Cannot set adap=
tive keyboard mode\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return true;<br>
&gt; +<br>
&gt; + =A0 =A0 case DFR_SHOW_QUICKVIEW_ROW:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (!acpi_evalf(hkey_handle,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;adaptiv=
e_keyboard_prev_mode,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;GTRW&q=
uot;, &quot;dd&quot;, 0)) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;Cannot read ada=
ptive keyboard mode\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adaptive_keyboard_mode_is_sa=
ved =3D true;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!acpi_evalf(hkey_handle,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 NULL, &quot;STRW&quot;, &quot;vd&quot;, FUNCTION_MODE)) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot=
;Cannot set adaptive keyboard mode\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false=
;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return true;<br>
&gt; +<br>
&gt; + =A0 =A0 default:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return false;<br>
&gt; + =A0 =A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static bool hotkey_notify_hotkey(const u32 hkey,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool *s=
end_acpi_ev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool *i=
gnore_acpi_ev)<br>
&gt; @@ -3456,6 +3556,8 @@ static bool hotkey_notify_hotkey(const u32 hkey,=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ignore_acpi_ev =3D true;<=
br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;<br>
&gt; + =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return adaptive_keyboard_hotkey_notify_hotke=
y(scancode);<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 return false;<br>
&gt; =A0}<br>
&gt; --<br>
&gt; 1.9.0<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--001a1133eb38cf45a004f3d459db--


--===============8964964807534364731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
--===============8964964807534364731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ibm-acpi-devel mailing list
ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel

--===============8964964807534364731==--
