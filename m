From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: please test latest acpi patch
Date: Tue, 22 Mar 2005 00:04:14 +0100
Message-ID: <423F52EE.4000703@gmx.net>
References: <1111214045.5932.41.camel@d845pe> <423F08C5.3060405@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <423F08C5.3060405-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Carl-Daniel Hailfinger schrieb:
> Len Brown schrieb:
> 
>>There are some very important -- and in some cases,
>>potentially disruptive -- changes in the latest ACPI patch.
>>
>>EC Burst Mode -- battery status AE_TIME etc.
>>Binding ACPI power states to PCI devices -- power loss in S3
>>Generic Hot Key Driver -- needs configuration from user space
>>S3 Resume PCI Interrupt Link fix, requiring drivers to behave better
>>Poweroff fix -- compatible with kexec patch
>>Improved "Implicit Return" AML workaround -- toshiba, compaq etc.
>>Relaxed AE_AML_BUFFER_LIMIT code -- reflects proposed ACPI spec update
>>
>>Please try it out on a system near you!
> 
> 
> Tested on my Samsung P35 notebook:
> 
> Seems to work so far. I only tested S3 suspend/resume; my battery is
> unplugged right now.

I take that back. Adjusting display brightness is now at least 10x slower
than before. Normally, pressing the keys to change brightness resulted
in immediate action. Now, the machine needs 1 second and more to react.
Before anybody asks: I have ACPI debugging switched off since it became
unbearably slow, so that is not my problem.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
