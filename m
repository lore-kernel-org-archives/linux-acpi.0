From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: ACPI + IO-APIC power off by button problems
Date: 05 Mar 2003 22:54:51 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046904893.1505.23.camel@darkstar.portugal>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E41B@cceexc19.americas.cpqcorp.net>
	<3E6286C3.1050504@tin.it>  <20030303105554.GA12170@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030303105554.GA12170-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Cc: AnonimoVeneziano <voloterreno-nc/lrvXPQ4s@public.gmane.org>, "Cagle, John    (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi=20
In kernel 2.4.20 you have many quirks in ./drivers/pci/quirks.c, which
attempt to assign irq to some problematic hardware, in my case I
discover that I have about 8 different quirks in my laptop, but one off
the are generic or standard, the curious thing is some off then is
related with acpi (look at the code), I try test the kernel without some
of then (this ones related with acpi) and seems work much faster, after
this I try without all, with I almost fuck up my computer, after this I
don't had time to investigate more, the patch that  I found in the
meddle of this is this in attach,
this patch comments 3 functions in patch of acpi kernel, my computer
work in the same way!. 3 functions of more fixup irqs!

I stop upgrade ACPI at Subsystem revision 20021212 with kernel 2.4.20,
which I in can say its very very stable :).

#lspci -tv
-[00]-+-00.0  VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
      +-01.0-[01]----00.0  S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA
Controller (TwisterK)
      +-07.0  VIA Technologies, Inc. VT82C686 [Apollo Super South]
      +-07.1  VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
      +-07.2  VIA Technologies, Inc. USB
      +-07.4  VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
      +-07.5  VIA Technologies, Inc. VT82C686 AC97 Audio Controller
      +-09.0  Conexant HSF 56k HSFi Modem
      +-0a.0  Texas Instruments PCI1410 PC card Cardbus Controller
      \-0b.0  Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
On Mon, 2003-03-03 at 10:55, Faye Pearson wrote:
> AnonimoVeneziano [voloterreno-nc/lrvXPQ4s@public.gmane.org] wrote:
> > My machine at boot says , in a moment , No IRQ known for 00.11.1=20
> > Probably Buggy MP Table,   if I have ACPI disabled. 00.11.1 is the IDE=20
> > COntroller , and I've searched for help for this yet , and in the=20
> > linux-kernel ML they have said me that this "problem" is hidden by the=20
> > fact that the IDE Channels  (ide0, ide1) takes indipendent IRQs  (14, 1=
5=20
> > if I remember well) .
>=20
> I have this on my Sony VAIO.  Alan Cox said that it was the ACPI version
> of a bug he recently squashed in the main kernel.  Basically nothing
> should try to assign interrupts to devices which use Legacy IRQs (ie the
> IDE controller in our case).
>=20
> Hopefully the ACPI guys can work out some way of detecting if the device
> is legacy or not and just ignore it if it is.  They didn't respond to
> Alan Cox's message to acknowledge it.
>=20
> It's a warning though, the IDE controller gets IRQ 14 and 15 anyway and
> all seems to be ok.
>=20
>=20
> Faye
>=20
> --=20
> Faye Pearson,
> Covert Development
> ClaraNET Ltd.       Tel 020 7903 3000
>=20
> "I've seen the forgeries I've sent out."
> -- John F. Haugh II (jfh-xUm3836SnjGloEwRBag+n8J6LWcAlBef@public.gmane.org), about forging net news art=
icles
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgioMB
email: sbasto-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me all.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
