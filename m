From: =?gb18030?q?Ois=A8=AAn_Mac_Fheara=A8=AA?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: Re: generic ACPI video and hotkey drivers vs. platform-specific drivers
Date: Fri, 11 Mar 2005 04:07:50 +0000
Message-ID: <200503110407.50728.destynova@esatclear.ie>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net> <1109884125.2102.781.camel@d845pe> <20050306104506.GM3485@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050306104506.GM3485-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 06 March 2005 10:45, Pavel Machek wrote:
> Hi!
>
> > We need to think through the suggestion that hot keys
> > should appear to Linux like other keyboard keys -- and
> > wind their way throught the input layer.  I think the important
> > thing will be what the user or administrator has to do in
> > order to map which keys to which functions; and if this
> > can work automatically without a call to 1-800-distro.
> > Hopefully we can leverage the stuff people use for keyboard
> > special keys already.
>
> There's utility for X called "hotkeys"; it has hw-specific config files=
,
> but on linux it should be possible to have one generic config file. X a=
re
> usefull for displaying overlays telling you current volume setting, etc=
.
> 				Pavel

I don't think so - I use hotkeys and I had to mess around with get/setkey=
codes=20
etc and basically mess around for quite a while with some Acer keyboard=20
config file as a template (I'm using an Aspire 1705SMi, which has nothing=
 in=20
common with the acerwl keyboard...).

I could only get the kernel to recognize and let me assign one of the key=
s=20
(the fast forward button, annoyingly, under my wrists as I type), which p=
uts=20
the machine into S3 sleep.

So... it's a handy utility, but I can't see a "generic" solution (from my=
=20
uneducated accidental wrist-putting-machine-to-sleep hassle point of view=
).

Ois=A8=AAn


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
