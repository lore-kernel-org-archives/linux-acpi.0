From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Tue, 20 Apr 2010 13:21:38 +0200
Message-ID: <1271762498.1537.215.camel@pancake>
References: <1271518653.4549.186.camel@flunder>
	 <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
	 <1271687130.26267.147.camel@pancake>
	 <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com>
	 <1271746353.16585.9.camel@flunder>
	 <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com>
	 <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello Corentin,

> > Looking at your dsdt:
> >
> > BUF1 and BUF2 contains some easy to find data:
[...]
You're correct, but most of the data fields within BUF1 and BUF2 are
never referenced anywhere else. Doesn't that mean that these fields are
probably dead?

> > Looking at _INI :
> >       Store (\_SB.BRNS, BRMX) probably means "set the brightness to
> > the maximum brightness"
> >
> > WQIO returns both BUF1 and BUF2, you can get it with wmi_query_block()
> >
> > WSIO calls CPSR and CPSR store the argument in INBF.
> > BY00, BY01, ... BY31, BGTX, BGTY, BGTZ etc ... are used to access
> > specific bytes in INBF :
> >                        CreateByteField (INBF, 0x00, BY00)
> >                        CreateByteField (INBF, 0x01, BY01)
> >                        CreateByteField (INBF, 0x02, BY02)
> >                        CreateByteField (INBF, 0x03, BY03)
> >                        CreateByteField (INBF, 0x04, BY04)
> >                        CreateByteField (INBF, 0x05, BY05)
> >
> >
> > CSPR wants BY00 to be 0x01 and BY01 to be 0x10 to do something.
> > It calls CMD0 (BY08, BY09, BY10, BY11, BY16)
> >
> > ERQ0 (present in BUF1) is compared to Arg2 (BY09) == 0x1
> > if true, it will store some values and call notify
So this would then trigger the WMI event in the driver, right?
I'd assume that EVID is the EVent ID - would make sense, since somewhere
in the embedded controller code, there's this snippet:

	Method (_QEF, 0, NotSerialized)
	{
		Store (0xEF, P80H)
		\_SB.WMI2.CMD2 (0x2D, 0x01, 0x01)
	}

	Method (_QF1, 0, NotSerialized)
	{
		Store (0xF1, P80H)
		\_SB.WMI2.CMD2 (0x2C, 0x01, 0x01)
	}

AFAICT the problem might be that ERQ0 is never initialized.. so it's
probably zero from the start and the first code branch in CMD0 will
never be called.

> Method (GECN, 1, NotSerialized)
> Method (SECN, 2, Serialized)
> 
> are very interesting:
> 
> GECN is used to get status, and SECN to set status.
> 
> For example, use \_SB.GECN(0x03) to get bluetooth status
> And \_SB.SECN(0x03, 0x01) to enable bluetooth.
> I don't really understand what DECN is used for, maybe to know if a
> device is present (or maybe just switch GECN and DECN).
I've gone through the binary module from Splashtop (lenovo_ec.ko) with
objdump, and it appears that it's calling exactly those methods
(GECN,SECN,DECN). The EC registers themselves also do look very
interesting, especially with fields like XALM/YALM/ZALM or
GSVX/GSVY/GSVZ which are probably related to the accelerometer.

Do you perhaps have some example as to how to access the EC register
space?

Thanks, Florian
-- 
0666 - Filemode of the Beast

