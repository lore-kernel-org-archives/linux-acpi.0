From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: Doubt about fan
Date: Tue, 9 Jan 2007 18:17:08 +0300
Message-ID: <E3C0BCA40296C347AF7142161DB9FC8293D9F3@mssmsx411>
References: <beb91d720701070833j12461721q4e8f21d5e6c4fdd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19583 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbXAIPRT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jan 2007 10:17:19 -0500
Content-class: urn:content-classes:message
In-Reply-To: <beb91d720701070833j12461721q4e8f21d5e6c4fdd9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Salatiel Filho <salatiel.filho@gmail.com>, Karthik Gopalakrishnan <karthik.g.krishnan@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,

Could you please try the patches for 2.6.20-rc3 from these bugs:
http://bugzilla.kernel.org/show_bug.cgi?id=3D7570
http://bugzilla.kernel.org/show_bug.cgi?id=3D7122

and report the results (possibly in bugzilla)?


Regards.
Konstantin.

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Salatiel Filho
>Sent: Sunday, January 07, 2007 7:33 PM
>To: Karthik Gopalakrishnan
>Cc: linux-acpi@vger.kernel.org
>Subject: Re: Doubt about fan
>
>On 1/7/07, Karthik Gopalakrishnan <karthik.g.krishnan@gmail.com> wrote=
:
>> On 1/7/07, Salatiel Filho <salatiel.filho@gmail.com> wrote:
>> > Hi guys , i have two doubts and i`d be grateful if someone could h=
elp-
>me.
>> >
>> > 1) When i`m over windows , i can see hear my laptop` fans runing b=
ut
>> > when i`m over linux i think they never run or at least i do not he=
ar
>> > then and i think my machine gets a little hot. Is there something =
that
>> > i can do ???
>>
>> There is an issue "CPU fan shuts down on load of fan.ko in kernel
>> 2.6.18 and later" reported by Mathew Brett. Maybe your problem is
>> similar. Please look through the Archives for more information.
>
>I`m wondering who controls fans if i blacklist fan module ?
>I`forgot mention that i`m using kernel 2.6.20rc-3
>
>
>>
>> >
>> > 2) Is there anyway to control monitor brightness for HP Pavillion
>> > notebooks when working in battery mode ?
>> >
>> >
>> > --
>> > []'s
>> > Salatiel
>> >
>> > "O maior prazer do inteligente =E9 bancar o  idiota
>> >    diante de um  idiota que banca o inteligente".
>> > -
>> > To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi"
>in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>>
>
>
>--
>[]'s
>Salatiel
>
>"O maior prazer do inteligente =E9 bancar o  idiota
>   diante de um  idiota que banca o inteligente".
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
