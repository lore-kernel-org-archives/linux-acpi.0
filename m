From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Thu, 7 Apr 2005 15:12:14 +0200
Message-ID: <20050407131214.GE2298@poupinou.org>
References: <200504042214.15648.jfrey@gmx.de> <200504051638.22705.stefandoesinger@gmx.at> <200504051813.28983.jfrey@gmx.de> <425515A2.3080103@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <425515A2.3080103-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: jfrey-Mmb7MZpHnFY@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 07, 2005 at 01:12:34PM +0200, Thomas Renninger wrote:
> The temperature is fixed to exactly 70 C?
> I saw machines where a fixed temperature is returned depending on some bit/byte
> in EC/SystemIO.
> Sounds like this one does the same?
> You'll find out by going back the _TMP code in the DSDT.
> The value should be about 0xD66 ((70+273)*10, right?)

Most time its fixed to a low value in order to not
trigger all the thermal stuff.
(I also see one with a fixed 0xBAD which correspond to 26 C)

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
