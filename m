From: Matthias Pfaller <leo@marco.de>
Subject: Re: DMI year "00" + ACPI [was: DMI: fix dmi_get_year year parsing]
Date: Thu, 09 Jul 2009 09:39:23 +0200
Message-ID: <4A559EAB.10706@marco.de>
References: <1246998990-9594-1-git-send-email-jirislaby@gmail.com> <4A5440BA.6070409@marco.de> <4A5442AD.1080402@gmail.com> <4A5444BD.1090905@marco.de> <4A559851.5030302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.marco.de ([217.6.149.82]:54959 "HELO mail.marco.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751429AbZGIHqm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Jul 2009 03:46:42 -0400
In-Reply-To: <4A559851.5030302@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Jiri Slaby wrote:
> On 07/08/2009 09:03 AM, Matthias Pfaller wrote:
>> Jiri Slaby wrote:
>>> On 07/08/2009 08:46 AM, Matthias Pfaller wrote:
>>>> Jiri Slaby wrote:
>>>>> Don't guess a year number base. Use 10 instead, since year may
>>>>> be 2-digit starting with 0, so that we would end up in base equal
>>>>> to 8.
>>>>>
>>>>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>>>> Reported-by: Matthias Pfaller <leo@marco.de>
>>>>> ---
>>>>>  drivers/firmware/dmi_scan.c |    2 +-
>>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_s=
can.c
>>>>> index 6071078..8fe0f6e 100644
>>>>> --- a/drivers/firmware/dmi_scan.c
>>>>> +++ b/drivers/firmware/dmi_scan.c
>>>>> @@ -611,7 +611,7 @@ int dmi_get_year(int field)
>>>>>          return 0;
>>>>> =20
>>>>>      s +=3D 1;
>>>>> -    year =3D simple_strtoul(s, NULL, 0);
>>>>> +    year =3D simple_strtoul(s, NULL, 10);
>>>>>      if (year && year < 100) {    /* 2-digit year */
>>>>>          year +=3D 1900;
>>>>>          if (year < 1996)    /* no dates < spec 1.0 */
>>>> I just noticed, that this is not enough, because this will still f=
ail
>>>> for xxx/xx/00. I suggest the following patch:
>>> Actually the patch below is not correct. Standard says consider xx/=
xx/yy
>>> as 19yy, not 20yy.
>>>
>>> BTW. the patch above is not useful, reporting 1908 and 1909 as a ye=
ar is
>>> almost the same as 1900.
>> Sorry, I don't understand.
>=20
> Nevermind, you're right. Both patches are OK, however we might hit a
> regression with 00/00/00 entries so that acpi gets unintentionally ar=
med
> now for them (ACPI checks year =3D=3D 0). I don't know if it's worth =
it. Any
> ideas?

There are bioses with 00/00/00? How about that:

--- dmi_scan.c.orig     Thu Jul  9 03:34:48 2009
+++ dmi_scan.c  Thu Jul  9 03:38:19 2009
@@ -352,17 +352,36 @@
                 return -1;
         if (*s =3D=3D '\0')
                 return 0;
+
+       /* Month must not be zero */
+       if (simple_strtoul(s, NULL, 10) =3D=3D 0)
+               return 0;
+
+       /* Look for day of month */
+       s =3D strchr(s, '/');
+       if (!s)
+               return 0;
+
+       /* Day of month must not be zero */
+       s +=3D 1;
+       if (simple_strtoul(s, NULL, 10) =3D=3D 0)
+               return 0;
+
+       /* Look for year */
         s =3D strrchr(s, '/');
         if (!s)
                 return 0;
          s +=3D 1;
-       year =3D simple_strtoul(s, NULL, 0);
-       if (year && year < 100) {       /* 2-digit year */
-               year +=3D 1900;
-               if (year < 1996)        /* no dates < spec 1.0 */
-                       year +=3D 100;
+       if (s[0] =3D=3D '0' && s[1] =3D=3D '0' && s[2] =3D=3D '\0') {
+               year =3D 2000;
+       } else {
+               year =3D simple_strtoul(s, NULL, 10);
+               if (year && year < 100) {       /* 2-digit year */
+                       year +=3D 1900;
+                       if (year < 1996)        /* no dates < spec 1.0 =
*/
+                               year +=3D 100;
+               }
         }
-
         return year;
  }
--=20
Matthias Pfaller                          Software Entwicklung
marco Systemanalyse und Entwicklung GmbH  Tel   +49 8131 5161 41
Hans-B=F6ckler-Str. 2, D 85221 Dachau       Fax   +49 8131 5161 66
http://www.marco.de/                      Email leo@marco.de
Gesch=E4ftsf=FChrer Martin Reuter             HRB 171775 Amtsgericht M=FC=
nchen
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
