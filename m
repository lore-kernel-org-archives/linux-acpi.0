From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Tue, 20 Apr 2010 14:09:46 +0200
Message-ID: <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com>
References: <1271518653.4549.186.camel@flunder>
	 <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
	 <1271687130.26267.147.camel@pancake>
	 <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com>
	 <1271746353.16585.9.camel@flunder>
	 <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com>
	 <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com>
	 <1271762498.1537.215.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1271762498.1537.215.camel@pancake>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 20, 2010 at 1:21 PM, Florian Echtler <floe@butterbrot.org> =
wrote:
> Hello Corentin,
>
>> > Looking at your dsdt:
>> >
>> > BUF1 and BUF2 contains some easy to find data:
> [...]
> You're correct, but most of the data fields within BUF1 and BUF2 are
> never referenced anywhere else. Doesn't that mean that these fields a=
re
> probably dead?

Hum .. maybe, the best way to know would be to dump it in various
hardware states.

>> > Looking at _INI :
>> > =A0 =A0 =A0 Store (\_SB.BRNS, BRMX) probably means "set the bright=
ness to
>> > the maximum brightness"
>> >
>> > WQIO returns both BUF1 and BUF2, you can get it with wmi_query_blo=
ck()
>> >
>> > WSIO calls CPSR and CPSR store the argument in INBF.
>> > BY00, BY01, ... BY31, BGTX, BGTY, BGTZ etc ... are used to access
>> > specific bytes in INBF :
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CreateByteField (IN=
BF, 0x00, BY00)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CreateByteField (IN=
BF, 0x01, BY01)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CreateByteField (IN=
BF, 0x02, BY02)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CreateByteField (IN=
BF, 0x03, BY03)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CreateByteField (IN=
BF, 0x04, BY04)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CreateByteField (IN=
BF, 0x05, BY05)
>> >
>> >
>> > CSPR wants BY00 to be 0x01 and BY01 to be 0x10 to do something.
>> > It calls CMD0 (BY08, BY09, BY10, BY11, BY16)
>> >
>> > ERQ0 (present in BUF1) is compared to Arg2 (BY09) =3D=3D 0x1
>> > if true, it will store some values and call notify
> So this would then trigger the WMI event in the driver, right?
> I'd assume that EVID is the EVent ID - would make sense, since somewh=
ere
> in the embedded controller code, there's this snippet:
>
> =A0 =A0 =A0 =A0Method (_QEF, 0, NotSerialized)
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Store (0xEF, P80H)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_SB.WMI2.CMD2 (0x2D, 0x01, 0x01)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0Method (_QF1, 0, NotSerialized)
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Store (0xF1, P80H)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_SB.WMI2.CMD2 (0x2C, 0x01, 0x01)
> =A0 =A0 =A0 =A0}
>
> AFAICT the problem might be that ERQ0 is never initialized.. so it's
> probably zero from the start and the first code branch in CMD0 will
> never be called.

ERQ0 is initialized here (with 0x00):
                        Name (BUF1, Buffer (0x40)
                        {
                                /* 0000 */      0x01, 0x00, 0x00,
0xFF, 0x00, 0xFF, 0xFF, 0xFF,
                                /* 0008 */      0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                                /* 0010 */      0xFF, 0xFF, 0x00,
0x00, 0x00, 0xFF, 0xFF, 0xFF,
                                /* 0018 */      0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                                /* 0020 */      0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                                /* 0028 */      0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                                /* 0030 */      0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                                /* 0038 */      0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF
                        })


>> Method (GECN, 1, NotSerialized)
>> Method (SECN, 2, Serialized)
>>
>> are very interesting:
>>
>> GECN is used to get status, and SECN to set status.
>>
>> For example, use \_SB.GECN(0x03) to get bluetooth status
>> And \_SB.SECN(0x03, 0x01) to enable bluetooth.
>> I don't really understand what DECN is used for, maybe to know if a
>> device is present (or maybe just switch GECN and DECN).
> I've gone through the binary module from Splashtop (lenovo_ec.ko) wit=
h
> objdump, and it appears that it's calling exactly those methods
> (GECN,SECN,DECN). The EC registers themselves also do look very
> interesting, especially with fields like XALM/YALM/ZALM or
> GSVX/GSVY/GSVZ which are probably related to the accelerometer.
>
> Do you perhaps have some example as to how to access the EC register
> space?

Take a look at eeepc-laptop, you can do most of the work with
acpi_evaluate_object (see write_acpi_int/read_acpi_init in
eeepc-laptop).

If you really need to access the EC directly, check ec_write()/ec_read(=
) calls.



--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe platform-driv=
er-x86" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
