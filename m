From: Ultrakorne <ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Subject: Re: Re: bluetooth button is dead
Date: Wed, 22 Dec 2004 13:34:32 +0100
Message-ID: <41C969D8.5080709@paranoici.org>
References: <20041221150316.14A5D9DA3B@phoenix.squirrel.nl>	<41C84078.9060402@mega.ist.utl.pt> <16840.23466.968238.615803@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16840.23466.968238.615803-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
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

Johan Vromans wrote:
> [Quoting Pedro Venda, on December 21 2004, 15:25, in "Re: [ACPI] Re: bluet"]
> 
>>but does it return such a message? mine does.
>>
>>atkbd.c: Unknown key pressed (translated set 2, code 0xd5 on isa0060/serio0).
>>atkbd.c: Use 'setkeycodes e055 <keycode>' to make it known.
>>atkbd.c: Unknown key released (translated set 2, code 0xd5 on isa0060/serio0).
>>atkbd.c: Use 'setkeycodes e055 <keycode>' to make it known.
> 
> 
> Yes, it does. When I press the BlueTooth button I get a e058, and the
> WiFi button alternates e055 (On) and e056 (Off). This is a TravelMate
> 4001WLMi; your actual codes can differ. 
> 
> -- Johan
> 

k, but binding a keycode didnt enable BT, we need to know the values to
write to the control and data registry of the keyboard controller.
with such 2 values it's then easy to enable Bt...
but how pich then without reverse engineering the windows drivers?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
