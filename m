From: jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org (Johan Vromans)
Subject: Re: Re: bluetooth button is dead
Date: Tue, 21 Dec 2004 18:21:46 +0100
Message-ID: <16840.23466.968238.615803@phoenix.squirrel.nl>
References: <20041221150316.14A5D9DA3B@phoenix.squirrel.nl>
	<41C84078.9060402@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[Quoting Pedro Venda, on December 21 2004, 15:25, in "Re: [ACPI] Re: bluet"]
> but does it return such a message? mine does.
> 
> atkbd.c: Unknown key pressed (translated set 2, code 0xd5 on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e055 <keycode>' to make it known.
> atkbd.c: Unknown key released (translated set 2, code 0xd5 on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e055 <keycode>' to make it known.

Yes, it does. When I press the BlueTooth button I get a e058, and the
WiFi button alternates e055 (On) and e056 (Off). This is a TravelMate
4001WLMi; your actual codes can differ. 

-- Johan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
