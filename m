From: "Salatiel Filho" <salatiel.filho@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Thu, 11 Jan 2007 11:37:05 -0300
Message-ID: <beb91d720701110637p3828878bpcd94e2d6fd036164@mail.gmail.com>
References: <beb91d720701110549r346991beh95547e912f68d98f@mail.gmail.com>
	 <E3C0BCA40296C347AF7142161DB9FC8298EF3A@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:45828 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965358AbXAKOhH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jan 2007 09:37:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so485363uga
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2007 06:37:06 -0800 (PST)
In-Reply-To: <E3C0BCA40296C347AF7142161DB9FC8298EF3A@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Cc: linux-acpi@vger.kernel.org

On 1/11/07, Karasyov, Konstantin A <konstantin.a.karasyov@intel.com> wr=
ote:
> Hi,
>
> Unfortunately, thermal zones defined in your DSDT doesn't contain any=
 trip points except critical, but the fan control requires at least one=
 active trip point (_ACx) to be defined.
> Also, there are no fan devices (i.e. device with 'PNP0C0B' HID) defin=
ed.
>
> This means, that no fan and minimal thermal control is available on y=
our system through the ACPI functionality.

So who controls fan on and off when i am on linux ?

>
>
> Regards.
> Konstantin.
>
> >-----Original Message-----
> >From: Salatiel Filho [mailto:salatiel.filho@gmail.com]
> >Sent: Thursday, January 11, 2007 4:50 PM
> >To: Karasyov, Konstantin A
> >Cc: Matthew Brett; linux-acpi@vger.kernel.org
> >Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel=
 2.6.18
> >and later
> >
> >On 1/11/07, Karasyov, Konstantin A <konstantin.a.karasyov@intel.com>=
 wrote:
> >> Hi,
> >>
> >> Could you send acpidump command output?
> >>
> >sure. Attached
> >>
> >> Regards.
> >> Konstantin.
> >> >-----Original Message-----
> >> >From: Salatiel Filho [mailto:salatiel.filho@gmail.com]
> >> >Sent: Wednesday, January 10, 2007 6:19 AM
> >> >To: Karasyov, Konstantin A
> >> >Cc: Matthew Brett; linux-acpi@vger.kernel.org
> >> >Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in ker=
nel
> >2.6.18
> >> >and later
> >> >
> >> >On 1/9/07, Karasyov, Konstantin A <konstantin.a.karasyov@intel.co=
m>
> >wrote:
> >> >> Hi Matthew,
> >> >>
> >> >> Could you please perform the following testing:
> >> >
> >> >
> >> >
> >> >Well , i tried to perform this steps in my machine since i think =
my
> >> >fans are not working in linux. Well , for my surprise , i have
> >> >absolutely nothing in
> >> >
> >> ># ls -lh  /proc/acpi/fan/
> >> >total 0
> >> >
> >> >
> >> >
> >> >>
> >> >> 1. boot, make sure the fan doesn't spin.
> >> >>
> >> >> 2. do 'cat /proc/acpi/thermal/*/*', check the following:
> >> >>         - the 'state' field shows 'active[<smthng>]'
> >> >>         (if not - perform some CPU-intensive task);
> >> >>         - fan still doesn't spin,
> >> >
> >> >#cat /proc/acpi/thermal/*/*
> >> >cat: /proc/acpi/thermal/*/*: No such file or directory
> >> >
> >> >#cat /proc/acpi/thermal_zone/*/*
> >> ><setting not supported>
> >> >cooling mode:   critical
> >> ><polling disabled>
> >> >state:                   ok
> >> >temperature:             60 C
> >> >critical (S5):           99 C
> >> ><setting not supported>
> >> >cooling mode:   critical
> >> ><polling disabled>
> >> >state:                   ok
> >> >temperature:             27 C
> >> >critical (S5):           105 C
> >> >
> >> >
> >> >
> >> >
> >> >>
> >> >> 3. do 'cat /proc/acpi/fan/*/state', check the following:
> >> >>         - the 'status' field shows 'on' (at least one of them);
> >> >>         - fan still doesn't spin,
> >> >>
> >> >
> >> ># cat /proc/acpi/fan/*/state
> >> >cat: /proc/acpi/fan/*/state: No such file or directory
> >> >
> >> >
> >> >
> >> >
> >> >> 4a. do consequently (as root) the following:
> >> >>         - 'echo 3 > /proc/acpi/fan/*/state'
> >> >>         - 'echo 0 > /proc/acpi/fan/*/state'
> >> >>         (the fan should be that one, which shown 'on' in step 3=
)
> >> >>
> >> >> 4b. (if step 3 failed) do (as root) 'echo 0 > /proc/acpi/fan/*/=
state'
> >> >> consequently for each fan device under /proc/acpi/fan/, check t=
he
> >> >> following:
> >> >>         - fans start spinning;
> >> >>         - fans' states are correct ('cat /proc/acpi/fan/*/state=
'
> >> >> command)
> >> >>
> >> >> 5. check if the fan(s) start spinning.
> >> >>
> >> >> Please, get back to me with the results, test flow description =
and
> >> >> commands' outputs.
> >> >>
> >> >> Also, you could try the patches from bugs ##7122, 7570 for 2.6.=
20-rc3
> >to
> >> >> see if it help.
> >> >>
> >> >
> >> >any ideas why i have no /proc/acpi/fan/*?
> >> >
> >> >Notebook HP Pavillion dv8230us
> >> >
> >> >--
> >> >[]'s
> >> >Salatiel
> >> >
> >> >"O maior prazer do inteligente =E9 bancar o  idiota
> >> >   diante de um  idiota que banca o inteligente".
> >>
> >
> >
> >--
> >[]'s
> >Salatiel
> >
> >"O maior prazer do inteligente =E9 bancar o  idiota
> >   diante de um  idiota que banca o inteligente".
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
