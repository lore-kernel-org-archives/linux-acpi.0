From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Battery change in sleep mode breaks battery support
Date: Fri, 11 Feb 2005 12:54:45 +0100
Message-ID: <420C9D05.2030500@suse.de>
References: <420A224B.9050308@colitti.com> <420A6144.5050501@suse.de> <420BA4D5.6090107@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <420BA4D5.6090107-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Lorenzo Colitti wrote:
> Thomas Renninger wrote:
> 
>>> I am having problems with battery monitoring and sleep mode: if I 
>>> plug in or unplug the battery while the machine is asleep, when it 
>>> wakes up the change has not been registered and no further changes 
>>> are logged.
>>> [..]
>>> Any ideas?
>>>
>> I expect that your _WAK function does not work properly.
>> Does S3 invoke the _WAK function after wake up?
> 
> 
> I don't know, how do I find out? Do I have to (attempt to) read the 
> decompiled dsdt or can I just use the acpi debugging options?
> 
Hmm, don't know.
Putting a:
Store ("_WAK invoked", Debug)
into the _WAK function of your DSDT.

But maybe it won't be printed because the kernel logger won't run at 
this moment?

Hoped that some of the suspend guys comments on this, sorry.

You should disassemble and recompile your dsdt:
cp /proc/acpi/dsdt /tmp
iasl -d /tmp/dsdt
iasl -sa /tmp/dsdt.dsl

maybe you even find an error inside this function.
Send me your DSDT if iasl -sa /tmp/dsdt.dsl throws errors, maybe just 
adjusting some lines help.

        Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
