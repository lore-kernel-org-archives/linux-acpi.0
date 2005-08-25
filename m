From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RE: EC Confusion
Date: Thu, 25 Aug 2005 16:56:23 -0300
Message-ID: <BAY12-F297C1478A6E800210A33F2A8AB0@phx.gbl>
References: <3ACA40606221794F80A5670F0AF15F84041AC1FE@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC1FE@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

sorry for the late reply. I would like to thank for all your help.
I did a grep for "burst-mode-ec-10-Aug" and it was there, but the sleep 
button still didn't work. The dmesg output is the same for both kernel I am 
testing, 2.6.12-rc2-mm2 e 2.6.13-rc6.

kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST] (Node c14d0d28)
kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR] (Node c14d0ba8)
kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST] (Node c14d0d28)
kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR] (Node c14d0ba8)
kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST] (Node c14d0d28)
kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR] (Node c14d0ba8)
kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST] (Node c14d0d28)
kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR] (Node c14d0ba8)
kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__._Q0D] (Node c14d1aa8)

It keeps polling the AC and Battery, and when I hit the sleep button it 
appears the Q0D line. However for kernel 2.6.13-rc6, this line only appears 
after 8 hits in the sleep button.

Thanks,
Paulo

>From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>To: "Thomas Renninger" <trenn-l3A5Bk7waGM@public.gmane.org>
>CC: "Paulo Vitor Magacho da Silva" 
><pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>,<acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>Subject: RE: [ACPI] EC Confusion
>Date: Wed, 17 Aug 2005 21:10:10 +0800
>
>
> >> EC burst mode did solve this problem on that machine.
> >>
> >Seems there is a regression in the EC burst mode code:
> >EC burst mode does not solve the problem for this guy in
> >current kernels any more.
> >
> >I used one of the patches applied to:
> >http://bugzilla.kernel.org/show_bug.cgi?id=3851
> >(Sorry don't know the exact one any more, was about a month or
> >a bit more ago).
> >With that one the buffered key issue was gone.
> >
> >He now retested with current kernels: 2.6.13-rc6-git1-2 and
> >the problem exists again.
> >
> >Maybe Paolo should raise a new bug for that issue if not already done?
> >Please CC me.
>
>Please grep dmesg if you find "burst-mode-ec-10-Aug", then there has
>right patch.
>
> >
> >Thanks,
> >
> >    Thomas
> >
>
>

_________________________________________________________________
Chegou o que faltava: MSN Acesso Grátis. Instale Já! 
http://www.msn.com.br/discador



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
