From: "Salatiel Filho" <salatiel.filho@gmail.com>
Subject: Re: acpi_serialize lock kernel 2.6.21-rc3
Date: Sun, 11 Mar 2007 18:02:26 -0300
Message-ID: <beb91d720703111402g5d8a2010q4f57e33c22cac675@mail.gmail.com>
References: <beb91d720703101142q7e82cf8dt392eb932d12b1813@mail.gmail.com>
	 <200703102226.02991.lenb@kernel.org>
	 <beb91d720703110801q71199cd2iee7f655541137d13@mail.gmail.com>
	 <200703111536.21753.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:25352 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbXCKVC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Mar 2007 17:02:28 -0400
Received: by an-out-0708.google.com with SMTP id b33so1250703ana
        for <linux-acpi@vger.kernel.org>; Sun, 11 Mar 2007 14:02:27 -0700 (PDT)
In-Reply-To: <200703111536.21753.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On 3/11/07, Len Brown <lenb@kernel.org> wrote:
> On Sunday 11 March 2007 11:01, you wrote:
> > Sometime ago i ask in this same list how to fix problems like :
> >
> > Jan  6 00:43:49 localhost kernel: ACPI Error (psargs-0355): [PBST]
> > Namespace lookup failure, AE_NOT_FOUND
> > Jan  6 00:43:49 localhost kernel: ACPI Error (psparse-0537): Method
> > parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c1910770),
> > AE_NOT_FOUND
> > Jan  6 00:43:49 localhost kernel: ACPI Exception (acpi_battery-0207=
):
> > AE_NOT_FOUND, Evaluating _BST [20060707]
> > Jan  6 00:44:19 localhost kernel: ACPI Error (psargs-0355): [PBST]
> > Namespace lookup failure, AE_NOT_FOUND
> > Jan  6 00:44:19 localhost kernel: ACPI Error (psparse-0537): Method
> > parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c1910770),
> > AE_NOT_FOUND
> > Jan  6 00:44:19 localhost kernel: ACPI Exception (acpi_battery-0207=
):
> > AE_NOT_FOUND, Evaluating _BST [20060707]
> > Jan  6 00:44:49 localhost kernel: ACPI Error (psargs-0355): [PBST]
> > Namespace lookup failure, AE_NOT_FOUND
> > Jan  6 00:44:49 localhost kernel: ACPI Error (psparse-0537): Method
> > parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node c1910770),
> > AE_NOT_FOUND
> > Jan  6 00:44:49 localhost kernel: ACPI Exception (acpi_battery-0207=
):
> > AE_NOT_FOUND, Evaluating _BST [20060707]
> >
> >
> > and someone recommend me to use acpi_serialize flag and that fixed =
all
> > problems. Do you have another suggestion ?
>
> That isn't a "fix", that is a "workaround".
> Please open a bugzilla with the error messages and the output
> from acpidump so we can get to the root cause of the issue
> and fix it for everybody.
>
> thanks,
> -Len
Hi , i found the same bug already opened in bugzilla, so i put my
acpidump output there.
HERE -> http://bugzilla.kernel.org/show_bug.cgi?id=3D8171
I hope it helps.

>
> >
> >
> > On 3/11/07, Len Brown <lenb@kernel.org> wrote:
> > > On Saturday 10 March 2007 14:42, Salatiel Filho wrote:
> > > > Is anyone having problems with acpi_serialize in kernel 2.6.21-=
rc3 ?
> > > > Kernel locks during boot when i use acpi_serialize, and i need =
it to
> > > > acpi function properly on my laptop. It worked fine in 2.6.20.
> > > >
> > > > Any help ?
> > >
> > > Why were you using acpi_serialize in the first place.
> > > There is a serious bug if you need it -- which is obscured
> > > by the fact that you're using it...
> > >
> > > -Len
> > >
> > >
> >
> >
>


--=20
[]'s
Salatiel

"O maior prazer do inteligente =E9 bancar o  idiota
   diante de um  idiota que banca o inteligente".
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
