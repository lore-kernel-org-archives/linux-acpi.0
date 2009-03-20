From: Ken Perl <kenperl@gmail.com>
Subject: Re: FAN Processor and Thermap
Date: Fri, 20 Mar 2009 09:48:37 +0800
Message-ID: <335b7d740903191848i1addc5fcyf02610ee20003c91@mail.gmail.com>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
	 <1237510029.3640.125.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:25822 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759900AbZCTBsi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 21:48:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so844421rvb.1
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2009 18:48:37 -0700 (PDT)
In-Reply-To: <1237510029.3640.125.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

# acpidump
ACPI tables were not found. If you know location of RSD PTR table
(from dmesg, etc), supply it with either --addr or -a option

I have no idea from the dmesg output where the ACPI tables are.

On Fri, Mar 20, 2009 at 8:47 AM, yakui_zhao <yakui.zhao@intel.com> wrot=
e:
> On Thu, 2009-03-19 at 16:18 +0800, Ken Perl wrote:
>> After I replaced my mainboard, then I can see errors related to ACPI
>> during the Linux booting, I can also reproduce it with command below=
,
>>
>> moproble fan processor thermap
>>
>> I got error "no such device", =C2=A0I ever tried to append following=
 lines
>> to the /etc/modprobe.d/blacklist but can not succeed, I can still se=
e
>> same error during boot, another error is "ACPI unable to load system
>> description tables",
> Maybe the issue is related with the following complains:
> =C2=A0 >=EF=BB=BFACPI unable to load system description tables",
> =C2=A0 If so, the ACPI SSDT table is not loaded correctly.
>
> Will you please attach the output of acpidump ?
> Thanks.
>>
>> blacklist fan
>> blacklist processor
>> blacklist thermap
>>
>> Do these a big problem? Can anyone tell how I can fix the issue?
>>
>
>



--=20
perl -e 'print unpack(u,"62V5N\"FME;G\!E<FQ`9VUA:6PN8V]M\"\@``
")'
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
