From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: ACPI to driver connection
Date: Fri, 17 Sep 2004 09:06:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <414A8D0D.9080200@drzeus.cx>
References: <413CD636.6090409@drzeus.cx> <20040913223952.GB28524@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040913223952.GB28524-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI devel list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>I'm currently writing a driver for a sd card reader. This reader is 
>>present in the ACPI DSDT tree and can be identified there using the EISA 
>>PNP id. I'm not all too familiar with exactly how ACPI works and even 
>>less how ACPI works on linux so my question is this. Is there anything 
>>my driver should do to associate the entries in the DSDT with the 
>>device? Perhaps there are methods that should be called or similar? I do 
>>not have the time to study ACPI in detail so I'd appreciate any help.
>>    
>>
>
>See for example battery.c driver -- it detects battery based on PNP
>id.
>								Pavel
>  
>
The acpi_device doesn't seem to be connected to a "normal" device 
structure. Is the intention that one should register with the ACPI 
subsystem, wait for the add routine to be called and then add the device 
as previously (to the platform bus in this case)?

/Pierre



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
