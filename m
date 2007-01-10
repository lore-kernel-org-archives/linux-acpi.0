From: "Salatiel Filho" <salatiel.filho@gmail.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Wed, 10 Jan 2007 00:18:45 -0300
Message-ID: <beb91d720701091918g83a0677y33778c17d4b9c82d@mail.gmail.com>
References: <1e2af89e0612280914n62a192e2kdb7e2677b55d2670@mail.gmail.com>
	 <E3C0BCA40296C347AF7142161DB9FC8293DA20@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:16704 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701AbXAJDSq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jan 2007 22:18:46 -0500
Received: by nf-out-0910.google.com with SMTP id o25so360416nfa
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jan 2007 19:18:45 -0800 (PST)
In-Reply-To: <E3C0BCA40296C347AF7142161DB9FC8293DA20@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Cc: Matthew Brett <matthew.brett@gmail.com>, linux-acpi@vger.kernel.org

On 1/9/07, Karasyov, Konstantin A <konstantin.a.karasyov@intel.com> wro=
te:
> Hi Matthew,
>
> Could you please perform the following testing:



Well , i tried to perform this steps in my machine since i think my
fans are not working in linux. Well , for my surprise , i have
absolutely nothing in

# ls -lh  /proc/acpi/fan/
total 0



>
> 1. boot, make sure the fan doesn't spin.
>
> 2. do 'cat /proc/acpi/thermal/*/*', check the following:
>         - the 'state' field shows 'active[<smthng>]'
>         (if not - perform some CPU-intensive task);
>         - fan still doesn't spin,

#cat /proc/acpi/thermal/*/*
cat: /proc/acpi/thermal/*/*: No such file or directory

#cat /proc/acpi/thermal_zone/*/*
<setting not supported>
cooling mode:   critical
<polling disabled>
state:                   ok
temperature:             60 C
critical (S5):           99 C
<setting not supported>
cooling mode:   critical
<polling disabled>
state:                   ok
temperature:             27 C
critical (S5):           105 C




>
> 3. do 'cat /proc/acpi/fan/*/state', check the following:
>         - the 'status' field shows 'on' (at least one of them);
>         - fan still doesn't spin,
>

# cat /proc/acpi/fan/*/state
cat: /proc/acpi/fan/*/state: No such file or directory




> 4a. do consequently (as root) the following:
>         - 'echo 3 > /proc/acpi/fan/*/state'
>         - 'echo 0 > /proc/acpi/fan/*/state'
>         (the fan should be that one, which shown 'on' in step 3)
>
> 4b. (if step 3 failed) do (as root) 'echo 0 > /proc/acpi/fan/*/state'
> consequently for each fan device under /proc/acpi/fan/, check the
> following:
>         - fans start spinning;
>         - fans' states are correct ('cat /proc/acpi/fan/*/state'
> command)
>
> 5. check if the fan(s) start spinning.
>
> Please, get back to me with the results, test flow description and
> commands' outputs.
>
> Also, you could try the patches from bugs ##7122, 7570 for 2.6.20-rc3=
 to
> see if it help.
>

any ideas why i have no /proc/acpi/fan/*?

Notebook HP Pavillion dv8230us

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
