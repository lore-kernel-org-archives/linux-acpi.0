From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: New Smart Battery release (incl. updated embedded controller
 patches)
Date: Mon, 14 Nov 2005 22:11:10 -0500
Message-ID: <437951CE.7060708@bartol.udel.edu>
References: <4376BD90.5080603@bartol.udel.edu> <43791753.2030004@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43791753.2030004-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Berthold Cogel <cogel-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Berthold Cogel wrote:
> Rich Townsend wrote:
> 
>>I'm pleased to announce that, after quite a long period of inactivity,
>>I've finally managed to grab enough spare time from the real world to
>>bring the SBS-CM (Smart Battery System/Control Method) project up to date.
>>
> 
> 
> I've just build linux-2.6.14 with SBS-CM, acpi-dsdt-initrd patch and
> suspend2 for my Acer Extensa 3002WLMi.
> I'm not shure wether the ec_burst parameter is still necessary or not.
> But in both cases there is an improvement compared to the situation I
> had before. There are still keyboard events missing, but now it's one
> out of 15 to 20 and not 2 to 4 out of 10.
> 
> There might be some issues with BIOS and the DSDT connected to the
> problem. I've compared the data from my Acer with some informations,
> Olaf Jansen-Olliges gave me. His system does not suffer from the
> 'missing key syndrome'.
> Olaf's Acer has BIOS version 3A08. Mine came (6 months ago) with BIOS
> version 3A10, which is still not available on the Acer website.
> And there are some minor diffs for the DSDT too. I don't know if it's a
> good idea, but I will try to modify the memory size information in the
> DSDT I got from Olaf, so I can test it with my system.
> 

You don't mention whether you've applied the acpi-ec-nospinlock patch. This 
patch is designed to remove lost interrupts completely. I know that Olaf has 
used this patch -- perhaps that is what you are missing.

As well as checking on this patch, could you send me the DSDT (undisassembled) 
so I can check it out.

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
