From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Thu, 11 Jan 2007 16:37:16 +0300
Message-ID: <E3C0BCA40296C347AF7142161DB9FC8298EEEA@mssmsx411>
References: <beb91d720701091918g83a0677y33778c17d4b9c82d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:44608 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030437AbXAKNhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jan 2007 08:37:42 -0500
Content-class: urn:content-classes:message
In-Reply-To: <beb91d720701091918g83a0677y33778c17d4b9c82d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Salatiel Filho <salatiel.filho@gmail.com>, Matthew Brett <matthew.brett@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,

Could you send acpidump command output?


Regards.
Konstantin.
>-----Original Message-----
>From: Salatiel Filho [mailto:salatiel.filho@gmail.com]
>Sent: Wednesday, January 10, 2007 6:19 AM
>To: Karasyov, Konstantin A
>Cc: Matthew Brett; linux-acpi@vger.kernel.org
>Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2=
=2E6.18
>and later
>
>On 1/9/07, Karasyov, Konstantin A <konstantin.a.karasyov@intel.com> wr=
ote:
>> Hi Matthew,
>>
>> Could you please perform the following testing:
>
>
>
>Well , i tried to perform this steps in my machine since i think my
>fans are not working in linux. Well , for my surprise , i have
>absolutely nothing in
>
># ls -lh  /proc/acpi/fan/
>total 0
>
>
>
>>
>> 1. boot, make sure the fan doesn't spin.
>>
>> 2. do 'cat /proc/acpi/thermal/*/*', check the following:
>>         - the 'state' field shows 'active[<smthng>]'
>>         (if not - perform some CPU-intensive task);
>>         - fan still doesn't spin,
>
>#cat /proc/acpi/thermal/*/*
>cat: /proc/acpi/thermal/*/*: No such file or directory
>
>#cat /proc/acpi/thermal_zone/*/*
><setting not supported>
>cooling mode:   critical
><polling disabled>
>state:                   ok
>temperature:             60 C
>critical (S5):           99 C
><setting not supported>
>cooling mode:   critical
><polling disabled>
>state:                   ok
>temperature:             27 C
>critical (S5):           105 C
>
>
>
>
>>
>> 3. do 'cat /proc/acpi/fan/*/state', check the following:
>>         - the 'status' field shows 'on' (at least one of them);
>>         - fan still doesn't spin,
>>
>
># cat /proc/acpi/fan/*/state
>cat: /proc/acpi/fan/*/state: No such file or directory
>
>
>
>
>> 4a. do consequently (as root) the following:
>>         - 'echo 3 > /proc/acpi/fan/*/state'
>>         - 'echo 0 > /proc/acpi/fan/*/state'
>>         (the fan should be that one, which shown 'on' in step 3)
>>
>> 4b. (if step 3 failed) do (as root) 'echo 0 > /proc/acpi/fan/*/state=
'
>> consequently for each fan device under /proc/acpi/fan/, check the
>> following:
>>         - fans start spinning;
>>         - fans' states are correct ('cat /proc/acpi/fan/*/state'
>> command)
>>
>> 5. check if the fan(s) start spinning.
>>
>> Please, get back to me with the results, test flow description and
>> commands' outputs.
>>
>> Also, you could try the patches from bugs ##7122, 7570 for 2.6.20-rc=
3 to
>> see if it help.
>>
>
>any ideas why i have no /proc/acpi/fan/*?
>
>Notebook HP Pavillion dv8230us
>
>--
>[]'s
>Salatiel
>
>"O maior prazer do inteligente =E9 bancar o  idiota
>   diante de um  idiota que banca o inteligente".
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
