From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: generic hotkey driver
Date: Tue, 07 Sep 2004 09:13:33 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <413DB3FD.80209@neggie.net>
References: <3ACA40606221794F80A5670F0AF15F84056B5783@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84056B5783@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yu, Luming wrote:
>>> a. Configure interface:
>>>	1. register mapping of event number to internal hotkey number.
>>>	2. register expected acpi_handle which is needed to install
>>>notify handler, which will generate event for acpid.
>>>	3. register the AML methods that should be executed , with
>>>respect to  the hotkey get pressed.
>>
>>As far as I know, there is no hotkey event available in 
>>Toshiba's case. 
>> The only way to monitor the keys is by polling.
> 
> Hmm. It's not efficient way for hotkey.
> I'm curious what's the polling frequency.

I don't poll within the kernel-- I leave that issue to userspace.  The 
hotkeys are queued, and I've found a period of .2s to be more than adequate.

> I guess I can slightly modify the configure interface to
> add a polling register interface.  To keep other parts of
> interfaces unchanged, just need to generate corresponding
> pseudo event for each active event found by polling.
> 
> Does it make sense?

If you want to provide hotkey events to userspace, I guess there is no 
other choice.

-John


-- 
http://giftfile.org/  ::  giftfile project


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
