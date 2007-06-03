From: Goulven Guillard <lecotegougdelaforce@free.fr>
Subject: Re: Laptop overheating problem
Date: Sun, 03 Jun 2007 03:10:12 +0200
Message-ID: <466214F4.5060008@free.fr>
References: <519554c10706021144p1206ca76u58de14068dddfbbb@mail.gmail.com>	 <519554c10706021145m2f0fdf9co9fb289c28ce312df@mail.gmail.com> <8f8ff01d0706021257n1216a981m81beca6135986fde@mail.gmail.com>
Reply-To: lecotegougdelaforce@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1-g19.free.fr ([212.27.42.27]:60999 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbXFCBLJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 21:11:09 -0400
In-Reply-To: <8f8ff01d0706021257n1216a981m81beca6135986fde@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Tolga Onbay <tolgaonbay@gmail.com>, linux-acpi@vger.kernel.org

Alexey Starikovskiy a =E9crit :
> Please take a look at bugzilla.kernel.org #5534, 2.6.21 or later
> kernels should not have this problem.
>>
>> I installed Ubuntu 7.04 to my hp nc6120 laptop. After working with t=
he
>> laptop for a while  (changing with the load on the system)  for
>> example archiving an ~700MB directory, the system is overheating (i
>> mean really hot) and shutting down automatically.
>>
>> I searched the problem on the Ubuntu forums, Linux kernel mailing
>> list, Linux acpi mailing list, ... There have been so many questions
>> and bug entries for this problem since 2005. But i can't find the
>> solution yet. Is there any solution to solve the overheating problem=
?

Didn't try 2.6.21 kernel (2.6.20 only). Don't know if you've read this =
:
https://launchpad.net/ubuntu/+bug/22336 =3D> Ubuntu's overheating is a=20
known problem since at least 09/2005, but doesn't seem important enough=
=20
so Ubuntu's developpers accord much interest on it... (Must be
disparaging... ;-) )

I don't know if this will help, but on my girlfriend HP laptop, I was=20
able to workaround this Ubuntu bug by forcing thermal polling :
su
echo 2 > /proc/acpi/thermal/TH*/polling_frequency

Then the laptop still overheated, but tried to cool it passively before=
=20
it was to late, so that it didn't freeze or shut down.

You could also try to change thermal trip points (have a look on the=20
last section of http://acpi.sourceforge.net/documentation/thermal.html=20
but be aware that Len Brown DOES NOT LIKE this way of fixing thing (his=
=20
point of vue is explained on this topic :=20
http://lkml.org/lkml/2007/5/16/310)).

Hope this helped... If not and neither 2..21 kernel, just add your=20
testimony on Ubuntu's bug report and try another distro... ;-)



--=20
     ~~
    |Oo|   La banquise fond !!! Adoptez un pingouin...
   /|\/|\
    |__|            =3D> http://doc.ubuntu-fr.org/
    ^__^
~~~|  |~~~
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
