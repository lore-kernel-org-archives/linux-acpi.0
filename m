From: Corrado Zoccolo <czoccolo@gmail.com>
Subject: Re: acpi_idle_enter_bm & mwait_idle
Date: Mon, 24 Aug 2009 22:47:35 +0200
Message-ID: <4e5e476b0908241347j3d4918f8o4f4852af0cf7fc41@mail.gmail.com>
References: <200908161452.53264.elfy.ua@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:30416 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZHXUre convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 16:47:34 -0400
Received: by rv-out-0506.google.com with SMTP id f6so793397rvb.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Aug 2009 13:47:36 -0700 (PDT)
In-Reply-To: <200908161452.53264.elfy.ua@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oleksiy Protas <elfy.ua@gmail.com>
Cc: linux-acpi@vger.kernel.org

Those functions are called when there is nothing to do for the processo=
r.
Is it possible that your system is doing disk accesses when the
slowdown happens?

Corrado

On Sun, Aug 16, 2009 at 1:52 PM, Oleksiy Protas<elfy.ua@gmail.com> wrot=
e:
> Hello,
>
> I am sorry for bugging you guys here, but I've got a question and I t=
hink it
> best fits here. I have an Acer laptop, namely TravelMate 5320 with a =
Linux OS
> (uname -a gives: Linux seagull 2.6.30-gentoo-r4 #4 Sat Aug 15 01:29:4=
4 EEST
> 2009 i686 Intel(R) Celeron(R) CPU 550 @ 2.00GHz GenuineIntel GNU/Linu=
x). What
> I'm observing are regular streak of system unreponsiveness. Performan=
ce
> monitors show an activity of =C2=A0high-nice processes during these p=
eriods.
> OProfile gives ~24% time eaten by apci_idle_enter_bm() with ACPI enab=
led and
> 35% time by mwait_idle() with acpi=3Doff, regardless of streak presen=
ce or just
> smooth operating time. My question is how can I debug more indepth to=
 see
> what's happening and what the named functions do so I can or can't bl=
ame them
> for unusable system. Thanks in advance.
> --
> Oleksiy Protas
> National University =C2=ABKyiv-Mohyla Academy=C2=BB
> Institute of Molecular Biology and Genetics, Ukraine
> This message is signed. You can obtain a public key to verify it here=
:
> http://minsky.surfnet.nl:11371/pks/lookup?op=3Dget&search=3D0x81B636D=
4F015B7EC
>



--=20
_______________________________________________________________________=
___

dott. Corrado Zoccolo                          mailto:czoccolo@gmail.co=
m
PhD - Department of Computer Science - University of Pisa, Italy
-----------------------------------------------------------------------=
---
The self-confidence of a warrior is not the self-confidence of the aver=
age
man. The average man seeks certainty in the eyes of the onlooker and ca=
lls
that self-confidence. The warrior seeks impeccability in his own eyes a=
nd
calls that humbleness.
                               Tales of Power - C. Castaneda
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
