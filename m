From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: No C3 states after swsuspend/resume
Date: Sat, 25 Dec 2004 09:47:18 +0100
Message-ID: <m2r7lebw89.fsf@phoenix.squirrel.nl>
References: <m2brcmavnl.fsf@phoenix.squirrel.nl>
	<20041223130339.GD731@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041223130339.GD731-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org> (Pavel Machek's
 message of "Thu, 23 Dec 2004 14:03:40 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:

> Can you try again on vanilla 2.6.9?

I'll give it a try.

> Does it still happen without usb?

Yes. In fact, when I boot in single user mode, and unload the uhci-hcd
module, all is well and C3 states are used. After suspend/resume, bus
master activity is ffffffff and never changes. I tried stopping all
processes and unloading all modules, but nothing seems to make a
difference.

-- Johan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
