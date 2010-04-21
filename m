From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Wed, 21 Apr 2010 14:33:05 +0100
Message-ID: <20100421133305.GA28710@srcf.ucam.org>
References: <1271518653.4549.186.camel@flunder> <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com> <1271687130.26267.147.camel@pancake> <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com> <1271746353.16585.9.camel@flunder> <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com> <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com> <1271762498.1537.215.camel@pancake> <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com> <1271853961.1537.1781.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1271853961.1537.1781.camel@pancake>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 21, 2010 at 02:46:01PM +0200, Florian Echtler wrote:

> 	Method (_Q8F, 0, NotSerialized)
> 	{
> 		Store ("_Q8F : Hot Key Event", Debug)
> 		Store (0x8F, P80H)
> 		DSGO ()
> 		DSSV ()
> 		Store ("_Q8F : Hot Key Event Finished", Debug)
> 	}
> 
> IIRC all _Qxx methods are also some kind of notification system, right?

Yes, _Q indicates that it's an embedded controller event (_L and _E are 
level or edge triggered events from GPEs). Unless either DSGO or DSSV 
trigger a notification I'd hope that the EC fires some other event after 
the hotkey has been stored.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
