From: Andrea Borgia <borgia-iEixELS/QsY1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: reboot instead of poweroff in 20040715, no S5 on AC and
 no status changes
Date: Thu, 26 Aug 2004 18:48:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <412E1474.3020309@cs.unibo.it>
References: <Pine.LNX.4.44.0408261627420.22242-100000@emilia.cs.unibo.it> <412DFF23.6040400@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <412DFF23.6040400-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pierre Ossman wrote:

> I wrote a post about this a month ago called "[ACPI] Cannot enter S5 
> with AC power". Didn't get any responses then though.
> I'm running FC2. But the distro doesn't matter since the problem appears 
> even if you bypass the init.

I quoted my distro info just to give a (rough) idea of the average "age" 
of the software installed on the system, I agree with you it doesn't 
really matter beyond that.

Anyway... yes, I can confirm the same happens here, with a twist: I 
found out laptop_mode wasn't shutting down the hd anymore and the reason 
is.... according to /proc/acpi, I never installed the battery and never 
pulled the power plug, which of course is just what I did to confirm 
your idea. No matter how many times I plug/unplug the ac adapter and how 
long I wait before each cycle, proc still reports ac online and battery 
missing.

Even more puzzled than I was when I posted 8-)

BR,
Andrea.

-- 
Homepage: http://andrea.borgia.bo.it     /    Amateur radio: IZ4FHT
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
