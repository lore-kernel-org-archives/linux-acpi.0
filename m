From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [Suspend2-devel] Cause of Suspend2 resume failures on Toshiba laptops
Date: Tue, 8 Mar 2005 11:25:42 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750155EABF@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, Dumitru Ciobarcianu <swsusp-devel-P4rH+HwZiSk@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, suspend2-devel-g/J2nbn7YhmWn91e4EydUaxOck334EZe@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
>On Sat, Mar 05, 2005 at 10:44:58AM +0200, Dumitru Ciobarcianu wrote:
>> ??n data de S??, 05-03-2005 la 01:50 +0800, Bernard Blackham a scris:
>> > The attached patch more or less reverts the change in 2.6.9-rc1
that
>> > began this all. If you have a Toshiba or other laptop that's
>> > affected by this, I ask you to see if it helps your problems. (It
>> > hacks around the problem rather than fixing it, but I'm not
entirely
>> > sure what functionality it disables).
>>
>> You are on the right track , it does the trick, I did serveral
>> suspend/resume cycles whitout problems.
>>
>> But (yes, it's a but :) it is functionally equivalent with using the
>> other workaround (booting at resume with acpi=3Doff) meaning that I
lose
>> all the acpi events (AC events, LID events, etc). The system records
the
>> event (if I do an "watch cat /proc/acpi/ac_adapter/ADP1/state" it
shows
>> the current state correctly) but acpid does not receive the event,
and
>> thus can not act accordingly :(  (Toshiba Satellite Pro 6100)
>
>Ahh, d'oh. Try this patch instead.
>
>After more investigation, it seems that the issue is the GPE is
>fired but not serviced because kacpid is frozen. This in itself
>would be okay, however, the GPE isn't being disabled before the
>method executes (despite there being code there to do so), and hence
>fires continuously.
>
>The attached patch makes kacpid NOFREEZE so the GPE does get
>serviced (eventually), but probably still isn't the correct
>solution. (A better solution being making sure the GPE gets disabled
>in the first place ... still looking into this).
Hi,
Did you guys try the suspend method 'platform'? In this case, ACPI will
disable all non-wakeup GPEs.

Thanks,
Shaohua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
