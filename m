From: Lukas Hejtmanek <xhejtman-IGZnsrowxP9fmBTHTHKXmQ@public.gmane.org>
Subject: Re: ACPI - DOS - 2.6.10
Date: Wed, 29 Dec 2004 10:28:36 +0100
Message-ID: <20041229092836.GA15367@mail.muni.cz>
References: <3ACA40606221794F80A5670F0AF15F8406A73C1E@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8406A73C1E@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 29, 2004 at 10:56:51AM +0800, Yu, Luming wrote:
> The DSDT shows that:
> In _DOS:
>                      If (LNot (LLess (OSYS, 0x07D0)))
>                     {
>                         Store (0x00, DSEN)
>                     }
> And in _Q0E,  if DSEN is 1 then, BIOS will automatically handle  dispaly switch,
> otherwise, it just generate Notify event to OSPM, and rely on driver to handle it.
> However, there don't have _DSS in DSDT , which is requred for acpi video driver to handle display switch.
> 
> Could you try kernel option "acpi_osi=" 

Nothing changed.

Btw, there is a touchpad switch (to turn it off/on) that does not work any more
either.

-- 
Luká¹ Hejtmánek


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
