From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Tue, 24 Aug 2004 09:23:48 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <412B4164.8090601@optonline.net>
References: <412B2E16.1040904@optonline.net> <20040824123913.GD25947@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040824123913.GD25947-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Norbert Preining wrote:
> On Die, 24 Aug 2004, Nathan Bryant wrote:
> 
>>For your b44 IRQ problem, try one of the workarounds in the message I'm 
>>forwarding you. For more details, check the mailing list archives for 
>>the thread of the forwarded message
> 
> 
> Thanks a lot, will do it immediately.
> 
> One more question: Which workaround do you think is the `right' one in
> the sense that it is not only a local workaround, but a real fix?
> Accoriding to your comment it looks like 2. is the one.

Both should work just fine for your machine, but I'm not sure that 
either one is fully general. We have other initialization-order problems 
that can't be solved just by changing everything to late_initcall, and 
although it's perfectly fine in all the KNOWN cases to ignore the BIOS' 
possible-IRQ list, for the specific case where the BIOS has already set 
up a different IRQ, there may be some case where the BIOS knows better 
than we do. It just doesn't seem 100% ACPI-compliant to ignore the list, 
even though some BIOSes clearly get the list wrong.

All that being said, if all we do is remove the line that checks the 
possible-IRQ list, that still doesn't solve the case where we have 
deliberately rebalanced IRQ's due to the "acpi IRQ rebalance" kernel 
parameter; we would need to fix the initialization order, to get that 
right... so in that sense, the late_initcall is slightly more correct, 
because it's more in the direction we want to ultimately go in, even 
though it doesn't give us enough fine-grained control over 
initialization order.

Are you running APIC or PIC mode on your machine? If PIC, it would be 
nice if you could try the late_initcall workaround, so that we can 
confirm that it fixes the problem for you.

Nathan


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
