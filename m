From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 22:35:03 +0900
Message-ID: <46B87507.4090505@gmail.com>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>	 <1186411815.4355.7.camel@nx6310>	 <20070806150159.GC31615@khazad-dum.debian.net>	 <200708061732.03425.rjw@sisk.pl> <46B75459.9020204@gmail.com>	 <1186424492.4355.1.camel@nx6310> <46B76BBC.9010107@gmail.com>	 <20070806234509.GC27640@khazad-dum.debian.net> <46B816FF.7060303@gmail.com>	 <20070807125104.GC30661@khazad-dum.debian.net> <1186491879.8780.51.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1186491879.8780.51.camel@queen.suse.de>
Sender: linux-ide-owner@vger.kernel.org
To: trenn@suse.de
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Thomas Renninger wrote:
>>>> Any chances of changing things
>>>> so that we inspect/snoop all tasks sent to the device, and filter them
>>>> out, or react to them accordingly?
>>> No, we can't unless we snoop ACPI method execution and detect accesses
>>> to IO ports or iomem regions.  It's not going through any driver.  This
>>> is a gross mess.
>> I don't mean fixing the stuff clowns like Toshiba did.  The correct fix for
>> that is to blacklist the hell out of that crap and patch their DSDT into
>> something remotely sane.
>>
>> I do mean snooping the ACPI methods that *return* a taskset to send to the
>> driver, and we send that taskset ourselves in libata and libpata(?).
> 
> I haven't read the whole thread in every detail, but this sounds like a
> very intrusive, overdosed workaround.
> 
> Are the DSDT/SSDTs already lying around somewhere (collecting them in a
> bug assigned to ACPI component should be a good idea)?
> Could someone give me a pointer where this happens (best in code and
> DSDT).

The toshiba problem is already taken care of.  It's the issue that we
talked over beer.  Let me look up the bug number...  It's 7780.

  http://bugzilla.kernel.org/show_bug.cgi?id=7780

This was worked around by blacklisting the systems using dmi.

Thanks.

-- 
tejun
