From: Rick Kerkhof <rick.2889-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Acer Aspire V7-582PG (Haswell,
 GTX 750M) fails to power off GPU via Power Resources
Date: Thu, 27 Oct 2016 10:07:45 +0000
Message-ID: <CANni8hfSnT46pH8EnA1f00SWXUrJ=8PHRjydricGbH4AS4mR7A@mail.gmail.com>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al> <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1517785870=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161027095508.GA1476-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--===============1517785870==
Content-Type: multipart/alternative; boundary=089e012278cc50aaf7053fd5ea21

--089e012278cc50aaf7053fd5ea21
Content-Type: text/plain; charset=UTF-8

Op do 27 okt. 2016 om 11:59 schreef Mika Westerberg <
mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:

> On Thu, Oct 27, 2016 at 09:42:28AM +0000, Rick Kerkhof wrote:
> >    No, there are not. Here is the recursive directory listing:
>
> Are you able to try the following patch and send me dmesg (or attach it
> to that bug)? It should show if the ACPI core even tries to add those
> power resources.
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index fcd4ce6f78d5..af9c3e15dd74 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -444,6 +444,9 @@ void acpi_power_add_remove_device(struct acpi_device
> *adev, bool add)
>         if (!adev->power.flags.power_resources)
>                 return;
>
> +       acpi_handle_info(adev->handle, "Adding power resources for %s\n",
> +                        dev_name(&adev->dev));
> +
>         for (state = ACPI_STATE_D0; state <= ACPI_STATE_D3_HOT; state++)
>                 acpi_power_expose_hide(adev,
>
>  &adev->power.states[state].resources,
>

Thank you for the patch, I have applied it to the kernel sources but I'm
not sure how to proceed from now on. Should I compile the whole kernel or
can I just build an out-of-tree acpi module?

--089e012278cc50aaf7053fd5ea21
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">Op do 27 okt. =
2016 om 11:59 schreef Mika Westerberg &lt;<a href=3D"mailto:mika.westerberg=
@linux.intel.com">mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt;:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">On Thu, Oct 27, 2016 at 09:42:28AM +0000, Rick Kerk=
hof wrote:<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 No, there are not. Here is the recursive directory listin=
g:<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Are you able to try the following patch and send me dmesg (or attach it<br =
class=3D"gmail_msg">
to that bug)? It should show if the ACPI core even tries to add those<br cl=
ass=3D"gmail_msg">
power resources.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c<br class=3D"gmail_=
msg">
index fcd4ce6f78d5..af9c3e15dd74 100644<br class=3D"gmail_msg">
--- a/drivers/acpi/power.c<br class=3D"gmail_msg">
+++ b/drivers/acpi/power.c<br class=3D"gmail_msg">
@@ -444,6 +444,9 @@ void acpi_power_add_remove_device(struct acpi_device *a=
dev, bool add)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!adev-&gt;power.flags.power_resources)<br c=
lass=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br class=3D=
"gmail_msg">
<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_handle_info(adev-&gt;handle, &quot;Adding =
power resources for %s\n&quot;,<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_name(&amp;adev-&gt;dev));<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (state =3D ACPI_STATE_D0; state &lt;=3D ACP=
I_STATE_D3_HOT; state++)<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_power_expose_h=
ide(adev,<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;adev=
-&gt;power.states[state].resources,<br class=3D"gmail_msg"></blockquote><di=
v><br></div><div>Thank you for the patch, I have applied it to the kernel s=
ources but I&#39;m not sure how to proceed from now on. Should I compile th=
e whole kernel or can I just build an out-of-tree acpi module?</div></div><=
/div>

--089e012278cc50aaf7053fd5ea21--

--===============1517785870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============1517785870==--
