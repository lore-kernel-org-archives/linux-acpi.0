From: =?gb18030?q?Ois=A8=AAn_Mac_Fheara=A8=AA?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: Re: Re: generic ACPI video and hotkey drivers vs. platform-specific drivers
Date: Fri, 11 Mar 2005 21:23:25 +0000
Message-ID: <200503112123.25490.destynova@esatclear.ie>
References: <200502230953.j1N9rPLp020723@shell0.pdx.osdl.net> <200503110407.50728.destynova@esatclear.ie> <20050311174346.GA21611@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050311174346.GA21611-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
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

On Friday 11 March 2005 17:43, Stefan Seyfried wrote:
> What pavel wanted to say (IIUC) was, that there are already enough tools
> for grabbing "generic" keys (AKA your keyboard) from the input system
> and reacting on them, so routing ACPI hotkeys through the input layer
> seems a good thing to do. I tend to agree.

Yes, if they all use the same method and all can be made to work consistently 
without a bizarre amount of effort, sure.
>
> maybe because your acer does not generate "normal" keystrokes for those
> buttons but ACPI events? So you would benefit from these solution, too.

It seems to send two-byte scancodes for (some, but not all) keys actually, but 
I could only make one of them work properly. It's a bit confusing.

Checking just now, I noticed that two of the 'user' hotkeys produce a 2 byte 
scancode for keydown and the same value +128 for keyup.

In fact, tailing /proc/acpi/event never produces any output for me, at least 
when I watch it while opening and closing the lid and whacking all the 
hotkeys.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
