From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Help with the DSDT for an Acer Ferrari 3400 laptop
Date: Wed, 29 Dec 2004 11:57:12 +0100
Message-ID: <20041229105712.GG9606@poupinou.org>
References: <41D0F15D.8000201@rogers.com> <20041228105611.GF9606@poupinou.org> <41D21B9A.4020409@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41D21B9A.4020409-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pedro I. Sanchez" <pedro.sanchez-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 28, 2004 at 09:51:06PM -0500, Pedro I. Sanchez wrote:
> 
> >They go to a SSDT table likely.  If you do something like:
> >sudo ./acpidmp SSDT > ssdt
> >and
> >iasl -d ssdt
> >you should get those external statements.
> >
> 
> I'm looking for acpidmp in my Debian box but I can't find it, it's not 
> in the pmtools package. And I can't find it in the Intel's download page 
> either (http://www.intel.com/technology/iapc/acpi/downloads.htm). Where 
> can I get it?

Oops sorry.  I supposed you got the DSDT with acpidmp..

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
make
sudo ./acpidmp > acpidmp.out
bzip2 acpidmp.out 

NB: the debian package 'pmtools' is for some perl stuff (perl modules
tools)...

> Also, what am I supposed to do after disassembling the ssdt?

Nothing.  You asked where are the external statements.  I just wanted to
tell you where you can find them, and how to read them.

> >>The Warning
> >>-----------
> >>dsdt.dsl  4287: Method (SMSL, 0, NotSerialized)
> >>Warning  2019 -            ^ Not all control paths return a value (SMSL)
> >>
> >>I added a Return (0x00) statement at the very end of the method and the 
> >>warning disappeared. But, is this right? Following my signature you will 
> >>find the code of the offending method including my extra line.
> >
> >
> >Could you send me the original DSDT please (or better the full acpidmp)
> >or even better provide a link?
> >
> 
> You will find the DSDT and some other files at http://www.colcan.biz

Ok.  Thanks.

SMSL() is only called as:

                    Method (_Q09, 0, NotSerialized)
                    {
                        Store ("QUERY_09", Debug)
                        SMSL ()
                    }

and

                    Method (_Q8E, 0, NotSerialized)
                    {
                        SMSL ()
                        Notify (\_SB.BAT1, 0x80)
                    }

so even if the 'return bug' (a bug in some ACPI interpreter) is present,
it's not a real trouble.  I guess they added a return only to break the
method without having to worry to rewrite the method properly.  Just
adding a return statement do not have any bad side effect but prevent
iasl to warn at compile time.

(BTW, there is something like that in the EC0 space:
                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, Lock, Preserve)
                    {
                        ...
                        ...
                        Offset (0x18),
                        SMPR,   8,
                        SMST,   8,
                        SMAD,   8,
                        SMCM,   8,
                        SMD0,   256,
                        BCNT,   8,
                        SMAA,   8,
                        S1D0,   8,
                        S1D1,   8,
                        SM2A,   8,
                        ...
                        ...
                     }


The SMPR, SMST, SMAD, ... indicate very likely a smbus access.
Even though there is no HC EC smbus defined in this ASL, the
whole ACPI control method battery defined under \_SB.BAT1 indicate
that they have written access to a smart battery selector and a smart
battery.
I guess Acer bios writers do not want anymore to write those codes for
others models, since anyway smartbattery is supported (at spec
level) by ACPI 1.0b at least.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
