From: Franck Routier <franck.routier-i39dT1/MG/sAvxtiuMwx3w@public.gmane.org>
Subject: Re: Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER [Scan]
Date: Tue, 29 Jun 2004 18:58:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40E19FC2.2000308@axege.com>
References: <B44D37711ED29844BEA67908EAF36F0332CECD@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F0332CECD-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Are you by any chance using acpi-dsdt-initrd-patch-v0.4-2.6.1.diff patch 
to load you modified dsdt table ?

I had the same behaviour on my samsung x10 laptop, until I switched to 
the latest version of the patch for kernel 2.6.7. This corrected the 
problem. acpi-dsdt-initrd patches for 2.6.4 and 2.6.5 seem to be broken, 
at least under certain circonstances...

Hope this helps...

Franck

>>-----Original Message-----
>>From: Z F [mailto:mail4me9999-/E1597aS9LQAvxtiuMwx3w@public.gmane.org]
>>Sent: Tuesday, June 29, 2004 9:22 AM
>>To: Li, Shaohua
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: RE: [ACPI] Error: Handler for [EmbeddedControl] returned
>>AE_BAD_PARAMETER
>>
>>Dear Shaohua Li,
>>
>>Thank you very muc for your reply. Attached are the outputs of the
>>dmesg
>>(I loaded ac, battery, processor and thermal modules) is in the
>>dmesg.out file. The new_dsdt file contains output of acpidump
>>    
>>
>>from pacpidump package. Could you take a look and see what is wrong.
>  
>
>>Thank you very much for your kind help.
>>
>>Lazar
>>
>>--- "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>>    
>>
>>>Please attach your dmesg and acpidmp output, so we can check it.
>>>
>>>Thanks,
>>>-Shaohua
>>>      
>>>
>>>>-----Original Message-----
>>>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Z F
>>>>Sent: Monday, June 28, 2004 1:26 PM
>>>>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>>>Subject: [ACPI] Error: Handler for [EmbeddedControl] returned
>>>>AE_BAD_PARAMETER
>>>>
>>>>Hello Everybody,
>>>>
>>>>IT seems to me that all my problems start with the error message
>>>>indicated in the subject line. Could someone explain to me what this
>>>>error message means and possibly how (if possible) to correct the
>>>>problem.
>>>>
>>>>I use Dell Latitude x300 laptop and 2.4.26 kernel with the latest
>>>>        
>>>>
>>>acpi
>>>      
>>>
>>>>patch (acpi-20040326-2.4.26).
>>>>
>>>>I have modified the dsdt table so that it compiles without any
>>>>        
>>>>
>>>errors,
>>>      
>>>
>>>>but
>>>>I still get the above error at boot. AC/Battery status does not
>>>>        
>>>>
>>>work.
>>>      
>>>
>>>>Thermal does not work. It seems I can change the throttling of the
>>>>        
>>>>
>>>CPU.
>>>      
>>>
>>>>Any suggestions are highly appreciated. Could I ask some one to
>>>>        
>>>>
>>>reply
>>>      
>>>
>>>>to me even if they do not know how to solve the problem? You see, I
>>>>have sent
>>>>several emails to this list and got very small number of replies.
>>>>        
>>>>
>>>Maybe
>>>      
>>>
>>>>my subscription is broken? Sometimes I get double postings of other
>>>>people.
>>>>Thanks a lot for you kind help
>>>>
>>>>Lazar
>>>>
>>>>
>>>>
>>>>__________________________________
>>>>Do you Yahoo!?
>>>>New and Improved Yahoo! Mail - Send 10MB messages!
>>>>http://promotions.yahoo.com/new_mail
>>>>
>>>>
>>>>-------------------------------------------------------
>>>>This SF.Net email sponsored by Black Hat Briefings & Training.
>>>>Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
>>>>digital self defense, top technical experts, no vendor pitches,
>>>>unmatched networking opportunities. Visit www.blackhat.com
>>>>_______________________________________________
>>>>Acpi-devel mailing list
>>>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>>>        
>>>>
>>>      
>>>
>>
>>__________________________________
>>Do you Yahoo!?
>>Yahoo! Mail - 50x more storage than other providers!
>>http://promotions.yahoo.com/new_mail
>>    
>>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by Black Hat Briefings & Training.
>Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
>digital self defense, top technical experts, no vendor pitches, 
>unmatched networking opportunities. Visit www.blackhat.com
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
