From: Richard Black <richard.black-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Battery "design capacity" incorrect
Date: Tue, 04 Mar 2003 08:16:24 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E64B538.20607@hp.com>
References: <F760B14C9561B941B89469F59BA3A84725A1C3@orsmsx401.jf.intel.com>	 <1046718101.3209.60.camel@comp6161.potsdam.edu> <1046723628.27050.3.camel@p2710>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I see this patch (design capacity patch) at 
http://sourceforge.net/projects/battstat/; however,
I don't see the 2 battery patch someone had not too long ago.  

Whoever has the 2 battery patch, could you post it to 
http://sourceforge.net/projects/battstat/?

Thanks in advance,
Richard Black

Troy Schultz wrote:

>>Correct. My main question is where is ACPI "getting" the 5400 from?
>>Various Windows tools, and even the manufacturer's specs claim "3860" or
>>"3870" as the capacity (tools and manufacturer respectively). I've
>>changed various Linux tools that I've written to do the math based on
>>the "last full capacity", but a lot of "other people's tools" use
>>"design capacity" which is "better", in my opinion as it can let you
>>know if you're having a calibration problem.
>>    
>>
>
>I wonder if the design capacity in your case is the capacity of the
>battery if it were fully charged and then fully depleated, a situation
>which would and should never occurr.  The last full capacity is what
>should be used in any calculation of percent charged as this will be
>changed to reflect the battery wear as the battery goes through its
>usefull life.
>
>I have made changes to the battstat applet I use to use the last full
>capacity in the calcualtions.
>
>Best Regards
>  
>

-- 
Sincerely,
Richard Black
http://www.cpqlinux.com
http://www.compaq.com/linux





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
