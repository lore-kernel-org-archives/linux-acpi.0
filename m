From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Tue, 18 Mar 2003 10:47:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030318094752.GO8319@poup.poupinou.org>
References: <20030317134809.GF8319@poup.poupinou.org> <3E75D6E2.4040001@tin.it> <20030317153147.GH8319@poup.poupinou.org> <3E7611EB.2050805@tin.it> <20030317184333.GL8319@poup.poupinou.org> <3E761BFA.9030609@tin.it> <3E762BDD.8030108@hp.com> <3E762DED.70301@tin.it> <3E763453.1080307@hp.com> <3E7648C3.9090402@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E7648C3.9090402-nc/lrvXPQ4s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Cc: Richard Black <richard.black-VXdhtT5mjnY@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 17, 2003 at 11:14:27PM +0100, Marci wrote:
> Richard Black wrote:
> 

...

> 
> Errors:
> 
> In file included from osl.c:205:
> /home/melchior/dsdt.hex:333: field name not in record or union initializer
> /home/melchior/dsdt.hex:333: (near initialization for `AmlCode')
> In file included from osl.c:205:
> /home/melchior/dsdt.hex:333:68: warning: multi-line string literals are 
> deprecated

This patch is not updated to the 'big struct change' that was
done in mid-january.

You have to replace all the
acpi_table_header
with:
struct acpi_table_header

or alternatively look at http://www.poupinou.org/acpi/
for more instruction.

Please note that I am in process to debug more your ASL.

I will point you to the correct diff, etc. when I finished, and
will comment you all the change done (but, I'm a human being,
you known, and I may be slow sometimes...).

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
