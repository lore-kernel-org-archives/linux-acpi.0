From: Simon Richter <richtesi-xrfDFxQfymSzQB+pC5nmwQ@public.gmane.org>
Subject: Re: questions
Date: Tue, 30 Jul 2002 14:56:23 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207301445570.6567-100000@phobos>
References: <20020730014417.69105.qmail@web9806.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020730014417.69105.qmail-3A75BWZatn2wAeGFf/znCBupM2+RrINj@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Bita Gorji-Ara <bita_gorjiara-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 29 Jul 2002, Bita Gorji-Ara wrote:

> I'm investigating the capabilities of ACPI and see if
> it is appropriate for us or not. Our system is a
> real-time complex embedded system, running Linux on
> Power PC. We are seeking for a suitable power
> management policy . the OS and hardware should be
> revised based on that policy.

> I want to consider all alternatives to ACPI and make
> the final decision and I prefer to find something
> commercial. does anybody have any good set of links to
> ACPI alternative approaches?

The only viable alternative on the PowerPC would be the method Apple uses
with their Macs. Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org> knows
more about this one, I believe. APM is a clearly i386 specific interface
and cannot be ported, and there are a few proprietary protocols.

I would go for ACPI, simply because the necessary toolchains and drivers
under Linux already exist.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: 040E B5F7 84F1 4FBC CEAD  ADC6 18A0 CC8D 5706 A4B4
Spread the word! Metal/Industrial party on May 22nd at Pulverturm, Munich.
NP: <add NP here>
UP: <add UPTIME here>




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
