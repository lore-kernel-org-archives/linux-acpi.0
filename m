From: David =?iso-8859-15?Q?G=F3mez?= <david-0d+f1cuTMnnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: smart battery on acer travelmate 4001
Date: Sun, 3 Oct 2004 11:40:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041003094008.GA20789@fargo>
References: <415DD4D6.2080402@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <415DD4D6.2080402-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
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

Hi Pedro ;),

> i found out recently that i have one of those laptops with a smart
> battery. mine is an acer travelmate 4001 wlmi.

Same as mine.

> i would like to ask you for some information:

I'm nothing as far a an ACPI expert, just an user ;), but i'll try to hel=
p you.

> 1. where do the smart batteries differ from "regular" batteries;

They're a different kind of batteries in the ACPI specification. It
defines two types, control-method batteries and smart batteries. Currentl=
y
ACPI only supports the first type.

> 2. what are the advantages/disadvantages of a smart battery vs "regular=
"
> battery

>From what i understand, a smart battery can 'offer' some information abou=
t
its state, voltage, composition, etc... This leads to the ACPI subsystem
to a more efficient power management. In short, they last longer, or at
least that is what manufacturers say ;).

> 3. i read that acpi4linux does not support smart batteries yet. what ca=
n
> i do to help?

I cannot answer to that. I downloaded the ACPI specification from
http://www.acpi.info, i tried to learn a bit more about ACPI and smart
batteries, but i'm far from being able to write a driver :-/

> note: i do not code in the kernel, i am unable to write the drivers
> myself... yet... but i am fully available to supply every bit of
> necessary information to help others develop/test new drivers.

Great ;). I'm avaliable too to do any kind of testing and help with
information if someone starts to develop linux acpi support for smart
batteries.

cheers,

--=20
David G=F3mez

"The question of whether computers can think is just like the question of
whether submarines can swim." -- Edsger W. Dijkstra


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
