From: "Prakash K. Cheemplavam" <PrakashKC-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: acpi problem with nforce motherboards and ethernet
Date: Fri, 06 Feb 2004 01:38:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4022E209.3040909@gmx.de>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org> <1076026496.16107.23.camel@athlonxp.bradney.info> <4022DE3C.1080905@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4022DE3C.1080905-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Cc: Craig Bradney <cbradney-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Luis Miguel García wrote:
> Craig Bradney wrote:
> 
>>
>>
>>
>> One day hopefully this will be sorted in the BIOSes and in mainline. I
>> keep having to patch for every release (although as thats the only patch
>> I have to do I'm sure there are many worse off than me). I use the 3com
>> n/w on my A7N8X Deluxe v2 BIOS 1007 so no need for nforcedeth.
>>
>> Best patches are at:
>> http://lkml.org/lkml/2003/12/21/7
>>
>> Ive applied them to 2.6.0 and 2.6.1 and give no crashes and no heat
>> issues.

Unfortunately that patch doesn't work for me. Still locks if I try APIC 
+CPU DIsc.

>>
>> (XP2600+ runs at 31/32C normal use and 38C compiling with Zalman cooler
>> +exhaust fans in box)
>>
>> Craig
>>  
>>
> you mean 31 - 38 C readed from /proc/acpi/temp[........]????
> 
> I'm having readings of 53 in idle and even 64 while compiling!! I have 
> no case fan, but I don't think it's so important for this bug difference.

The problem is, you cannot trust those infos esp not across board 
manufacturers. In case of Abit nearly every bios shows different values...

I have an Athon XP running at 2.1Gz with 1.65vcore. Idle: 50°C (with CPU 
Disc usually about 44-40°C) and under load about 54°C. I am usign a more 
or less self-made watercooling.


Prakash


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
