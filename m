From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: smartbattery support
Date: Fri, 8 Oct 2004 11:16:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041008091658.GE6785@poupinou.org>
References: <16A54BF5D6E14E4D916CE26C9AD30575457124@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575457124-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 08, 2004 at 04:39:47PM +0800, Li, Shaohua wrote:
> >function must be written.
> Some Acer laptops define the SMBus host as below:
>   		Device (SMBC)
>                     {
>                         Name (_HID, "ACPI0001")
>                         Name (_EC, 0x1820)
>                         Device (SBS0)
>                         {
>                             Name (_HID, "ACPI0002")
>                             Name (_SBS, 0x02)
>                         }
>                     }
> The base address and the notification number are defined on the _EC
> method.
> Please check if you system has such definition.
> 

It doesn't have such definition.

There were that actually for the EC device:

                    Field(ERAM, ByteAcc, Lock, Preserve)
                    {
                        Offset(0x60),
                        SMPR,8,
                        SMST,8,
                        SMAD,8,
                        SMCM,8,
                        SMD0,256,
                        BCNT,8,
                        SMAA,8,
                        ...
                        ...

(you can grab the ASL at
ftp://ftp.poupinou.org/acpi/tosh_3000/tosh3k-100.v13.asl.bz2
if you want to verify by yourself)

So my guess was that it's an smbus, and it was the case..

The only trouble were that I don't have the notification number
(though I think it was 1, because this laptop received sometimes
an EC QUERY with this value and there is no _Q01 method in the 
original asl), but I must admit I haven't checked more.

For the record, there were 3 sensors, a smartbattery I think, a
thermal sensor controlling also the CPU fan, and an eeprom.
Since I got in fact what I wanted to monitor by using acpi methods,
I haven't investigated more...

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
