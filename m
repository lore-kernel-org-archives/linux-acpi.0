From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: keylock regression with i8042 + S3 resume
Date: Fri, 17 Dec 2004 20:51:30 -0500
Message-ID: <41C38D22.1010101@optonline.net>
References: <419ECE6E.4030005@optonline.net>
 <d120d50004112314333ebb0eb@mail.gmail.com> <41A3BEF4.6030403@optonline.net>
 <200411240058.55744.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200411240058.55744.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dmitry Torokhov wrote:

>On Tuesday 23 November 2004 05:51 pm, Nathan Bryant wrote:
>  
>
>>Dmitry Torokhov wrote:
>>
>>    
>>
>>>It looks like the controller got "stuck" with OBF bit set. There is no response
>>>to any of the commands sent to it and any read returns 0 with both "timeout"
>>>and "bad parity" flags set.
>>>
>>>I wonder if latest changes in ACPI PNP and resources management that
>>>were reported to break floppy are responsible for this stuff as well. Linus
>>>has committed a fix that *might* help into his BK tree, try tonight's BK
>>>snapshot. If this does not work I guess you'd have to do binary search
>>>on various -bk snapshots to narry down which broke resume. 
>>>
>>>      
>>>
Looks like this problem has been fixed in recent 2.6.10-rc3 bk snapshots.

Nathan.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
