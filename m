From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: network card buzzing
Date: Thu, 9 Dec 2004 18:11:38 +0100
Message-ID: <20041209171138.GA3105@openzaurus.ucw.cz>
References: <41B86243.7090507@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41B86243.7090507-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
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

Hi!

> I tought it was normal to have a buzzing on the network card while it 
> transmits/receives high quanitities of data and using almost all of 
> it's bandwidth... I had such a network card on my desktop and now my 
> laptop does the same.
> 
> the laptop is a (smart-battery powered) acer travelmate 4001 WLMi and 
> the network card is a broadcom (b44) 10/100Mbps.
> 
> after rejecting the idea, I decided to try the same on another OS... 
> windows. it doesn't buzz while transmiting/receiving at 80Mbps 
> whereas on linux it does. one can hear exactly when there is activity 
> and when there isn't.
> 
> is this a problem? hardware issue? software issue? acpi? plain bad 
> luck? what is happening here?

Sining capacitors? See archives. idle=poll should fix it (evil grin).
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
