From: Ken Perl <kenperl@gmail.com>
Subject: Re: FAN Processor and Thermap
Date: Fri, 20 Mar 2009 16:06:27 +0800
Message-ID: <335b7d740903200106x468ead4bj4f3efed25248a0e4@mail.gmail.com>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
	 <1237510029.3640.125.camel@localhost.localdomain>
	 <335b7d740903191848i1addc5fcyf02610ee20003c91@mail.gmail.com>
	 <1237531781.3640.161.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:60036 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbZCTIG3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Mar 2009 04:06:29 -0400
Received: by rv-out-0506.google.com with SMTP id g37so250518rvb.5
        for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2009 01:06:28 -0700 (PDT)
In-Reply-To: <1237531781.3640.161.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

What I'm using is the Debian 5.0 lenny pre-complied kernel
linux-image-2.6.26-1-686, unfortunately, the CONFIG_ACPI_DEBUG is not
set.

Is this the only way to detect the problem and then fix it? is it
possible to recreate the System.map file and module.dep or something
else? I guess there is no bug in ACPI code, but I don't know how to
make it work whenever my mainboard is changed then maybe some
addresses are different in this case.

On Fri, Mar 20, 2009 at 2:49 PM, yakui_zhao <yakui.zhao@intel.com> wrot=
e:
> On Fri, 2009-03-20 at 09:48 +0800, Ken Perl wrote:
>> # acpidump
>> ACPI tables were not found. If you know location of RSD PTR table
>> (from dmesg, etc), supply it with either --addr or -a option
> It seems that the RSDP can't be found between the 0xE0000 and 0xFFFFF
> memory region.
> If so, the ACPI can't be initialized correctly.
>
> Will you please enable CONFIG_ACPI_DEBUG in kernel configuration and =
add
> the boot option of "acpi=3Dht"?
> =C2=A0 =C2=A0After the system is booted, please attach the output of =
dmesg.
> Thanks.
>
>>
>> I have no idea from the dmesg output where the ACPI tables are.
>>
>> On Fri, Mar 20, 2009 at 8:47 AM, yakui_zhao <yakui.zhao@intel.com> w=
rote:
>> > On Thu, 2009-03-19 at 16:18 +0800, Ken Perl wrote:
>> >> After I replaced my mainboard, then I can see errors related to A=
CPI
>> >> during the Linux booting, I can also reproduce it with command be=
low,
>> >>
>> >> moproble fan processor thermap
>> >>
>> >> I got error "no such device", =C2=A0I ever tried to append follow=
ing lines
>> >> to the /etc/modprobe.d/blacklist but can not succeed, I can still=
 see
>> >> same error during boot, another error is "ACPI unable to load sys=
tem
>> >> description tables",
>> > Maybe the issue is related with the following complains:
>> > =C2=A0 >=EF=BB=BFACPI unable to load system description tables",
>> > =C2=A0 If so, the ACPI SSDT table is not loaded correctly.
>> >
>> > Will you please attach the output of acpidump ?
>> > Thanks.
>> >>
>> >> blacklist fan
>> >> blacklist processor
>> >> blacklist thermap
>> >>
>> >> Do these a big problem? Can anyone tell how I can fix the issue?
>> >>
>> >
>> >
>>
>>
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
