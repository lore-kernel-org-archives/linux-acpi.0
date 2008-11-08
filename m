From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: The fatal  logic error in EC write transaction(EC transaction
 is done in interrupt context)
Date: Sat, 08 Nov 2008 19:47:18 +0300
Message-ID: <4915C296.9030903@suse.de>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com> <29086e19e9149aadd17ece7112d7d2cf3a8b82f3.1226032677.git.len.brown@intel.com> <1226038422.3989.244.camel@yakui_zhao.sh.intel.com> <alpine.LFD.2.00.0811071445140.8189@localhost.localdomain> <9F0C1DB20AFA954FA1DA05309350433D40C7CC84@pdsmsx503.ccr.corp.intel.com> <4915B165.8020207@suse.de> <9F0C1DB20AFA954FA1DA05309350433D40C7CC97@pdsmsx503.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51208 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753179AbYKHQrU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 11:47:20 -0500
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D40C7CC97@pdsmsx503.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhao, Yakui" <yakui.zhao@intel.com>
Cc: LenBrown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

Yakui,
This is not about my patch, this is about your ego...
My patch did not introduce this behaviour, it was there since "burst mo=
de" was introduced, and may be even earlier. You may ask Luming Yu, why=
 he was so optimistic about 1 microsecond (is he still around? you did =
not include him into CC yet...).

Regards,
Alex.

Zhao, Yakui wrote:
>     a. When the host writes data to the command or data register of t=
he embedded controller, the input buffer flag (IBF) in the status regis=
ter is set within 1 microsecond.( Please see it in the section 12.7 of =
ACPI 3.0b. This should be paid attention to).  So If another EC transac=
tion is started in 1 microsecond, maybe the EC status is not updated. I=
n such case the problem will appear.
>        At the same time we can't expect that all the EC follows the s=
pec strictly. Maybe on some EC controllers more time is needed.
>     b. Why not wait before the EC transaction is finished?  If it fai=
ls, it can't be caught in time.  From the programming viewpoint the log=
ic is incorrect. If you insist that viewpoint is correct, IMO this issu=
e can be discussed in the wider range.=20
>    =20
>      In my email I raise the issue about your patch. If your patch ca=
n work well, no one is willing to raise any issue about your patch.=20
>     =20
>=20
> -----Original Message-----
> From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]=20
> Sent: 2008=E5=B9=B411=E6=9C=888=E6=97=A5 23:34
> To: Zhao, Yakui
> Cc: LenBrown; linux-acpi@vger.kernel.org; Brown, Len; Li, Shaohua; Zh=
ang, Rui; Lin, Ming M
> Subject: Re: The fatal logic error in EC write transaction(EC transac=
tion is done in interrupt context)
>=20
> Hi Yakui,
>=20
> Just don't know how I would have lived without your valuable analisys=
=2E..
> Do you remember that ec_transaction starts by waiting for IBF to beco=
me 0?
> Thus not any new transaction should begin before previous write or bu=
rst-disable command completes.
> So, fatal logic error exists only in your head.
>=20
> Now, let me explain why it is better to wait for last IBF=3D0 event a=
t beginning of transaction, rather than at the end of previous one.
> Look at the flow chart from different angle -- as fast transaction pa=
tch does it:
> EC sends interrupt to OS then it is ready for us to proceed. It will =
send us interrupt marking IBF=3D0 transition if it expects us to write =
byte and it will send us interrupt marking OBF=3D1 transition if it exp=
ects us to read byte. It does not ever send us IBF=3D1 or OBF=3D0 inter=
rupts just because there is nothing we could of should do in such a cas=
e.
> After we completed write sequence, we don't need to wait for last IBF=
=3D0 transition, as we don't know if we will have anything else to writ=
e -- it might be last transaction for quite a while. But next transacti=
on knows that it should not start before IBF is cleared, thus it waits=20
> for it (and expects possible interrupt).
>=20
> Regards,
> Alex.
> =20
> Zhao, Yakui wrote:
>> Hi, Alexey
>>      After checking the EC working flowchart I find a fatal logic er=
ror that exists in EC write transaction. The issue happens on most lapt=
ops. The following is the detailed explanation about this issue:
>>      According to the ACPI the EC write transaction is divided into =
the following three phases: (Seen in the section 12.6.2 of ACPI 3.0b)
>>      a. Byte #1: Host Writes the EC command to EC CMD I/O PORT. Inte=
rrupt is triggered after EC reads the command byte=20
>>      b. Byte #2: Host writes the address index to EC data I/O port. =
Interrupt is triggered after EC reads the address index byte
>>      c. Byte #3: Host writes the Data to EC data I/O port. Interrupt=
 is triggered after EC reads the data byte
>>   =20
>>    When the function of acpi_ec_transaction_unlocked is called for E=
C write transaction, the wlen variable is initialized as 2 and the rlen=
 variable is initialized as zero. Then EC transaction follows the below=
 three steps.
>>      1. OS writes the EC command to EC CMD I/O port
>>      2. EC GPE interrupt is triggered and then the address index is =
written into EC data I/O port. (The wlen is decreased to 1.This is exec=
uted in EC GPE handler)
>>      3. EC GPE interrupt is triggered again and then the data is wri=
tten into the EC data I/O port. The wlen is decreased to 0.(This is als=
o executed in EC GPE handler). As the wlen is decreased to zero, it mea=
ns that the EC transaction is finished(True is returned by the function=
 of ec_transaction_done).=20
>>       >status =3D acpi_ec_read_status(ec);
>>       >gpe_transaction(ec, status);
>>       > if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) =3D=
=3D 0)
>>                 wake_up(&ec->wait);=20
>>      In this step the status variable only indicates that EC control=
ler already reads the address index written by OS(It can=E2=80=99t indi=
cate that EC controller already reads the data byte written by Host). A=
s the IBF flag is zero, the waiting process is waked up and EC mutex lo=
ck is released. In such case it means that OS can begin another EC tran=
saction.=20
>>      But in fact in such case EC transaction is not really finished.=
 After the EC data is written into EC Data I/O port, no flag indicates =
whether EC transaction is finished. Only when the IBF bit becomes zero =
again, we can say that EC transaction is really finished. If OS begins =
another EC transaction before previous EC transaction is really finishe=
d, we can't imagine what will happen.
>> =E3=80=80=E3=80=80IMO Based on the above analysis there exists the f=
atal logic error in the EC write transaction after the patch from Alexe=
y is shipped. Although now no one reports this issue, it is still an un=
stable factor. After all it is the fatal logic error.=20
>> =E3=80=80=E3=80=80=20
>> =E3=80=80=E3=80=80 At the same time there exists the similar logic e=
rror when OS begins an EC transaction to disable the EC burst mode.
>>     =20
>> =E3=80=80=E3=80=80Welcome the comments.
>>     =20
>> =E3=80=80=E3=80=80Best regards
>> =E3=80=80=E3=80=80     Yakui
>>
>>    =20
>>
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
