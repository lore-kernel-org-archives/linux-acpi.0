From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 21:42:22 +0000
Message-ID: <1103233342.5984.90.camel@tyrosine>
References: <41BFC3AD.5030001@gmx.net>
	 <200412162157.02741.stefandoesinger@gmx.at>
	 <1103231402.5984.84.camel@tyrosine>
	 <200412162226.43166.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412162226.43166.stefandoesinger-RbZlAiThDcE@public.gmane.org>
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

On Thu, 2004-12-16 at 22:26 +0100, Stefan D=C3=B6singer wrote:

> This is partially true for my system. The instruction at c000:0003 is a J=
MP.=20
> But the code seems to remain in the area around 0xc0000. A jump somewhere=
=20
> else is a good explanation for the crashes on some machines.
>=20
> Is this code used by the system bios to boot the VGA card when powering o=
n the=20
> machine?

Yup. However, bear in mind that a typical laptop BIOS is about 512K.
There's a lot of code that's used during boot, but then unmapped again
because it shouldn't be needed by any user application. Depending on
your machine, this may include stuff that's used for video POSTing.

> > POSTing will help in some cases (it seems to work well on Thinkpads),
> > but it's not a universal cure. I've had more joy with saving and
> > restoring the VBE state.
> Is this the vbestate utility? I'll have a look at it. What does=20
> vm86_video_post do? It looks like another lrmi based "call c000:0003=20
> utility". Can only saving and restoring the VBE state bring the card back=
 to=20
> live or do I need to call the reset routine in any case?

vm86_video_post is just an lrmi-based POST tool, yeah - I hacked it
together after speaking to some of the X.org people and discovering that
they don't have too much faith in the correctness of the x86emu code.
One advantage it does have over most of the POST tools is that it puts
the device it's initialising in ax, which seems to make a difference in
some hardware. On the Dell X300, just calling the POST code results in
nasty screen effects. Having the PCI ID in ax seems to avoid this.

I'm not sure whether saving and restoring VBE state is sufficient. It
seems quite effective in combination with POSTing.
--=20
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
