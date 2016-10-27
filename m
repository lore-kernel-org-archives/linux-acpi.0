From: Rick Kerkhof <rick.2889-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Acer Aspire V7-582PG (Haswell,
 GTX 750M) fails to power off GPU via Power Resources
Date: Thu, 27 Oct 2016 10:34:11 +0000
Message-ID: <CANni8hc_nFTHaQS-mLFg2kvTOYQ5fB7C3xLFRh+9F03nrVyM2A@mail.gmail.com>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al> <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com>
 <CANni8hfSnT46pH8EnA1f00SWXUrJ=8PHRjydricGbH4AS4mR7A@mail.gmail.com>
 <20161027101204.GB1476@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1483520902=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161027101204.GB1476-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
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

--===============1483520902==
Content-Type: multipart/alternative; boundary=047d7bfcfd10e3f4d9053fd64848

--047d7bfcfd10e3f4d9053fd64848
Content-Type: text/plain; charset=UTF-8

Op do 27 okt. 2016 om 12:12 schreef Mika Westerberg <
mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:

> On Thu, Oct 27, 2016 at 10:07:45AM +0000, Rick Kerkhof wrote:
> >    Thank you for the patch, I have applied it to the kernel sources but
> >    I'm not sure how to proceed from now on. Should I compile the whole
> >    kernel or can I just build an out-of-tree acpi module?
>
> You need to build the whole kernel, install and reboot.
>

Thanks, it's compiling now, I'll take it for a test drive once it is done
and installed and provide you with a dmesg log.

--047d7bfcfd10e3f4d9053fd64848
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">Op do 27 okt. =
2016 om 12:12 schreef Mika Westerberg &lt;<a href=3D"mailto:mika.westerberg=
@linux.intel.com">mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt;:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">On Thu, Oct 27, 2016 at 10:07:45AM +0000, Rick Kerk=
hof wrote:<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 Thank you for the patch, I have applied it to the kernel =
sources but<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 I&#39;m not sure how to proceed from now on. Should I com=
pile the whole<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 kernel or can I just build an out-of-tree acpi module?<br=
 class=3D"gmail_msg">
<br class=3D"gmail_msg">
You need to build the whole kernel, install and reboot.<br class=3D"gmail_m=
sg"></blockquote><div><br></div><div>Thanks, it&#39;s compiling now, I&#39;=
ll take it for a test drive once it is done and installed and provide you w=
ith a dmesg log.</div></div></div>

--047d7bfcfd10e3f4d9053fd64848--

--===============1483520902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============1483520902==--
