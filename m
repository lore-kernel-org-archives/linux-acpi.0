From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: apologizes (was Re: Re: thinkpad workaround v2.)
Date: Mon, 20 Jan 2003 18:15:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030120171558.GL11487@poup.poupinou.org>
References: <200301171947.54174.dom@wahuu.at> <200301201530.00303.dom@wahuu.at> <20030120144413.GD11487@poup.poupinou.org> <200301201554.13984.dom@wahuu.at> <20030120154043.GI11487@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030120154043.GI11487-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andy Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dominik Bartenstein <dom-K271P2BsTd0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 20, 2003 at 04:40:43PM +0100, Ducrot Bruno wrote:
> On Mon, Jan 20, 2003 at 03:54:13PM +0100, Dominik Bartenstein wrote:
> > Dear Bruno,
> > 
> > that's the osl.c I use. I have just discovered that I compiled ACPI as modules 
> > ... I am going to rebuild the kernel with ACPI compiled into the kernel, k?
> > 
> 
> OK.  I looked it a little bit more and I consider that is a bug in the acpi
> implementation in linux.  I will provide a patch to the acpi-ml list but
> only for tomorrow (sorry, I am a little bit busy, you know :).
> 
> short explanation:
> 
> drivers/acpi/ec.c::acpi_ec_ecdt_probe() load the ECDT table
> via acpi_get_firmware_table() but should use something else
> or the osl provided mechanism for overriding the ECDT table
> do not work.
> 

Just looked at acpi_get_firmware_table() and this is OK.  So, well
my big apologizes for the above statement to acpi core team!

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
