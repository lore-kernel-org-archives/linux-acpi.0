From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Error-5 Could not suspend Device 0000: 00: ld. 7
Date: Sun, 5 Dec 2004 23:43:33 +0100
Message-ID: <20041205224333.GA1415@elf.ucw.cz>
References: <9ed79ee0041201224525d402cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9ed79ee0041201224525d402cd-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: boltmelots <boltmelots-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I have just recently after much trouble installed acpi with kernel
> 2.6.7 running debian unstable.  The laptop is Dell inspiron 500m.
> 
> I am having trouble putting the thing on standby.  I try 
> 
>            'echo 1 > /proc/acpi/sleep'
> 
> but it produces the following message and just comes back to normal. 
> Does anyone know what it means and how I can fix it.  I will
> appreciate any suggestions I can try.
> 
> PM: Preparing system for suspend
> Stopping tasks: =====================================================|
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> Could not suspend device 0000:00:1d.7: error -5

lspci, and find out which device is that, then fix it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
