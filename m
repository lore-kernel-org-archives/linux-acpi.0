From: Chamara Gunaratne <pgunarat-oWe+HmWQADH2fBVCVOL8/A@public.gmane.org>
Subject: Re: Re: Pattern Match wake-up for wake-on-LAN NIC
Date: Wed, 08 Dec 2004 20:11:31 -0500
Message-ID: <6.1.2.0.0.20041208201103.03ba48b8@babbage.csee.usf.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thank you. yes, i figure that the actual pattern matching is done within 
the card itself. what i am trying to figure out is since the wake-up events 
are specified in the network device class specification, whether ACPI has 
any role in defining and sending the patterns to the card or whether it is 
handled by the OS + device driver alone.
cheers,

chamara gunaratne


At 07:51 AM 12/8/2004, you wrote:
>On Mon, Dec 06, 2004 at 04:27:50PM -0500, Chamara Gunaratne wrote:
> > Hello,
> >
> > I am trying to figure out how the pattern-based wake-up in ACPI compatible
> > network devices work. I am using an Intel PRO 1000 MT card and it wakes up
> > the PC correctly for Magic Packets and IP address directed packets. How
> > does pattern matching work in ACPI and what kind of information and
> > parameters do I need to give if I need to get the PC to wake-up on a
> > specific pattern ?
>
>ACPI has nothing to do with this. The only thing you can probably control
>using ACPI is _if_ your network card will wake up the machine or if it won't.
>The matching of the magic packet against the MAC etc is done by the card,
>not by ACPI.
>--
>Stefan Seyfried
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now.
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
