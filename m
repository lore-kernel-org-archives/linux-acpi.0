From: Rick Kerkhof <rick.2889-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Acer Aspire V7-582PG (Haswell,
 GTX 750M) fails to power off GPU via Power Resources
Date: Thu, 27 Oct 2016 09:15:19 +0000
Message-ID: <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al> <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1969162568=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161027090604.GB27017@al>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--===============1969162568==
Content-Type: multipart/alternative; boundary=94eb2c0715e2d6571c053fd52e84

--94eb2c0715e2d6571c053fd52e84
Content-Type: text/plain; charset=UTF-8

I can confirm what Peter said, path contains \_SB_.PCI0.RP05 and
power_state contains D3hot.

Op do 27 okt. 2016 11:06 schreef Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>:

> On Thu, Oct 27, 2016 at 11:17:48AM +0300, Mika Westerberg wrote:
> > On Thu, Oct 27, 2016 at 12:56:41AM +0200, Peter Wu wrote:
> > > Hi PCI/ACPI PM experts,
> > >
> > > Since Linux 4.8, nouveau switched to rely on the PCIe port driver to
> > > transition to D3cold. This however does not happen for an Acer Aspire
> > > V7-582PG (Haswell, NVIDIA GTX 750M) from Rick.
> > >
> > > Any idea why? acpidump, lspci, dmesg and other details can be found in
> > > the linked bug below.
> >
> > >
> > > Kind regards,
> > > Peter
> > >
> > > On Wed, Oct 26, 2016 at 10:42:07PM +0000,
> bugzilla-daemon-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org wrote:
> > > > https://bugs.freedesktop.org/show_bug.cgi?id=98398
> > > >
> > > > --- Comment #11 from Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org> ---
> > > > So 4.7 and before used the "DSM" method on runtime-suspend:
> > > > - \_SB.PCI0.RP05.PEGP._DSM would be invoked to enable Optimus
> > > > - \_SB.PCI0.RP05.PEGP._PS3 is then invoked which would enter D3cold
> > > > (note, this method is still used in 4.8 on older laptops or with the
> > > > pcie_pm_port=off kernel option)
> > > >
> > > > Since 4.8, _DSM is not called anymore by nouveau (when support from
> the PCI
> > > > core is detected) and this sequence should instead happen:
> > > > - \_SB.PCI0.RP05.PEGP._PS3 (does nothing besides updating _STA)
> > > > - PCIe core removes power for the PCIe port since all its children
> are in
> > > >   D3 and are willing to transition to D3cold. It does so by invoking
> > > >   \NVP3._OFF (where \NVP3 is the power resource from
> \_SB.PCI0.RP05._PR3)
> > > >
> > > > That is how I think it should work in theory, but on Ricks laptop
> running
> > > > 4.8.4,
> > > > /sys/bus/devices/0000:1c.4/firmware_node/ does not have
> power_resources_D0
> > > > devices (which I do have on my own laptop for 0000:01:0).
> > > >
> > > > The SSDT1 of Rick's Acer laptop shows this structure:
> > > >
> > > >     If (\_OSI ("Windows 2013"))
> > > >     {
> > > >         Scope (\_SB.PCI0.RP05)
> > > >         {
> > > >         //...
> > > >             Name (_PR0, Package (0x01)  // _PR0: Power Resources for
> D0
> > > >             {
> > > >                 NVP3
> > > >             })
> > > >             Name (_PR2, Package (0x01)  // _PR2: Power Resources for
> D2
> > > >             {
> > > >                 NVP2
> > > >             })
> > > >             Name (_PR3, Package (0x01)  // _PR3: Power Resources for
> D3hot
> > > >             {
> > > >                 NVP3
> > > >             })
> > > >             // ...
> > > >             Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
> > > >             {
> > > >             }
> > > >
> > > >             Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
> > > >             {
> > > >             }
> > > >         }
> > > >
> > > >         Name (MSD3, Zero)
> > > >         PowerResource (NVP3, 0x00, 0x0000)
> > > >         {
> > > >             Name (_STA, One)  // _STA: Status
> > > >             // ...
> > > >
> > > >             Method (_ON, 0, NotSerialized)  // _ON_: Power On
> > > >             {
> > > >                 // ...
> > > >             }
> > > >
> > > >             Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
> > > >             {
> > > >                 // ...
> > > >             }
> > > >         }
> > > >
> > > > The dmesg does show "ACPI: Power Resource [NVP3] (on)", so I guess
> that the
> > > > methods are found. It is a mystery to me why the
> "power_resources_Dx" files are
> > > > not created, possibly breaking PM.
> >
> > The ASL code looks right to me (except for the NVP2 which never set _STA
> > to 0 but should not affect here).
> >
> > I wonder what does /sys/bus/pci/devices/0000:00:1c.4/firmware_node/path
> contain?
>
> The value is as expected, \_SB.PCI0.RP05:
>
> /sys/bus/pci/devices/0000:00:1c.4/firmware_node/path:\_SB_.PCI0.RP05
> /sys/bus/pci/devices/0000:00:1c.4/firmware_node/power_state:D3hot
> --
> Kind regards,
> Peter Wu
> https://lekensteyn.nl
>

--94eb2c0715e2d6571c053fd52e84
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I can confirm what Peter said, path contains \_SB_.PCI0.RP05=
 and power_state contains D3hot.</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">Op do 27 okt. 2016 11:06 sc=
hreef Peter Wu &lt;<a href=3D"mailto:peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org">peter@lekensteyn.=
nl</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, Oct 27, 2016 at=
 11:17:48AM +0300, Mika Westerberg wrote:<br class=3D"gmail_msg">
&gt; On Thu, Oct 27, 2016 at 12:56:41AM +0200, Peter Wu wrote:<br class=3D"=
gmail_msg">
&gt; &gt; Hi PCI/ACPI PM experts,<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; Since Linux 4.8, nouveau switched to rely on the PCIe port driver=
 to<br class=3D"gmail_msg">
&gt; &gt; transition to D3cold. This however does not happen for an Acer As=
pire<br class=3D"gmail_msg">
&gt; &gt; V7-582PG (Haswell, NVIDIA GTX 750M) from Rick.<br class=3D"gmail_=
msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; Any idea why? acpidump, lspci, dmesg and other details can be fou=
nd in<br class=3D"gmail_msg">
&gt; &gt; the linked bug below.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; Kind regards,<br class=3D"gmail_msg">
&gt; &gt; Peter<br class=3D"gmail_msg">
&gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; On Wed, Oct 26, 2016 at 10:42:07PM +0000, <a href=3D"mailto:bugzi=
lla-daemon-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">bugzilla-=
daemon-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org</a> wrote:<br class=3D"gmail_msg">
&gt; &gt; &gt; <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D98=
398" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://bugs.=
freedesktop.org/show_bug.cgi?id=3D98398</a><br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; --- Comment #11 from Peter Wu &lt;<a href=3D"mailto:peter@le=
kensteyn.nl" class=3D"gmail_msg" target=3D"_blank">peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org</a>&=
gt; ---<br class=3D"gmail_msg">
&gt; &gt; &gt; So 4.7 and before used the &quot;DSM&quot; method on runtime=
-suspend:<br class=3D"gmail_msg">
&gt; &gt; &gt; - \_SB.PCI0.RP05.PEGP._DSM would be invoked to enable Optimu=
s<br class=3D"gmail_msg">
&gt; &gt; &gt; - \_SB.PCI0.RP05.PEGP._PS3 is then invoked which would enter=
 D3cold<br class=3D"gmail_msg">
&gt; &gt; &gt; (note, this method is still used in 4.8 on older laptops or =
with the<br class=3D"gmail_msg">
&gt; &gt; &gt; pcie_pm_port=3Doff kernel option)<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; Since 4.8, _DSM is not called anymore by nouveau (when suppo=
rt from the PCI<br class=3D"gmail_msg">
&gt; &gt; &gt; core is detected) and this sequence should instead happen:<b=
r class=3D"gmail_msg">
&gt; &gt; &gt; - \_SB.PCI0.RP05.PEGP._PS3 (does nothing besides updating _S=
TA)<br class=3D"gmail_msg">
&gt; &gt; &gt; - PCIe core removes power for the PCIe port since all its ch=
ildren are in<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0D3 and are willing to transition to D3cold. It d=
oes so by invoking<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0\NVP3._OFF (where \NVP3 is the power resource fr=
om \_SB.PCI0.RP05._PR3)<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; That is how I think it should work in theory, but on Ricks l=
aptop running<br class=3D"gmail_msg">
&gt; &gt; &gt; 4.8.4,<br class=3D"gmail_msg">
&gt; &gt; &gt; /sys/bus/devices/0000:1c.4/firmware_node/ does not have powe=
r_resources_D0<br class=3D"gmail_msg">
&gt; &gt; &gt; devices (which I do have on my own laptop for 0000:01:0).<br=
 class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; The SSDT1 of Rick&#39;s Acer laptop shows this structure:<br=
 class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0If (\_OSI (&quot;Windows 2013&quot;))<br =
class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0{<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Scope (\_SB.PCI0.RP05)<br c=
lass=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//...<br class=3D"gmail_msg=
">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name (_PR0, P=
ackage (0x01)=C2=A0 // _PR0: Power Resources for D0<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NVP3<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0})<br class=
=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name (_PR2, P=
ackage (0x01)=C2=A0 // _PR2: Power Resources for D2<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NVP2<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0})<br class=
=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name (_PR3, P=
ackage (0x01)=C2=A0 // _PR3: Power Resources for D3hot<br class=3D"gmail_ms=
g">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NVP3<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0})<br class=
=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// ...<br cla=
ss=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Method (_PS0,=
 0, NotSerialized)=C2=A0 // _PS0: Power State 0<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D=
"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Method (_PS3,=
 0, NotSerialized)=C2=A0 // _PS3: Power State 3<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name (MSD3, Zero)<br class=
=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PowerResource (NVP3, 0x00, =
0x0000)<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Name (_STA, O=
ne)=C2=A0 // _STA: Status<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// ...<br cla=
ss=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Method (_ON, =
0, NotSerialized)=C2=A0 // _ON_: Power On<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0// ...<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D=
"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Method (_OFF,=
 0, NotSerialized)=C2=A0 // _OFF: Power Off<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0// ...<br class=3D"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D=
"gmail_msg">
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt; &gt; &gt;<br class=3D"gmail_msg">
&gt; &gt; &gt; The dmesg does show &quot;ACPI: Power Resource [NVP3] (on)&q=
uot;, so I guess that the<br class=3D"gmail_msg">
&gt; &gt; &gt; methods are found. It is a mystery to me why the &quot;power=
_resources_Dx&quot; files are<br class=3D"gmail_msg">
&gt; &gt; &gt; not created, possibly breaking PM.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; The ASL code looks right to me (except for the NVP2 which never set _S=
TA<br class=3D"gmail_msg">
&gt; to 0 but should not affect here).<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; I wonder what does /sys/bus/pci/devices/0000:00:1c.4/firmware_node/pat=
h contain?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
The value is as expected, \_SB.PCI0.RP05:<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
/sys/bus/pci/devices/0000:00:1c.4/firmware_node/path:\_SB_.PCI0.RP05<br cla=
ss=3D"gmail_msg">
/sys/bus/pci/devices/0000:00:1c.4/firmware_node/power_state:D3hot<br class=
=3D"gmail_msg">
--<br class=3D"gmail_msg">
Kind regards,<br class=3D"gmail_msg">
Peter Wu<br class=3D"gmail_msg">
<a href=3D"https://lekensteyn.nl" rel=3D"noreferrer" class=3D"gmail_msg" ta=
rget=3D"_blank">https://lekensteyn.nl</a><br class=3D"gmail_msg">
</blockquote></div>

--94eb2c0715e2d6571c053fd52e84--

--===============1969162568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============1969162568==--
