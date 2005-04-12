From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: [Fwd: Suspend powers off machine]
Date: Tue, 12 Apr 2005 12:06:48 -0700
Message-ID: <425C1C48.60600@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

It seems on Eric's Dell D600, entering S3 powers off the system (similar 
to S5).  It also apparently works on Linux.  Anyone have an idea what 
we're doing wrong?

Thanks,
Nate

-------- Original Message --------
Subject: Re: Suspend powers off machine
Date: Mon, 11 Apr 2005 22:06:52 -0500
From: Eric Anderson <anderson-EcDrcr+ShHtWk0Htik3J/w@public.gmane.org>
References: <42552573.6040902-EcDrcr+ShHtWk0Htik3J/w@public.gmane.org> <42556AA3.5040403-Y6VGUYTwhu0@public.gmane.org>

Nate Lawson wrote:
> Eric Anderson wrote:
> 
>> I'm going to have some time on my hands next week, and I'd like to 
>> hunt down an issue with my laptop.  When attempting to go into S3, 
>> instead of going into S3, it powers off (uncleanly).  Can anyone tell 
>> me where this might be happening in the code, so I can start the 
>> printf debugging process? 
> 
> 
> It's nearly 100% certain it happens in AcpiEnterSleepState at the write 
> to PM1A.  This is in sys/contrib/dev/acpica/hwsleep.c

You're right - it happens here:
Status = AcpiHwRegisterWrite (ACPI_MTX_DO_NOT_LOCK, 
ACPI_REGISTER_PM1A_CONTROL, PM1AControl);
In that subroutine..

> In thinking about it, my best theory is that the southbridge interprets 
> this write as an S4/S5 transition.  Perhaps the ASL gives the wrong 
> value to write?  Perhaps the chipset is not being prepared for S3 
> correctly.  In any case, better chipset specs would probably help 
> diagnose this.
 >
> Other possibilities are that the setting of SLP_EN should be done at the 
> same time as the write with the SLP_TYP value (i.e. write 
> SLP_TYPE_S3|SLP_EN instead of splitting the write into two phases).  It 
> also may be that the previous steps like disabling BM ctrl are not 
> appropriate for some chipsets.
> 
> If you can get more info, I can refine this theory.

-- 
Nate


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
