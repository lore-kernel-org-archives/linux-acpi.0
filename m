From: Martin Platter <mxp1-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: No events when pressing power button
Date: Thu, 15 Aug 2002 15:42:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D5BAFD5.2030500@gmx.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD85@orsmsx119.jf.intel.com> <20020813210108.GA11105@digda.intern.quelltext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Arndt Schoenewald wrote:

>Hi Andy,
>
>nice to hear you're back from vacation! (Hum, well, not quite as nice
>for yourself, I guess...!)
>
>On Tue, Aug 13, 2002 at 11:33:56AM -0700, Grover, Andrew wrote:
>  
>
>>>From: Sérgio Monteiro Basto [mailto:sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org] 
>>>      
>>>
>>>>I patched my kernel (2.4.18) today with latest version of 
>>>>        
>>>>
>>>acpi-patch 
>>>      
>>>
>>>>(acpi-20020726-2.4.18.diff). My power button gets detected 
>>>>        
>>>>
>>>but I dont get 
>>>      
>>>
>>>>any events from it. I have a ABit BP6 with dual celeron processors.
>>>>ACPI: Power Button (FF) [PWRF]
>>>>What could be wrong? I tried latest acpid rpm and 'cat 
>>>>        
>>>>
>>>/proc/acpi/event' 
>>>      
>>>
>>>>without results. Acpid doesn't write nothing to 
>>>>        
>>>>
>>>/var/log/acpid when I 
>>>      
>>>
>>>>press power button. 
>>>>
>>>>        
>>>>
>>>had you try kacpid patch 
>>>that detects lost acpi events
>>>      
>>>
>>Hi,
>>
>>The problem *may* be that the ACPI interrupt is not being set to active-low,
>>level-triggered properly (we do this for PCI irqs but not our own ;-)
>>
>>Is your acpi interrupt shared with any PCI devices? If the above hypothesis
>>is true, the answer should be "no".
>>
>>    
>>
>
>AHA!
>
>I own one of those machines that need eisa_set_level_irq() for some
>builtin devices, and I have never seen any events coming out of
>/var/log/acpid so far. The ACPI interrupt is not shared with anything.
>
>So I really guess you are right and eisa_set_level_irq(9) might be
>needed to turn ACPI interrupt reporting on. I'll add this call next
>time I build a kernel.
>
>Arndt
>
Hi!

It works on my Gericom M6T. I have added "eisa_set_level_irq(9);" in the 
pci_irq.c at line 365.
Now I get events from LID, Powerbutton and I can even use the special 
function keys to set the backlight :-)

Martin

>>I don't know about people's comfort level with the code, but you might try
>>adding a call to eisa_set_level_irq(<ACPI irq #>) and seeing if that gets
>>interrupts happening properly. kacpid should not be necessary but obviously
>>until SCIs work 100% it remains useful for some people.
>>
>>Regards -- Andy
>>    
>>
>
>
>-------------------------------------------------------
>This sf.net email is sponsored by: Dice - The leading online job board
>for high-tech professionals. Search and apply for tech jobs today!
>http://seeker.dice.com/seeker.epl?rel_code=31
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
