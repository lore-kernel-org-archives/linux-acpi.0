From: Rick Kerkhof <rick.2889-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Acer Aspire V7-582PG (Haswell,
 GTX 750M) fails to power off GPU via Power Resources
Date: Thu, 27 Oct 2016 09:42:28 +0000
Message-ID: <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al> <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1716136472=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161027093011.GZ1476-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
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

--===============1716136472==
Content-Type: multipart/alternative; boundary=089e01161dd0f1b577053fd58f14

--089e01161dd0f1b577053fd58f14
Content-Type: text/plain; charset=UTF-8

No, there are not. Here is the recursive directory listing:
http://sprunge.us/FIRE

Op do 27 okt. 2016 11:30 schreef Mika Westerberg <
mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:

> On Thu, Oct 27, 2016 at 09:15:19AM +0000, Rick Kerkhof wrote:
> >    I can confirm what Peter said, path contains \_SB_.PCI0.RP05 and
> >    power_state contains D3hot.
>
> And there are no power_resources_Dx directories under
> /sys/bus/pci/devices/0000:00:1c.4/firmware_node?
>

--089e01161dd0f1b577053fd58f14
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">No, there are not. Here is the recursive directory listing: =
<a href=3D"http://sprunge.us/FIRE">http://sprunge.us/FIRE</a></p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">Op do 27 okt. 2016 11:30 sc=
hreef Mika Westerberg &lt;<a href=3D"mailto:mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org=
">mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt;:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On Thu, Oct 27, 2016 at 09:15:19AM +0000, Rick Kerkhof wrote:<br cl=
ass=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 I can confirm what Peter said, path contains \_SB_.PCI0.R=
P05 and<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 power_state contains D3hot.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
And there are no power_resources_Dx directories under<br class=3D"gmail_msg=
">
/sys/bus/pci/devices/0000:00:1c.4/firmware_node?<br class=3D"gmail_msg">
</blockquote></div>

--089e01161dd0f1b577053fd58f14--

--===============1716136472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============1716136472==--
