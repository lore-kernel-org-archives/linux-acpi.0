From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Re: Asus K8V Deluxe VIA SATA RAID power management problem
Date: Thu, 17 Nov 2005 16:43:59 -0500
Message-ID: <437CF99F.5030901@cfl.rr.com>
References: <4378FF0A.4070301@cfl.rr.com> <200511171753.21041.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200511171753.21041.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have determined that after the resume, the controller requires an 
extended period of time before it is ready for use.  The errors I was 
getting were due to the driver waiting for the busy bit in the status 
register to clear, and it did not before the wait timed out.  I worked 
around the problem by extending the timeout by a factor of 100, but this 
does not seem like an appropriate fix.

Is there maybe a method in the DSDT that is called during resume where I 
could make it wait for the controller to be ready?

Yu, Luming wrote:
> On Tuesday 15 November 2005 05:18, Phillip Susi wrote:
>> I have noticed that when I suspend my system, on resume the via_sata
>> driver complains about an unexpected status of 0x80 in register 0xE000,
> What does 0x80 mean? What is register 0xE000 for?
> I think you need to figure them out from spec.  
> 
> Thanks,
> Luming
> 



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
