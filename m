From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 04:24:35 +0100
Message-ID: <41C0FFF3.4010902@gmx.net>
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>	 <41C07B6F.70900@gmx.net> <1103159022.5924.17.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1103159022.5924.17.camel@mhcln03>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>, =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Matthias Hentges schrieb:
> 
>> Matthias Hentges schrieb:
>> 
>>>I haven't had any luck with resume on any kernel > 2.6.9 so far.
>>>So, I suggest you try 2.6.9 and apply the patches from here:
>>>http://www.hentges.net/misc/howtos/samsung_p30_s3.shtml

> Am Mittwoch, den 15.12.2004, 18:59 +0100 schrieb Carl-Daniel Hailfinger:
> 
>>Do you have any hints what to exclude in the .config? The .config
>>which was once available in your forum is marked as "deleted
>>attachment" and cannot be downloaded.
> 
> Do not use any framebuffer, be it radeonfb or vesafb, it will freeze
> your machine on resume. USB drivers should be built as modules and need
> to be unloaded before suspending or USB might become FUBAR after a
> resume. Besides that, I don't remember anything which I haven't noted on
> my page (see above).
> [...]
> 
> I've attached my current kernel .config for 2.6.9 and the suspend script
> I'm using. 
> It looks like an ugly hack but it is working very well for me

Thanks! While you wrote your mail, I got S3 working here, but your suspend
script is very appreciated.


>>Oh, and once I get S3 working with 2.6.9 I'll do a binary search
>>to find the changeset that is causing the problems after 2.6.9
>>and report back.
> 
> That would be most appreciated. I still haven't fully recovered from
> trying 30+ kernels / configurations to find the borked patch ;)

A first hint: CONFIG_REGPARM killed swsusp in some kernels before
2.6.10-rc3, it could also be the culprit for S3.

Besides that, I think we could convince the X.Org developers that
the "get display working" bug is their problem ;-)
It seems they have merged some suspend/resume bugfixes for Radeon and
will merge at least one more bugfix in the next few days. Basically,
it should be possible that the normal Radeon Xserver rePOSTs the card
itself once it detects a resume event. If that is done properly, we
could get rid of the hack completely and would only have to live with
the text console.

Once these patches are merged completely, I'll try a current X.Org
build and open a bug with X.Org if the situation isn't better.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
